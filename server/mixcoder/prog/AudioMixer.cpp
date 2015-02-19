#include "AudioMixer.h"
#include <stdlib.h>     /* srand, rand */
#include <time.h>
#include "fwk/log.h"

int randInRange(int max)
{
    double frac = ((double)rand() / (double) ((double)RAND_MAX + 1));
    return (int) ( frac * (max + 1));
}

//TODO a better whitenoise generation algorithm
void genWhiteNoise(short* buffer, int bufSize)
{
    srand (time(NULL));
    memset(buffer, 0, bufSize*sizeof(short));
    for ( int i = 0; i < bufSize; i+=2 ) {
        int idx = randInRange(bufSize);
        buffer[idx] = 2;
        idx = randInRange(bufSize);
        buffer[idx] = -2;
    }
}

//combine 2 audio raw data to shrink the audio length
SmartPtr<AudioRawData> AudioMixer::combineAudioRawData( SmartPtr<AudioRawData> a1, SmartPtr<AudioRawData> a2) {
    SmartPtr<AudioRawData> c = new AudioRawData();
    if ( c ) {
        c->bIsStereo = a1->bIsStereo;
        c->bIsValid = a1->bIsValid;
        c->ss = a1->ss;
        c->pts = a1->pts;
        u32 bufSize = a1->rawAudioFrame_->dataLength();
        c->rawAudioFrame_ = new SmartBuffer(bufSize);
        if( c->rawAudioFrame_ ) {
            if( a1->bIsStereo ) {
                //combine stereo samples
                u32 i = 0;
                short* target = (short*)c->rawAudioFrame_->data();
                short* src = (short*)a1->rawAudioFrame_->data();
                u32 sampleSize = bufSize/(sizeof(short) * 2);
                LOG( "---combine stereo channels a1->pts=%d, a2->pts=%d, sampleSize=%d", a1->pts, a2->pts, sampleSize);
                while( i< sampleSize ) {
                    int valLeft  = *(src++);
                    int valRight = *(src++);
                    valLeft     += *(src++);
                    valRight    += *(src++);
                    target[i++] = CLIP(valLeft/2, 32767, -32768);
                    target[i++] = CLIP(valRight/2, 32767, -32768);
                }
                src = (short*)a2->rawAudioFrame_->data();
                while( i< sampleSize*2 ) {
                    int valLeft  = *(src++);
                    int valRight = *(src++);
                    valLeft     += *(src++);
                    valRight    += *(src++);
                    target[i++] = CLIP(valLeft/2, 32767, -32768);
                    target[i++] = CLIP(valRight/2, 32767, -32768);
                }
            } else {
                //combine 2 samples
                u32 i = 0;
                short* target = (short*)c->rawAudioFrame_->data();
                short* src = (short*)a1->rawAudioFrame_->data();
                u32 sampleSize = bufSize/sizeof(short);
                LOG( "---combine mono channels a1->pts=%d, a2->pts=%d, sampleSize=%d", a1->pts, a2->pts, sampleSize);
                while( i< sampleSize/2 ) {
                    int val = *(src++);
                    val    += *(src++);
                    target[i++] = CLIP(val/2, 32767, -32768);
                }
                src = (short*)a2->rawAudioFrame_->data();
                while( i< sampleSize ) {
                    int val = *(src++);
                    val    += *(src++);
                    target[i++] = CLIP(val/2, 32767, -32768);
                }
            }
        }
    }
    return c;
}

void AudioMixer::mixOneStreams(SmartPtr<AudioRawData>* rawData, 
                               int oneIndex,
                               short* valShort,
                               int sampleSize)
{
    //LOG("--------one index=%d, len=%ld, isStereo=%d\r\n", oneIndex, rawData[oneIndex]->rawAudioFrame_->dataLength(), rawData[oneIndex]->bIsStereo );

    if( rawData[oneIndex]->bIsStereo ) {
        memcpy((u8*)valShort, rawData[oneIndex]->rawAudioFrame_->data(), sampleSize*sizeof(short)*2);
    } else {
        int j = sampleSize*2-1;
        int i = sampleSize-1;
        short* rawDataPtr = (short*)rawData[oneIndex]->rawAudioFrame_->data();
        while( i>=0 ) {
            short singleSample = rawDataPtr[i];
            valShort[j--] = singleSample;
            valShort[j--] = singleSample;
            i--;
        }
    }
}

void AudioMixer::mixTwoStreams(SmartPtr<AudioRawData>* rawData,
                   int* index,
                   short* valShort,
                   int sampleSize)
{
    int a = index[0];
    int b = index[1];
    short* aData = (short*)rawData[a]->rawAudioFrame_->data();
    short* bData = (short*)rawData[b]->rawAudioFrame_->data();
    
    //fprintf(stderr, "--------two index=%d %d, len=%ld %ld\r\n", index[0], index[1], rawData[a]->rawAudioFrame_->dataLength(), rawData[b]->rawAudioFrame_->dataLength());
    bool aIsStereo = rawData[a]->bIsStereo;
    bool bIsStereo = rawData[b]->bIsStereo;
    for(int i = sampleSize*2-1; i >= 0; i-- ) {
        int val = 0;
        if( aIsStereo ) {
            val += aData[i];
        } else {
            val += aData[i/2];
        }

        if( bIsStereo ) {
            val += bData[i];
        } else {
            val += bData[i/2];
        }
        valShort[i] = CLIP(val, 32767, -32768);
    }
}

void AudioMixer::mixThreeStreams(SmartPtr<AudioRawData>* rawData,
                   int* index,
                   short* valShort,
                   int sampleSize)
{
    int a = index[0];
    int b = index[1];
    int c = index[2];
    short* aData = (short*)rawData[a]->rawAudioFrame_->data();
    short* bData = (short*)rawData[b]->rawAudioFrame_->data();
    short* cData = (short*)rawData[c]->rawAudioFrame_->data();

    bool aIsStereo = rawData[a]->bIsStereo;
    bool bIsStereo = rawData[b]->bIsStereo;
    bool cIsStereo = rawData[c]->bIsStereo;
    for ( int i = sampleSize*2-1 ; i>=0; i-- ) {
        int val = 0;
        if( aIsStereo ) {
            val += aData[i];
        } else {
            val += aData[i/2];
        }

        if( bIsStereo ) {
            val += bData[i];
        } else {
            val += bData[i/2];
        }

        if( cIsStereo ) {
            val += cData[i];
        } else {
            val += cData[i/2];
        }

        cachedVal_[i] = val; //cache value

        valShort[i] = CLIP(val, 32767, -32768);
    }
}

void AudioMixer::mixFourStreams(SmartPtr<AudioRawData>* rawData,
                                int* index,
                                short* valShort,
                                int sampleSize)
{
    int a = index[0];
    int b = index[1];
    int c = index[2];
    int d = index[3];
    short* aData = (short*)rawData[a]->rawAudioFrame_->data();
    short* bData = (short*)rawData[b]->rawAudioFrame_->data();
    short* cData = (short*)rawData[c]->rawAudioFrame_->data();
    short* dData = (short*)rawData[d]->rawAudioFrame_->data();

    bool aIsStereo = rawData[a]->bIsStereo;
    bool bIsStereo = rawData[b]->bIsStereo;
    bool cIsStereo = rawData[c]->bIsStereo;
    bool dIsStereo = rawData[d]->bIsStereo;

    for ( int i = sampleSize*2-1; i>=0; i-- ) {
        int val = 0;
        if( aIsStereo ) {
            val += aData[i];
        } else {
            val += aData[i/2];
        }

        if( bIsStereo ) {
            val += bData[i];
        } else {
            val += bData[i/2];
        }

        if( cIsStereo ) {
            val += cData[i];
        } else {
            val += cData[i/2];
        }

        if( dIsStereo ) {
            val += dData[i];
        } else {
            val += dData[i/2];
        }

        cachedVal_[i] = val; //cache value

        valShort[i] = CLIP(val, 32767, -32768);
    }
}

void AudioMixer::mixFiveStreams(SmartPtr<AudioRawData>* rawData,
                                int* index,
                                short* valShort,
                                int sampleSize)
{
    int a = index[0];
    int b = index[1];
    int c = index[2];
    int d = index[3];
    int e = index[4];
    short* aData = (short*)rawData[a]->rawAudioFrame_->data();
    short* bData = (short*)rawData[b]->rawAudioFrame_->data();
    short* cData = (short*)rawData[c]->rawAudioFrame_->data();
    short* dData = (short*)rawData[d]->rawAudioFrame_->data();
    short* eData = (short*)rawData[e]->rawAudioFrame_->data();

    bool aIsStereo = rawData[a]->bIsStereo;
    bool bIsStereo = rawData[b]->bIsStereo;
    bool cIsStereo = rawData[c]->bIsStereo;
    bool dIsStereo = rawData[d]->bIsStereo;
    bool eIsStereo = rawData[e]->bIsStereo;

    for ( int i = sampleSize*2-1; i>=0; i-- ) {
        int val = 0;
        if( aIsStereo ) {
            val += aData[i];
        } else {
            val += aData[i/2];
        }

        if( bIsStereo ) {
            val += bData[i];
        } else {
            val += bData[i/2];
        }

        if( cIsStereo ) {
            val += cData[i];
        } else {
            val += cData[i/2];
        }

        if( dIsStereo ) {
            val += dData[i];
        } else {
            val += dData[i/2];
        }

        if( eIsStereo ) {
            val += eData[i];
        } else {
            val += eData[i/2];
        }

        cachedVal_[i] = val; //cache value

        valShort[i] = CLIP(val, 32767, -32768);
    }
}

void AudioMixer::mixSixStreams(SmartPtr<AudioRawData>* rawData,
                                int* index,
                                short* valShort,
                                int sampleSize)
{
    int a = index[0];
    int b = index[1];
    int c = index[2];
    int d = index[3];
    int e = index[4];
    int f = index[5];
    short* aData = (short*)rawData[a]->rawAudioFrame_->data();
    short* bData = (short*)rawData[b]->rawAudioFrame_->data();
    short* cData = (short*)rawData[c]->rawAudioFrame_->data();
    short* dData = (short*)rawData[d]->rawAudioFrame_->data();
    short* eData = (short*)rawData[e]->rawAudioFrame_->data();
    short* fData = (short*)rawData[f]->rawAudioFrame_->data();

    bool aIsStereo = rawData[a]->bIsStereo;
    bool bIsStereo = rawData[b]->bIsStereo;
    bool cIsStereo = rawData[c]->bIsStereo;
    bool dIsStereo = rawData[d]->bIsStereo;
    bool eIsStereo = rawData[e]->bIsStereo;
    bool fIsStereo = rawData[f]->bIsStereo;

    for ( int i = sampleSize*2-1; i>=0; i-- ) {
        int val = 0;
        if( aIsStereo ) {
            val += aData[i];
        } else {
            val += aData[i/2];
        }

        if( bIsStereo ) {
            val += bData[i];
        } else {
            val += bData[i/2];
        }

        if( cIsStereo ) {
            val += cData[i];
        } else {
            val += cData[i/2];
        }

        if( dIsStereo ) {
            val += dData[i];
        } else {
            val += dData[i/2];
        }

        if( eIsStereo ) {
            val += eData[i];
        } else {
            val += eData[i/2];
        }

        if( fIsStereo ) {
            val += fData[i];
        } else {
            val += fData[i/2];
        }

        cachedVal_[i] = val; //cache value

        valShort[i] = CLIP(val, 32767, -32768);
    }
}

void AudioMixer::mixSevenStreams(SmartPtr<AudioRawData>* rawData,
                                int* index,
                                short* valShort,
                                int sampleSize)
{
    int a = index[0];
    int b = index[1];
    int c = index[2];
    int d = index[3];
    int e = index[4];
    int f = index[5];
    int g = index[6];
    short* aData = (short*)rawData[a]->rawAudioFrame_->data();
    short* bData = (short*)rawData[b]->rawAudioFrame_->data();
    short* cData = (short*)rawData[c]->rawAudioFrame_->data();
    short* dData = (short*)rawData[d]->rawAudioFrame_->data();
    short* eData = (short*)rawData[e]->rawAudioFrame_->data();
    short* fData = (short*)rawData[f]->rawAudioFrame_->data();
    short* gData = (short*)rawData[g]->rawAudioFrame_->data();

    bool aIsStereo = rawData[a]->bIsStereo;
    bool bIsStereo = rawData[b]->bIsStereo;
    bool cIsStereo = rawData[c]->bIsStereo;
    bool dIsStereo = rawData[d]->bIsStereo;
    bool eIsStereo = rawData[e]->bIsStereo;
    bool fIsStereo = rawData[f]->bIsStereo;
    bool gIsStereo = rawData[g]->bIsStereo;

    for ( int i = sampleSize*2-1; i>=0; i-- ) {
        int val = 0;
        if( aIsStereo ) {
            val += aData[i];
        } else {
            val += aData[i/2];
        }

        if( bIsStereo ) {
            val += bData[i];
        } else {
            val += bData[i/2];
        }

        if( cIsStereo ) {
            val += cData[i];
        } else {
            val += cData[i/2];
        }

        if( dIsStereo ) {
            val += dData[i];
        } else {
            val += dData[i/2];
        }

        if( eIsStereo ) {
            val += eData[i];
        } else {
            val += eData[i/2];
        }

        if( fIsStereo ) {
            val += fData[i];
        } else {
            val += fData[i/2];
        }
        if( gIsStereo ) {
            val += gData[i];
        } else {
            val += gData[i/2];
        }

        cachedVal_[i] = val; //cache value

        valShort[i] = CLIP(val, 32767, -32768);
    }
}

void AudioMixer::mixEightStreams(SmartPtr<AudioRawData>* rawData,
                                int* index,
                                short* valShort,
                                int sampleSize)
{
    int a = index[0];
    int b = index[1];
    int c = index[2];
    int d = index[3];
    int e = index[4];
    int f = index[5];
    int g = index[6];
    int h = index[7];
    short* aData = (short*)rawData[a]->rawAudioFrame_->data();
    short* bData = (short*)rawData[b]->rawAudioFrame_->data();
    short* cData = (short*)rawData[c]->rawAudioFrame_->data();
    short* dData = (short*)rawData[d]->rawAudioFrame_->data();
    short* eData = (short*)rawData[e]->rawAudioFrame_->data();
    short* fData = (short*)rawData[f]->rawAudioFrame_->data();
    short* gData = (short*)rawData[g]->rawAudioFrame_->data();
    short* hData = (short*)rawData[h]->rawAudioFrame_->data();

    bool aIsStereo = rawData[a]->bIsStereo;
    bool bIsStereo = rawData[b]->bIsStereo;
    bool cIsStereo = rawData[c]->bIsStereo;
    bool dIsStereo = rawData[d]->bIsStereo;
    bool eIsStereo = rawData[e]->bIsStereo;
    bool fIsStereo = rawData[f]->bIsStereo;
    bool gIsStereo = rawData[g]->bIsStereo;
    bool hIsStereo = rawData[h]->bIsStereo;

    for ( int i = sampleSize*2-1; i>=0; i-- ) {
        int val = 0;
        if( aIsStereo ) {
            val += aData[i];
        } else {
            val += aData[i/2];
        }

        if( bIsStereo ) {
            val += bData[i];
        } else {
            val += bData[i/2];
        }

        if( cIsStereo ) {
            val += cData[i];
        } else {
            val += cData[i/2];
        }

        if( dIsStereo ) {
            val += dData[i];
        } else {
            val += dData[i/2];
        }

        if( eIsStereo ) {
            val += eData[i];
        } else {
            val += eData[i/2];
        }

        if( fIsStereo ) {
            val += fData[i];
        } else {
            val += fData[i/2];
        }
        if( gIsStereo ) {
            val += gData[i];
        } else {
            val += gData[i/2];
        }
        if( hIsStereo ) {
            val += hData[i];
        } else {
            val += hData[i/2];
        }

        cachedVal_[i] = val; //cache value

        valShort[i] = CLIP(val, 32767, -32768);
    }
}

void AudioMixer::mixNineStreams(SmartPtr<AudioRawData>* rawData,
                                int* index,
                                short* valShort,
                                int sampleSize)
{
    int a = index[0];
    int b = index[1];
    int c = index[2];
    int d = index[3];
    int e = index[4];
    int f = index[5];
    int g = index[6];
    int h = index[7];
    int i = index[8];
    short* aData = (short*)rawData[a]->rawAudioFrame_->data();
    short* bData = (short*)rawData[b]->rawAudioFrame_->data();
    short* cData = (short*)rawData[c]->rawAudioFrame_->data();
    short* dData = (short*)rawData[d]->rawAudioFrame_->data();
    short* eData = (short*)rawData[e]->rawAudioFrame_->data();
    short* fData = (short*)rawData[f]->rawAudioFrame_->data();
    short* gData = (short*)rawData[g]->rawAudioFrame_->data();
    short* hData = (short*)rawData[h]->rawAudioFrame_->data();
    short* iData = (short*)rawData[i]->rawAudioFrame_->data();

    bool aIsStereo = rawData[a]->bIsStereo;
    bool bIsStereo = rawData[b]->bIsStereo;
    bool cIsStereo = rawData[c]->bIsStereo;
    bool dIsStereo = rawData[d]->bIsStereo;
    bool eIsStereo = rawData[e]->bIsStereo;
    bool fIsStereo = rawData[f]->bIsStereo;
    bool gIsStereo = rawData[g]->bIsStereo;
    bool hIsStereo = rawData[h]->bIsStereo;
    bool iIsStereo = rawData[i]->bIsStereo;

    for ( int i = sampleSize*2-1; i>=0; i-- ) {
        int val = 0;
        if( aIsStereo ) {
            val += aData[i];
        } else {
            val += aData[i/2];
        }

        if( bIsStereo ) {
            val += bData[i];
        } else {
            val += bData[i/2];
        }

        if( cIsStereo ) {
            val += cData[i];
        } else {
            val += cData[i/2];
        }

        if( dIsStereo ) {
            val += dData[i];
        } else {
            val += dData[i/2];
        }

        if( eIsStereo ) {
            val += eData[i];
        } else {
            val += eData[i/2];
        }

        if( fIsStereo ) {
            val += fData[i];
        } else {
            val += fData[i/2];
        }
        if( gIsStereo ) {
            val += gData[i];
        } else {
            val += gData[i/2];
        }
        if( hIsStereo ) {
            val += hData[i];
        } else {
            val += hData[i/2];
        }
        if( iIsStereo ) {
            val += iData[i];
        } else {
            val += iData[i/2];
        }

        cachedVal_[i] = val; //cache value

        valShort[i] = CLIP(val, 32767, -32768);
    }
}

void AudioMixer::readCachedStream(SmartPtr<AudioRawData>* rawData,
                                  u32 excludeStreamId, 
                                  short* valShort,
                                  int sampleSize)
{
    short* iData = (short*)rawData[excludeStreamId]->rawAudioFrame_->data();
    bool iIsStereo = rawData[excludeStreamId]->bIsStereo;
    for ( int i = sampleSize*2-1; i>=0; i-- ) {
        int val = cachedVal_[i];
        if( iIsStereo ) {
            val -= iData[i];
        } else {
            val -= iData[i/2];
        }
        valShort[i] = CLIP(val, 32767, -32768);
    }
}


void AudioMixer::findIndexes(SmartPtr<AudioRawData>* rawData,
                             u32 excludeStreamId,
                             int* indexArr)
{
    int i = 0;
    for(u32 j=0; j<MAX_XCODING_INSTANCES; j++) {
        if( rawData[j] && rawData[j]->bIsValid && j != excludeStreamId) {
            indexArr[i++] = j;
        }
    } 
}

//do the mixing, for now, always mix n speex streams into 1 speex stream
SmartPtr<SmartBuffer> AudioMixer::mixStreams(SmartPtr<AudioRawData>* rawData,
                                             int sampleSize,
                                             int totalStreams,
                                             u32 excludeStreamId)
{
    SmartPtr<SmartBuffer> result;
    if ( totalStreams > 0 ) {
        u32 frameTotalLen = sampleSize*sizeof(u16)*2; //stereo
        short valShort[sampleSize*2];
        switch ( totalStreams ) {
            case 1: {
                if( excludeStreamId != MAX_U32 ) {
                    //if nothing is mixed, i.e., one stream only voip, use white noise
                    genWhiteNoise(valShort, sampleSize*2);
                } else {
                    int index[1];
                    findIndexes(rawData, excludeStreamId, index);
                    mixOneStreams(rawData, index[0], valShort, sampleSize);
                }
                break;
            }
            case 2: {
                int index[2];
                findIndexes(rawData, excludeStreamId, index);
                if( excludeStreamId != MAX_U32 ) {
                    mixOneStreams(rawData, index[0], valShort, sampleSize);
                } else {
                    mixTwoStreams(rawData, index, valShort, sampleSize);
                }
                break;
            }
            case 3: {
                if( excludeStreamId != MAX_U32 ) {
                    readCachedStream(rawData, excludeStreamId, valShort, sampleSize);
                } else {
                    int index[3];
                    findIndexes(rawData, excludeStreamId, index);
                    mixThreeStreams(rawData, index, valShort, sampleSize);
                }
                break;
            }
            case 4: {
                if( excludeStreamId != MAX_U32 ) {
                    readCachedStream(rawData, excludeStreamId, valShort, sampleSize);
                } else {
                    int index[4];
                    findIndexes(rawData, excludeStreamId, index);
                    mixFourStreams(rawData, index, valShort, sampleSize);
                }
                break;
            }
            case 5: {
                if( excludeStreamId != MAX_U32 ) {
                    readCachedStream(rawData, excludeStreamId, valShort, sampleSize);
                } else {
                    int index[5];
                    findIndexes(rawData, excludeStreamId, index);
                    mixFiveStreams(rawData, index, valShort, sampleSize);
                }
                break;
            }
            case 6: {
                if( excludeStreamId != MAX_U32 ) {
                    readCachedStream(rawData, excludeStreamId, valShort, sampleSize);
                } else {
                    int index[6];
                    findIndexes(rawData, excludeStreamId, index);
                    mixSixStreams(rawData, index, valShort, sampleSize);
                }
                break;
            }
            case 7: {
                if( excludeStreamId != MAX_U32 ) {
                    readCachedStream(rawData, excludeStreamId, valShort, sampleSize);
                } else {
                    int index[7];
                    findIndexes(rawData, excludeStreamId, index);
                    mixSevenStreams(rawData, index, valShort, sampleSize);
                }
                break;
            }
            case 8: {
                if( excludeStreamId != MAX_U32 ) {
                    readCachedStream(rawData, excludeStreamId, valShort, sampleSize);
                } else {
                    int index[8];
                    findIndexes(rawData, excludeStreamId, index);
                    mixEightStreams(rawData, index, valShort, sampleSize);
                }
                break;
            }
            case 9: {
                if( excludeStreamId != MAX_U32 ) {
                    readCachedStream(rawData, excludeStreamId, valShort, sampleSize);
                } else {
                    int index[9];
                    findIndexes(rawData, excludeStreamId, index);
                    mixNineStreams(rawData, index, valShort, sampleSize);
                }
                break;
            }
              
            /* Brutal force algorithm
            for ( u32 i = 0; i < frameTotalLen; i+=2 ) {
                int val = 0;
                for(u32 j=0; j<MAX_XCODING_INSTANCES; j++) {
                    if( settings[j].bIsValid && j != excludeStreamId ) { 
                        short* data = (short*)buffer[j]->data();
                        val += data[i/2];
                        isMixed = true;
                        //LOG("i=%d j=%d audio mixed val = %d, flen=%d, excludeStreamId=%d\n", i, j, val, frameTotalLen, excludeStreamId);       
                    }
                }
                valShort[i/2] = CLIP(val, 32767, -32768);
            }
            */
        }

        result = new SmartBuffer( frameTotalLen, (u8*)valShort);
    }
    return result;
}

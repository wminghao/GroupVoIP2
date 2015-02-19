#include "VideoMixer.h"
#include "fwk/log.h"
#include "fwk/Units.h"

int mappingToScalingWidth(int totalStream) {
    if(totalStream == 1) {
        return 640;
    } else if(totalStream <= 4) {
        return 320;
    } else if(totalStream <= 9) {
        return 213;
    } else if(totalStream <= 16) {
        return 160;
    } else if(totalStream <= 25) {
        return 128;
    } else {
        return 106;
    }
}
int mappingToScalingHeight(int totalStream) {
    if(totalStream == 1) {
        return 480;
    } else if(totalStream <= 4) {
        return 240;
    } else if(totalStream <= 9) {
        return 160;
    } else if(totalStream <= 16) {
        return 120;
    } else if(totalStream <= 25) {
        return 96;
    } else {
        return 80;
    }
}

//do the mixing, for now, always mix n raw streams into 1 rawstream
SmartPtr<SmartBuffer> VideoMixer::mixStreams(SmartPtr<VideoRawData>* rawData,
                                             int totalStreams,
                                             VideoRect* videoRect)
{
    SmartPtr<SmartBuffer> result;
    if( tryToInitSws(rawData, totalStreams) ) {
        int scaledWidth = mappingToScalingWidth(totalStreams);
        int scaledHeight = mappingToScalingHeight(totalStreams);

        SmartPtr<SmartBuffer> scaledVideoPlanes[MAX_XCODING_INSTANCES][3];
        int scaledVideoStrides[MAX_XCODING_INSTANCES][3];

        int validStreamId[totalStreams];
        int validStreamIdIndex = 0;
        
        for(u32 i=0; i<MAX_XCODING_INSTANCES; i++) {
            if( rawData[i] && rawData[i]->rawVideoSettings_.bIsValid ) { 
                scaledVideoPlanes[i][0] = new SmartBuffer( scaledWidth* scaledHeight );
                scaledVideoPlanes[i][1] = new SmartBuffer( ( scaledWidth * scaledHeight  + 4) / 4 );
                scaledVideoPlanes[i][2] = new SmartBuffer( ( scaledWidth * scaledHeight  + 4) / 4 );
                scaledVideoStrides[i][0] = scaledWidth;
                scaledVideoStrides[i][1] = scaledWidth/2;
                scaledVideoStrides[i][2] = scaledWidth/2;
                
                u8* inputPlanes[3];
                inputPlanes[0] = rawData[i]->rawVideoPlanes_[0]->data();
                inputPlanes[1] = rawData[i]->rawVideoPlanes_[1]->data();
                inputPlanes[2] = rawData[i]->rawVideoPlanes_[2]->data();

                u8* scaledPlanes[3];
                scaledPlanes[0] = scaledVideoPlanes[i][0]->data();
                scaledPlanes[1] = scaledVideoPlanes[i][1]->data();
                scaledPlanes[2] = scaledVideoPlanes[i][2]->data();
                sws_scale( swsCtx_[i], inputPlanes, rawData[i]->rawVideoStrides_, 0, rawData[i]->rawVideoSettings_.height,
                           scaledPlanes, scaledVideoStrides[i]);
                validStreamId[validStreamIdIndex++] = i;
                ASSERT(validStreamIdIndex <= totalStreams);
            }
        }
        ASSERT( validStreamIdIndex == totalStreams );

        if ( totalStreams > 0 ) {
            int outputWidth = outputSetting_.width;
            int outputHeight = outputSetting_.height;
            result = new SmartBuffer( outputWidth*outputHeight*3/2 );
            u8* out = result->data();
            u32 offsetOut = 0;

            if( totalStreams == 1 ) {
                int curStreamId = validStreamId[0];
                ASSERT( curStreamId != -1 );

                mixStreamsInternal( curStreamId, 
                                    scaledVideoPlanes,
                                    scaledVideoStrides,
                                    videoRect,
                                    0,
                                    0,
                                    scaledWidth,
                                    scaledHeight,
                                    outputWidth,
                                    outputHeight,
                                    out,
                                    offsetOut);
            } else if( totalStreams == 2 ) {                
                int startingOffsetY = (outputWidth*scaledHeight)/2;
                int startingOffsetUV = (outputWidth*scaledHeight)/8;

                fillWithBlack(outputWidth,
                              outputHeight,
                              out);
                
                for(int index=0; index<totalStreams; index++) {
                    int curStreamId = validStreamId[index];
                    mixStreamsInternal( curStreamId, 
                                        scaledVideoPlanes,
                                        scaledVideoStrides,
                                        videoRect,
                                        startingOffsetY,
                                        startingOffsetUV,
                                        scaledWidth,
                                        scaledHeight,
                                        outputWidth,
                                        outputHeight,
                                        out,
                                        offsetOut);

                    startingOffsetY += scaledWidth;
                    startingOffsetUV += scaledWidth/2;                    
                } 
            } else if( totalStreams == 3 ) {                
                int startingOffsetY = scaledWidth/2;
                int startingOffsetUV = scaledWidth/4;
                fillWithBlack(outputWidth,
                              outputHeight,
                              out);
                
                for(int index=0; index<totalStreams; index++) {
                    int curStreamId = validStreamId[index];
                    mixStreamsInternal( curStreamId, 
                                        scaledVideoPlanes,
                                        scaledVideoStrides,
                                        videoRect,
                                        startingOffsetY,
                                        startingOffsetUV,
                                        scaledWidth,
                                        scaledHeight,
                                        outputWidth,
                                        outputHeight,
                                        out,
                                        offsetOut);
                    
                    if( index == 0 ) {
                        startingOffsetY = outputWidth*outputHeight/2;
                        startingOffsetUV = outputWidth*outputHeight/8;
                    } else {
                        startingOffsetY += scaledWidth;
                        startingOffsetUV += scaledWidth/2;                    
                    }
                }
            } else if( totalStreams == 4 ) {         
                int startingOffsetY = 0;
                int startingOffsetUV = 0;
                
                for(int index=0; index<totalStreams; index++) {
                    int curStreamId = validStreamId[index];
                    mixStreamsInternal( curStreamId, 
                                        scaledVideoPlanes,
                                        scaledVideoStrides,
                                        videoRect,
                                        startingOffsetY,
                                        startingOffsetUV,
                                        scaledWidth,
                                        scaledHeight,
                                        outputWidth,
                                        outputHeight,
                                        out,
                                        offsetOut);
                    
                    if((index + 1) == 2) {
                        startingOffsetY = outputWidth*outputHeight/2;
                        startingOffsetUV = outputWidth*outputHeight/8;
                    } else {
                        startingOffsetY += scaledWidth;
                        startingOffsetUV += scaledWidth/2;                    
                    }
                }
            } else if( totalStreams == 5 ) {
                int startingOffsetY = (scaledWidth + outputWidth*scaledHeight)/2;
                int startingOffsetUV = (scaledWidth + outputWidth*scaledHeight)/8;
                fillWithBlack(outputWidth,
                              outputHeight,
                              out);
                
                for(int index=0; index<totalStreams; index++) {
                    int curStreamId = validStreamId[index];
                    mixStreamsInternal( curStreamId, 
                                        scaledVideoPlanes,
                                        scaledVideoStrides,
                                        videoRect,
                                        startingOffsetY,
                                        startingOffsetUV,
                                        scaledWidth,
                                        scaledHeight,
                                        outputWidth,
                                        outputHeight,
                                        out,
                                        offsetOut);
                    if( index == 1 ) {
                        startingOffsetY = outputWidth*outputHeight/2;
                        startingOffsetUV = outputWidth*outputHeight/8;
                    } else {
                        startingOffsetY += scaledWidth;
                        startingOffsetUV += scaledWidth/2;                    
                    }
                }
            } else if( totalStreams == 6 ) {
                int startingOffsetY = (outputWidth*scaledHeight)/2;
                int startingOffsetUV = (outputWidth*scaledHeight)/8;
                fillWithBlack(outputWidth,
                              outputHeight,
                              out);
                
                for(int index=0; index<totalStreams; index++) {
                    int curStreamId = validStreamId[index];
                    mixStreamsInternal( curStreamId, 
                                        scaledVideoPlanes,
                                        scaledVideoStrides,
                                        videoRect,
                                        startingOffsetY,
                                        startingOffsetUV,
                                        scaledWidth,
                                        scaledHeight,
                                        outputWidth,
                                        outputHeight,
                                        out,
                                        offsetOut);
                    if( index == 2 ) {
                        startingOffsetY = outputWidth*outputHeight/2;
                        startingOffsetUV = outputWidth*outputHeight/8;
                    } else {
                        startingOffsetY += scaledWidth;
                        startingOffsetUV += scaledWidth/2;                    
                    }
                }
            }else if( totalStreams == 7 ) {
                int startingOffsetY = outputWidth/3;
                int startingOffsetUV = outputWidth/6;
                fillWithBlack(outputWidth,
                              outputHeight,
                              out);
                
                for(int index=0; index<totalStreams; index++) {
                    int curStreamId = validStreamId[index];
                    mixStreamsInternal( curStreamId, 
                                        scaledVideoPlanes,
                                        scaledVideoStrides,
                                        videoRect,
                                        startingOffsetY,
                                        startingOffsetUV,
                                        scaledWidth,
                                        scaledHeight,
                                        outputWidth,
                                        outputHeight,
                                        out,
                                        offsetOut);
                    if( index == 0 ) {
                        startingOffsetY = outputWidth*outputHeight/3;
                        startingOffsetUV = outputWidth*outputHeight/12;
                    } else if( index == 3) {
                        startingOffsetY = (outputWidth*outputHeight*2)/3;
                        startingOffsetUV = (outputWidth*outputHeight*2)/12;
                    } else {
                        startingOffsetY += scaledWidth;
                        startingOffsetUV += scaledWidth/2;                    
                    }
                }
            } else if( totalStreams == 8 ) {
                int startingOffsetY = outputWidth/6;
                int startingOffsetUV = outputWidth/12;
                fillWithBlack(outputWidth,
                              outputHeight,
                              out);
                
                for(int index=0; index<totalStreams; index++) {
                    int curStreamId = validStreamId[index];
                    mixStreamsInternal( curStreamId, 
                                        scaledVideoPlanes,
                                        scaledVideoStrides,
                                        videoRect,
                                        startingOffsetY,
                                        startingOffsetUV,
                                        scaledWidth,
                                        scaledHeight,
                                        outputWidth,
                                        outputHeight,
                                        out,
                                        offsetOut);
                    if( index == 1 ) {
                        startingOffsetY = outputWidth*outputHeight/3;
                        startingOffsetUV = outputWidth*outputHeight/12;
                    } else if( index == 4) {
                        startingOffsetY = (outputWidth*outputHeight*2)/3;
                        startingOffsetUV = (outputWidth*outputHeight*2)/12;
                    } else {
                        startingOffsetY += scaledWidth;
                        startingOffsetUV += scaledWidth/2;                    
                    }
                }

            }else if( totalStreams == 9 ) {
                int startingOffsetY = 0;
                int startingOffsetUV = 0;
                fillWithBlack(outputWidth,
                              outputHeight,
                              out);
                
                for(int index=0; index<totalStreams; index++) {
                    int curStreamId = validStreamId[index];
                    mixStreamsInternal( curStreamId, 
                                        scaledVideoPlanes,
                                        scaledVideoStrides,
                                        videoRect,
                                        startingOffsetY,
                                        startingOffsetUV,
                                        scaledWidth,
                                        scaledHeight,
                                        outputWidth,
                                        outputHeight,
                                        out,
                                        offsetOut);
                    if( index == 2 ) {
                        startingOffsetY = outputWidth*outputHeight/3;
                        startingOffsetUV = outputWidth*outputHeight/12;
                    } else if( index == 5) {
                        startingOffsetY = (outputWidth*outputHeight*2)/3;
                        startingOffsetUV = (outputWidth*outputHeight*2)/12;
                    } else {
                        startingOffsetY += scaledWidth;
                        startingOffsetUV += scaledWidth/2;                    
                    }                    
                }
            } else {
                //TODO do mixing for other cases
            }
        }
    }
    return result;
}
void VideoMixer::fillWithBlack( int outputWidth,
                                int outputHeight,
                                u8* out ) {
    int blackY = 16;
    memset(out, blackY, outputWidth*outputHeight);
    int blackUV = 128;
    memset(out+outputWidth*outputHeight, blackUV, outputWidth*outputHeight/2);    
}
void VideoMixer::mixStreamsInternal( int curStreamId,
                                     SmartPtr<SmartBuffer> scaledVideoPlanes[][3],
                                     int scaledVideoStrides[][3],
                                     VideoRect* videoRect,
                                     int startingOffsetY,
                                     int startingOffsetUV,
                                     int scaledWidth,
                                     int scaledHeight,
                                     int outputWidth,
                                     int outputHeight,
                                     u8* out,
                                     u32& offsetOut)
{
    if(videoRect) {
        videoRect[curStreamId].x = startingOffsetY%outputWidth;
        videoRect[curStreamId].y = startingOffsetY/outputWidth;
        videoRect[curStreamId].width = scaledWidth;
        videoRect[curStreamId].height = scaledHeight;
        //LOG("----i=%d, x=%d, y=%d, w=%d,h=%d\r\n", curStreamId, videoRect[curStreamId].x, videoRect[curStreamId].y, videoRect[curStreamId].width, videoRect[curStreamId].height);
    }
    
    //convert from AV_PIX_FMT_YUV420P
    //3 planes combined into 1 buffer
    offsetOut = startingOffsetY;
    u8* in = scaledVideoPlanes[curStreamId][0]->data();            
    u32 bytesPerLineInY = scaledVideoStrides[curStreamId][0];                                                                                                                            
    u32 offsetInY = 0;                                                                                                                                                            
    for(int i = 0; i < scaledHeight; i ++ ) {          
        memcpy( out+offsetOut, in+offsetInY, scaledWidth);
        offsetInY += bytesPerLineInY;                                                                                                               
        offsetOut += outputWidth;                                                                                                                                   
    }
    
    offsetOut = outputWidth*outputHeight + startingOffsetUV;
    in = scaledVideoPlanes[curStreamId][1]->data();
    u32 bytesPerLineInU = scaledVideoStrides[curStreamId][1];
    u32 offsetInU = 0;                                                                                                                                                              
    for(int i = 0; i < scaledHeight/2; i ++ ) {
        memcpy( out+offsetOut, in+offsetInU, scaledWidth/2);                                                                
        offsetInU += bytesPerLineInU;
        offsetOut += outputWidth/2;       
    }                                                     
    
    offsetOut = outputWidth*outputHeight*5/4 + startingOffsetUV;  
    in = scaledVideoPlanes[curStreamId][2]->data();
    u32 bytesPerLineInV = scaledVideoStrides[curStreamId][2];
    u32 offsetInV = 0; 
    for(int i = 0; i < scaledHeight/2; i ++ ) {
        memcpy( out+offsetOut, in+offsetInV, scaledWidth/2);
        offsetInV += bytesPerLineInV;
        offsetOut += outputWidth/2;
    }
}
VideoMixer::~VideoMixer()
{
    releaseSws();
}
void VideoMixer::releaseSws()
{
    for(u32 i=0; i<MAX_XCODING_INSTANCES; i++) {
        if( swsCtx_[i] ) {
            sws_freeContext( swsCtx_[i] );
            swsCtx_[i] = 0;
        }
    }
}
bool VideoMixer::tryToInitSws(SmartPtr<VideoRawData>* rawData, int totalStreams)
{
    bool ret = true;
    int outputWidth = mappingToScalingWidth(totalStreams);
    int outputHeight = mappingToScalingHeight(totalStreams);

    if( mappingToScalingWidth(totalStreams_) != outputWidth ) {
        releaseSws();
    }
    for(u32 i=0;  i<MAX_XCODING_INSTANCES; i++) {
        if( rawData[i] ) {
            VideoStreamSetting* curSetting = &(rawData[i]->rawVideoSettings_);
            if ( curSetting->bIsValid && !swsCtx_[i] ) {
                swsCtx_[i] = sws_getCachedContext( swsCtx_[i], curSetting->width, curSetting->height, PIX_FMT_YUV420P,
                                                   outputWidth, outputHeight, PIX_FMT_YUV420P,
                                                   SWS_BICUBIC, 0, 0, 0 );
                if( !swsCtx_[i] ) {
                    LOG("FAILED to create swscale context, inWidth=%d, inHeight=%d, outWith=%d, outHeight=%d\n", curSetting->width, curSetting->height, outputWidth, outputHeight);
                    ret = false;
                }
            }
        }
    }
    totalStreams_ = totalStreams;
    return ret;
}

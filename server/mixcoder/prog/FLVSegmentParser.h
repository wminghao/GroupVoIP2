#ifndef __FLV_SEG_PARSER__
#define __FLV_SEG_PARSER__

#include "FLVParser.h"
#include "FLVSegmentParserDelegate.h"
#include "FLVParserDelegate.h"
#include <string>

using namespace std;

class FLVSegmentParser:public FLVParserDelegate
{
 public:
 FLVSegmentParser(FLVSegmentParserDelegate* dele):delegate_(dele), parsingState_(SEARCHING_SEGHEADER),
        curSegTagSize_(0), curStreamId_(0), curStreamLen_(0), 
        curStreamCnt_(0), numStreams_(0){
        for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++) {
            parser_[i] = new FLVParser(this, i);
        }
    }
    virtual ~FLVSegmentParser() {
        for(u32 i = 0; i < MAX_XCODING_INSTANCES; i++) {
            delete parser_[i];
        }
    }
    bool readData(SmartPtr<SmartBuffer> input);                     
    StreamSource getStreamSource(int streamId) { return streamSource_[streamId]; }

 private:
    virtual u32 getGlobalAudioTimestamp() {
        return delegate_->getGlobalAudioTimestamp();
    }
    virtual void onFLVFrameParsed( SmartPtr<AccessUnit> au, int index ) {
        delegate_->onFLVFrameParsed(au, index);
    }
    
 private:
    FLVSegmentParserDelegate* delegate_;
    
    typedef enum FLVSegmentParsingState
    {
        SEARCHING_SEGHEADER,
        SEARCHING_STREAM_MASK,
        SEARCHING_STREAM_HEADER,
        SEARCHING_STREAM_DATA
    }FLVSegmentParsingState;
    
    //parsing logic
    FLVSegmentParsingState parsingState_;
    string curBuf_;
    u32 curSegTagSize_;
    u32 curStreamId_;
    u32 curStreamLen_;
    u32 curStreamCnt_;
    FLVParser* parser_[MAX_XCODING_INSTANCES];
    StreamSource streamSource_[MAX_XCODING_INSTANCES];
    
    u32 numStreams_;
};

#endif

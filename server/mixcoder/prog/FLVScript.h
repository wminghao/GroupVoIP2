#ifndef __FLV_SCRIPT__
#define __FLV_SCRIPT__

#include "fwk/SmartPtr.h"
#include "fwk/SmartBuffer.h"
#include "string"
#include "vector"

using namespace std;

class FLVScript
{
 public:
    FLVScript(){}
    ~FLVScript(){}

    bool newNameValuePair(const string& name, int value);
    SmartPtr<SmartBuffer> toBuf(const string& method);

 private:
    static inline void toAMF0AppendTypelessString( string *out, const string &str ) {
        u32 len = str.length();
        out->append( 1, (len>>8)&0xff );
        out->append( 1, len&0xff );
        out->append( str );
    }

    static inline void toAMF0AppendTypelessU32( string *out, const u32 &n ) {
        out->append( 1, (n>>24)&0xff );
        out->append( 1, (n>>16)&0xff );
        out->append( 1, (n>>8)&0xff );
        out->append( 1, n&0xff );
    }

    static inline void toAMF0AppendTypelessU24( string *out, const u32 &n ) {
        out->append( 1, (n>>16)&0xff );
        out->append( 1, (n>>8)&0xff );
        out->append( 1, n&0xff );
    }

    static inline void toAMF0AppendDouble( string *out, double f ) {
        unsigned char *fptr = (unsigned char *)&f;
        out->append( 1, 0 );
        out->append( 1, fptr[7] );
        out->append( 1, fptr[6] );
        out->append( 1, fptr[5] );
        out->append( 1, fptr[4] );
        out->append( 1, fptr[3] );
        out->append( 1, fptr[2] );
        out->append( 1, fptr[1] );
        out->append( 1, fptr[0] );
    }

    static inline void toAMF0AppendBoolean( string *out, bool b ) {
        out->append( 1, 1 );
        out->append( 1, (b?1:0) );
    }    

    static inline void toAMF0AppendString( string *out, const string &str ) {
        out->append( 1, 2 );
        out->append( 1, (str.length()>>8)&0xff );
        out->append( 1, (str.length())&0xff );
        out->append( str );
    }
    class ECMAArrayDoubleElement {
    public:
        ECMAArrayDoubleElement( const string &name, double f ) : name_(name), f_(f){}
        void write( string *str ) {
            toAMF0AppendTypelessString( str, name_ );
            toAMF0AppendDouble( str, f_ );
        }
    private:
        string name_;
        double f_;
    };
    
 private:
    vector<ECMAArrayDoubleElement> args_;
};

#endif //__FLV_SCRIPT__

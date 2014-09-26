#include "FLVScript.h"
#include "fwk/log.h"

bool FLVScript::newNameValuePair(const string& name, int value)
{
    args_.push_back( ECMAArrayDoubleElement( name, (double)value ) );
    //LOG("-----Pushed name-value pair, name=%s, value=%d", name.data(), value);
    return true;
}
SmartPtr<SmartBuffer> FLVScript::toBuf(const string& method)
{
    //create an ECMA array
    string buf;
    toAMF0AppendString( &buf, method );
    buf.append( 1, 8 ); // type: ECMA Array
    toAMF0AppendTypelessU32( &buf, args_.size() ); // number of arguments in the ECMA Array
    for ( size_t i = 0 ; i < args_.size() ; ++i ) {
        args_[i].write( &buf );
    }
    toAMF0AppendTypelessU24( &buf, 9 ); // ECMA Array end
    //LOG("-----Wrote name-value pair, method=%s", method.data());

    return new SmartBuffer(buf);
}

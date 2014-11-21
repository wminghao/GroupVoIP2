.class public final Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;
.super Lcom/adobe/fre/FREContext;
.source "TelephoneManagerContext.java"


# instance fields
.field private functions:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/adobe/fre/FREFunction;",
            ">;"
        }
    .end annotation
.end field

.field private mAddListener:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$AddListener;

.field private mGetCallState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetCallState;

.field private mGetDataState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDataState;

.field private mGetDeviceId:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceId;

.field private mGetDeviceSoftwareVersion:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceSoftwareVersion;

.field private mGetGroupIdLevel1:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetGroupIdLevel1;

.field private mGetMmsUAProfUrl:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUAProfUrl;

.field private mGetMmsUserAgent:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUserAgent;

.field private mGetNetworkCountryIso:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkCountryIso;

.field private mGetNetworkOperator:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperator;

.field private mGetNetworkOperatorName:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperatorName;

.field private mGetNetworkType:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkType;

.field private mGetPhoneNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneNumber;

.field private mGetPhoneType:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneType;

.field private mGetSimCountryIso:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimCountryIso;

.field private mGetSimOperator:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperator;

.field private mGetSimOperatorName:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperatorName;

.field private mGetSimSerialNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimSerialNumber;

.field private mGetSimState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimState;

.field private mGetSubscriberId:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSubscriberId;

.field private mGetVoiceMailAlphaTag:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailAlphaTag;

.field private mGetVoiceMailNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailNumber;

.field private mIsNetworkRoaming:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsNetworkRoaming;

.field private mIsSmsCapable:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsSmsCapable;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 40
    invoke-direct {p0}, Lcom/adobe/fre/FREContext;-><init>()V

    .line 42
    return-void
.end method


# virtual methods
.method public final dispose()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 47
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mIsNetworkRoaming:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsNetworkRoaming;

    if-eqz v0, :cond_0

    .line 48
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->clear()V

    .line 49
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    .line 51
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetCallState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetCallState;

    .line 52
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDataState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDataState;

    .line 53
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDeviceId:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceId;

    .line 54
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDeviceSoftwareVersion:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceSoftwareVersion;

    .line 55
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetGroupIdLevel1:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetGroupIdLevel1;

    .line 56
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetMmsUAProfUrl:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUAProfUrl;

    .line 57
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetMmsUserAgent:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUserAgent;

    .line 58
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkCountryIso:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkCountryIso;

    .line 59
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkOperator:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperator;

    .line 60
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkOperatorName:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperatorName;

    .line 61
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkType:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkType;

    .line 62
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetPhoneNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneNumber;

    .line 63
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetPhoneType:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneType;

    .line 64
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimCountryIso:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimCountryIso;

    .line 65
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimOperator:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperator;

    .line 66
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimOperatorName:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperatorName;

    .line 67
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimSerialNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimSerialNumber;

    .line 68
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimState;

    .line 69
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSubscriberId:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSubscriberId;

    .line 70
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetVoiceMailAlphaTag:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailAlphaTag;

    .line 71
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetVoiceMailNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailNumber;

    .line 72
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mIsNetworkRoaming:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsNetworkRoaming;

    .line 73
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mIsSmsCapable:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsSmsCapable;

    .line 74
    iput-object v1, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mAddListener:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$AddListener;

    .line 76
    :cond_0
    return-void
.end method

.method public final getFunctions()Ljava/util/Map;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Lcom/adobe/fre/FREFunction;",
            ">;"
        }
    .end annotation

    .prologue
    .line 81
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetCallState;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetCallState;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetCallState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetCallState;

    .line 82
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDataState;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDataState;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDataState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDataState;

    .line 83
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceId;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceId;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDeviceId:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceId;

    .line 84
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceSoftwareVersion;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceSoftwareVersion;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDeviceSoftwareVersion:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceSoftwareVersion;

    .line 85
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetGroupIdLevel1;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetGroupIdLevel1;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetGroupIdLevel1:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetGroupIdLevel1;

    .line 86
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUAProfUrl;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUAProfUrl;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetMmsUAProfUrl:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUAProfUrl;

    .line 87
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUserAgent;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUserAgent;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetMmsUserAgent:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUserAgent;

    .line 88
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkCountryIso;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkCountryIso;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkCountryIso:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkCountryIso;

    .line 89
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperator;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperator;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkOperator:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperator;

    .line 90
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperatorName;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperatorName;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkOperatorName:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperatorName;

    .line 91
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkType;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkType;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkType:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkType;

    .line 92
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneNumber;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneNumber;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetPhoneNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneNumber;

    .line 93
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneType;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneType;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetPhoneType:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneType;

    .line 94
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimCountryIso;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimCountryIso;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimCountryIso:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimCountryIso;

    .line 95
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperator;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperator;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimOperator:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperator;

    .line 96
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperatorName;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperatorName;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimOperatorName:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperatorName;

    .line 97
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimSerialNumber;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimSerialNumber;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimSerialNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimSerialNumber;

    .line 98
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimState;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimState;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimState;

    .line 99
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSubscriberId;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSubscriberId;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSubscriberId:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSubscriberId;

    .line 100
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailAlphaTag;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailAlphaTag;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetVoiceMailAlphaTag:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailAlphaTag;

    .line 101
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailNumber;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailNumber;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetVoiceMailNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailNumber;

    .line 102
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsNetworkRoaming;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsNetworkRoaming;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mIsNetworkRoaming:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsNetworkRoaming;

    .line 103
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsSmsCapable;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsSmsCapable;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mIsSmsCapable:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsSmsCapable;

    .line 104
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$AddListener;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$AddListener;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mAddListener:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$AddListener;

    .line 106
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    .line 107
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getCallState"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetCallState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetCallState;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 108
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getDataState"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDataState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDataState;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 109
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getDeviceId"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDeviceId:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceId;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 110
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getDeviceSoftwareVersion"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetDeviceSoftwareVersion:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDeviceSoftwareVersion;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 111
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getGroupIdLevel1"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetGroupIdLevel1:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetGroupIdLevel1;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 112
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getMmsUAProfUrl"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetMmsUAProfUrl:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUAProfUrl;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 113
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getMmsUserAgent"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetMmsUserAgent:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetMmsUserAgent;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 114
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getNetworkCountryIso"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkCountryIso:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkCountryIso;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 115
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getNetworkOperator"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkOperator:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperator;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 116
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getNetworkOperatorName"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkOperatorName:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkOperatorName;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 117
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getNetworkType"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetNetworkType:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetNetworkType;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 118
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getPhoneNumber"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetPhoneNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneNumber;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 119
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getPhoneType"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetPhoneType:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetPhoneType;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 120
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getSimCountryIso"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimCountryIso:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimCountryIso;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 121
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getSimOperator"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimOperator:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperator;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 122
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getSimOperatorName"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimOperatorName:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimOperatorName;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 123
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getSimSerialNumber"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimSerialNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimSerialNumber;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 124
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getSimState"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSimState:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSimState;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 125
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getSubscriberId"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetSubscriberId:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetSubscriberId;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 126
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getVoiceMailAlphaTag"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetVoiceMailAlphaTag:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailAlphaTag;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 127
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "getVoiceMailNumber"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mGetVoiceMailNumber:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetVoiceMailNumber;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 128
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "isNetworkRoaming"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mIsNetworkRoaming:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsNetworkRoaming;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 129
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "isSmsCapable"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mIsSmsCapable:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$IsSmsCapable;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 130
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    const-string v1, "addListener"

    iget-object v2, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->mAddListener:Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$AddListener;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 131
    iget-object v0, p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->functions:Ljava/util/Map;

    return-object v0
.end method

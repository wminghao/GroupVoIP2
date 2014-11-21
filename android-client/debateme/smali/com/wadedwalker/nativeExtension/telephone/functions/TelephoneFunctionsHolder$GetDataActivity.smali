.class public Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$GetDataActivity;
.super Ljava/lang/Object;
.source "TelephoneFunctionsHolder.java"

# interfaces
.implements Lcom/adobe/fre/FREFunction;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "GetDataActivity"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final call(Lcom/adobe/fre/FREContext;[Lcom/adobe/fre/FREObject;)Lcom/adobe/fre/FREObject;
    .locals 3
    .parameter "context"
    .parameter "args"

    .prologue
    .line 45
    sget-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->telephonyManager:Landroid/telephony/TelephonyManager;

    if-nez v1, :cond_0

    .line 46
    sget-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    invoke-virtual {v1}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->getActivity()Landroid/app/Activity;

    move-result-object v1

    const-string v2, "phone"

    invoke-virtual {v1, v2}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Landroid/telephony/TelephonyManager;

    sput-object p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->telephonyManager:Landroid/telephony/TelephonyManager;

    .line 48
    :cond_0
    const/4 v0, 0x0

    .line 51
    .local v0, returnValue:Lcom/adobe/fre/FREObject;
    :try_start_0
    sget-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->telephonyManager:Landroid/telephony/TelephonyManager;

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getDataActivity()I

    move-result v1

    invoke-static {v1}, Lcom/adobe/fre/FREObject;->newObject(I)Lcom/adobe/fre/FREObject;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 57
    :goto_0
    return-object v0

    .line 53
    :catch_0
    move-exception v1

    goto :goto_0
.end method

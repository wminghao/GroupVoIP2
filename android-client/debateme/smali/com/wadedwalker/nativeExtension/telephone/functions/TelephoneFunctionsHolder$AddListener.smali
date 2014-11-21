.class public Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$AddListener;
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
    name = "AddListener"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 548
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final call(Lcom/adobe/fre/FREContext;[Lcom/adobe/fre/FREObject;)Lcom/adobe/fre/FREObject;
    .locals 3
    .parameter "context"
    .parameter "args"

    .prologue
    .line 551
    sget-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->telephonyManager:Landroid/telephony/TelephonyManager;

    if-nez v1, :cond_0

    .line 552
    sget-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    invoke-virtual {v1}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->getActivity()Landroid/app/Activity;

    move-result-object v1

    const-string v2, "phone"

    invoke-virtual {v1, v2}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Landroid/telephony/TelephonyManager;

    sput-object p0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->telephonyManager:Landroid/telephony/TelephonyManager;

    .line 554
    :cond_0
    sget-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->teleStateListener:Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;

    if-nez v1, :cond_1

    .line 555
    new-instance v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;

    invoke-direct {v1}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;-><init>()V

    sput-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->teleStateListener:Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;

    .line 558
    :cond_1
    const/4 v0, 0x0

    .line 561
    .local v0, flags:I
    const/4 v1, 0x0

    :try_start_0
    aget-object v1, p2, v1

    invoke-virtual {v1}, Lcom/adobe/fre/FREObject;->getAsInt()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v0

    .line 567
    :goto_0
    sget-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->telephonyManager:Landroid/telephony/TelephonyManager;

    sget-object v2, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->teleStateListener:Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;

    invoke-virtual {v1, v2, v0}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    .line 569
    const/4 v1, 0x0

    return-object v1

    .line 563
    :catch_0
    move-exception v1

    goto :goto_0
.end method

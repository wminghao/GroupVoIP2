.class public final Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;
.super Ljava/lang/Object;
.source "TelephoneManager.java"

# interfaces
.implements Lcom/adobe/fre/FREExtension;


# static fields
.field public static extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

.field public static teleStateListener:Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;

.field public static telephonyManager:Landroid/telephony/TelephonyManager;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final createContext(Ljava/lang/String;)Lcom/adobe/fre/FREContext;
    .locals 1
    .parameter "arg0"

    .prologue
    .line 18
    new-instance v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    invoke-direct {v0}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;-><init>()V

    sput-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    .line 19
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    return-object v0
.end method

.method public final dispose()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 25
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    if-eqz v0, :cond_0

    .line 26
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    invoke-virtual {v0}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->dispose()V

    .line 27
    sput-object v3, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    .line 28
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->telephonyManager:Landroid/telephony/TelephonyManager;

    sget-object v1, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->teleStateListener:Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    .line 29
    sput-object v3, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->teleStateListener:Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;

    .line 30
    sput-object v3, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->telephonyManager:Landroid/telephony/TelephonyManager;

    .line 32
    :cond_0
    return-void
.end method

.method public final initialize()V
    .locals 0

    .prologue
    .line 38
    return-void
.end method

.class public final Lcom/wadedwalker/nativeExtension/telephone/TelephoneStateListener;
.super Landroid/telephony/PhoneStateListener;
.source "TelephoneStateListener.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 6
    invoke-direct {p0}, Landroid/telephony/PhoneStateListener;-><init>()V

    return-void
.end method


# virtual methods
.method public final onCallStateChanged(ILjava/lang/String;)V
    .locals 4
    .parameter "state"
    .parameter "incomingNumber"

    .prologue
    const-string v3, "callStateChange"

    .line 9
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    if-eqz v0, :cond_0

    .line 10
    const/4 v0, 0x1

    if-ne v0, p1, :cond_1

    .line 11
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    .line 12
    const-string v1, "callStateChange"

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ringing,"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 11
    invoke-virtual {v0, v3, v1}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->dispatchStatusEventAsync(Ljava/lang/String;Ljava/lang/String;)V

    .line 24
    :cond_0
    :goto_0
    return-void

    .line 14
    :cond_1
    if-nez p1, :cond_2

    .line 15
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    .line 16
    const-string v1, "callStateChange"

    const-string v1, "idle"

    .line 15
    invoke-virtual {v0, v3, v1}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->dispatchStatusEventAsync(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 18
    :cond_2
    const/4 v0, 0x2

    if-ne v0, p1, :cond_0

    .line 19
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    .line 20
    const-string v1, "callStateChange"

    const-string v1, "offhook"

    .line 19
    invoke-virtual {v0, v3, v1}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->dispatchStatusEventAsync(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0
.end method

.method public final onDataActivity(I)V
    .locals 3
    .parameter "direction"

    .prologue
    .line 28
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    if-eqz v0, :cond_0

    .line 29
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    .line 30
    const-string v1, "dataActivityChange"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 29
    invoke-virtual {v0, v1, v2}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->dispatchStatusEventAsync(Ljava/lang/String;Ljava/lang/String;)V

    .line 33
    :cond_0
    return-void
.end method

.method public final onDataConnectionStateChanged(II)V
    .locals 4
    .parameter "state"
    .parameter "networkType"

    .prologue
    .line 37
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    if-eqz v0, :cond_0

    .line 38
    sget-object v0, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManager;->extension:Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;

    .line 39
    const-string v1, "dataConnectionStateChange"

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "state = "

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, ", networkType = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 38
    invoke-virtual {v0, v1, v2}, Lcom/wadedwalker/nativeExtension/telephone/TelephoneManagerContext;->dispatchStatusEventAsync(Ljava/lang/String;Ljava/lang/String;)V

    .line 42
    :cond_0
    return-void
.end method

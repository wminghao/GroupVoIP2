.class public Lcom/adobe/air/ShakeListenerService;
.super Landroid/app/IntentService;
.source "ShakeListenerService.java"


# instance fields
.field private final AIR_WAND_CLASS_NAME:Ljava/lang/String;

.field private mShakeListener:Lcom/adobe/air/ShakeListener;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 22
    const-string v0, "ShakeListenerService"

    invoke-direct {p0, v0}, Landroid/app/IntentService;-><init>(Ljava/lang/String;)V

    .line 68
    const-string v0, "com.adobe.air.wand.WandActivity"

    iput-object v0, p0, Lcom/adobe/air/ShakeListenerService;->AIR_WAND_CLASS_NAME:Ljava/lang/String;

    .line 23
    return-void
.end method


# virtual methods
.method protected onHandleIntent(Landroid/content/Intent;)V
    .locals 2
    .parameter

    .prologue
    .line 29
    :try_start_0
    new-instance v0, Lcom/adobe/air/ShakeListener;

    invoke-direct {v0, p0}, Lcom/adobe/air/ShakeListener;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/ShakeListenerService;->mShakeListener:Lcom/adobe/air/ShakeListener;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 37
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService;->mShakeListener:Lcom/adobe/air/ShakeListener;

    new-instance v1, Lcom/adobe/air/ShakeListenerService$1;

    invoke-direct {v1, p0}, Lcom/adobe/air/ShakeListenerService$1;-><init>(Lcom/adobe/air/ShakeListenerService;)V

    invoke-virtual {v0, v1}, Lcom/adobe/air/ShakeListener;->registerListener(Lcom/adobe/air/ShakeListener$Listener;)V

    .line 66
    :goto_0
    return-void

    .line 31
    :catch_0
    move-exception v0

    goto :goto_0
.end method

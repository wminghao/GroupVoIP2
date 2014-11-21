.class Lcom/adobe/air/ShakeListenerService$1;
.super Ljava/lang/Object;
.source "ShakeListenerService.java"

# interfaces
.implements Lcom/adobe/air/ShakeListener$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/ShakeListenerService;->onHandleIntent(Landroid/content/Intent;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/ShakeListenerService;


# direct methods
.method constructor <init>(Lcom/adobe/air/ShakeListenerService;)V
    .locals 0
    .parameter

    .prologue
    .line 38
    iput-object p1, p0, Lcom/adobe/air/ShakeListenerService$1;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onShake()V
    .locals 3

    .prologue
    .line 43
    iget-object v0, p0, Lcom/adobe/air/ShakeListenerService$1;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-virtual {v0}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "activity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 44
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object v0

    .line 45
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_0

    .line 47
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager$RunningTaskInfo;

    iget-object v0, v0, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    .line 51
    invoke-virtual {v0}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/adobe/air/ShakeListenerService$1;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-virtual {v2}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 53
    invoke-virtual {v0}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.adobe.air.wand.WandActivity"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 55
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/adobe/air/ShakeListenerService$1;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-virtual {v1}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-class v2, Lcom/adobe/air/wand/WandActivity;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 57
    const/high16 v1, 0x1040

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 58
    iget-object v1, p0, Lcom/adobe/air/ShakeListenerService$1;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-virtual {v1, v0}, Lcom/adobe/air/ShakeListenerService;->startActivity(Landroid/content/Intent;)V

    .line 64
    :cond_0
    return-void
.end method

.class Lair/Vispar/AppEntry$4;
.super Ljava/lang/Object;
.source "AppEntry.java"

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lair/Vispar/AppEntry;->launchAIRService()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lair/Vispar/AppEntry;


# direct methods
.method constructor <init>(Lair/Vispar/AppEntry;)V
    .locals 0
    .parameter

    .prologue
    .line 290
    iput-object p1, p0, Lair/Vispar/AppEntry$4;->this$0:Lair/Vispar/AppEntry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 2
    .parameter "name"
    .parameter "service"

    .prologue
    .line 296
    iget-object v0, p0, Lair/Vispar/AppEntry$4;->this$0:Lair/Vispar/AppEntry;

    invoke-virtual {v0, p0}, Lair/Vispar/AppEntry;->unbindService(Landroid/content/ServiceConnection;)V

    .line 299
    iget-object v0, p0, Lair/Vispar/AppEntry$4;->this$0:Lair/Vispar/AppEntry;

    #calls: Lair/Vispar/AppEntry;->loadSharedRuntimeDex()V
    invoke-static {v0}, Lair/Vispar/AppEntry;->access$300(Lair/Vispar/AppEntry;)V

    .line 300
    iget-object v0, p0, Lair/Vispar/AppEntry$4;->this$0:Lair/Vispar/AppEntry;

    const/4 v1, 0x0

    #calls: Lair/Vispar/AppEntry;->createActivityWrapper(Z)V
    invoke-static {v0, v1}, Lair/Vispar/AppEntry;->access$400(Lair/Vispar/AppEntry;Z)V

    .line 302
    invoke-static {}, Lair/Vispar/AppEntry;->access$500()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 304
    iget-object v0, p0, Lair/Vispar/AppEntry$4;->this$0:Lair/Vispar/AppEntry;

    #calls: Lair/Vispar/AppEntry;->InvokeWrapperOnCreate()V
    invoke-static {v0}, Lair/Vispar/AppEntry;->access$600(Lair/Vispar/AppEntry;)V

    .line 311
    :goto_0
    return-void

    .line 309
    :cond_0
    #calls: Lair/Vispar/AppEntry;->KillSelf()V
    invoke-static {}, Lair/Vispar/AppEntry;->access$700()V

    goto :goto_0
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 0
    .parameter "name"

    .prologue
    .line 316
    return-void
.end method

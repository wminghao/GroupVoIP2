.class Lcom/adobe/air/AIRUpdateDialog$3;
.super Ljava/lang/Object;
.source "AIRUpdateDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnKeyListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AIRUpdateDialog;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AIRUpdateDialog;


# direct methods
.method constructor <init>(Lcom/adobe/air/AIRUpdateDialog;)V
    .locals 0
    .parameter

    .prologue
    .line 44
    iput-object p1, p0, Lcom/adobe/air/AIRUpdateDialog$3;->this$0:Lcom/adobe/air/AIRUpdateDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onKey(Landroid/content/DialogInterface;ILandroid/view/KeyEvent;)Z
    .locals 4
    .parameter
    .parameter
    .parameter

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 47
    const/4 v0, 0x4

    if-eq p2, v0, :cond_0

    const/16 v0, 0x54

    if-ne p2, v0, :cond_1

    .line 50
    :cond_0
    invoke-interface {p1}, Landroid/content/DialogInterface;->cancel()V

    .line 51
    invoke-static {}, Lcom/adobe/air/AIRUpdateDialog;->access$100()Lcom/adobe/air/AIRUpdateDialog;

    move-result-object v0

    invoke-static {}, Lcom/adobe/air/AIRUpdateDialog;->access$200()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1, v2, v3, v2}, Lcom/adobe/air/InstallOfferPingUtils;->PingAndExit(Landroid/app/Activity;Ljava/lang/String;ZZZ)V

    move v0, v3

    .line 55
    :goto_0
    return v0

    :cond_1
    move v0, v2

    goto :goto_0
.end method

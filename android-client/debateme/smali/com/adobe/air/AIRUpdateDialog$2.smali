.class Lcom/adobe/air/AIRUpdateDialog$2;
.super Ljava/lang/Object;
.source "AIRUpdateDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


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
    .line 36
    iput-object p1, p0, Lcom/adobe/air/AIRUpdateDialog$2;->this$0:Lcom/adobe/air/AIRUpdateDialog;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4
    .parameter
    .parameter

    .prologue
    const/4 v3, 0x0

    .line 40
    invoke-static {}, Lcom/adobe/air/AIRUpdateDialog;->access$100()Lcom/adobe/air/AIRUpdateDialog;

    move-result-object v0

    invoke-static {}, Lcom/adobe/air/AIRUpdateDialog;->access$200()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v3, v2, v3}, Lcom/adobe/air/InstallOfferPingUtils;->PingAndExit(Landroid/app/Activity;Ljava/lang/String;ZZZ)V

    .line 41
    return-void
.end method

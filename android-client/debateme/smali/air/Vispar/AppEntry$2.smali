.class Lair/Vispar/AppEntry$2;
.super Ljava/lang/Object;
.source "AppEntry.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lair/Vispar/AppEntry;->showDialog(ILjava/lang/String;II)V
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
    .line 170
    iput-object p1, p0, Lair/Vispar/AppEntry$2;->this$0:Lair/Vispar/AppEntry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4
    .parameter "dialog"
    .parameter "which"

    .prologue
    const/4 v3, 0x0

    .line 173
    invoke-static {}, Lair/Vispar/AppEntry;->access$100()Lair/Vispar/AppEntry;

    move-result-object v0

    invoke-static {}, Lair/Vispar/AppEntry;->access$200()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v3, v3, v2}, Lcom/adobe/air/InstallOfferPingUtils;->PingAndExit(Landroid/app/Activity;Ljava/lang/String;ZZZ)V

    .line 174
    return-void
.end method

.class public Lcom/wadedwalker/nativeExtension/telephone/functions/TelephoneFunctionsHolder$MakeToast;
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
    name = "MakeToast"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 576
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final call(Lcom/adobe/fre/FREContext;[Lcom/adobe/fre/FREObject;)Lcom/adobe/fre/FREObject;
    .locals 3
    .parameter "context"
    .parameter "args"

    .prologue
    const/4 v2, 0x0

    .line 579
    const-string v0, ""

    .line 582
    .local v0, text:Ljava/lang/String;
    const/4 v1, 0x0

    :try_start_0
    aget-object v1, p2, v1

    invoke-virtual {v1}, Lcom/adobe/fre/FREObject;->getAsString()Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 588
    :goto_0
    invoke-virtual {p1}, Lcom/adobe/fre/FREContext;->getActivity()Landroid/app/Activity;

    move-result-object v1

    invoke-static {v1, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 590
    const/4 v1, 0x0

    return-object v1

    .line 584
    :catch_0
    move-exception v1

    goto :goto_0
.end method

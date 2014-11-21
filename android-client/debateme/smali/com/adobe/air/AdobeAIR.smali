.class public Lcom/adobe/air/AdobeAIR;
.super Landroid/app/Activity;
.source "AdobeAIR.java"


# static fields
.field private static final PROPERTY_INITIAL_LAUNCH:Ljava/lang/String; = "initialLaunch"

.field private static final TAG:Ljava/lang/String; = "Adobe AIR"


# instance fields
.field public DYNAMIC_URL:Ljava/lang/String;

.field private mCtx:Landroid/content/Context;

.field private mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 34
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 119
    iput-object v1, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    .line 120
    const-string v0, "https://www.adobe.com/airgames/5/"

    iput-object v0, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    .line 123
    iput-object v1, p0, Lcom/adobe/air/AdobeAIR;->mCtx:Landroid/content/Context;

    return-void
.end method

.method private isInitialLaunch()Z
    .locals 3

    .prologue
    .line 62
    const-class v0, Lcom/adobe/air/AdobeAIR;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adobe/air/AdobeAIR;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 63
    const-string v1, "initialLaunch"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    return v0
.end method

.method private updateSharedPrefForInitialLaunch()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 70
    const-class v0, Lcom/adobe/air/AdobeAIR;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, v2}, Lcom/adobe/air/AdobeAIR;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 71
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 72
    const-string v1, "initialLaunch"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 73
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 74
    return-void
.end method


# virtual methods
.method public onBackPressed()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 90
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 94
    const/16 v1, 0xc

    if-lt v0, v1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v0}, Lcom/adobe/air/AdobeAIRWebView;->canGoBack()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 97
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v0}, Lcom/adobe/air/AdobeAIRWebView;->copyBackForwardList()Landroid/webkit/WebBackForwardList;

    move-result-object v0

    .line 98
    invoke-virtual {v0}, Landroid/webkit/WebBackForwardList;->getCurrentIndex()I

    move-result v1

    .line 99
    if-lez v1, :cond_1

    .line 101
    sub-int/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/webkit/WebBackForwardList;->getItemAtIndex(I)Landroid/webkit/WebHistoryItem;

    move-result-object v0

    invoke-virtual {v0}, Landroid/webkit/WebHistoryItem;->getUrl()Ljava/lang/String;

    move-result-object v0

    .line 104
    iget-object v1, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 105
    const/4 v0, 0x0

    .line 110
    :goto_0
    if-eqz v0, :cond_0

    .line 112
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v0}, Lcom/adobe/air/AdobeAIRWebView;->goBack()V

    .line 117
    :goto_1
    return-void

    .line 116
    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V

    goto :goto_1

    :cond_1
    move v0, v2

    goto :goto_0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .parameter

    .prologue
    .line 41
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 43
    iput-object p0, p0, Lcom/adobe/air/AdobeAIR;->mCtx:Landroid/content/Context;

    .line 45
    invoke-direct {p0}, Lcom/adobe/air/AdobeAIR;->isInitialLaunch()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 47
    const-string v0, "https://www.adobe.com/airgames/4/"

    iput-object v0, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    .line 48
    invoke-direct {p0}, Lcom/adobe/air/AdobeAIR;->updateSharedPrefForInitialLaunch()V

    .line 51
    :cond_0
    new-instance v0, Lcom/adobe/air/AdobeAIRWebView;

    iget-object v1, p0, Lcom/adobe/air/AdobeAIR;->mCtx:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    .line 52
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v0}, Lcom/adobe/air/AdobeAIRWebView;->create()V

    .line 55
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    iget-object v1, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;->loadUrl(Ljava/lang/String;)V

    .line 57
    invoke-virtual {p0}, Lcom/adobe/air/AdobeAIR;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/AdobeAIR;->onNewIntent(Landroid/content/Intent;)V

    .line 58
    return-void
.end method

.method public onResume()V
    .locals 2

    .prologue
    .line 79
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 80
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v0}, Lcom/adobe/air/AdobeAIRWebView;->isOffline()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 82
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;->setOffline(Z)V

    .line 83
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    iget-object v1, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;->loadUrl(Ljava/lang/String;)V

    .line 85
    :cond_0
    return-void
.end method

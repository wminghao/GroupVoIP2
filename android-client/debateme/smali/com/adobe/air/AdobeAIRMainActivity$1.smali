.class Lcom/adobe/air/AdobeAIRMainActivity$1;
.super Ljava/lang/Object;
.source "AdobeAIRMainActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AdobeAIRMainActivity;->decideDefaultActivityForNextLaunch()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AdobeAIRMainActivity;


# direct methods
.method constructor <init>(Lcom/adobe/air/AdobeAIRMainActivity;)V
    .locals 0
    .parameter

    .prologue
    .line 249
    iput-object p1, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 254
    new-instance v0, Lorg/apache/http/impl/client/DefaultHttpClient;

    invoke-direct {v0}, Lorg/apache/http/impl/client/DefaultHttpClient;-><init>()V

    .line 255
    new-instance v1, Lorg/apache/http/client/methods/HttpGet;

    iget-object v2, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    #getter for: Lcom/adobe/air/AdobeAIRMainActivity;->mAirPropsFileUrl:Ljava/lang/String;
    invoke-static {v2}, Lcom/adobe/air/AdobeAIRMainActivity;->access$000(Lcom/adobe/air/AdobeAIRMainActivity;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Lorg/apache/http/client/methods/HttpGet;-><init>(Ljava/lang/String;)V

    .line 257
    :try_start_0
    invoke-virtual {v0, v1}, Lorg/apache/http/impl/client/DefaultHttpClient;->execute(Lorg/apache/http/client/methods/HttpUriRequest;)Lorg/apache/http/HttpResponse;

    move-result-object v0

    .line 258
    invoke-interface {v0}, Lorg/apache/http/HttpResponse;->getEntity()Lorg/apache/http/HttpEntity;

    move-result-object v0

    invoke-interface {v0}, Lorg/apache/http/HttpEntity;->getContent()Ljava/io/InputStream;

    move-result-object v0

    .line 259
    new-instance v1, Ljava/util/Properties;

    invoke-direct {v1}, Ljava/util/Properties;-><init>()V

    .line 260
    invoke-virtual {v1, v0}, Ljava/util/Properties;->load(Ljava/io/InputStream;)V

    .line 262
    if-eqz v1, :cond_3

    .line 264
    const-string v0, "NewUIPercentage"

    invoke-virtual {v1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .line 267
    if-eqz v0, :cond_0

    .line 269
    :try_start_1
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    .line 270
    iget-object v2, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    #setter for: Lcom/adobe/air/AdobeAIRMainActivity;->mNewUIThreshold:I
    invoke-static {v2, v0}, Lcom/adobe/air/AdobeAIRMainActivity;->access$102(Lcom/adobe/air/AdobeAIRMainActivity;I)I

    .line 271
    iget-object v0, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    iget-object v2, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    #getter for: Lcom/adobe/air/AdobeAIRMainActivity;->mRandomNumber:I
    invoke-static {v2}, Lcom/adobe/air/AdobeAIRMainActivity;->access$300(Lcom/adobe/air/AdobeAIRMainActivity;)I

    move-result v2

    iget-object v3, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    #getter for: Lcom/adobe/air/AdobeAIRMainActivity;->mNewUIThreshold:I
    invoke-static {v3}, Lcom/adobe/air/AdobeAIRMainActivity;->access$100(Lcom/adobe/air/AdobeAIRMainActivity;)I

    move-result v3

    if-gt v2, v3, :cond_4

    const/4 v2, 0x0

    :goto_0
    #setter for: Lcom/adobe/air/AdobeAIRMainActivity;->mIsGameListDefaultActivity:Z
    invoke-static {v0, v2}, Lcom/adobe/air/AdobeAIRMainActivity;->access$202(Lcom/adobe/air/AdobeAIRMainActivity;Z)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3

    .line 280
    :cond_0
    :goto_1
    :try_start_2
    const-string v0, "MyGamesPercentage"

    invoke-virtual {v1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 281
    if-eqz v0, :cond_1

    .line 283
    iget-object v2, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    #setter for: Lcom/adobe/air/AdobeAIRMainActivity;->mEnableMyGamesThreshold:I
    invoke-static {v2, v0}, Lcom/adobe/air/AdobeAIRMainActivity;->access$402(Lcom/adobe/air/AdobeAIRMainActivity;I)I
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    .line 292
    :cond_1
    :goto_2
    :try_start_3
    const-string v0, "PartnerAdsPercentage"

    invoke-virtual {v1, v0}, Ljava/util/Properties;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 293
    if-eqz v0, :cond_2

    .line 295
    iget-object v1, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    #setter for: Lcom/adobe/air/AdobeAIRMainActivity;->mEnablePartnerAdsThreshold:I
    invoke-static {v1, v0}, Lcom/adobe/air/AdobeAIRMainActivity;->access$502(Lcom/adobe/air/AdobeAIRMainActivity;I)I
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1

    .line 301
    :cond_2
    :goto_3
    :try_start_4
    iget-object v0, p0, Lcom/adobe/air/AdobeAIRMainActivity$1;->this$0:Lcom/adobe/air/AdobeAIRMainActivity;

    #calls: Lcom/adobe/air/AdobeAIRMainActivity;->updateSharedPrefForDefaultActivity()V
    invoke-static {v0}, Lcom/adobe/air/AdobeAIRMainActivity;->access$600(Lcom/adobe/air/AdobeAIRMainActivity;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 307
    :cond_3
    :goto_4
    return-void

    .line 271
    :cond_4
    const/4 v2, 0x1

    goto :goto_0

    .line 304
    :catch_0
    move-exception v0

    goto :goto_4

    .line 298
    :catch_1
    move-exception v0

    goto :goto_3

    .line 286
    :catch_2
    move-exception v0

    goto :goto_2

    .line 274
    :catch_3
    move-exception v0

    goto :goto_1
.end method

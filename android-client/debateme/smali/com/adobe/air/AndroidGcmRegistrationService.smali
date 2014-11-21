.class public Lcom/adobe/air/AndroidGcmRegistrationService;
.super Landroid/app/IntentService;
.source "AndroidGcmRegistrationService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AndroidGcmRegistrationService$1;,
        Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;
    }
.end annotation


# static fields
.field private static ACCESS_KEY:Ljava/lang/String; = null

.field private static APPLICATION_ARN:Ljava/lang/String; = null

.field private static final CUSTOM_USER_DATA:Ljava/lang/String; = "CustomUserData"

.field private static final ENABLED:Ljava/lang/String; = "Enabled"

.field private static final ENABLE_LOGGING:Ljava/lang/String; = "enableLogging"

.field private static final MAX_RETRIES:I = 0xa

.field private static final PROPERTY_APP_VERSION:Ljava/lang/String; = "appVersion"

.field private static final PROPERTY_ENDPOINT_ARN:Ljava/lang/String; = "endpointArn"

.field private static final RATE_LIMIT:Ljava/lang/String; = "rateLimit"

.field private static final RETRY_TIME:I = 0x493e0

.field private static SECRET_KEY:Ljava/lang/String; = null

.field private static SENDER_ID:Ljava/lang/String; = null

.field private static final TAG:Ljava/lang/String; = "AndroidGcmRegistrationService"

.field private static final TEST_ACCESS_KEY:Ljava/lang/String; = ""

.field private static final TEST_APPLICATION_ARN:Ljava/lang/String; = "arn:aws:sns:us-west-2:413177889857:app/GCM/airruntimetestapp"

.field private static final TEST_ENV:Ljava/lang/String; = "testEnv"

.field private static final TEST_SECRET_KEY:Ljava/lang/String; = ""

.field private static final TEST_SENDER_ID:Ljava/lang/String; = "1078258869814"

.field private static final TOKEN:Ljava/lang/String; = "Token"


# instance fields
.field private mClient:Lcom/amazonaws/services/sns/AmazonSNS;

.field private mEnableLogging:Z

.field private mEndpointArn:Ljava/lang/String;

.field private mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

.field private mRegId:Ljava/lang/String;

.field private mResultReceiver:Landroid/os/ResultReceiver;

.field private mRetryCount:I

.field private mTestEnv:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const-string v1, ""

    .line 411
    const-string v0, "233437466354"

    sput-object v0, Lcom/adobe/air/AndroidGcmRegistrationService;->SENDER_ID:Ljava/lang/String;

    .line 412
    const-string v0, "arn:aws:sns:us-west-2:502492504188:app/GCM/AdobeAIRGCM"

    sput-object v0, Lcom/adobe/air/AndroidGcmRegistrationService;->APPLICATION_ARN:Ljava/lang/String;

    .line 413
    const-string v0, ""

    sput-object v1, Lcom/adobe/air/AndroidGcmRegistrationService;->ACCESS_KEY:Ljava/lang/String;

    .line 414
    const-string v0, ""

    sput-object v1, Lcom/adobe/air/AndroidGcmRegistrationService;->SECRET_KEY:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 69
    const-string v0, "AndroidGcmRegistrationService"

    invoke-direct {p0, v0}, Landroid/app/IntentService;-><init>(Ljava/lang/String;)V

    .line 421
    iput v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRetryCount:I

    .line 422
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    .line 423
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    .line 424
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    .line 425
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    .line 426
    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mResultReceiver:Landroid/os/ResultReceiver;

    .line 427
    iput-boolean v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEnableLogging:Z

    .line 428
    iput-boolean v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mTestEnv:Z

    .line 70
    return-void
.end method

.method static synthetic access$100(Lcom/adobe/air/AndroidGcmRegistrationService;)Ljava/lang/String;
    .locals 1
    .parameter

    .prologue
    .line 65
    iget-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$102(Lcom/adobe/air/AndroidGcmRegistrationService;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 65
    iput-object p1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$200()Ljava/lang/String;
    .locals 1

    .prologue
    .line 65
    sget-object v0, Lcom/adobe/air/AndroidGcmRegistrationService;->SENDER_ID:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$300(Lcom/adobe/air/AndroidGcmRegistrationService;)Lcom/google/android/gms/gcm/GoogleCloudMessaging;
    .locals 1
    .parameter

    .prologue
    .line 65
    iget-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    return-object v0
.end method

.method static synthetic access$400(Lcom/adobe/air/AndroidGcmRegistrationService;I)V
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 65
    invoke-direct {p0, p1}, Lcom/adobe/air/AndroidGcmRegistrationService;->registerInBackground(I)V

    return-void
.end method

.method static synthetic access$500(Lcom/adobe/air/AndroidGcmRegistrationService;)V
    .locals 0
    .parameter

    .prologue
    .line 65
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->sendRegistrationIdToAws()V

    return-void
.end method

.method private checkPlayServices()Z
    .locals 3

    .prologue
    .line 98
    invoke-static {p0}, Lcom/google/android/gms/common/GooglePlayServicesUtil;->isGooglePlayServicesAvailable(Landroid/content/Context;)I

    move-result v0

    .line 99
    if-eqz v0, :cond_1

    .line 101
    invoke-static {v0}, Lcom/google/android/gms/common/GooglePlayServicesUtil;->isUserRecoverableError(I)Z

    move-result v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mResultReceiver:Landroid/os/ResultReceiver;

    if-eqz v1, :cond_0

    .line 103
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mResultReceiver:Landroid/os/ResultReceiver;

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2}, Landroid/os/ResultReceiver;->send(ILandroid/os/Bundle;)V

    .line 109
    :cond_0
    const/4 v0, 0x0

    .line 111
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private configureTestEnv()V
    .locals 4

    .prologue
    const/high16 v3, -0x8000

    const-string v0, ""

    .line 135
    :try_start_0
    new-instance v0, Landroid/content/ComponentName;

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-direct {v0, p0, v1}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 136
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    const/16 v2, 0x80

    invoke-virtual {v1, v0, v2}, Landroid/content/pm/PackageManager;->getServiceInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ServiceInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/ServiceInfo;->metaData:Landroid/os/Bundle;

    .line 139
    if-nez v0, :cond_1

    .line 163
    :cond_0
    :goto_0
    return-void

    .line 142
    :cond_1
    const-string v1, "enableLogging"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEnableLogging:Z

    .line 143
    const-string v1, "testEnv"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mTestEnv:Z

    .line 144
    iget-boolean v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mTestEnv:Z

    if-eqz v1, :cond_0

    .line 146
    const-string v1, "1078258869814"

    sput-object v1, Lcom/adobe/air/AndroidGcmRegistrationService;->SENDER_ID:Ljava/lang/String;

    .line 147
    const-string v1, "arn:aws:sns:us-west-2:413177889857:app/GCM/airruntimetestapp"

    sput-object v1, Lcom/adobe/air/AndroidGcmRegistrationService;->APPLICATION_ARN:Ljava/lang/String;

    .line 148
    const-string v1, ""

    sput-object v1, Lcom/adobe/air/AndroidGcmRegistrationService;->ACCESS_KEY:Ljava/lang/String;

    .line 149
    const-string v1, ""

    sput-object v1, Lcom/adobe/air/AndroidGcmRegistrationService;->SECRET_KEY:Ljava/lang/String;

    .line 151
    const-string v1, "rateLimit"

    const/high16 v2, -0x8000

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 152
    if-eq v0, v3, :cond_0

    .line 154
    int-to-long v0, v0

    sput-wide v0, Lcom/adobe/air/AdobeAIRMainActivity;->RATE_LIMIT:J
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 159
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private getAppVersion()I
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 216
    :try_start_0
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 217
    iget v0, v0, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 222
    :goto_0
    return v0

    .line 219
    :catch_0
    move-exception v0

    move v0, v3

    .line 222
    goto :goto_0
.end method

.method private getCustomData()Ljava/lang/String;
    .locals 8

    .prologue
    const-string v0, "network"

    const-string v0, "AIRDefaultActivity"

    const-string v0, "&"

    .line 318
    :try_start_0
    new-instance v6, Lorg/json/JSONObject;

    invoke-direct {v6}, Lorg/json/JSONObject;-><init>()V

    .line 319
    const-string v0, "osVersion"

    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-virtual {v6, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 321
    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    .line 322
    const-string v1, "airVersion"

    iget-object v0, v0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    invoke-virtual {v6, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 324
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Lcom/adobe/air/SystemCapabilities;->GetScreenHRes(Landroid/content/Context;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Lcom/adobe/air/SystemCapabilities;->GetScreenVRes(Landroid/content/Context;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "&"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {p0}, Lcom/adobe/air/SystemCapabilities;->GetScreenDPI(Landroid/content/Context;)I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 328
    const-string v1, "deviceInfo"

    invoke-virtual {v6, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 330
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    .line 331
    const-string v1, "locale"

    invoke-virtual {v0}, Ljava/util/Locale;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 333
    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/util/Locale;->getDisplayCountry(Ljava/util/Locale;)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v7

    .line 337
    :try_start_1
    const-string v0, "location"

    invoke-virtual {p0, v0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/location/LocationManager;

    .line 339
    const-string v1, "network"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->isProviderEnabled(Ljava/lang/String;)Z

    move-result v1

    .line 342
    if-eqz v1, :cond_1

    .line 344
    const-string v1, "network"

    invoke-virtual {v0, v1}, Landroid/location/LocationManager;->getLastKnownLocation(Ljava/lang/String;)Landroid/location/Location;

    move-result-object v3

    .line 345
    new-instance v0, Landroid/location/Geocoder;

    sget-object v1, Ljava/util/Locale;->ENGLISH:Ljava/util/Locale;

    invoke-direct {v0, p0, v1}, Landroid/location/Geocoder;-><init>(Landroid/content/Context;Ljava/util/Locale;)V

    .line 346
    if-eqz v3, :cond_1

    if-eqz v0, :cond_1

    .line 348
    invoke-static {}, Landroid/location/Geocoder;->isPresent()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 350
    invoke-virtual {v3}, Landroid/location/Location;->getLatitude()D

    move-result-wide v1

    invoke-virtual {v3}, Landroid/location/Location;->getLongitude()D

    move-result-wide v3

    const/4 v5, 0x1

    invoke-virtual/range {v0 .. v5}, Landroid/location/Geocoder;->getFromLocation(DDI)Ljava/util/List;

    move-result-object v0

    .line 351
    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/location/Address;

    invoke-virtual {v0}, Landroid/location/Address;->getCountryName()Ljava/lang/String;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-result-object v0

    .line 360
    :goto_0
    :try_start_2
    const-string v1, "geo"

    invoke-virtual {v6, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 362
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v0

    .line 363
    const-string v1, "timestamp"

    invoke-virtual {v6, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 366
    const-class v0, Lcom/adobe/air/AdobeAIR;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adobe/air/AndroidGcmRegistrationService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 367
    const-string v1, "AIRDefaultActivity"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 368
    if-eqz v0, :cond_0

    .line 370
    const-string v0, "AIRDefaultActivity"

    const-string v1, "GL"

    invoke-virtual {v6, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 377
    :goto_1
    invoke-virtual {v6}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    .line 382
    :goto_2
    return-object v0

    .line 356
    :catch_0
    move-exception v0

    move-object v0, v7

    goto :goto_0

    .line 374
    :cond_0
    const-string v0, "AIRDefaultActivity"

    const-string v1, "PP"

    invoke-virtual {v6, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_1

    .line 379
    :catch_1
    move-exception v0

    .line 382
    const-string v0, ""

    goto :goto_2

    :cond_1
    move-object v0, v7

    goto :goto_0
.end method

.method private isAppRegistered()Z
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/high16 v2, -0x8000

    .line 116
    const-class v0, Lcom/adobe/air/AdobeAIR;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0, v3}, Lcom/adobe/air/AndroidGcmRegistrationService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 121
    const-string v1, "appVersion"

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    .line 122
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getAppVersion()I

    move-result v1

    .line 123
    if-eq v0, v2, :cond_0

    if-eq v0, v1, :cond_1

    :cond_0
    move v0, v3

    .line 128
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private registerForNotifications()V
    .locals 1

    .prologue
    .line 82
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->isAppRegistered()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 94
    :cond_0
    :goto_0
    return-void

    .line 85
    :cond_1
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->checkPlayServices()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 87
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->configureTestEnv()V

    .line 88
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidGcmRegistrationService;->registerInBackground(I)V

    goto :goto_0
.end method

.method private registerInBackground(I)V
    .locals 4
    .parameter

    .prologue
    .line 168
    iget v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRetryCount:I

    const/16 v1, 0xa

    if-ge v0, v1, :cond_2

    .line 170
    if-eqz p1, :cond_0

    .line 171
    iget v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRetryCount:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRetryCount:I

    .line 173
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    if-nez v0, :cond_1

    .line 174
    invoke-static {p0}, Lcom/google/android/gms/gcm/GoogleCloudMessaging;->getInstance(Landroid/content/Context;)Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mGcm:Lcom/google/android/gms/gcm/GoogleCloudMessaging;

    .line 176
    :cond_1
    new-instance v0, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;-><init>(Lcom/adobe/air/AndroidGcmRegistrationService;Lcom/adobe/air/AndroidGcmRegistrationService$1;)V

    .line 177
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Integer;

    const/4 v2, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-virtual {v0, v1}, Lcom/adobe/air/AndroidGcmRegistrationService$AsyncTaskRunner;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 179
    :cond_2
    return-void
.end method

.method private sendRegistrationIdToAws()V
    .locals 3

    .prologue
    .line 232
    :try_start_0
    new-instance v0, Lcom/amazonaws/auth/BasicAWSCredentials;

    sget-object v1, Lcom/adobe/air/AndroidGcmRegistrationService;->ACCESS_KEY:Ljava/lang/String;

    sget-object v2, Lcom/adobe/air/AndroidGcmRegistrationService;->SECRET_KEY:Ljava/lang/String;

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/auth/BasicAWSCredentials;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 233
    sget-object v1, Lcom/amazonaws/regions/Regions;->US_WEST_2:Lcom/amazonaws/regions/Regions;

    invoke-static {v1}, Lcom/amazonaws/regions/Region;->getRegion(Lcom/amazonaws/regions/Regions;)Lcom/amazonaws/regions/Region;

    move-result-object v1

    .line 235
    new-instance v2, Lcom/amazonaws/services/sns/AmazonSNSClient;

    invoke-direct {v2, v0}, Lcom/amazonaws/services/sns/AmazonSNSClient;-><init>(Lcom/amazonaws/auth/AWSCredentials;)V

    iput-object v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    .line 236
    iget-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    invoke-interface {v0, v1}, Lcom/amazonaws/services/sns/AmazonSNS;->setRegion(Lcom/amazonaws/regions/Region;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 240
    :try_start_1
    new-instance v0, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;-><init>()V

    .line 241
    sget-object v1, Lcom/adobe/air/AndroidGcmRegistrationService;->APPLICATION_ARN:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;->setPlatformApplicationArn(Ljava/lang/String;)V

    .line 242
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;->setToken(Ljava/lang/String;)V

    .line 243
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getCustomData()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;->setCustomUserData(Ljava/lang/String;)V

    .line 245
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    invoke-interface {v1, v0}, Lcom/amazonaws/services/sns/AmazonSNS;->createPlatformEndpoint(Lcom/amazonaws/services/sns/model/CreatePlatformEndpointRequest;)Lcom/amazonaws/services/sns/model/CreatePlatformEndpointResult;

    move-result-object v0

    .line 246
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointResult;->getEndpointArn()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 248
    invoke-virtual {v0}, Lcom/amazonaws/services/sns/model/CreatePlatformEndpointResult;->getEndpointArn()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    .line 249
    iget-boolean v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEnableLogging:Z

    if-eqz v0, :cond_0

    .line 250
    const-string v0, "AndroidGcmRegistrationService"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Creation EndpointArn = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 253
    :cond_0
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->updateSharedPref()V
    :try_end_1
    .catch Lcom/amazonaws/services/sns/model/InternalErrorException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Lcom/amazonaws/services/sns/model/InvalidParameterException; {:try_start_1 .. :try_end_1} :catch_2
    .catch Lcom/amazonaws/AmazonServiceException; {:try_start_1 .. :try_end_1} :catch_4
    .catch Lcom/amazonaws/AmazonClientException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    .line 279
    :cond_1
    :goto_0
    return-void

    .line 256
    :catch_0
    move-exception v0

    .line 259
    const v0, 0x493e0

    :try_start_2
    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidGcmRegistrationService;->registerInBackground(I)V

    goto :goto_0

    .line 275
    :catch_1
    move-exception v0

    goto :goto_0

    .line 261
    :catch_2
    move-exception v0

    .line 264
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->updateEndpointAttributes()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 270
    :catch_3
    move-exception v0

    goto :goto_0

    .line 266
    :catch_4
    move-exception v0

    goto :goto_0
.end method

.method private updateEndpointAttributes()V
    .locals 4

    .prologue
    .line 286
    :try_start_0
    new-instance v0, Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;

    invoke-direct {v0}, Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;-><init>()V

    .line 287
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    if-nez v1, :cond_0

    .line 289
    const-class v1, Lcom/adobe/air/AdobeAIR;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {p0, v1, v2}, Lcom/adobe/air/AndroidGcmRegistrationService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 290
    const-string v2, "endpointArn"

    const-string v3, ""

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    .line 292
    iget-boolean v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEnableLogging:Z

    if-eqz v1, :cond_0

    .line 293
    const-string v1, "AndroidGcmRegistrationService"

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Update EndpointArn = "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    iget-object v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 295
    :cond_0
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;->setEndpointArn(Ljava/lang/String;)V

    .line 296
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    .line 297
    const-string v2, "CustomUserData"

    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getCustomData()Ljava/lang/String;

    move-result-object v3

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 298
    const-string v2, "Enabled"

    const-string v3, "true"

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 299
    const-string v2, "Token"

    iget-object v3, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mRegId:Ljava/lang/String;

    invoke-interface {v1, v2, v3}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 300
    invoke-virtual {v0, v1}, Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;->setAttributes(Ljava/util/Map;)V

    .line 301
    iget-object v1, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mClient:Lcom/amazonaws/services/sns/AmazonSNS;

    invoke-interface {v1, v0}, Lcom/amazonaws/services/sns/AmazonSNS;->setEndpointAttributes(Lcom/amazonaws/services/sns/model/SetEndpointAttributesRequest;)V

    .line 302
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->updateSharedPref()V
    :try_end_0
    .catch Lcom/amazonaws/AmazonServiceException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/amazonaws/AmazonClientException; {:try_start_0 .. :try_end_0} :catch_0

    .line 312
    :goto_0
    return-void

    .line 308
    :catch_0
    move-exception v0

    goto :goto_0

    .line 304
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method private updateSharedPref()V
    .locals 3

    .prologue
    .line 388
    const-class v0, Lcom/adobe/air/AdobeAIR;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/adobe/air/AndroidGcmRegistrationService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 389
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->getAppVersion()I

    move-result v1

    .line 393
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 394
    const-string v2, "appVersion"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    .line 395
    const-string v1, "endpointArn"

    iget-object v2, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mEndpointArn:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 396
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 397
    return-void
.end method


# virtual methods
.method protected onHandleIntent(Landroid/content/Intent;)V
    .locals 1
    .parameter

    .prologue
    .line 76
    const-string v0, "resultReceiver"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getParcelableExtra(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    check-cast v0, Landroid/os/ResultReceiver;

    iput-object v0, p0, Lcom/adobe/air/AndroidGcmRegistrationService;->mResultReceiver:Landroid/os/ResultReceiver;

    .line 77
    invoke-direct {p0}, Lcom/adobe/air/AndroidGcmRegistrationService;->registerForNotifications()V

    .line 78
    return-void
.end method

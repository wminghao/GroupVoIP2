.class public Lair/Vispar/AppEntry;
.super Landroid/app/Activity;
.source "AppEntry.java"


# static fields
.field private static AIR_PING_URL:Ljava/lang/String; = null

.field private static final LOG_TAG:Ljava/lang/String; = "AppEntry"

.field private static final RESOURCE_BUTTON_EXIT:Ljava/lang/String; = "string.button_exit"

.field private static final RESOURCE_BUTTON_INSTALL:Ljava/lang/String; = "string.button_install"

.field private static final RESOURCE_CLASS:Ljava/lang/String; = "air.Vispar.R"

.field private static final RESOURCE_TEXT_RUNTIME_REQUIRED:Ljava/lang/String; = "string.text_runtime_required"

.field private static final RESOURCE_TITLE_ADOBE_AIR:Ljava/lang/String; = "string.title_adobe_air"

.field private static RUNTIME_PACKAGE_ID:Ljava/lang/String;

.field private static sAndroidActivityWrapper:Ljava/lang/Object;

.field private static sAndroidActivityWrapperClass:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class",
            "<*>;"
        }
    .end annotation
.end field

.field private static sDloader:Ldalvik/system/DexClassLoader;

.field private static sRuntimeClassesLoaded:Z

.field private static sThis:Lair/Vispar/AppEntry;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 59
    const/4 v0, 0x0

    sput-boolean v0, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    .line 62
    sput-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapper:Ljava/lang/Object;

    .line 63
    sput-object v1, Lair/Vispar/AppEntry;->sThis:Lair/Vispar/AppEntry;

    .line 64
    const-string v0, "com.adobe.air"

    sput-object v0, Lair/Vispar/AppEntry;->RUNTIME_PACKAGE_ID:Ljava/lang/String;

    .line 65
    const-string v0, "http://airdownload2.adobe.com/air?"

    sput-object v0, Lair/Vispar/AppEntry;->AIR_PING_URL:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 56
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private BroadcastIntent(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .parameter "action"
    .parameter "data"

    .prologue
    .line 72
    const/4 v0, 0x0

    :try_start_0
    invoke-static {p2, v0}, Landroid/content/Intent;->parseUri(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    const/high16 v1, 0x1000

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Lair/Vispar/AppEntry;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 82
    :goto_0
    return-void

    .line 78
    :catch_0
    move-exception v0

    goto :goto_0

    .line 74
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method private varargs InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .parameter "method"
    .parameter "args"

    .prologue
    .line 355
    sget-boolean v1, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    if-nez v1, :cond_0

    .line 356
    const/4 v1, 0x0

    .line 370
    :goto_0
    return-object v1

    .line 358
    :cond_0
    const/4 v0, 0x0

    .line 361
    .local v0, retval:Ljava/lang/Object;
    if-eqz p2, :cond_1

    .line 362
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapper:Ljava/lang/Object;

    invoke-virtual {p1, v1, p2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .end local v0           #retval:Ljava/lang/Object;
    :goto_1
    move-object v1, v0

    .line 370
    goto :goto_0

    .line 364
    .restart local v0       #retval:Ljava/lang/Object;
    :cond_1
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapper:Ljava/lang/Object;

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p1, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    goto :goto_1

    .line 366
    :catch_0
    move-exception v1

    goto :goto_1
.end method

.method private InvokeWrapperOnCreate()V
    .locals 12

    .prologue
    .line 333
    :try_start_0
    sget-object v7, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v8, "onCreate"

    const/4 v9, 0x2

    new-array v9, v9, [Ljava/lang/Class;

    const/4 v10, 0x0

    const-class v11, Landroid/app/Activity;

    aput-object v11, v9, v10

    const/4 v10, 0x1

    const-class v11, [Ljava/lang/String;

    aput-object v11, v9, v10

    invoke-virtual {v7, v8, v9}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    .line 338
    .local v4, method:Ljava/lang/reflect/Method;
    const-string v6, ""

    .line 339
    .local v6, xmlPath:Ljava/lang/String;
    const-string v5, ""

    .line 340
    .local v5, rootDirectory:Ljava/lang/String;
    const-string v1, "-nodebug"

    .line 341
    .local v1, extraArgs:Ljava/lang/String;
    new-instance v2, Ljava/lang/Boolean;

    const/4 v7, 0x0

    invoke-direct {v2, v7}, Ljava/lang/Boolean;-><init>(Z)V

    .line 342
    .local v2, isADL:Ljava/lang/Boolean;
    new-instance v3, Ljava/lang/Boolean;

    const/4 v7, 0x0

    invoke-direct {v3, v7}, Ljava/lang/Boolean;-><init>(Z)V

    .line 343
    .local v3, isDebuggerMode:Ljava/lang/Boolean;
    const/4 v7, 0x5

    new-array v0, v7, [Ljava/lang/String;

    const/4 v7, 0x0

    aput-object v6, v0, v7

    const/4 v7, 0x1

    aput-object v5, v0, v7

    const/4 v7, 0x2

    aput-object v1, v0, v7

    const/4 v7, 0x3

    invoke-virtual {v2}, Ljava/lang/Boolean;->toString()Ljava/lang/String;

    move-result-object v8

    aput-object v8, v0, v7

    const/4 v7, 0x4

    invoke-virtual {v3}, Ljava/lang/Boolean;->toString()Ljava/lang/String;

    move-result-object v8

    aput-object v8, v0, v7

    .line 345
    .local v0, args:[Ljava/lang/String;
    const/4 v7, 0x2

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    aput-object p0, v7, v8

    const/4 v8, 0x1

    aput-object v0, v7, v8

    invoke-direct {p0, v4, v7}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 351
    .end local v0           #args:[Ljava/lang/String;
    .end local v1           #extraArgs:Ljava/lang/String;
    .end local v2           #isADL:Ljava/lang/Boolean;
    .end local v3           #isDebuggerMode:Ljava/lang/Boolean;
    .end local v4           #method:Ljava/lang/reflect/Method;
    .end local v5           #rootDirectory:Ljava/lang/String;
    .end local v6           #xmlPath:Ljava/lang/String;
    :goto_0
    return-void

    .line 347
    :catch_0
    move-exception v7

    goto :goto_0
.end method

.method private static KillSelf()V
    .locals 1

    .prologue
    .line 375
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {v0}, Landroid/os/Process;->killProcess(I)V

    .line 376
    return-void
.end method

.method static synthetic access$000(Lair/Vispar/AppEntry;)V
    .locals 0
    .parameter "x0"

    .prologue
    .line 56
    invoke-direct {p0}, Lair/Vispar/AppEntry;->launchMarketPlaceForAIR()V

    return-void
.end method

.method static synthetic access$100()Lair/Vispar/AppEntry;
    .locals 1

    .prologue
    .line 56
    sget-object v0, Lair/Vispar/AppEntry;->sThis:Lair/Vispar/AppEntry;

    return-object v0
.end method

.method static synthetic access$200()Ljava/lang/String;
    .locals 1

    .prologue
    .line 56
    sget-object v0, Lair/Vispar/AppEntry;->AIR_PING_URL:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$300(Lair/Vispar/AppEntry;)V
    .locals 0
    .parameter "x0"

    .prologue
    .line 56
    invoke-direct {p0}, Lair/Vispar/AppEntry;->loadSharedRuntimeDex()V

    return-void
.end method

.method static synthetic access$400(Lair/Vispar/AppEntry;Z)V
    .locals 0
    .parameter "x0"
    .parameter "x1"

    .prologue
    .line 56
    invoke-direct {p0, p1}, Lair/Vispar/AppEntry;->createActivityWrapper(Z)V

    return-void
.end method

.method static synthetic access$500()Z
    .locals 1

    .prologue
    .line 56
    sget-boolean v0, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    return v0
.end method

.method static synthetic access$600(Lair/Vispar/AppEntry;)V
    .locals 0
    .parameter "x0"

    .prologue
    .line 56
    invoke-direct {p0}, Lair/Vispar/AppEntry;->InvokeWrapperOnCreate()V

    return-void
.end method

.method static synthetic access$700()V
    .locals 0

    .prologue
    .line 56
    invoke-static {}, Lair/Vispar/AppEntry;->KillSelf()V

    return-void
.end method

.method private createActivityWrapper(Z)V
    .locals 6
    .parameter "hasCaptiveRuntime"

    .prologue
    const-string v1, "CreateAndroidActivityWrapper"

    .line 624
    if-eqz p1, :cond_0

    .line 626
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "CreateAndroidActivityWrapper"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/app/Activity;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-class v5, Ljava/lang/Boolean;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 627
    .local v0, methodCreateAndroidActivityWrapper:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    const/4 v3, 0x1

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sput-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapper:Ljava/lang/Object;

    .line 639
    .end local v0           #methodCreateAndroidActivityWrapper:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 631
    :cond_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "CreateAndroidActivityWrapper"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/app/Activity;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 632
    .restart local v0       #methodCreateAndroidActivityWrapper:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p0, v2, v3

    invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    sput-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapper:Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 635
    .end local v0           #methodCreateAndroidActivityWrapper:Ljava/lang/reflect/Method;
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private isRuntimeInstalled()Z
    .locals 4

    .prologue
    .line 123
    invoke-virtual {p0}, Lair/Vispar/AppEntry;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 127
    .local v1, pkgMgr:Landroid/content/pm/PackageManager;
    :try_start_0
    sget-object v2, Lair/Vispar/AppEntry;->RUNTIME_PACKAGE_ID:Ljava/lang/String;

    const/16 v3, 0x100

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 135
    const/4 v2, 0x1

    :goto_0
    return v2

    .line 130
    :catch_0
    move-exception v2

    move-object v0, v2

    .line 132
    .local v0, nfe:Landroid/content/pm/PackageManager$NameNotFoundException;
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private isRuntimeOnExternalStorage()Z
    .locals 5

    .prologue
    const/high16 v4, 0x4

    .line 140
    invoke-virtual {p0}, Lair/Vispar/AppEntry;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    .line 145
    .local v1, pkgMgr:Landroid/content/pm/PackageManager;
    :try_start_0
    sget-object v2, Lair/Vispar/AppEntry;->RUNTIME_PACKAGE_ID:Ljava/lang/String;

    const/16 v3, 0x2000

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 146
    .local v0, appInfo:Landroid/content/pm/ApplicationInfo;
    iget v2, v0, Landroid/content/pm/ApplicationInfo;->flags:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    and-int/2addr v2, v4

    if-ne v2, v4, :cond_0

    .line 147
    const/4 v2, 0x1

    .line 154
    .end local v0           #appInfo:Landroid/content/pm/ApplicationInfo;
    :goto_0
    return v2

    .line 149
    :catch_0
    move-exception v2

    .line 154
    :cond_0
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private launchAIRService()V
    .locals 4

    .prologue
    .line 285
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    const-string v2, "com.adobe.air.AIRServiceAction"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 286
    .local v1, intent:Landroid/content/Intent;
    sget-object v2, Lair/Vispar/AppEntry;->RUNTIME_PACKAGE_ID:Ljava/lang/String;

    const-string v3, "com.adobe.air.AIRService"

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 289
    new-instance v0, Lair/Vispar/AppEntry$4;

    invoke-direct {v0, p0}, Lair/Vispar/AppEntry$4;-><init>(Lair/Vispar/AppEntry;)V

    .line 320
    .local v0, conn:Landroid/content/ServiceConnection;
    const/4 v2, 0x1

    invoke-virtual {p0, v1, v0, v2}, Lair/Vispar/AppEntry;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 327
    .end local v0           #conn:Landroid/content/ServiceConnection;
    .end local v1           #intent:Landroid/content/Intent;
    :goto_0
    return-void

    .line 323
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method private launchMarketPlaceForAIR()V
    .locals 8

    .prologue
    .line 87
    const/4 v1, 0x0

    .line 91
    .local v1, airDownloadURL:Ljava/lang/String;
    :try_start_0
    invoke-virtual {p0}, Lair/Vispar/AppEntry;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v5

    invoke-virtual {p0}, Lair/Vispar/AppEntry;->getComponentName()Landroid/content/ComponentName;

    move-result-object v6

    const/16 v7, 0x80

    invoke-virtual {v5, v6, v7}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;

    move-result-object v2

    .line 92
    .local v2, info:Landroid/content/pm/ActivityInfo;
    iget-object v4, v2, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    .line 95
    .local v4, metadata:Landroid/os/Bundle;
    if-eqz v4, :cond_0

    .line 97
    const-string v5, "airDownloadURL"

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    move-object v0, v5

    check-cast v0, Ljava/lang/String;

    move-object v1, v0
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_1

    .line 107
    .end local v2           #info:Landroid/content/pm/ActivityInfo;
    .end local v4           #metadata:Landroid/os/Bundle;
    :cond_0
    :goto_0
    move-object v3, v1

    .line 108
    .local v3, marketPlaceURL:Ljava/lang/String;
    if-nez v3, :cond_1

    .line 109
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "market://details?id="

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lair/Vispar/AppEntry;->RUNTIME_PACKAGE_ID:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 113
    :cond_1
    :try_start_1
    const-string v5, "android.intent.action.VIEW"

    invoke-direct {p0, v5, v3}, Lair/Vispar/AppEntry;->BroadcastIntent(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 119
    :goto_1
    return-void

    .line 115
    :catch_0
    move-exception v5

    goto :goto_1

    .line 101
    .end local v3           #marketPlaceURL:Ljava/lang/String;
    :catch_1
    move-exception v5

    goto :goto_0
.end method

.method private loadCaptiveRuntimeClasses()Z
    .locals 2

    .prologue
    .line 578
    const/4 v0, 0x0

    .line 582
    .local v0, hasCaptiveRuntime:Z
    :try_start_0
    const-string v1, "com.adobe.air.AndroidActivityWrapper"

    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    sput-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    .line 583
    const/4 v0, 0x1

    .line 584
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    sput-boolean v1, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 590
    :cond_0
    :goto_0
    return v0

    .line 586
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private loadSharedRuntimeDex()V
    .locals 6

    .prologue
    .line 599
    :try_start_0
    sget-boolean v1, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    if-nez v1, :cond_0

    .line 602
    sget-object v1, Lair/Vispar/AppEntry;->RUNTIME_PACKAGE_ID:Ljava/lang/String;

    const/4 v2, 0x3

    invoke-virtual {p0, v1, v2}, Lair/Vispar/AppEntry;->createPackageContext(Ljava/lang/String;I)Landroid/content/Context;

    move-result-object v0

    .line 603
    .local v0, con:Landroid/content/Context;
    new-instance v1, Ldalvik/system/DexClassLoader;

    sget-object v2, Lair/Vispar/AppEntry;->RUNTIME_PACKAGE_ID:Ljava/lang/String;

    invoke-virtual {p0}, Lair/Vispar/AppEntry;->getFilesDir()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v0}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v5

    invoke-direct {v1, v2, v3, v4, v5}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    sput-object v1, Lair/Vispar/AppEntry;->sDloader:Ldalvik/system/DexClassLoader;

    .line 608
    sget-object v1, Lair/Vispar/AppEntry;->sDloader:Ldalvik/system/DexClassLoader;

    const-string v2, "com.adobe.air.AndroidActivityWrapper"

    invoke-virtual {v1, v2}, Ldalvik/system/DexClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    sput-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    .line 609
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    if-eqz v1, :cond_0

    .line 610
    const/4 v1, 0x1

    sput-boolean v1, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 619
    .end local v0           #con:Landroid/content/Context;
    :cond_0
    :goto_0
    return-void

    .line 615
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private registerForNotifications()V
    .locals 4

    .prologue
    const-string v3, "com.adobe.air.AndroidGcmRegistrationService"

    .line 274
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.adobe.air.AndroidGcmRegistrationService"

    invoke-direct {v0, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 275
    .local v0, serviceIntent:Landroid/content/Intent;
    sget-object v1, Lair/Vispar/AppEntry;->RUNTIME_PACKAGE_ID:Ljava/lang/String;

    const-string v2, "com.adobe.air.AndroidGcmRegistrationService"

    invoke-virtual {v0, v1, v3}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 276
    invoke-virtual {p0, v0}, Lair/Vispar/AppEntry;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 277
    return-void
.end method

.method private showDialog(ILjava/lang/String;II)V
    .locals 2
    .parameter "titleId"
    .parameter "text"
    .parameter "positiveButtonId"
    .parameter "negativeButtonId"

    .prologue
    .line 160
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 161
    .local v0, alertDialogBuilder:Landroid/app/AlertDialog$Builder;
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 162
    invoke-virtual {v0, p2}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    .line 163
    new-instance v1, Lair/Vispar/AppEntry$1;

    invoke-direct {v1, p0}, Lair/Vispar/AppEntry$1;-><init>(Lair/Vispar/AppEntry;)V

    invoke-virtual {v0, p3, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 170
    new-instance v1, Lair/Vispar/AppEntry$2;

    invoke-direct {v1, p0}, Lair/Vispar/AppEntry$2;-><init>(Lair/Vispar/AppEntry;)V

    invoke-virtual {v0, p4, v1}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 176
    new-instance v1, Lair/Vispar/AppEntry$3;

    invoke-direct {v1, p0}, Lair/Vispar/AppEntry$3;-><init>(Lair/Vispar/AppEntry;)V

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroid/app/AlertDialog$Builder;

    .line 182
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 183
    return-void
.end method

.method private showRuntimeNotInstalledDialog()V
    .locals 5

    .prologue
    .line 193
    new-instance v0, Lcom/adobe/air/ResourceIdMap;

    const-string v2, "air.Vispar.R"

    invoke-direct {v0, v2}, Lcom/adobe/air/ResourceIdMap;-><init>(Ljava/lang/String;)V

    .line 194
    .local v0, r:Lcom/adobe/air/ResourceIdMap;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "string.text_runtime_required"

    invoke-virtual {v0, v3}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {p0, v3}, Lair/Vispar/AppEntry;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "string.text_install_runtime"

    invoke-virtual {v0, v3}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {p0, v3}, Lair/Vispar/AppEntry;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 195
    .local v1, text:Ljava/lang/String;
    const-string v2, "string.title_adobe_air"

    invoke-virtual {v0, v2}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v2

    const-string v3, "string.button_install"

    invoke-virtual {v0, v3}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v3

    const-string v4, "string.button_exit"

    invoke-virtual {v0, v4}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v4

    invoke-direct {p0, v2, v1, v3, v4}, Lair/Vispar/AppEntry;->showDialog(ILjava/lang/String;II)V

    .line 199
    return-void
.end method

.method private showRuntimeOnExternalStorageDialog()V
    .locals 5

    .prologue
    .line 203
    new-instance v0, Lcom/adobe/air/ResourceIdMap;

    const-string v2, "air.Vispar.R"

    invoke-direct {v0, v2}, Lcom/adobe/air/ResourceIdMap;-><init>(Ljava/lang/String;)V

    .line 204
    .local v0, r:Lcom/adobe/air/ResourceIdMap;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "string.text_runtime_required"

    invoke-virtual {v0, v3}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {p0, v3}, Lair/Vispar/AppEntry;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "string.text_runtime_on_external_storage"

    invoke-virtual {v0, v3}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {p0, v3}, Lair/Vispar/AppEntry;->getString(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 205
    .local v1, text:Ljava/lang/String;
    const-string v2, "string.title_adobe_air"

    invoke-virtual {v0, v2}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v2

    const-string v3, "string.button_install"

    invoke-virtual {v0, v3}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v3

    const-string v4, "string.button_exit"

    invoke-virtual {v0, v4}, Lcom/adobe/air/ResourceIdMap;->getId(Ljava/lang/String;)I

    move-result v4

    invoke-direct {p0, v2, v1, v3, v4}, Lair/Vispar/AppEntry;->showDialog(ILjava/lang/String;II)V

    .line 209
    return-void
.end method


# virtual methods
.method public dispatchGenericMotionEvent(Landroid/view/MotionEvent;)Z
    .locals 9
    .parameter "event"

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 507
    const/4 v0, 0x0

    .line 510
    .local v0, handled:Z
    :try_start_0
    sget-object v2, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v3, "dispatchGenericMotionEvent"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/view/MotionEvent;

    aput-object v6, v4, v5

    const/4 v5, 0x1

    sget-object v6, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 511
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p1, v2, v3

    const/4 v3, 0x1

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-direct {p0, v1, v2}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 518
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    if-nez v0, :cond_0

    invoke-super {p0, p1}, Landroid/app/Activity;->dispatchGenericMotionEvent(Landroid/view/MotionEvent;)Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_0
    move v2, v8

    :goto_1
    return v2

    :cond_1
    move v2, v7

    goto :goto_1

    .line 513
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public dispatchKeyEvent(Landroid/view/KeyEvent;)Z
    .locals 9
    .parameter "event"

    .prologue
    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 489
    const/4 v0, 0x0

    .line 492
    .local v0, handled:Z
    :try_start_0
    sget-object v2, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v3, "dispatchKeyEvent"

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/view/KeyEvent;

    aput-object v6, v4, v5

    const/4 v5, 0x1

    sget-object v6, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 493
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v2, 0x2

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object p1, v2, v3

    const/4 v3, 0x1

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-direct {p0, v1, v2}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 500
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    if-nez v0, :cond_0

    invoke-super {p0, p1}, Landroid/app/Activity;->dispatchKeyEvent(Landroid/view/KeyEvent;)Z

    move-result v2

    if-eqz v2, :cond_1

    :cond_0
    move v2, v8

    :goto_1
    return v2

    :cond_1
    move v2, v7

    goto :goto_1

    .line 495
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public finishActivityFromChild(Landroid/app/Activity;I)V
    .locals 6
    .parameter "child"
    .parameter "requestCode"

    .prologue
    .line 644
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->finishActivityFromChild(Landroid/app/Activity;I)V

    .line 648
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "finishActivityFromChild"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/app/Activity;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 649
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const/4 v2, 0x1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 655
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 651
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public finishFromChild(Landroid/app/Activity;)V
    .locals 6
    .parameter "child"

    .prologue
    .line 660
    invoke-super {p0, p1}, Landroid/app/Activity;->finishFromChild(Landroid/app/Activity;)V

    .line 664
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "finishFromChild"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/app/Activity;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 665
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 671
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 667
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 6
    .parameter "requestCode"
    .parameter "resultCode"
    .parameter "data"

    .prologue
    .line 545
    :try_start_0
    sget-boolean v1, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    if-eqz v1, :cond_0

    .line 547
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onActivityResult"

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    const/4 v4, 0x2

    const-class v5, Landroid/content/Intent;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 548
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x2

    aput-object p3, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 555
    .end local v0           #method:Ljava/lang/reflect/Method;
    :cond_0
    :goto_0
    return-void

    .line 551
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onApplyThemeResource(Landroid/content/res/Resources$Theme;IZ)V
    .locals 6
    .parameter "theme"
    .parameter "resid"
    .parameter "first"

    .prologue
    .line 1194
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onApplyThemeResource(Landroid/content/res/Resources$Theme;IZ)V

    .line 1198
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onApplyThemeResource"

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/content/res/Resources$Theme;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    const/4 v4, 0x2

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1199
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const/4 v2, 0x1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x2

    invoke-static {p3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1205
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1201
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onAttachedToWindow()V
    .locals 4

    .prologue
    .line 676
    invoke-super {p0}, Landroid/app/Activity;->onAttachedToWindow()V

    .line 680
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onAttachedToWindow"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 681
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 687
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 683
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onBackPressed()V
    .locals 4

    .prologue
    .line 692
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V

    .line 696
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onBackPressed"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 697
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 703
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 699
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onChildTitleChanged(Landroid/app/Activity;Ljava/lang/CharSequence;)V
    .locals 6
    .parameter "childActivity"
    .parameter "title"

    .prologue
    .line 1210
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onChildTitleChanged(Landroid/app/Activity;Ljava/lang/CharSequence;)V

    .line 1214
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onChildTitleChanged"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/app/Activity;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-class v5, Ljava/lang/CharSequence;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1215
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const/4 v2, 0x1

    aput-object p2, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1221
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1217
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 6
    .parameter "newConfig"

    .prologue
    .line 473
    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 477
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onConfigurationChanged"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/content/res/Configuration;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 478
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 484
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 480
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onContentChanged()V
    .locals 4

    .prologue
    .line 708
    invoke-super {p0}, Landroid/app/Activity;->onContentChanged()V

    .line 712
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onContentChanged"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 713
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 719
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 715
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onContextItemSelected(Landroid/view/MenuItem;)Z
    .locals 8
    .parameter "item"

    .prologue
    .line 724
    invoke-super {p0, p1}, Landroid/app/Activity;->onContextItemSelected(Landroid/view/MenuItem;)Z

    move-result v2

    .line 728
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onContextItemSelected"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/view/MenuItem;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 729
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 734
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 731
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 734
    goto :goto_0
.end method

.method public onContextMenuClosed(Landroid/view/Menu;)V
    .locals 6
    .parameter "menu"

    .prologue
    .line 741
    invoke-super {p0, p1}, Landroid/app/Activity;->onContextMenuClosed(Landroid/view/Menu;)V

    .line 745
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onContextMenuClosed"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/view/Menu;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 746
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 752
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 748
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 7
    .parameter "savedInstanceState"

    .prologue
    .line 215
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 216
    sput-object p0, Lair/Vispar/AppEntry;->sThis:Lair/Vispar/AppEntry;

    .line 220
    new-instance v3, Ljava/util/Date;

    invoke-direct {v3}, Ljava/util/Date;-><init>()V

    .line 221
    .local v3, t:Ljava/util/Date;
    invoke-virtual {v3}, Ljava/util/Date;->getTime()J

    move-result-wide v1

    .line 222
    .local v1, millis:J
    const-string v4, "StartupTime1"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, ":"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 227
    invoke-direct {p0}, Lair/Vispar/AppEntry;->loadCaptiveRuntimeClasses()Z

    move-result v0

    .line 228
    .local v0, hasCaptiveRuntime:Z
    if-nez v0, :cond_2

    .line 230
    sget-boolean v4, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    if-nez v4, :cond_1

    invoke-direct {p0}, Lair/Vispar/AppEntry;->isRuntimeInstalled()Z

    move-result v4

    if-nez v4, :cond_1

    .line 235
    invoke-direct {p0}, Lair/Vispar/AppEntry;->isRuntimeOnExternalStorage()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 236
    invoke-direct {p0}, Lair/Vispar/AppEntry;->showRuntimeOnExternalStorageDialog()V

    .line 270
    :goto_0
    return-void

    .line 238
    :cond_0
    invoke-direct {p0}, Lair/Vispar/AppEntry;->showRuntimeNotInstalledDialog()V

    goto :goto_0

    .line 241
    :cond_1
    invoke-direct {p0}, Lair/Vispar/AppEntry;->loadSharedRuntimeDex()V

    .line 244
    :cond_2
    sget-boolean v4, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    if-eqz v4, :cond_3

    .line 246
    invoke-direct {p0, v0}, Lair/Vispar/AppEntry;->createActivityWrapper(Z)V

    .line 249
    invoke-direct {p0}, Lair/Vispar/AppEntry;->InvokeWrapperOnCreate()V

    goto :goto_0

    .line 253
    :cond_3
    if-eqz v0, :cond_4

    .line 257
    invoke-static {}, Lair/Vispar/AppEntry;->KillSelf()V

    goto :goto_0

    .line 265
    :cond_4
    invoke-direct {p0}, Lair/Vispar/AppEntry;->launchAIRService()V

    goto :goto_0
.end method

.method public onCreateContextMenu(Landroid/view/ContextMenu;Landroid/view/View;Landroid/view/ContextMenu$ContextMenuInfo;)V
    .locals 6
    .parameter "menu"
    .parameter "v"
    .parameter "menuInfo"

    .prologue
    .line 757
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onCreateContextMenu(Landroid/view/ContextMenu;Landroid/view/View;Landroid/view/ContextMenu$ContextMenuInfo;)V

    .line 761
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onCreateContextMenu"

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/view/ContextMenu;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-class v5, Landroid/view/View;

    aput-object v5, v3, v4

    const/4 v4, 0x2

    const-class v5, Landroid/view/ContextMenu$ContextMenuInfo;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 762
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const/4 v2, 0x1

    aput-object p2, v1, v2

    const/4 v2, 0x2

    aput-object p3, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 768
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 764
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onCreateDescription()Ljava/lang/CharSequence;
    .locals 8

    .prologue
    .line 773
    invoke-super {p0}, Landroid/app/Activity;->onCreateDescription()Ljava/lang/CharSequence;

    move-result-object v2

    .line 777
    .local v2, retval:Ljava/lang/CharSequence;
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onCreateDescription"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Ljava/lang/CharSequence;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 778
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v2, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/CharSequence;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, p0

    .line 783
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-object v3

    .line 780
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move-object v3, v2

    .line 783
    goto :goto_0
.end method

.method protected onCreateDialog(I)Landroid/app/Dialog;
    .locals 8
    .parameter "id"

    .prologue
    .line 1226
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreateDialog(I)Landroid/app/Dialog;

    move-result-object v2

    .line 1230
    .local v2, retval:Landroid/app/Dialog;
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onCreateDialog"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/app/Dialog;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 1231
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object v2, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, p0

    .line 1236
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-object v3

    .line 1233
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move-object v3, v2

    .line 1236
    goto :goto_0
.end method

.method protected onCreateDialog(ILandroid/os/Bundle;)Landroid/app/Dialog;
    .locals 8
    .parameter "id"
    .parameter "args"

    .prologue
    .line 1243
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onCreateDialog(ILandroid/os/Bundle;)Landroid/app/Dialog;

    move-result-object v2

    .line 1247
    .local v2, retval:Landroid/app/Dialog;
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onCreateDialog"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/os/Bundle;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    const-class v7, Landroid/app/Dialog;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 1248
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    aput-object v2, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Landroid/app/Dialog;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, p0

    .line 1253
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-object v3

    .line 1250
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move-object v3, v2

    .line 1253
    goto :goto_0
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;)Z
    .locals 8
    .parameter "menu"

    .prologue
    .line 790
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreateOptionsMenu(Landroid/view/Menu;)Z

    move-result v2

    .line 794
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onCreateOptionsMenu"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/view/Menu;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 795
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 800
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 797
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 800
    goto :goto_0
.end method

.method public onCreatePanelMenu(ILandroid/view/Menu;)Z
    .locals 8
    .parameter "featureId"
    .parameter "menu"

    .prologue
    .line 807
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onCreatePanelMenu(ILandroid/view/Menu;)Z

    move-result v2

    .line 811
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onCreatePanelMenu"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/view/Menu;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 812
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 817
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 814
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 817
    goto :goto_0
.end method

.method public onCreatePanelView(I)Landroid/view/View;
    .locals 8
    .parameter "featureId"

    .prologue
    .line 824
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreatePanelView(I)Landroid/view/View;

    move-result-object v2

    .line 828
    .local v2, retval:Landroid/view/View;
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onCreatePanelView"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/view/View;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 829
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object v2, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, p0

    .line 834
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-object v3

    .line 831
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move-object v3, v2

    .line 834
    goto :goto_0
.end method

.method public onCreateThumbnail(Landroid/graphics/Bitmap;Landroid/graphics/Canvas;)Z
    .locals 8
    .parameter "outBitmap"
    .parameter "canvas"

    .prologue
    .line 841
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onCreateThumbnail(Landroid/graphics/Bitmap;Landroid/graphics/Canvas;)Z

    move-result v2

    .line 845
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onCreateThumbnail"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/graphics/Bitmap;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/graphics/Canvas;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 846
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 851
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 848
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 851
    goto :goto_0
.end method

.method public onCreateView(Ljava/lang/String;Landroid/content/Context;Landroid/util/AttributeSet;)Landroid/view/View;
    .locals 8
    .parameter "name"
    .parameter "context"
    .parameter "attrs"

    .prologue
    .line 858
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onCreateView(Ljava/lang/String;Landroid/content/Context;Landroid/util/AttributeSet;)Landroid/view/View;

    move-result-object v2

    .line 862
    .local v2, retval:Landroid/view/View;
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onCreateView"

    const/4 v5, 0x4

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Ljava/lang/String;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/content/Context;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    const-class v7, Landroid/util/AttributeSet;

    aput-object v7, v5, v6

    const/4 v6, 0x3

    const-class v7, Landroid/view/View;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 863
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x4

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    aput-object p3, v3, v4

    const/4 v4, 0x3

    aput-object v2, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Landroid/view/View;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v3, p0

    .line 868
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-object v3

    .line 865
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move-object v3, v2

    .line 868
    goto :goto_0
.end method

.method public onDestroy()V
    .locals 4

    .prologue
    .line 456
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 459
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onDestroy"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 460
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 466
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    const/4 v1, 0x0

    sput-object v1, Lair/Vispar/AppEntry;->sThis:Lair/Vispar/AppEntry;

    .line 467
    return-void

    .line 462
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onDetachedFromWindow()V
    .locals 4

    .prologue
    .line 875
    invoke-super {p0}, Landroid/app/Activity;->onDetachedFromWindow()V

    .line 879
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onDetachedFromWindow"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 880
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 886
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 882
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 8
    .parameter "keyCode"
    .parameter "event"

    .prologue
    .line 891
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v2

    .line 895
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onKeyDown"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/view/KeyEvent;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 896
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 901
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 898
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 901
    goto :goto_0
.end method

.method public onKeyLongPress(ILandroid/view/KeyEvent;)Z
    .locals 8
    .parameter "keyCode"
    .parameter "event"

    .prologue
    .line 908
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyLongPress(ILandroid/view/KeyEvent;)Z

    move-result v2

    .line 912
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onKeyLongPress"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/view/KeyEvent;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 913
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 918
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 915
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 918
    goto :goto_0
.end method

.method public onKeyMultiple(IILandroid/view/KeyEvent;)Z
    .locals 8
    .parameter "keyCode"
    .parameter "repeatCount"
    .parameter "event"

    .prologue
    .line 925
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onKeyMultiple(IILandroid/view/KeyEvent;)Z

    move-result v2

    .line 929
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onKeyMultiple"

    const/4 v5, 0x4

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    const-class v7, Landroid/view/KeyEvent;

    aput-object v7, v5, v6

    const/4 v6, 0x3

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 930
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x4

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x2

    aput-object p3, v3, v4

    const/4 v4, 0x3

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 935
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 932
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 935
    goto :goto_0
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 8
    .parameter "keyCode"
    .parameter "event"

    .prologue
    .line 942
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result v2

    .line 946
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onKeyUp"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/view/KeyEvent;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 947
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 952
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 949
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 952
    goto :goto_0
.end method

.method public onLowMemory()V
    .locals 4

    .prologue
    .line 531
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onLowMemory"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 532
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 538
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 534
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onMenuItemSelected(ILandroid/view/MenuItem;)Z
    .locals 8
    .parameter "featureId"
    .parameter "item"

    .prologue
    .line 959
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onMenuItemSelected(ILandroid/view/MenuItem;)Z

    move-result v2

    .line 963
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onMenuItemSelected"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/view/MenuItem;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 964
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 969
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 966
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 969
    goto :goto_0
.end method

.method public onMenuOpened(ILandroid/view/Menu;)Z
    .locals 8
    .parameter "featureId"
    .parameter "menu"

    .prologue
    .line 976
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onMenuOpened(ILandroid/view/Menu;)Z

    move-result v2

    .line 980
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onMenuOpened"

    const/4 v5, 0x3

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/view/Menu;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 981
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 986
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 983
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 986
    goto :goto_0
.end method

.method protected onNewIntent(Landroid/content/Intent;)V
    .locals 7
    .parameter "aIntent"

    .prologue
    .line 560
    move-object v0, p1

    .line 561
    .local v0, ii:Landroid/content/Intent;
    invoke-super {p0, v0}, Landroid/app/Activity;->onNewIntent(Landroid/content/Intent;)V

    .line 567
    :try_start_0
    sget-object v2, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v3, "onNewIntent"

    const/4 v4, 0x1

    new-array v4, v4, [Ljava/lang/Class;

    const/4 v5, 0x0

    const-class v6, Landroid/content/Intent;

    aput-object v6, v4, v5

    invoke-virtual {v2, v3, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 568
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    aput-object v0, v2, v3

    invoke-direct {p0, v1, v2}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 574
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 570
    :catch_0
    move-exception v2

    goto :goto_0
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .locals 8
    .parameter "item"

    .prologue
    .line 994
    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result v2

    .line 998
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onOptionsItemSelected"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/view/MenuItem;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 999
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 1004
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 1001
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 1004
    goto :goto_0
.end method

.method public onOptionsMenuClosed(Landroid/view/Menu;)V
    .locals 6
    .parameter "menu"

    .prologue
    .line 1011
    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsMenuClosed(Landroid/view/Menu;)V

    .line 1015
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onOptionsMenuClosed"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/view/Menu;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1016
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1022
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1018
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onPanelClosed(ILandroid/view/Menu;)V
    .locals 6
    .parameter "featureId"
    .parameter "menu"

    .prologue
    .line 1027
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onPanelClosed(ILandroid/view/Menu;)V

    .line 1031
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onPanelClosed"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-class v5, Landroid/view/Menu;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1032
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    aput-object p2, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1038
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1034
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onPause()V
    .locals 4

    .prologue
    .line 405
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 408
    :try_start_0
    sget-boolean v1, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    if-eqz v1, :cond_0

    .line 410
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onPause"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 411
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 418
    .end local v0           #method:Ljava/lang/reflect/Method;
    :cond_0
    :goto_0
    return-void

    .line 414
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onPostCreate(Landroid/os/Bundle;)V
    .locals 6
    .parameter "savedInstanceState"

    .prologue
    .line 1260
    invoke-super {p0, p1}, Landroid/app/Activity;->onPostCreate(Landroid/os/Bundle;)V

    .line 1264
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onPostCreate"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/os/Bundle;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1265
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1271
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1267
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onPostResume()V
    .locals 4

    .prologue
    .line 1276
    invoke-super {p0}, Landroid/app/Activity;->onPostResume()V

    .line 1280
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onPostResume"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1281
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1287
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1283
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onPrepareDialog(ILandroid/app/Dialog;)V
    .locals 6
    .parameter "id"
    .parameter "dialog"

    .prologue
    .line 1292
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onPrepareDialog(ILandroid/app/Dialog;)V

    .line 1296
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onPrepareDialog"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/R$id;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-class v5, Landroid/app/Dialog;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1297
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    aput-object p2, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1303
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1299
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onPrepareDialog(ILandroid/app/Dialog;Landroid/os/Bundle;)V
    .locals 6
    .parameter "id"
    .parameter "dialog"
    .parameter "args"

    .prologue
    .line 1308
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onPrepareDialog(ILandroid/app/Dialog;Landroid/os/Bundle;)V

    .line 1312
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onPrepareDialog"

    const/4 v3, 0x3

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/R$id;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    const-class v5, Landroid/app/Dialog;

    aput-object v5, v3, v4

    const/4 v4, 0x2

    const-class v5, Landroid/os/Bundle;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1313
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x3

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    const/4 v2, 0x1

    aput-object p2, v1, v2

    const/4 v2, 0x2

    aput-object p3, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1319
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1315
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onPrepareOptionsMenu(Landroid/view/Menu;)Z
    .locals 8
    .parameter "menu"

    .prologue
    .line 1043
    invoke-super {p0, p1}, Landroid/app/Activity;->onPrepareOptionsMenu(Landroid/view/Menu;)Z

    move-result v2

    .line 1047
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onPrepareOptionsMenu"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/view/Menu;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 1048
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 1053
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 1050
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 1053
    goto :goto_0
.end method

.method public onPreparePanel(ILandroid/view/View;Landroid/view/Menu;)Z
    .locals 8
    .parameter "featureId"
    .parameter "view"
    .parameter "menu"

    .prologue
    .line 1060
    invoke-super {p0, p1, p2, p3}, Landroid/app/Activity;->onPreparePanel(ILandroid/view/View;Landroid/view/Menu;)Z

    move-result v2

    .line 1064
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onPreparePanel"

    const/4 v5, 0x4

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    const-class v7, Landroid/view/View;

    aput-object v7, v5, v6

    const/4 v6, 0x2

    const-class v7, Landroid/view/Menu;

    aput-object v7, v5, v6

    const/4 v6, 0x3

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 1065
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x4

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    const/4 v4, 0x1

    aput-object p2, v3, v4

    const/4 v4, 0x2

    aput-object p3, v3, v4

    const/4 v4, 0x3

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 1070
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 1067
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 1070
    goto :goto_0
.end method

.method public onRestart()V
    .locals 4

    .prologue
    .line 387
    invoke-super {p0}, Landroid/app/Activity;->onRestart()V

    .line 390
    :try_start_0
    sget-boolean v1, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    if-eqz v1, :cond_0

    .line 392
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onRestart"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 393
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 400
    .end local v0           #method:Ljava/lang/reflect/Method;
    :cond_0
    :goto_0
    return-void

    .line 396
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 6
    .parameter "savedInstanceState"

    .prologue
    .line 1324
    invoke-super {p0, p1}, Landroid/app/Activity;->onRestoreInstanceState(Landroid/os/Bundle;)V

    .line 1328
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onRestoreInstanceState"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/os/Bundle;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1329
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1335
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1331
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onResume()V
    .locals 4

    .prologue
    .line 423
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 426
    :try_start_0
    sget-boolean v1, Lair/Vispar/AppEntry;->sRuntimeClassesLoaded:Z

    if-eqz v1, :cond_0

    .line 428
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onResume"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 429
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 436
    .end local v0           #method:Ljava/lang/reflect/Method;
    :cond_0
    :goto_0
    return-void

    .line 432
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onRetainNonConfigurationInstance()Ljava/lang/Object;
    .locals 8

    .prologue
    .line 1077
    invoke-super {p0}, Landroid/app/Activity;->onRetainNonConfigurationInstance()Ljava/lang/Object;

    move-result-object v2

    .line 1081
    .local v2, retval:Ljava/lang/Object;
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onRetainNonConfigurationInstance"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Ljava/lang/Object;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 1082
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object v2, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v3

    .line 1087
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-object v3

    .line 1084
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move-object v3, v2

    .line 1087
    goto :goto_0
.end method

.method protected onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 6
    .parameter "outState"

    .prologue
    .line 1340
    invoke-super {p0, p1}, Landroid/app/Activity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 1344
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onSaveInstanceState"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/os/Bundle;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1345
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1351
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1347
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onSearchRequested()Z
    .locals 8

    .prologue
    .line 1094
    invoke-super {p0}, Landroid/app/Activity;->onSearchRequested()Z

    move-result v2

    .line 1098
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onSearchRequested"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 1099
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 1104
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 1101
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 1104
    goto :goto_0
.end method

.method public onStart()V
    .locals 0

    .prologue
    .line 381
    invoke-super {p0}, Landroid/app/Activity;->onStart()V

    .line 382
    return-void
.end method

.method public onStop()V
    .locals 4

    .prologue
    .line 441
    invoke-super {p0}, Landroid/app/Activity;->onStop()V

    .line 444
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onStop"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 445
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 451
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 447
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onTitleChanged(Ljava/lang/CharSequence;I)V
    .locals 6
    .parameter "title"
    .parameter "color"

    .prologue
    .line 1356
    invoke-super {p0, p1, p2}, Landroid/app/Activity;->onTitleChanged(Ljava/lang/CharSequence;I)V

    .line 1360
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onTitleChanged"

    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Ljava/lang/CharSequence;

    aput-object v5, v3, v4

    const/4 v4, 0x1

    sget-object v5, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1361
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    const/4 v2, 0x1

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1367
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1363
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 8
    .parameter "event"

    .prologue
    .line 1111
    invoke-super {p0, p1}, Landroid/app/Activity;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v2

    .line 1115
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onTouchEvent"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/view/MotionEvent;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 1116
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 1121
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 1118
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 1121
    goto :goto_0
.end method

.method public onTrackballEvent(Landroid/view/MotionEvent;)Z
    .locals 8
    .parameter "event"

    .prologue
    .line 1128
    invoke-super {p0, p1}, Landroid/app/Activity;->onTrackballEvent(Landroid/view/MotionEvent;)Z

    move-result v2

    .line 1132
    .local v2, retval:Z
    :try_start_0
    sget-object v3, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v4, "onTrackballEvent"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Class;

    const/4 v6, 0x0

    const-class v7, Landroid/view/MotionEvent;

    aput-object v7, v5, v6

    const/4 v6, 0x1

    sget-object v7, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v7, v5, v6

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 1133
    .local v1, method:Ljava/lang/reflect/Method;
    const/4 v3, 0x2

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p1, v3, v4

    const/4 v4, 0x1

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-direct {p0, v1, v3}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    .end local p0
    check-cast p0, Ljava/lang/Boolean;

    invoke-virtual {p0}, Ljava/lang/Boolean;->booleanValue()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    .line 1139
    .end local v1           #method:Ljava/lang/reflect/Method;
    :goto_0
    return v3

    .line 1136
    :catch_0
    move-exception v3

    move-object v0, v3

    .local v0, e:Ljava/lang/Exception;
    move v3, v2

    .line 1139
    goto :goto_0
.end method

.method public onUserInteraction()V
    .locals 4

    .prologue
    .line 1146
    invoke-super {p0}, Landroid/app/Activity;->onUserInteraction()V

    .line 1150
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onUserInteraction"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1151
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1157
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1153
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method protected onUserLeaveHint()V
    .locals 4

    .prologue
    .line 1372
    invoke-super {p0}, Landroid/app/Activity;->onUserLeaveHint()V

    .line 1376
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onUserLeaveHint"

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/Class;

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1377
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1383
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1379
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onWindowAttributesChanged(Landroid/view/WindowManager$LayoutParams;)V
    .locals 6
    .parameter "params"

    .prologue
    .line 1162
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowAttributesChanged(Landroid/view/WindowManager$LayoutParams;)V

    .line 1166
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onWindowAttributesChanged"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    const-class v5, Landroid/view/WindowManager$LayoutParams;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1167
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    aput-object p1, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1173
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1169
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public onWindowFocusChanged(Z)V
    .locals 6
    .parameter "hasFocus"

    .prologue
    .line 1178
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    .line 1182
    :try_start_0
    sget-object v1, Lair/Vispar/AppEntry;->sAndroidActivityWrapperClass:Ljava/lang/Class;

    const-string v2, "onWindowFocusChanged"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    const/4 v4, 0x0

    sget-object v5, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v5, v3, v4

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    .line 1183
    .local v0, method:Ljava/lang/reflect/Method;
    const/4 v1, 0x1

    new-array v1, v1, [Ljava/lang/Object;

    const/4 v2, 0x0

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    aput-object v3, v1, v2

    invoke-direct {p0, v0, v1}, Lair/Vispar/AppEntry;->InvokeMethod(Ljava/lang/reflect/Method;[Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1189
    .end local v0           #method:Ljava/lang/reflect/Method;
    :goto_0
    return-void

    .line 1185
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.class public Lcom/adobe/air/AndroidActivityWrapper;
.super Ljava/lang/Object;
.source "AndroidActivityWrapper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/AndroidActivityWrapper$2;,
        Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;,
        Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;,
        Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;,
        Lcom/adobe/air/AndroidActivityWrapper$DebugMode;,
        Lcom/adobe/air/AndroidActivityWrapper$PlaneID;,
        Lcom/adobe/air/AndroidActivityWrapper$ActivityState;
    }
.end annotation


# static fields
.field private static final ADOBE_COM:Ljava/lang/String; = "adobe.com"

.field private static final ASPECT_RATIO_ANY:I = 0x3

.field private static final ASPECT_RATIO_LANDSCAPE:I = 0x2

.field private static final ASPECT_RATIO_PORTRAIT:I = 0x1

.field public static final IMAGE_PICKER_REQUEST_CODE:I = 0x2

.field private static final INVOKE_EVENT_OPEN_URL:I = 0x1

.field private static final INVOKE_EVENT_STANDARD:I = 0x0

.field private static final LOG_TAG:Ljava/lang/String; = "AndroidActivityWrapper"

.field public static final STILL_PICTURE_REQUEST_CODE:I = 0x3

.field public static final VIDEO_CAPTURE_REQUEST_CODE:I = 0x4

.field public static final WEBVIEW_UPLOAD_FILE_CHOOSER_CODE:I = 0x5

.field private static final WWW_ADOBE_COM:Ljava/lang/String; = "www.adobe.com"

.field private static sActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

.field private static sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

.field private static sApplicationLaunched:Z

.field private static sDepthAndStencil:Z

.field private static sEntryPoint:Lcom/adobe/air/Entrypoints;

.field private static sGamePreviewHost:Ljava/lang/String;

.field private static sHasCaptiveRuntime:Z

.field private static sIdleStateManager:Lcom/adobe/air/AndroidIdleState;

.field private static sIsSwfPreviewMode:Z

.field private static sRuntimeLibrariesLoaded:Z


# instance fields
.field private debuggerPort:I

.field private keyGuardManager:Landroid/app/KeyguardManager;

.field private mActivateEventPending:Z

.field private mActivityResultListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

.field private mActivityStateListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mConfigDownloadListener:Lcom/adobe/air/ConfigDownloadListener;

.field private mContainsVideo:Z

.field private mDebuggerSettings:Lcom/adobe/air/DebuggerSettings;

.field private mDisplayWaitingDialog:Z

.field private mExtraArgs:Ljava/lang/String;

.field private mFullScreenSetFromMetaData:Z

.field private mHardKeyboardHidden:I

.field private mHardKeyboardType:I

.field private mInputEventListeners:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;",
            ">;"
        }
    .end annotation
.end field

.field private mInvokeEventPendingFromOnCreate:Z

.field private mIsADL:Z

.field private mIsDebuggerMode:Z

.field private mIsFullScreen:Z

.field private mLibCorePath:Ljava/lang/String;

.field private mOrientationManager:Lcom/adobe/air/OrientationManager;

.field private mRGB565Override:Z

.field private mRootDir:Ljava/lang/String;

.field private mScreenOn:Z

.field private mShowDebuggerDialog:Z

.field private mXmlPath:Ljava/lang/String;

.field private m_activity:Landroid/app/Activity;

.field private m_application:Landroid/app/Application;

.field private m_cameraView:Lcom/adobe/air/AndroidCameraView;

.field private m_flashEGL:Lcom/adobe/air/FlashEGL;

.field private m_layout:Landroid/widget/FrameLayout;

.field private m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

.field private m_newActivityCondition:Ljava/util/concurrent/locks/Condition;

.field private m_newActivityLock:Ljava/util/concurrent/locks/Lock;

.field private m_overlaysLayout:Landroid/widget/RelativeLayout;

.field private m_planeBreakCascade:Z

.field private m_planeCascadeInit:Z

.field private m_planeCascadeStep:I

.field private m_planes:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List",
            "<",
            "Landroid/view/SurfaceView;",
            ">;"
        }
    .end annotation
.end field

.field private m_runtimeContext:Landroid/content/Context;

.field private m_skipKickCascade:Z

.field private m_videoView:Landroid/view/SurfaceView;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    const/4 v1, 0x0

    .line 82
    sput-boolean v1, Lcom/adobe/air/AndroidActivityWrapper;->sApplicationLaunched:Z

    .line 83
    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sEntryPoint:Lcom/adobe/air/Entrypoints;

    .line 84
    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    .line 85
    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    .line 86
    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    .line 111
    sput-boolean v1, Lcom/adobe/air/AndroidActivityWrapper;->sRuntimeLibrariesLoaded:Z

    .line 116
    sput-boolean v1, Lcom/adobe/air/AndroidActivityWrapper;->sHasCaptiveRuntime:Z

    .line 117
    sput-boolean v1, Lcom/adobe/air/AndroidActivityWrapper;->sIsSwfPreviewMode:Z

    .line 118
    const-string v0, ""

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sGamePreviewHost:Ljava/lang/String;

    .line 123
    sput-boolean v1, Lcom/adobe/air/AndroidActivityWrapper;->sDepthAndStencil:Z

    return-void
.end method

.method private constructor <init>(Landroid/app/Activity;)V
    .locals 4
    .parameter

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 227
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 87
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    .line 88
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mConfigDownloadListener:Lcom/adobe/air/ConfigDownloadListener;

    .line 89
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    .line 90
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    .line 91
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 92
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_videoView:Landroid/view/SurfaceView;

    .line 93
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_cameraView:Lcom/adobe/air/AndroidCameraView;

    .line 94
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    .line 95
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_flashEGL:Lcom/adobe/air/FlashEGL;

    .line 96
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mXmlPath:Ljava/lang/String;

    .line 97
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mRootDir:Ljava/lang/String;

    .line 98
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mExtraArgs:Ljava/lang/String;

    .line 99
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    .line 100
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mRGB565Override:Z

    .line 101
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsDebuggerMode:Z

    .line 102
    const/4 v0, 0x2

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mHardKeyboardHidden:I

    .line 103
    iput v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mHardKeyboardType:I

    .line 104
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mShowDebuggerDialog:Z

    .line 105
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDisplayWaitingDialog:Z

    .line 106
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->debuggerPort:I

    .line 107
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInvokeEventPendingFromOnCreate:Z

    .line 108
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivateEventPending:Z

    .line 109
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    .line 110
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    .line 112
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mFullScreenSetFromMetaData:Z

    .line 113
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsFullScreen:Z

    .line 114
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mContainsVideo:Z

    .line 115
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mLibCorePath:Ljava/lang/String;

    .line 129
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;

    .line 131
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    .line 133
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    .line 134
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityCondition:Ljava/util/concurrent/locks/Condition;

    .line 143
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    .line 144
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->keyGuardManager:Landroid/app/KeyguardManager;

    .line 147
    iput-boolean v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->mScreenOn:Z

    .line 148
    new-instance v0, Lcom/adobe/air/DebuggerSettings;

    invoke-direct {v0}, Lcom/adobe/air/DebuggerSettings;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDebuggerSettings:Lcom/adobe/air/DebuggerSettings;

    .line 151
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->STARTED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .line 333
    iput-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    .line 335
    iput v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    .line 336
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeBreakCascade:Z

    .line 337
    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeInit:Z

    .line 338
    iput-boolean v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_skipKickCascade:Z

    .line 228
    iput-object p1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    .line 229
    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    .line 230
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->newCondition()Ljava/util/concurrent/locks/Condition;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityCondition:Ljava/util/concurrent/locks/Condition;

    .line 231
    invoke-virtual {p1}, Landroid/app/Activity;->getApplication()Landroid/app/Application;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    .line 240
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->LoadRuntimeLibraries()V

    .line 242
    const-string v0, "keyguard"

    invoke-virtual {p1, v0}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/KeyguardManager;

    check-cast v0, Landroid/app/KeyguardManager;

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->keyGuardManager:Landroid/app/KeyguardManager;

    .line 243
    return-void
.end method

.method public static CreateAndroidActivityWrapper(Landroid/app/Activity;)Lcom/adobe/air/AndroidActivityWrapper;
    .locals 1
    .parameter

    .prologue
    .line 206
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->CreateAndroidActivityWrapper(Landroid/app/Activity;Ljava/lang/Boolean;)Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    return-object v0
.end method

.method public static CreateAndroidActivityWrapper(Landroid/app/Activity;Ljava/lang/Boolean;)Lcom/adobe/air/AndroidActivityWrapper;
    .locals 1
    .parameter
    .parameter

    .prologue
    .line 211
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    sput-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sHasCaptiveRuntime:Z

    .line 212
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 214
    invoke-virtual {p0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/adobe/air/utils/Utils;->setRuntimePackageName(Ljava/lang/String;)V

    .line 221
    :goto_0
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    if-nez v0, :cond_0

    .line 222
    new-instance v0, Lcom/adobe/air/AndroidActivityWrapper;

    invoke-direct {v0, p0}, Lcom/adobe/air/AndroidActivityWrapper;-><init>(Landroid/app/Activity;)V

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    .line 223
    :cond_0
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    return-object v0

    .line 219
    :cond_1
    const-string v0, "com.adobe.air"

    invoke-static {v0}, Lcom/adobe/air/utils/Utils;->setRuntimePackageName(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;
    .locals 1

    .prologue
    .line 247
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sActivityWrapper:Lcom/adobe/air/AndroidActivityWrapper;

    return-object v0
.end method

.method public static GetDepthAndStencilForGamePreview()Z
    .locals 1

    .prologue
    .line 264
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sDepthAndStencil:Z

    return v0
.end method

.method public static GetHasCaptiveRuntime()Z
    .locals 1

    .prologue
    .line 252
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sHasCaptiveRuntime:Z

    return v0
.end method

.method public static IsGamePreviewMode()Z
    .locals 1

    .prologue
    .line 258
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sIsSwfPreviewMode:Z

    return v0
.end method

.method private LaunchApplication(Landroid/app/Activity;Lcom/adobe/air/AIRWindowSurfaceView;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)V
    .locals 13
    .parameter
    .parameter
    .parameter
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    .line 858
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sApplicationLaunched:Z

    if-eqz v0, :cond_0

    .line 1008
    :goto_0
    return-void

    .line 873
    :cond_0
    if-eqz p6, :cond_2

    .line 876
    :try_start_0
    invoke-virtual {p1}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    const-string v1, "args"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 877
    if-eqz v0, :cond_e

    .line 879
    const-string v1, " "

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 880
    const/4 v1, 0x0

    aget-object v1, v0, v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 881
    const/4 v2, 0x1

    :try_start_1
    aget-object v2, v0, v2
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_3

    .line 883
    :try_start_2
    array-length v3, v0

    const/4 v4, 0x2

    if-lt v3, v4, :cond_d

    .line 885
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v4, 0x2

    aget-object v4, v0, v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4

    move-result-object v3

    .line 887
    :goto_1
    const/4 v4, 0x3

    move v12, v4

    move-object v4, v3

    move v3, v12

    :goto_2
    :try_start_3
    array-length v5, v0

    if-ge v3, v5, :cond_1

    .line 889
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    aget-object v6, v0, v3

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_5

    move-result-object v4

    .line 887
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    :cond_1
    move-object v0, v4

    move-object v12, v2

    move-object v2, v1

    move-object v1, v12

    :goto_3
    move-object v3, v0

    move-object v12, v1

    move-object v1, v2

    move-object v2, v12

    .line 995
    :goto_4
    :try_start_4
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getApplicationContext()Landroid/content/Context;

    move-result-object v8

    .line 997
    new-instance v0, Lcom/adobe/air/Entrypoints;

    invoke-direct {v0}, Lcom/adobe/air/Entrypoints;-><init>()V

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sEntryPoint:Lcom/adobe/air/Entrypoints;

    .line 998
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sEntryPoint:Lcom/adobe/air/Entrypoints;

    invoke-static {}, Lcom/adobe/air/utils/Utils;->getRuntimePackageName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1}, Landroid/app/Activity;->getApplication()Landroid/app/Application;

    move-result-object v6

    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v7

    move-object v5, p2

    move-object v9, p0

    move/from16 v10, p6

    move/from16 v11, p7

    invoke-virtual/range {v0 .. v11}, Lcom/adobe/air/Entrypoints;->EntryMain(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;ZZ)V

    .line 1000
    invoke-static {v8}, Lcom/adobe/air/AndroidIdleState;->GetIdleStateManager(Landroid/content/Context;)Lcom/adobe/air/AndroidIdleState;

    move-result-object v0

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    .line 1002
    const/4 v0, 0x1

    sput-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sApplicationLaunched:Z

    goto/16 :goto_0

    .line 1004
    :catch_0
    move-exception v0

    goto/16 :goto_0

    .line 900
    :catch_1
    move-exception v0

    move-object/from16 v0, p5

    move-object/from16 v1, p4

    move-object/from16 v2, p3

    :goto_5
    move-object v3, v0

    move-object v12, v1

    move-object v1, v2

    move-object v2, v12

    .line 903
    goto :goto_4

    .line 905
    :cond_2
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sIsSwfPreviewMode:Z
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    if-eqz v0, :cond_c

    .line 908
    :try_start_5
    invoke-virtual {p1}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v0

    .line 909
    if-eqz v0, :cond_b

    .line 913
    const-string v1, "?"

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    if-lez v1, :cond_b

    .line 915
    const-string v1, "?"

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 916
    const/4 v1, -0x1

    .line 917
    const-string v2, "&"

    invoke-virtual {v0, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    array-length v2, v0

    const/4 v3, 0x0

    move v12, v3

    move v3, v1

    move v1, v12

    :goto_6
    if-ge v1, v2, :cond_a

    aget-object v4, v0, v1

    .line 921
    const/4 v5, 0x0

    const-string v6, "="

    invoke-virtual {v4, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    const-string v6, "depthAndStencil"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_5

    .line 923
    const-string v5, "="

    invoke-virtual {v4, v5}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v5

    add-int/lit8 v5, v5, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .line 925
    const-string v5, "true"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    .line 928
    const/4 v4, 0x1

    sput-boolean v4, Lcom/adobe/air/AndroidActivityWrapper;->sDepthAndStencil:Z

    .line 917
    :cond_3
    :goto_7
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 933
    :cond_4
    const/4 v4, 0x0

    sput-boolean v4, Lcom/adobe/air/AndroidActivityWrapper;->sDepthAndStencil:Z

    goto :goto_7

    .line 989
    :catch_2
    move-exception v0

    move-object/from16 v3, p5

    move-object/from16 v2, p4

    move-object/from16 v1, p3

    goto/16 :goto_4

    .line 936
    :cond_5
    const/4 v5, 0x0

    const-string v6, "="

    invoke-virtual {v4, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    const-string v6, "autoorients"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_7

    .line 938
    const-string v5, "="

    invoke-virtual {v4, v5}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v5

    add-int/lit8 v5, v5, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .line 940
    const-string v5, "true"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 943
    const/4 v4, 0x1

    invoke-virtual {p0, v4}, Lcom/adobe/air/AndroidActivityWrapper;->setAutoOrients(Z)V

    goto :goto_7

    .line 948
    :cond_6
    const/4 v4, 0x0

    invoke-virtual {p0, v4}, Lcom/adobe/air/AndroidActivityWrapper;->setAutoOrients(Z)V

    goto :goto_7

    .line 951
    :cond_7
    const/4 v5, 0x0

    const-string v6, "="

    invoke-virtual {v4, v6}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v4, v5, v6}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v5

    const-string v6, "aspectratio"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_3

    .line 953
    const-string v5, "="

    invoke-virtual {v4, v5}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v5

    add-int/lit8 v5, v5, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .line 955
    const-string v5, "portrait"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_8

    .line 957
    const/4 v3, 0x1

    goto :goto_7

    .line 959
    :cond_8
    const-string v5, "landscape"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_9

    .line 961
    const/4 v3, 0x2

    goto :goto_7

    .line 963
    :cond_9
    const-string v5, "any"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 965
    const/4 v3, 0x3

    goto :goto_7

    .line 976
    :cond_a
    const/4 v0, -0x1

    if-eq v3, v0, :cond_b

    .line 979
    invoke-virtual {p0, v3}, Lcom/adobe/air/AndroidActivityWrapper;->setAspectRatio(I)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2

    :cond_b
    move-object/from16 v3, p5

    move-object/from16 v2, p4

    move-object/from16 v1, p3

    .line 992
    goto/16 :goto_4

    .line 900
    :catch_3
    move-exception v0

    move-object/from16 v0, p5

    move-object v2, v1

    move-object/from16 v1, p4

    goto/16 :goto_5

    :catch_4
    move-exception v0

    move-object/from16 v0, p5

    move-object v12, v2

    move-object v2, v1

    move-object v1, v12

    goto/16 :goto_5

    :catch_5
    move-exception v0

    move-object v0, v4

    move-object v12, v2

    move-object v2, v1

    move-object v1, v12

    goto/16 :goto_5

    :cond_c
    move-object/from16 v3, p5

    move-object/from16 v2, p4

    move-object/from16 v1, p3

    goto/16 :goto_4

    :cond_d
    move-object/from16 v3, p5

    goto/16 :goto_1

    :cond_e
    move-object/from16 v0, p5

    move-object/from16 v1, p4

    move-object/from16 v2, p3

    goto/16 :goto_3
.end method

.method private LoadRuntimeLibraries()V
    .locals 1

    .prologue
    .line 1408
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sRuntimeLibrariesLoaded:Z

    if-nez v0, :cond_0

    .line 1412
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    invoke-static {v0}, Lcom/adobe/air/utils/Utils;->GetLibSTLPath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 1413
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->GetLibCorePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/System;->load(Ljava/lang/String;)V

    .line 1414
    const/4 v0, 0x1

    sput-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sRuntimeLibrariesLoaded:Z
    :try_end_0
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    .line 1421
    :cond_0
    :goto_0
    return-void

    .line 1416
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private SetVisible(Z)V
    .locals 2
    .parameter

    .prologue
    .line 1243
    if-eqz p1, :cond_1

    .line 1245
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->isSurfaceValid()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mScreenOn:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->STOPPED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->DESTROYED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-eq v0, v1, :cond_0

    .line 1246
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->nativeSetVisible(Z)V

    .line 1254
    :cond_0
    :goto_0
    return-void

    .line 1251
    :cond_1
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->isApplicationLaunched()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1252
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->nativeSetVisible(Z)V

    goto :goto_0
.end method

.method public static ShouldShowGamePreviewWatermark()Z
    .locals 3

    .prologue
    .line 269
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sIsSwfPreviewMode:Z

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    .line 270
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 273
    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper;->sGamePreviewHost:Ljava/lang/String;

    const-string v2, "www.adobe.com"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper;->sGamePreviewHost:Ljava/lang/String;

    const-string v2, "adobe.com"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 275
    :cond_0
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    .line 279
    :cond_1
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    return v0
.end method

.method private SignalNewActivityCreated()V
    .locals 1

    .prologue
    .line 1828
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 1829
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityCondition:Ljava/util/concurrent/locks/Condition;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Condition;->signalAll()V

    .line 1830
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 1831
    return-void
.end method

.method private afterOnCreate()V
    .locals 5

    .prologue
    const/4 v2, 0x0

    const/16 v3, 0x8

    .line 749
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    if-nez v0, :cond_0

    .line 750
    new-instance v0, Ljava/util/ArrayList;

    const/16 v1, 0x8

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    move v0, v2

    .line 751
    :goto_0
    if-ge v0, v3, :cond_0

    .line 752
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    const/4 v2, 0x0

    invoke-interface {v1, v0, v2}, Ljava/util/List;->add(ILjava/lang/Object;)V

    .line 751
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 757
    :cond_0
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    .line 758
    new-instance v0, Landroid/widget/FrameLayout;

    invoke-direct {v0, v1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    .line 761
    new-instance v0, Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-direct {v0, v1, p0}, Lcom/adobe/air/AIRWindowSurfaceView;-><init>(Landroid/content/Context;Lcom/adobe/air/AndroidActivityWrapper;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 766
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_cameraView:Lcom/adobe/air/AndroidCameraView;

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;

    const-string v2, "android.permission.CAMERA"

    invoke-virtual {v0, v2}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_1

    .line 768
    new-instance v0, Lcom/adobe/air/AndroidCameraView;

    invoke-direct {v0, v1, p0}, Lcom/adobe/air/AndroidCameraView;-><init>(Landroid/content/Context;Lcom/adobe/air/AndroidActivityWrapper;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_cameraView:Lcom/adobe/air/AndroidCameraView;

    .line 783
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_cameraView:Lcom/adobe/air/AndroidCameraView;

    if-eqz v0, :cond_2

    .line 784
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_cameraView:Lcom/adobe/air/AndroidCameraView;

    const/16 v3, 0x8

    const/16 v4, 0x10

    invoke-virtual {v0, v2, v3, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;II)V

    .line 788
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getComponentName()Landroid/content/ComponentName;

    move-result-object v2

    const/16 v3, 0x80

    invoke-virtual {v0, v2, v3}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;

    move-result-object v0

    .line 789
    iget-object v0, v0, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    .line 791
    if-eqz v0, :cond_3

    .line 793
    const-string v2, "containsVideo"

    invoke-virtual {v0, v2}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    .line 795
    if-eqz v0, :cond_3

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 797
    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iput-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mContainsVideo:Z

    .line 798
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getVideoView()Lcom/adobe/flashruntime/shared/VideoView;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_videoView:Landroid/view/SurfaceView;

    .line 799
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_videoView:Landroid/view/SurfaceView;

    const/4 v3, 0x0

    invoke-virtual {v0, v2, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;I)V

    .line 803
    :cond_3
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 805
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    if-eqz v0, :cond_4

    .line 806
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {v0, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 810
    :cond_4
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    invoke-virtual {v0, v2}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    .line 817
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    if-nez v0, :cond_5

    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mShowDebuggerDialog:Z

    if-eqz v0, :cond_6

    .line 819
    :cond_5
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getCurrentFocus()Landroid/view/View;

    move-result-object v0

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    if-eq v0, v2, :cond_6

    .line 821
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->requestFocus()Z

    .line 822
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Lcom/adobe/air/AIRWindowSurfaceView;->onWindowFocusChanged(Z)V

    .line 826
    :cond_6
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mFullScreenSetFromMetaData:Z

    if-nez v0, :cond_7

    .line 828
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->setFullScreenFromMetaData()V

    .line 830
    :cond_7
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mFullScreenSetFromMetaData:Z

    .line 834
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getIsFullScreen()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 836
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->setFullScreen()V

    .line 840
    :cond_8
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->hardKeyboardHidden:I

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mHardKeyboardHidden:I

    .line 841
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->keyboard:I

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mHardKeyboardType:I

    .line 844
    invoke-static {}, Lcom/adobe/air/OrientationManager;->getOrientationManager()Lcom/adobe/air/OrientationManager;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    .line 845
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    iget-object v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0, v2, v3}, Lcom/adobe/air/OrientationManager;->onActivityCreated(Landroid/app/Activity;Lcom/adobe/air/AIRWindowSurfaceView;)V

    .line 846
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->callActivityStateListeners()V

    .line 848
    invoke-static {v1}, Lcom/adobe/flashplayer/HDMIUtils;->initHelper(Landroid/content/Context;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 854
    :goto_1
    return-void

    .line 850
    :catch_0
    move-exception v0

    goto :goto_1
.end method

.method private callActivityResultListeners(IILandroid/content/Intent;)V
    .locals 3
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1807
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    if-nez v0, :cond_1

    .line 1824
    :cond_0
    :goto_0
    return-void

    .line 1815
    :cond_1
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    move v2, v0

    :goto_1
    if-ge v2, v1, :cond_0

    .line 1817
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;

    invoke-interface {v0, p1, p2, p3}, Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;->onActivityResult(IILandroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1815
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 1820
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private callActivityStateListeners()V
    .locals 4

    .prologue
    .line 1741
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    if-nez v0, :cond_1

    .line 1755
    :cond_0
    :goto_0
    return-void

    .line 1746
    :cond_1
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    move v2, v0

    :goto_1
    if-ge v2, v1, :cond_0

    .line 1748
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    iget-object v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    invoke-interface {v0, v3}, Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;->onActivityStateChanged(Lcom/adobe/air/AndroidActivityWrapper$ActivityState;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1746
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 1751
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private callActivityStateListeners(Landroid/content/res/Configuration;)V
    .locals 3
    .parameter

    .prologue
    .line 1761
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    if-nez v0, :cond_1

    .line 1775
    :cond_0
    :goto_0
    return-void

    .line 1766
    :cond_1
    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    move v2, v0

    :goto_1
    if-ge v2, v1, :cond_0

    .line 1768
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;

    invoke-interface {v0, p1}, Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;->onConfigurationChanged(Landroid/content/res/Configuration;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1766
    add-int/lit8 v0, v2, 0x1

    move v2, v0

    goto :goto_1

    .line 1771
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private callInputEventListeners(Landroid/view/KeyEvent;)Z
    .locals 5
    .parameter

    .prologue
    const/4 v4, 0x0

    .line 1674
    .line 1675
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    if-nez v0, :cond_0

    move v0, v4

    .line 1690
    :goto_0
    return v0

    .line 1680
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    move v2, v4

    move v3, v4

    :goto_1
    if-ge v2, v1, :cond_3

    .line 1682
    if-nez v3, :cond_1

    :try_start_1
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;

    invoke-interface {v0, p1}, Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;->onKeyEvent(Landroid/view/KeyEvent;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    .line 1680
    :goto_2
    add-int/lit8 v2, v2, 0x1

    move v3, v0

    goto :goto_1

    :cond_2
    move v0, v4

    .line 1682
    goto :goto_2

    :cond_3
    move v0, v3

    .line 1688
    goto :goto_0

    .line 1685
    :catch_0
    move-exception v0

    move v0, v4

    goto :goto_0

    :catch_1
    move-exception v0

    move v0, v3

    goto :goto_0
.end method

.method private callInputEventListeners(Landroid/view/MotionEvent;)Z
    .locals 5
    .parameter

    .prologue
    const/4 v4, 0x0

    .line 1696
    .line 1697
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    if-nez v0, :cond_0

    move v0, v4

    .line 1711
    :goto_0
    return v0

    .line 1702
    :cond_0
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v1

    move v2, v4

    move v3, v4

    :goto_1
    if-ge v2, v1, :cond_3

    .line 1704
    if-nez v3, :cond_1

    :try_start_1
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;

    invoke-interface {v0, p1}, Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;->onGenericMotionEvent(Landroid/view/MotionEvent;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    .line 1702
    :goto_2
    add-int/lit8 v2, v2, 0x1

    move v3, v0

    goto :goto_1

    :cond_2
    move v0, v4

    .line 1704
    goto :goto_2

    :cond_3
    move v0, v3

    .line 1710
    goto :goto_0

    .line 1707
    :catch_0
    move-exception v0

    move v0, v4

    goto :goto_0

    :catch_1
    move-exception v0

    move v0, v3

    goto :goto_0
.end method

.method private checkForDebuggerAndLaunchDialog()V
    .locals 9

    .prologue
    const/4 v7, 0x0

    const/4 v6, 0x1

    const/4 v5, 0x0

    const-string v3, "raw.debuginfo"

    .line 1438
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    if-nez v0, :cond_1

    .line 1440
    new-instance v0, Lcom/adobe/air/ResourceFileManager;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/adobe/air/ResourceFileManager;-><init>(Landroid/content/Context;)V

    .line 1442
    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->None:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    .line 1444
    const-string v2, "raw.debuginfo"

    invoke-virtual {v0, v3}, Lcom/adobe/air/ResourceFileManager;->lookupResId(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/adobe/air/ResourceFileManager;->resExists(I)Z

    move-result v2

    if-eqz v2, :cond_c

    .line 1447
    :try_start_0
    const-string v2, "raw.debuginfo"

    invoke-virtual {v0, v2}, Lcom/adobe/air/ResourceFileManager;->lookupResId(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/adobe/air/ResourceFileManager;->getFileStreamFromRawRes(I)Ljava/io/InputStream;

    move-result-object v0

    .line 1452
    const-string v2, "="

    invoke-static {v0, v2}, Lcom/adobe/air/utils/Utils;->parseKeyValuePairFile(Ljava/io/InputStream;Ljava/lang/String;)Ljava/util/HashMap;

    move-result-object v2

    .line 1453
    const-string v0, "incomingDebugPort"

    invoke-virtual {v2, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1455
    if-eqz v0, :cond_0

    .line 1458
    :try_start_1
    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->debuggerPort:I

    .line 1459
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ListenMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;
    :try_end_1
    .catch Ljava/lang/NumberFormatException; {:try_start_1 .. :try_end_1} :catch_c
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-object v1, v0

    .line 1468
    :cond_0
    :goto_0
    :try_start_2
    const-string v0, "outgoingDebugHost"

    invoke-virtual {v2, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    if-eqz v0, :cond_c

    .line 1473
    sget-object v2, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ListenMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    if-ne v1, v2, :cond_2

    .line 1474
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ConflictMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    .line 1477
    new-instance v0, Ljava/lang/Exception;

    const-string v1, "listen and connect are mutually exclusive."

    invoke-direct {v0, v1}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1483
    :catch_0
    move-exception v0

    .line 1564
    :cond_1
    :goto_1
    :pswitch_0
    return-void

    .line 1480
    :cond_2
    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ConnectMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    move-object v8, v1

    move-object v1, v0

    move-object v0, v8

    .line 1489
    :goto_2
    sget-object v2, Lcom/adobe/air/AndroidActivityWrapper$2;->$SwitchMap$com$adobe$air$AndroidActivityWrapper$DebugMode:[I

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ordinal()I

    move-result v3

    aget v2, v2, v3

    packed-switch v2, :pswitch_data_0

    goto :goto_1

    .line 1502
    :pswitch_1
    :try_start_3
    new-instance v1, Ljava/net/ServerSocket;

    iget v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->debuggerPort:I

    const/4 v3, 0x1

    invoke-static {}, Ljava/net/InetAddress;->getLocalHost()Ljava/net/InetAddress;

    move-result-object v4

    invoke-direct {v1, v2, v3, v4}, Ljava/net/ServerSocket;-><init>(IILjava/net/InetAddress;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2
    .catch Ljava/lang/SecurityException; {:try_start_3 .. :try_end_3} :catch_4
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_6

    .line 1503
    :try_start_4
    invoke-virtual {v1}, Ljava/net/ServerSocket;->close()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_1
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_b
    .catch Ljava/lang/SecurityException; {:try_start_4 .. :try_end_4} :catch_a
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_9

    .line 1520
    if-eqz v1, :cond_3

    .line 1521
    :try_start_5
    invoke-virtual {v1}, Ljava/net/ServerSocket;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_1

    :cond_3
    move v1, v6

    .line 1528
    :cond_4
    :goto_3
    if-eqz v1, :cond_9

    .line 1529
    iput-boolean v6, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDisplayWaitingDialog:Z

    .line 1530
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->afterOnCreate()V

    .line 1536
    :goto_4
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDebuggerSettings:Lcom/adobe/air/DebuggerSettings;

    sget-object v2, Lcom/adobe/air/AndroidActivityWrapper$DebugMode;->ListenMode:Lcom/adobe/air/AndroidActivityWrapper$DebugMode;

    if-ne v0, v2, :cond_a

    move v0, v6

    :goto_5
    invoke-virtual {v1, v0}, Lcom/adobe/air/DebuggerSettings;->setListen(Z)V

    .line 1537
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDebuggerSettings:Lcom/adobe/air/DebuggerSettings;

    iget v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->debuggerPort:I

    invoke-virtual {v0, v1}, Lcom/adobe/air/DebuggerSettings;->setDebugerPort(I)V

    goto :goto_1

    .line 1522
    :catch_1
    move-exception v1

    move v1, v6

    .line 1526
    goto :goto_3

    .line 1504
    :catch_2
    move-exception v1

    move-object v1, v7

    .line 1520
    :goto_6
    if-eqz v1, :cond_5

    .line 1521
    :try_start_6
    invoke-virtual {v1}, Ljava/net/ServerSocket;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    :cond_5
    move v1, v5

    .line 1525
    goto :goto_3

    .line 1522
    :catch_3
    move-exception v1

    move v1, v5

    .line 1526
    goto :goto_3

    .line 1507
    :catch_4
    move-exception v1

    move-object v1, v7

    .line 1520
    :goto_7
    if-eqz v1, :cond_6

    .line 1521
    :try_start_7
    invoke-virtual {v1}, Ljava/net/ServerSocket;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_5

    :cond_6
    move v1, v5

    .line 1525
    goto :goto_3

    .line 1522
    :catch_5
    move-exception v1

    move v1, v5

    .line 1526
    goto :goto_3

    .line 1510
    :catch_6
    move-exception v1

    move-object v2, v7

    .line 1511
    :goto_8
    :try_start_8
    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    const-string v3, "android.os.NetworkOnMainThreadException"

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_2

    move-result v1

    if-eqz v1, :cond_7

    move v1, v6

    .line 1520
    :goto_9
    if-eqz v2, :cond_4

    .line 1521
    :try_start_9
    invoke-virtual {v2}, Ljava/net/ServerSocket;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_7

    goto :goto_3

    .line 1522
    :catch_7
    move-exception v2

    goto :goto_3

    :cond_7
    move v1, v5

    .line 1515
    goto :goto_9

    .line 1519
    :catchall_0
    move-exception v0

    move-object v1, v7

    .line 1520
    :goto_a
    if-eqz v1, :cond_8

    .line 1521
    :try_start_a
    invoke-virtual {v1}, Ljava/net/ServerSocket;->close()V
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_8

    .line 1525
    :cond_8
    :goto_b
    throw v0

    .line 1533
    :cond_9
    iget v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->debuggerPort:I

    invoke-direct {p0, v1}, Lcom/adobe/air/AndroidActivityWrapper;->showDialogUnableToListenOnPort(I)V

    goto :goto_4

    :cond_a
    move v0, v5

    .line 1536
    goto :goto_5

    .line 1541
    :pswitch_2
    invoke-static {v1}, Lcom/adobe/air/utils/Utils;->nativeConnectDebuggerSocket(Ljava/lang/String;)Z

    move-result v0

    .line 1544
    if-nez v0, :cond_b

    .line 1545
    invoke-direct {p0, v1}, Lcom/adobe/air/AndroidActivityWrapper;->showDialogforIpAddress(Ljava/lang/String;)V

    goto/16 :goto_1

    .line 1548
    :cond_b
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDebuggerSettings:Lcom/adobe/air/DebuggerSettings;

    invoke-virtual {v0, v1}, Lcom/adobe/air/DebuggerSettings;->setHost(Ljava/lang/String;)V

    .line 1549
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->afterOnCreate()V

    goto/16 :goto_1

    .line 1555
    :pswitch_3
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->afterOnCreate()V

    goto/16 :goto_1

    .line 1522
    :catch_8
    move-exception v1

    goto :goto_b

    .line 1519
    :catchall_1
    move-exception v0

    goto :goto_a

    :catchall_2
    move-exception v0

    move-object v1, v2

    goto :goto_a

    .line 1510
    :catch_9
    move-exception v2

    move-object v8, v2

    move-object v2, v1

    move-object v1, v8

    goto :goto_8

    .line 1507
    :catch_a
    move-exception v2

    goto :goto_7

    .line 1504
    :catch_b
    move-exception v2

    goto :goto_6

    .line 1460
    :catch_c
    move-exception v0

    goto/16 :goto_0

    :cond_c
    move-object v0, v1

    move-object v1, v7

    goto/16 :goto_2

    .line 1489
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_0
    .end packed-switch
.end method

.method private closeDialogWaitingForConnection()V
    .locals 4

    .prologue
    .line 1575
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 1578
    :try_start_0
    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    .line 1579
    const-string v2, "android.intent.action.MAIN"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 1580
    const-string v2, "RemoteDebuggerListenerDialogClose"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 1581
    const-string v2, "debuggerPort"

    iget v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->debuggerPort:I

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 1582
    invoke-virtual {v0, v1}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1588
    :goto_0
    return-void

    .line 1584
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private initializeAndroidAppVars(Landroid/content/pm/ApplicationInfo;)V
    .locals 1
    .parameter

    .prologue
    .line 636
    iget-object v0, p1, Landroid/content/pm/ApplicationInfo;->packageName:Ljava/lang/String;

    .line 637
    invoke-static {v0}, Lcom/adobe/air/ApplicationFileManager;->setAndroidPackageName(Ljava/lang/String;)V

    .line 640
    iget-object v0, p1, Landroid/content/pm/ApplicationInfo;->sourceDir:Ljava/lang/String;

    invoke-static {v0}, Lcom/adobe/air/ApplicationFileManager;->setAndroidAPKPath(Ljava/lang/String;)V

    .line 643
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    invoke-virtual {v0}, Landroid/app/Application;->getCacheDir()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    .line 644
    invoke-static {v0}, Lcom/adobe/air/ApplicationFileManager;->processAndroidDataPath(Ljava/lang/String;)V

    .line 645
    return-void
.end method

.method public static isGingerbread()Z
    .locals 2

    .prologue
    .line 182
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 183
    const/16 v1, 0x9

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isHoneycomb()Z
    .locals 2

    .prologue
    .line 188
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 189
    const/16 v1, 0xb

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isIceCreamSandwich()Z
    .locals 2

    .prologue
    .line 194
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 195
    const/16 v1, 0xe

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public static isJellybean()Z
    .locals 2

    .prologue
    .line 200
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 201
    const/16 v1, 0x10

    if-lt v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private native nativeActivateEvent()V
.end method

.method private native nativeDeactivateEvent()V
.end method

.method private native nativeLowMemoryEvent()V
.end method

.method private native nativeOnFocusListener(Z)V
.end method

.method private native nativeSendInvokeEventWithData(Ljava/lang/String;Ljava/lang/String;I)V
.end method

.method private native nativeSetVisible(Z)V
.end method

.method private parseArgs(Landroid/app/Activity;[Ljava/lang/String;)V
    .locals 12
    .parameter
    .parameter

    .prologue
    const/4 v8, 0x6

    const-string v6, "false"

    const-string v7, ""

    .line 649
    const-string v0, ""

    .line 650
    const-string v0, ""

    .line 651
    const-string v0, ""

    .line 652
    const-string v0, "false"

    .line 653
    const-string v0, "false"

    .line 654
    const-string v0, "false"

    .line 655
    const-string v0, ""

    .line 658
    const/4 v0, 0x0

    :try_start_0
    aget-object v0, p2, v0
    :try_end_0
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_0 .. :try_end_0} :catch_0

    .line 659
    const/4 v1, 0x1

    :try_start_1
    aget-object v1, p2, v1
    :try_end_1
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_1 .. :try_end_1} :catch_1

    .line 660
    const/4 v2, 0x2

    :try_start_2
    aget-object v2, p2, v2
    :try_end_2
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_2 .. :try_end_2} :catch_2

    .line 661
    const/4 v3, 0x3

    :try_start_3
    aget-object v3, p2, v3
    :try_end_3
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_3 .. :try_end_3} :catch_3

    .line 662
    const/4 v4, 0x4

    :try_start_4
    aget-object v4, p2, v4
    :try_end_4
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_4 .. :try_end_4} :catch_4

    .line 664
    :try_start_5
    array-length v5, p2

    if-lt v5, v8, :cond_1

    .line 665
    const/4 v5, 0x5

    aget-object v5, p2, v5
    :try_end_5
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_5 .. :try_end_5} :catch_5

    .line 666
    const/4 v6, 0x6

    :try_start_6
    aget-object v6, p2, v6
    :try_end_6
    .catch Ljava/lang/ArrayIndexOutOfBoundsException; {:try_start_6 .. :try_end_6} :catch_6

    move-object v9, v6

    move-object v6, v5

    move-object v5, v9

    :goto_0
    move-object v9, v5

    move-object v5, v1

    move-object v1, v6

    move-object v6, v0

    move-object v0, v9

    move-object v10, v2

    move-object v2, v4

    move-object v4, v10

    .line 680
    :goto_1
    iput-object v4, p0, Lcom/adobe/air/AndroidActivityWrapper;->mExtraArgs:Ljava/lang/String;

    .line 681
    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v3

    iput-boolean v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    .line 682
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v2

    iput-boolean v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsDebuggerMode:Z

    .line 683
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v1

    sput-boolean v1, Lcom/adobe/air/AndroidActivityWrapper;->sIsSwfPreviewMode:Z

    .line 684
    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sGamePreviewHost:Ljava/lang/String;

    .line 685
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 688
    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->initializeAndroidAppVars(Landroid/content/pm/ApplicationInfo;)V

    .line 690
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    if-eqz v0, :cond_0

    .line 691
    iput-object v6, p0, Lcom/adobe/air/AndroidActivityWrapper;->mXmlPath:Ljava/lang/String;

    .line 692
    iput-object v5, p0, Lcom/adobe/air/AndroidActivityWrapper;->mRootDir:Ljava/lang/String;

    .line 698
    :goto_2
    return-void

    .line 668
    :catch_0
    move-exception v0

    move-object v0, v6

    move-object v1, v6

    move-object v2, v6

    move-object v3, v7

    move-object v4, v7

    move-object v5, v7

    :goto_3
    move-object v6, v5

    move-object v5, v4

    move-object v4, v3

    move-object v3, v2

    move-object v2, v1

    move-object v1, v0

    move-object v0, v7

    goto :goto_1

    .line 695
    :cond_0
    invoke-static {}, Lcom/adobe/air/ApplicationFileManager;->getAppXMLRoot()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mXmlPath:Ljava/lang/String;

    .line 696
    invoke-static {}, Lcom/adobe/air/ApplicationFileManager;->getAppRoot()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mRootDir:Ljava/lang/String;

    goto :goto_2

    .line 668
    :catch_1
    move-exception v1

    move-object v1, v6

    move-object v2, v6

    move-object v3, v7

    move-object v4, v7

    move-object v5, v0

    move-object v0, v6

    goto :goto_3

    :catch_2
    move-exception v2

    move-object v2, v6

    move-object v3, v7

    move-object v4, v1

    move-object v5, v0

    move-object v0, v6

    move-object v1, v6

    goto :goto_3

    :catch_3
    move-exception v3

    move-object v3, v2

    move-object v4, v1

    move-object v5, v0

    move-object v0, v6

    move-object v1, v6

    move-object v2, v6

    goto :goto_3

    :catch_4
    move-exception v4

    move-object v4, v1

    move-object v5, v0

    move-object v0, v6

    move-object v1, v6

    move-object v9, v3

    move-object v3, v2

    move-object v2, v9

    goto :goto_3

    :catch_5
    move-exception v5

    move-object v5, v0

    move-object v0, v6

    move-object v9, v3

    move-object v3, v2

    move-object v2, v9

    move-object v10, v1

    move-object v1, v4

    move-object v4, v10

    goto :goto_3

    :catch_6
    move-exception v6

    move-object v9, v5

    move-object v5, v0

    move-object v0, v9

    move-object v10, v3

    move-object v3, v2

    move-object v2, v10

    move-object v11, v1

    move-object v1, v4

    move-object v4, v11

    goto :goto_3

    :cond_1
    move-object v5, v7

    goto/16 :goto_0
.end method

.method private planeRemovedSuccessfully(Landroid/view/SurfaceView;)Z
    .locals 3
    .parameter

    .prologue
    const/4 v2, 0x1

    .line 379
    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    invoke-interface {v0}, Landroid/view/SurfaceHolder;->getSurface()Landroid/view/Surface;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Surface;->isValid()Z

    move-result v0

    if-nez v0, :cond_0

    move v0, v2

    .line 391
    :goto_0
    return v0

    .line 382
    :cond_0
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    const-string v1, "LT18i"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    const-string v1, "LT15i"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    const-string v1, "Arc"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->isIceCreamSandwich()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    invoke-virtual {v0, p1}, Landroid/widget/FrameLayout;->indexOfChild(Landroid/view/View;)I

    move-result v0

    if-gez v0, :cond_2

    move v0, v2

    .line 388
    goto :goto_0

    .line 391
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private setFullScreenFromMetaData()V
    .locals 3

    .prologue
    .line 1855
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getComponentName()Landroid/content/ComponentName;

    move-result-object v1

    const/16 v2, 0x80

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;

    move-result-object v0

    .line 1856
    iget-object v0, v0, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    .line 1859
    if-nez v0, :cond_1

    .line 1873
    :cond_0
    :goto_0
    return-void

    .line 1862
    :cond_1
    const-string v1, "fullScreen"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Boolean;

    .line 1864
    if-eqz v0, :cond_0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 1866
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->setFullScreen()V
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1869
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private setMainView(Landroid/view/View;)V
    .locals 1
    .parameter

    .prologue
    .line 1012
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sApplicationLaunched:Z

    if-eqz v0, :cond_0

    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sEntryPoint:Lcom/adobe/air/Entrypoints;

    if-nez v0, :cond_1

    .line 1026
    :cond_0
    :goto_0
    return-void

    .line 1015
    :cond_1
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->isResumed()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 1019
    :try_start_0
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sEntryPoint:Lcom/adobe/air/Entrypoints;

    invoke-virtual {v0, p1}, Lcom/adobe/air/Entrypoints;->setMainView(Landroid/view/View;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1021
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private showDialogUnableToListenOnPort(I)V
    .locals 2
    .parameter

    .prologue
    .line 1425
    new-instance v0, Lcom/adobe/air/ListenErrorDialog;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-direct {v0, v1, p1}, Lcom/adobe/air/ListenErrorDialog;-><init>(Landroid/app/Activity;I)V

    .line 1426
    invoke-virtual {v0}, Lcom/adobe/air/ListenErrorDialog;->createAndShowDialog()V

    .line 1427
    return-void
.end method

.method private showDialogWaitingForConnection(I)V
    .locals 3
    .parameter

    .prologue
    .line 1593
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getApplicationContext()Landroid/content/Context;

    .line 1594
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sHasCaptiveRuntime:Z

    if-eqz v0, :cond_0

    .line 1597
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/adobe/air/AndroidActivityWrapper$1;

    invoke-direct {v1, p0, p1}, Lcom/adobe/air/AndroidActivityWrapper$1;-><init>(Lcom/adobe/air/AndroidActivityWrapper;I)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 1623
    :goto_0
    return-void

    .line 1612
    :cond_0
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;

    const-class v2, Lcom/adobe/air/RemoteDebuggerListenerDialog;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 1613
    const-string v1, "android.intent.action.MAIN"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 1614
    const-string v1, "RemoteDebuggerListenerDialog"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 1615
    const-string v1, "debuggerPort"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 1616
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 1618
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method private showDialogforIpAddress(Ljava/lang/String;)V
    .locals 2
    .parameter

    .prologue
    .line 1568
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getApplicationContext()Landroid/content/Context;

    .line 1569
    new-instance v0, Lcom/adobe/air/RemoteDebuggerDialog;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/adobe/air/RemoteDebuggerDialog;-><init>(Landroid/app/Activity;)V

    .line 1570
    invoke-virtual {v0, p1}, Lcom/adobe/air/RemoteDebuggerDialog;->createAndShowDialog(Ljava/lang/String;)V

    .line 1571
    return-void
.end method


# virtual methods
.method public BroadcastIntent(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3
    .parameter
    .parameter

    .prologue
    .line 1367
    :try_start_0
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getDefaultContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    invoke-static {p2, v1}, Landroid/content/Intent;->parseUri(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getDefaultIntentFlags()I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Landroid/content/ActivityNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1377
    :goto_0
    return-void

    .line 1373
    :catch_0
    move-exception v0

    goto :goto_0

    .line 1369
    :catch_1
    move-exception v0

    goto :goto_0
.end method

.method public GetAppCacheDirectory()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1887
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    invoke-virtual {v0}, Landroid/app/Application;->getCacheDir()Ljava/io/File;

    move-result-object v0

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public GetAppDataDirectory()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1892
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    invoke-virtual {v0}, Landroid/app/Application;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->dataDir:Ljava/lang/String;

    return-object v0
.end method

.method public GetDebuggerSettings()Lcom/adobe/air/DebuggerSettings;
    .locals 1

    .prologue
    .line 2104
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDebuggerSettings:Lcom/adobe/air/DebuggerSettings;

    return-object v0
.end method

.method public GetLibCorePath()Ljava/lang/String;
    .locals 1

    .prologue
    .line 1400
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mLibCorePath:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 1401
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    invoke-static {v0}, Lcom/adobe/air/utils/Utils;->GetLibCorePath(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mLibCorePath:Ljava/lang/String;

    .line 1403
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mLibCorePath:Ljava/lang/String;

    return-object v0
.end method

.method public GetRuntimeDataDirectory()Ljava/lang/String;
    .locals 2

    .prologue
    .line 1897
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    iget-object v1, v1, Landroid/content/pm/ApplicationInfo;->dataDir:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public LaunchMarketPlaceForAIR(Ljava/lang/String;)V
    .locals 2
    .parameter

    .prologue
    .line 1383
    .line 1384
    if-nez p1, :cond_0

    .line 1385
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "market://details?id="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lcom/adobe/air/utils/Utils;->getRuntimePackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1389
    :goto_0
    :try_start_0
    const-string v1, "android.intent.action.VIEW"

    invoke-virtual {p0, v1, v0}, Lcom/adobe/air/AndroidActivityWrapper;->BroadcastIntent(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 1396
    :goto_1
    return-void

    .line 1392
    :catch_0
    move-exception v0

    goto :goto_1

    :cond_0
    move-object v0, p1

    goto :goto_0
.end method

.method public SendIntentToRuntime(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .parameter
    .parameter
    .parameter
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 564
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 565
    invoke-virtual {v0, p2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 566
    invoke-virtual {v0, p3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 567
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 573
    :goto_0
    return-void

    .line 569
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public SendIntentToRuntime(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .parameter
    .parameter
    .parameter
    .parameter
    .parameter
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class",
            "<*>;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .prologue
    .line 579
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;

    invoke-direct {v0, v1, p1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 580
    invoke-virtual {v0, p2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 581
    invoke-virtual {v0, p3}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 582
    invoke-virtual {v0, p4, p5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 583
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v1, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 589
    :goto_0
    return-void

    .line 585
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public SendInvokeEvent()V
    .locals 3

    .prologue
    .line 1159
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    .line 1163
    invoke-virtual {v0}, Landroid/content/Intent;->getDataString()Ljava/lang/String;

    move-result-object v1

    .line 1164
    const/4 v2, 0x0

    .line 1169
    if-eqz v1, :cond_0

    .line 1171
    const/4 v2, 0x1

    .line 1175
    :cond_0
    invoke-virtual {v0}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v1, v0, v2}, Lcom/adobe/air/AndroidActivityWrapper;->nativeSendInvokeEventWithData(Ljava/lang/String;Ljava/lang/String;I)V

    .line 1176
    return-void
.end method

.method public ShowImmediateUpdateDialog()V
    .locals 8

    .prologue
    const-class v1, Lcom/adobe/air/AIRUpdateDialog;

    const-string v2, "android.intent.action.MAIN"

    const-string v4, "airDownloadURL"

    const-string v3, "AIRUpdateDialog"

    .line 608
    const/4 v5, 0x0

    .line 612
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    iget-object v6, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v6}, Landroid/app/Activity;->getComponentName()Landroid/content/ComponentName;

    move-result-object v6

    const/16 v7, 0x80

    invoke-virtual {v0, v6, v7}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;

    move-result-object v0

    .line 613
    iget-object v0, v0, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    .line 616
    if-eqz v0, :cond_1

    .line 618
    const-string v6, "airDownloadURL"

    invoke-virtual {v0, v6}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    move-object v5, v0

    .line 627
    :goto_1
    if-eqz v5, :cond_0

    .line 628
    const-class v0, Lcom/adobe/air/AIRUpdateDialog;

    const-string v0, "android.intent.action.MAIN"

    const-string v0, "AIRUpdateDialog"

    const-string v0, "airDownloadURL"

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/AndroidActivityWrapper;->SendIntentToRuntime(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 631
    :goto_2
    return-void

    .line 630
    :cond_0
    const-class v0, Lcom/adobe/air/AIRUpdateDialog;

    const-string v0, "android.intent.action.MAIN"

    const-string v0, "AIRUpdateDialog"

    invoke-virtual {p0, v1, v2, v3}, Lcom/adobe/air/AndroidActivityWrapper;->SendIntentToRuntime(Ljava/lang/Class;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 622
    :catch_0
    move-exception v0

    goto :goto_1

    :cond_1
    move-object v0, v5

    goto :goto_0
.end method

.method public StartDownloadConfigService()V
    .locals 2

    .prologue
    .line 593
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 594
    invoke-static {}, Lcom/adobe/air/utils/Utils;->getRuntimePackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 595
    const-string v1, "com.adobe.air.DownloadConfig"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 598
    :try_start_0
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 603
    :goto_0
    return-void

    .line 599
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public WaitForNewActivity()Landroid/app/Activity;
    .locals 2

    .prologue
    .line 1837
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 1840
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    if-nez v0, :cond_0

    .line 1841
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityCondition:Ljava/util/concurrent/locks/Condition;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Condition;->await()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 1846
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 1848
    :goto_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    return-object v0

    .line 1843
    :catch_0
    move-exception v0

    .line 1846
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    goto :goto_0

    :catchall_0
    move-exception v0

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_newActivityLock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v1}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v0
.end method

.method public addActivityResultListener(Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;)V
    .locals 1
    .parameter

    .prologue
    .line 1784
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    if-nez v0, :cond_0

    .line 1786
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    .line 1789
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1791
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1793
    :cond_1
    return-void
.end method

.method public addActivityStateChangeListner(Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;)V
    .locals 1
    .parameter

    .prologue
    .line 1722
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    if-nez v0, :cond_0

    .line 1723
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    .line 1725
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1726
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1727
    :cond_1
    return-void
.end method

.method public addInputEventListner(Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;)V
    .locals 1
    .parameter

    .prologue
    .line 1655
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    if-nez v0, :cond_0

    .line 1656
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    .line 1658
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 1659
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 1660
    :cond_1
    return-void
.end method

.method public applyDownloadedConfig()V
    .locals 1

    .prologue
    .line 2110
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sEntryPoint:Lcom/adobe/air/Entrypoints;

    if-eqz v0, :cond_0

    .line 2112
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sEntryPoint:Lcom/adobe/air/Entrypoints;

    invoke-virtual {v0}, Lcom/adobe/air/Entrypoints;->EntryApplyDownloadedConfig()V

    .line 2114
    :cond_0
    return-void
.end method

.method public didRemoveOverlay()V
    .locals 2

    .prologue
    .line 524
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {v0}, Landroid/widget/RelativeLayout;->getChildCount()I

    move-result v0

    if-nez v0, :cond_0

    .line 526
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->removeView(Landroid/view/View;)V

    .line 527
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    .line 529
    :cond_0
    return-void
.end method

.method public dispatchGenericMotionEvent(Landroid/view/MotionEvent;Z)Z
    .locals 1
    .parameter
    .parameter

    .prologue
    .line 1275
    invoke-direct {p0, p1}, Lcom/adobe/air/AndroidActivityWrapper;->callInputEventListeners(Landroid/view/MotionEvent;)Z

    move-result v0

    .line 1276
    return v0
.end method

.method public dispatchKeyEvent(Landroid/view/KeyEvent;Z)Z
    .locals 1
    .parameter
    .parameter

    .prologue
    .line 1269
    invoke-direct {p0, p1}, Lcom/adobe/air/AndroidActivityWrapper;->callInputEventListeners(Landroid/view/KeyEvent;)Z

    move-result v0

    .line 1270
    return v0
.end method

.method public ensureZOrder()V
    .locals 3

    .prologue
    .line 467
    const/4 v0, 0x7

    move v1, v0

    :goto_0
    if-ltz v1, :cond_1

    .line 468
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 469
    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/widget/FrameLayout;->indexOfChild(Landroid/view/View;)I

    move-result v0

    if-ltz v0, :cond_0

    .line 470
    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/widget/FrameLayout;->bringChildToFront(Landroid/view/View;)V

    .line 467
    :cond_0
    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0

    .line 474
    :cond_1
    return-void
.end method

.method public finish()V
    .locals 1

    .prologue
    .line 1222
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 1223
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->finish()V

    .line 1224
    :cond_0
    return-void
.end method

.method public finishActivityFromChild(Landroid/app/Activity;I)V
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 1902
    return-void
.end method

.method public finishFromChild(Landroid/app/Activity;)V
    .locals 0
    .parameter

    .prologue
    .line 1906
    return-void
.end method

.method public getActivity()Landroid/app/Activity;
    .locals 1

    .prologue
    .line 284
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    return-object v0
.end method

.method public getApplication()Landroid/app/Application;
    .locals 1

    .prologue
    .line 485
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    return-object v0
.end method

.method public getApplicationContext()Landroid/content/Context;
    .locals 1

    .prologue
    .line 490
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    return-object v0
.end method

.method public getAutoOrients()Z
    .locals 1

    .prologue
    .line 1314
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager;->getAutoOrients()Z

    move-result v0

    return v0
.end method

.method public getCameraView()Lcom/adobe/air/AndroidCameraView;
    .locals 1

    .prologue
    .line 538
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_cameraView:Lcom/adobe/air/AndroidCameraView;

    return-object v0
.end method

.method public getDefaultContext()Landroid/content/Context;
    .locals 1

    .prologue
    .line 497
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 498
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    .line 500
    :goto_0
    return-object v0

    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_application:Landroid/app/Application;

    goto :goto_0
.end method

.method public getDefaultIntentFlags()I
    .locals 1

    .prologue
    .line 505
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 506
    const/4 v0, 0x0

    .line 508
    :goto_0
    return v0

    :cond_0
    const/high16 v0, 0x1000

    goto :goto_0
.end method

.method public getDeviceOrientation()I
    .locals 1

    .prologue
    .line 1291
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager;->getDeviceOrientation()I

    move-result v0

    return v0
.end method

.method public getEgl()Lcom/adobe/air/FlashEGL;
    .locals 1

    .prologue
    .line 548
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_flashEGL:Lcom/adobe/air/FlashEGL;

    if-nez v0, :cond_0

    .line 550
    invoke-static {}, Lcom/adobe/air/FlashEGLFactory;->CreateFlashEGL()Lcom/adobe/air/FlashEGL;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_flashEGL:Lcom/adobe/air/FlashEGL;

    .line 552
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_flashEGL:Lcom/adobe/air/FlashEGL;

    return-object v0
.end method

.method public getHardKeyboardType()I
    .locals 1

    .prologue
    .line 1335
    iget v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mHardKeyboardType:I

    return v0
.end method

.method protected getIsFullScreen()Z
    .locals 1

    .prologue
    .line 1882
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsFullScreen:Z

    return v0
.end method

.method public getOrientation()I
    .locals 1

    .prologue
    .line 1286
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager;->getOrientation()I

    move-result v0

    return v0
.end method

.method public getOverlaysLayout(Z)Landroid/widget/RelativeLayout;
    .locals 2
    .parameter

    .prologue
    .line 513
    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    if-nez v0, :cond_0

    .line 515
    new-instance v0, Landroid/widget/RelativeLayout;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    .line 516
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 519
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    return-object v0
.end method

.method public getRuntimeContext()Landroid/content/Context;
    .locals 1

    .prologue
    .line 480
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;

    return-object v0
.end method

.method public getSpeakerphoneOn()Z
    .locals 2

    .prologue
    .line 294
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v0

    const-string v1, "audio"

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/media/AudioManager;

    invoke-virtual {p0}, Landroid/media/AudioManager;->isSpeakerphoneOn()Z

    move-result v0

    return v0
.end method

.method public getSupportedOrientations()[I
    .locals 1

    .prologue
    .line 1320
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager;->getSupportedOrientations()[I

    move-result-object v0

    return-object v0
.end method

.method public getView()Landroid/view/View;
    .locals 1

    .prologue
    .line 533
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    return-object v0
.end method

.method public gotResultFromDialog(ZLjava/lang/String;)V
    .locals 3
    .parameter
    .parameter

    .prologue
    const/4 v2, 0x0

    .line 1627
    .line 1628
    if-eqz p1, :cond_4

    .line 1630
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_3

    .line 1631
    invoke-static {p2}, Lcom/adobe/air/utils/Utils;->nativeConnectDebuggerSocket(Ljava/lang/String;)Z

    move-result v0

    .line 1633
    :goto_0
    if-nez v0, :cond_2

    .line 1634
    invoke-direct {p0, p2}, Lcom/adobe/air/AndroidActivityWrapper;->showDialogforIpAddress(Ljava/lang/String;)V

    .line 1643
    :goto_1
    if-nez v0, :cond_0

    if-nez p1, :cond_1

    .line 1644
    :cond_0
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->afterOnCreate()V

    .line 1645
    :cond_1
    return-void

    .line 1637
    :cond_2
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDebuggerSettings:Lcom/adobe/air/DebuggerSettings;

    invoke-virtual {v1, p2}, Lcom/adobe/air/DebuggerSettings;->setHost(Ljava/lang/String;)V

    .line 1638
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDebuggerSettings:Lcom/adobe/air/DebuggerSettings;

    invoke-virtual {v1, v2}, Lcom/adobe/air/DebuggerSettings;->setListen(Z)V

    .line 1639
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mShowDebuggerDialog:Z

    goto :goto_1

    :cond_3
    move v0, v2

    goto :goto_0

    :cond_4
    move v0, v2

    goto :goto_1
.end method

.method public initCallStateListener()V
    .locals 2

    .prologue
    .line 1030
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    if-nez v0, :cond_0

    .line 1032
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/adobe/air/telephony/AndroidTelephonyManager;->CreateAndroidTelephonyManager(Landroid/content/Context;)Lcom/adobe/air/telephony/AndroidTelephonyManager;

    move-result-object v0

    sput-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    .line 1033
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/adobe/air/telephony/AndroidTelephonyManager;->listen(Z)V

    .line 1035
    :cond_0
    return-void
.end method

.method public isApplicationLaunched()Z
    .locals 1

    .prologue
    .line 543
    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sApplicationLaunched:Z

    return v0
.end method

.method public isHardKeyboardHidden()Z
    .locals 2

    .prologue
    .line 1330
    iget v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mHardKeyboardHidden:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isResumed()Z
    .locals 2

    .prologue
    .line 172
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->RESUMED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isScreenLocked()Z
    .locals 1

    .prologue
    .line 168
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->keyGuardManager:Landroid/app/KeyguardManager;

    invoke-virtual {v0}, Landroid/app/KeyguardManager;->inKeyguardRestrictedInputMode()Z

    move-result v0

    return v0
.end method

.method public isScreenOn()Z
    .locals 1

    .prologue
    .line 166
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mScreenOn:Z

    return v0
.end method

.method public isStarted()Z
    .locals 2

    .prologue
    .line 177
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->STARTED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->RESTARTED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-ne v0, v1, :cond_1

    :cond_0
    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public isSurfaceValid()Z
    .locals 1

    .prologue
    .line 557
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->isSurfaceValid()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public needsCompositingSurface()Z
    .locals 2

    .prologue
    .line 1341
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;

    const-string v1, "android.permission.CAMERA"

    invoke-virtual {v0, v1}, Landroid/content/Context;->checkCallingOrSelfPermission(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_0

    .line 1342
    const/4 v0, 0x1

    .line 1344
    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1325
    invoke-direct {p0, p1, p2, p3}, Lcom/adobe/air/AndroidActivityWrapper;->callActivityResultListeners(IILandroid/content/Intent;)V

    .line 1326
    return-void
.end method

.method public onApplyThemeResource(Landroid/content/res/Resources$Theme;IZ)V
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 2054
    return-void
.end method

.method public onAttachedToWindow()V
    .locals 0

    .prologue
    .line 1910
    return-void
.end method

.method public onBackPressed()V
    .locals 0

    .prologue
    .line 1914
    return-void
.end method

.method public onChildTitleChanged(Landroid/app/Activity;Ljava/lang/CharSequence;)V
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 2058
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 1
    .parameter

    .prologue
    .line 1258
    iget v0, p1, Landroid/content/res/Configuration;->hardKeyboardHidden:I

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mHardKeyboardHidden:I

    .line 1259
    iget v0, p1, Landroid/content/res/Configuration;->keyboard:I

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mHardKeyboardType:I

    .line 1261
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0, p1}, Lcom/adobe/air/OrientationManager;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 1263
    invoke-direct {p0, p1}, Lcom/adobe/air/AndroidActivityWrapper;->callActivityStateListeners(Landroid/content/res/Configuration;)V

    .line 1264
    return-void
.end method

.method public onContentChanged()V
    .locals 0

    .prologue
    .line 1918
    return-void
.end method

.method public onContextItemSelected(Landroid/view/MenuItem;Z)Z
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 1922
    return p2
.end method

.method public onContextMenuClosed(Landroid/view/Menu;)V
    .locals 0
    .parameter

    .prologue
    .line 1927
    return-void
.end method

.method public onCreate(Landroid/app/Activity;[Ljava/lang/String;)V
    .locals 3
    .parameter
    .parameter

    .prologue
    .line 703
    iput-object p1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    .line 704
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->STARTED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .line 706
    invoke-direct {p0, p1, p2}, Lcom/adobe/air/AndroidActivityWrapper;->parseArgs(Landroid/app/Activity;[Ljava/lang/String;)V

    .line 708
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->SignalNewActivityCreated()V

    .line 712
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-static {}, Lcom/adobe/air/utils/Utils;->getRuntimePackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x4

    invoke-virtual {v0, v1, v2}, Landroid/app/Activity;->createPackageContext(Ljava/lang/String;I)Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_runtimeContext:Landroid/content/Context;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 730
    :goto_0
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsDebuggerMode:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    if-nez v0, :cond_0

    sget-boolean v0, Lcom/adobe/air/AndroidActivityWrapper;->sApplicationLaunched:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-static {v0}, Lcom/adobe/air/DeviceProfiling;->checkAndInitiateProfiler(Landroid/app/Activity;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 732
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->checkForDebuggerAndLaunchDialog()V

    .line 740
    :goto_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInvokeEventPendingFromOnCreate:Z

    .line 742
    invoke-static {}, Lcom/adobe/air/ConfigDownloadListener;->GetConfigDownloadListener()Lcom/adobe/air/ConfigDownloadListener;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mConfigDownloadListener:Lcom/adobe/air/ConfigDownloadListener;

    .line 743
    return-void

    .line 736
    :cond_0
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->afterOnCreate()V

    goto :goto_1

    .line 714
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onCreateContextMenu(Landroid/view/ContextMenu;Landroid/view/View;Landroid/view/ContextMenu$ContextMenuInfo;)V
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1931
    return-void
.end method

.method public onCreateDescription(Ljava/lang/CharSequence;)Ljava/lang/CharSequence;
    .locals 0
    .parameter

    .prologue
    .line 1935
    return-object p1
.end method

.method public onCreateDialog(ILandroid/app/Dialog;)Landroid/app/Dialog;
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 2067
    return-object p2
.end method

.method public onCreateDialog(ILandroid/os/Bundle;Landroid/app/Dialog;)Landroid/app/Dialog;
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 2062
    return-object p3
.end method

.method public onCreateOptionsMenu(Landroid/view/Menu;Z)Z
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 1940
    return p2
.end method

.method public onCreatePanelMenu(ILandroid/view/Menu;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1945
    return p3
.end method

.method public onCreatePanelView(ILandroid/view/View;)Landroid/view/View;
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 1950
    return-object p2
.end method

.method public onCreateThumbnail(Landroid/graphics/Bitmap;Landroid/graphics/Canvas;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1955
    return p3
.end method

.method public onCreateView(Ljava/lang/String;Landroid/content/Context;Landroid/util/AttributeSet;Landroid/view/View;)Landroid/view/View;
    .locals 0
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1960
    return-object p4
.end method

.method public onDestroy()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 1127
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->DESTROYED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .line 1129
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->callActivityStateListeners()V

    .line 1131
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    if-eqz v0, :cond_0

    .line 1132
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager;->onActivityDestroyed()V

    .line 1134
    :cond_0
    const/4 v0, 0x0

    move v1, v0

    :goto_0
    const/16 v0, 0x8

    if-ge v1, v0, :cond_2

    .line 1135
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 1136
    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/widget/FrameLayout;->removeView(Landroid/view/View;)V

    .line 1134
    :cond_1
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_0

    .line 1140
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    if-eqz v0, :cond_3

    .line 1141
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_overlaysLayout:Landroid/widget/RelativeLayout;

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->removeView(Landroid/view/View;)V

    .line 1144
    :cond_3
    iput-object v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    .line 1145
    iput-object v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_cameraView:Lcom/adobe/air/AndroidCameraView;

    .line 1146
    iput-object v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 1147
    iput-object v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    .line 1148
    invoke-direct {p0, v3}, Lcom/adobe/air/AndroidActivityWrapper;->setMainView(Landroid/view/View;)V

    .line 1150
    invoke-static {}, Lcom/adobe/flashplayer/HDMIUtils;->closeHelper()V

    .line 1153
    return-void
.end method

.method public onDetachedFromWindow()V
    .locals 0

    .prologue
    .line 1965
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1969
    return p3
.end method

.method public onKeyLongPress(ILandroid/view/KeyEvent;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1974
    return p3
.end method

.method public onKeyMultiple(IILandroid/view/KeyEvent;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1979
    return p4
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1984
    return p3
.end method

.method public onLowMemory()V
    .locals 0

    .prologue
    .line 1281
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->nativeLowMemoryEvent()V

    .line 1282
    return-void
.end method

.method public onMenuItemSelected(ILandroid/view/MenuItem;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1989
    return p3
.end method

.method public onMenuOpened(ILandroid/view/Menu;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 1994
    return p3
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 1
    .parameter

    .prologue
    .line 1182
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0, p1}, Landroid/app/Activity;->setIntent(Landroid/content/Intent;)V

    .line 1183
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->SendInvokeEvent()V

    .line 1184
    return-void
.end method

.method public onOptionsItemSelected(Landroid/view/MenuItem;Z)Z
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 1999
    return p2
.end method

.method public onOptionsMenuClosed(Landroid/view/Menu;)V
    .locals 0
    .parameter

    .prologue
    .line 2004
    return-void
.end method

.method public onPanelClosed(ILandroid/view/Menu;)V
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 2008
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 1041
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->PAUSED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .line 1043
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->callActivityStateListeners()V

    .line 1047
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    if-eqz v0, :cond_0

    .line 1048
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->forceSoftKeyboardDown()V

    .line 1050
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    if-eqz v0, :cond_1

    .line 1051
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager;->onActivityPaused()V

    .line 1053
    :cond_1
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    if-eqz v0, :cond_2

    .line 1054
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidIdleState;->releaseLock()V

    .line 1057
    :cond_2
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->isApplicationLaunched()Z

    move-result v0

    if-eqz v0, :cond_3

    .line 1059
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->nativeOnFocusListener(Z)V

    .line 1060
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->nativeDeactivateEvent()V

    .line 1063
    :cond_3
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeBreakCascade()V

    .line 1064
    return-void
.end method

.method public onPostCreate(Landroid/os/Bundle;)V
    .locals 0
    .parameter

    .prologue
    .line 2072
    return-void
.end method

.method public onPostResume()V
    .locals 0

    .prologue
    .line 2076
    return-void
.end method

.method public onPrepareDialog(ILandroid/app/Dialog;)V
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 2084
    return-void
.end method

.method public onPrepareDialog(ILandroid/app/Dialog;Landroid/os/Bundle;)V
    .locals 0
    .parameter
    .parameter
    .parameter

    .prologue
    .line 2080
    return-void
.end method

.method public onPrepareOptionsMenu(Landroid/view/Menu;Z)Z
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 2012
    return p2
.end method

.method public onPreparePanel(ILandroid/view/View;Landroid/view/Menu;Z)Z
    .locals 0
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    .line 2017
    return p4
.end method

.method public onRestart()V
    .locals 1

    .prologue
    .line 1098
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->RESTARTED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .line 1100
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->callActivityStateListeners()V

    .line 1111
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    if-eqz v0, :cond_0

    .line 1112
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->HideSoftKeyboardOnWindowFocusChange()V

    .line 1114
    :cond_0
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->SetVisible(Z)V

    .line 1115
    return-void
.end method

.method public onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 0
    .parameter

    .prologue
    .line 2088
    return-void
.end method

.method public onResume()V
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 1070
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->RESUMED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .line 1072
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->callActivityStateListeners()V

    .line 1074
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    if-eqz v0, :cond_0

    .line 1075
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager;->onActivityResumed()V

    .line 1077
    :cond_0
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    if-eqz v0, :cond_1

    .line 1078
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper;->sIdleStateManager:Lcom/adobe/air/AndroidIdleState;

    invoke-virtual {v0}, Lcom/adobe/air/AndroidIdleState;->acquireLock()V

    .line 1080
    :cond_1
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->isApplicationLaunched()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 1082
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->nativeActivateEvent()V

    .line 1083
    invoke-direct {p0, v1}, Lcom/adobe/air/AndroidActivityWrapper;->nativeOnFocusListener(Z)V

    .line 1090
    :goto_0
    iput-boolean v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_skipKickCascade:Z

    .line 1091
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeBreakCascade()V

    .line 1092
    return-void

    .line 1087
    :cond_2
    iput-boolean v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivateEventPending:Z

    goto :goto_0
.end method

.method public onRetainNonConfigurationInstance(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0
    .parameter

    .prologue
    .line 2022
    return-object p1
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0
    .parameter

    .prologue
    .line 2092
    return-void
.end method

.method public onScreenStateChanged(Z)V
    .locals 1
    .parameter

    .prologue
    .line 1233
    iput-boolean p1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mScreenOn:Z

    .line 1234
    invoke-direct {p0, p1}, Lcom/adobe/air/AndroidActivityWrapper;->SetVisible(Z)V

    .line 1235
    if-eqz p1, :cond_0

    .line 1236
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_skipKickCascade:Z

    .line 1237
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeBreakCascade()V

    .line 1239
    :cond_0
    return-void
.end method

.method public onSearchRequested(Z)Z
    .locals 0
    .parameter

    .prologue
    .line 2027
    return p1
.end method

.method public onStop()V
    .locals 1

    .prologue
    .line 1120
    sget-object v0, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->STOPPED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    iput-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityState:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .line 1121
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->callActivityStateListeners()V

    .line 1122
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->SetVisible(Z)V

    .line 1123
    return-void
.end method

.method public onSurfaceDestroyed()V
    .locals 1

    .prologue
    .line 1228
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->SetVisible(Z)V

    .line 1229
    return-void
.end method

.method public onSurfaceInitialized()V
    .locals 9

    .prologue
    const/4 v8, 0x0

    .line 1188
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->setMainView(Landroid/view/View;)V

    .line 1189
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->SetVisible(Z)V

    .line 1191
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDisplayWaitingDialog:Z

    if-eqz v0, :cond_0

    .line 1193
    iget v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->debuggerPort:I

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->showDialogWaitingForConnection(I)V

    .line 1194
    iput-boolean v8, p0, Lcom/adobe/air/AndroidActivityWrapper;->mDisplayWaitingDialog:Z

    .line 1197
    :cond_0
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    iget-object v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->mXmlPath:Ljava/lang/String;

    iget-object v4, p0, Lcom/adobe/air/AndroidActivityWrapper;->mRootDir:Ljava/lang/String;

    iget-object v5, p0, Lcom/adobe/air/AndroidActivityWrapper;->mExtraArgs:Ljava/lang/String;

    iget-boolean v6, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    iget-boolean v7, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsDebuggerMode:Z

    move-object v0, p0

    invoke-direct/range {v0 .. v7}, Lcom/adobe/air/AndroidActivityWrapper;->LaunchApplication(Landroid/app/Activity;Lcom/adobe/air/AIRWindowSurfaceView;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)V

    .line 1199
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInvokeEventPendingFromOnCreate:Z

    if-eqz v0, :cond_2

    .line 1201
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    if-nez v0, :cond_1

    .line 1204
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->SendInvokeEvent()V

    .line 1207
    :cond_1
    iput-boolean v8, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInvokeEventPendingFromOnCreate:Z

    .line 1210
    :cond_2
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivateEventPending:Z

    if-eqz v0, :cond_3

    .line 1212
    invoke-direct {p0}, Lcom/adobe/air/AndroidActivityWrapper;->nativeActivateEvent()V

    .line 1213
    iput-boolean v8, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivateEventPending:Z

    .line 1217
    :cond_3
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeCleanCascade()V

    .line 1218
    return-void
.end method

.method public onTitleChanged(Ljava/lang/CharSequence;I)V
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 2096
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;Z)Z
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 2032
    return p2
.end method

.method public onTrackballEvent(Landroid/view/MotionEvent;Z)Z
    .locals 0
    .parameter
    .parameter

    .prologue
    .line 2037
    return p2
.end method

.method public onUserInteraction()V
    .locals 0

    .prologue
    .line 2042
    return-void
.end method

.method public onUserLeaveHint()V
    .locals 0

    .prologue
    .line 2100
    return-void
.end method

.method public onWindowAttributesChanged(Landroid/view/WindowManager$LayoutParams;)V
    .locals 0
    .parameter

    .prologue
    .line 2046
    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 0
    .parameter

    .prologue
    .line 2050
    return-void
.end method

.method public planeBreakCascade()V
    .locals 4

    .prologue
    const/4 v3, 0x1

    const/4 v0, 0x0

    .line 364
    move v1, v0

    .line 365
    :goto_0
    const/16 v2, 0x8

    if-ge v0, v2, :cond_1

    .line 366
    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v2, v0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 367
    add-int/lit8 v1, v1, 0x1

    .line 365
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 371
    :cond_1
    if-le v1, v3, :cond_2

    .line 372
    iput-boolean v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeBreakCascade:Z

    .line 374
    :cond_2
    return-void
.end method

.method public planeCleanCascade()V
    .locals 1

    .prologue
    .line 355
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeInit:Z

    if-nez v0, :cond_0

    .line 356
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeInit:Z

    .line 357
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeBreakCascade()V

    .line 359
    :cond_0
    return-void
.end method

.method public planeKickCascade()V
    .locals 6

    .prologue
    const/16 v5, 0x8

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 397
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->isHoneycomb()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_skipKickCascade:Z

    if-nez v0, :cond_1

    :cond_0
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->isJellybean()Z

    move-result v0

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mContainsVideo:Z

    if-ne v0, v4, :cond_2

    .line 431
    :cond_1
    :goto_0
    return-void

    .line 401
    :cond_2
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeCleanCascade()V

    .line 402
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    if-eqz v0, :cond_1

    .line 405
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeBreakCascade:Z

    if-eqz v0, :cond_6

    move v1, v3

    .line 406
    :goto_1
    if-ge v1, v5, :cond_4

    .line 407
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 408
    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/widget/FrameLayout;->indexOfChild(Landroid/view/View;)I

    move-result v0

    if-ltz v0, :cond_3

    .line 409
    iget-object v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v2, v0}, Landroid/widget/FrameLayout;->removeView(Landroid/view/View;)V

    .line 406
    :cond_3
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_1

    .line 413
    :cond_4
    iput-boolean v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeBreakCascade:Z

    move v1, v3

    .line 414
    :goto_2
    if-ge v1, v5, :cond_5

    .line 415
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_7

    .line 416
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/SurfaceView;

    invoke-direct {p0, v0}, Lcom/adobe/air/AndroidActivityWrapper;->planeRemovedSuccessfully(Landroid/view/SurfaceView;)Z

    move-result v0

    if-nez v0, :cond_7

    .line 417
    iput-boolean v4, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeBreakCascade:Z

    .line 422
    :cond_5
    iput v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    .line 424
    :cond_6
    iget v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    if-nez v0, :cond_1

    .line 425
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeStepCascade()V

    .line 429
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_mainView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->requestFocus()Z

    goto :goto_0

    .line 414
    :cond_7
    add-int/lit8 v0, v1, 0x1

    move v1, v0

    goto :goto_2
.end method

.method public planeStepCascade()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    .line 436
    iput-boolean v3, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_skipKickCascade:Z

    .line 445
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    if-nez v0, :cond_1

    .line 460
    :cond_0
    :goto_0
    return-void

    .line 449
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeBreakCascade:Z

    if-nez v0, :cond_0

    .line 450
    :goto_1
    iget v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    const/16 v1, 0x8

    if-ge v0, v1, :cond_0

    .line 451
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    iget v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    invoke-interface {v0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 452
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    iget v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->indexOfChild(Landroid/view/View;)I

    move-result v0

    if-gez v0, :cond_2

    .line 453
    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_layout:Landroid/widget/FrameLayout;

    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    iget v2, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    invoke-interface {v0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-virtual {v1, v0, v3}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;I)V

    .line 455
    :cond_2
    iget v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    goto :goto_0

    .line 450
    :cond_3
    iget v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planeCascadeStep:I

    goto :goto_1
.end method

.method public registerPlane(Landroid/view/SurfaceView;I)V
    .locals 1
    .parameter
    .parameter

    .prologue
    .line 342
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    invoke-interface {v0, p2, p1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 343
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeBreakCascade()V

    .line 344
    return-void
.end method

.method public removeActivityResultListener(Lcom/adobe/air/AndroidActivityWrapper$ActivityResultCallback;)V
    .locals 1
    .parameter

    .prologue
    .line 1797
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    if-eqz v0, :cond_0

    .line 1799
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityResultListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 1801
    :cond_0
    return-void
.end method

.method public removeActivityStateChangeListner(Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;)V
    .locals 1
    .parameter

    .prologue
    .line 1731
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    if-eqz v0, :cond_0

    .line 1733
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mActivityStateListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 1735
    :cond_0
    return-void
.end method

.method public removeInputEventListner(Lcom/adobe/air/AndroidActivityWrapper$InputEventCallback;)V
    .locals 1
    .parameter

    .prologue
    .line 1664
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    if-eqz v0, :cond_0

    .line 1666
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mInputEventListeners:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 1668
    :cond_0
    return-void
.end method

.method public setAspectRatio(I)V
    .locals 1
    .parameter

    .prologue
    .line 1303
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0, p1}, Lcom/adobe/air/OrientationManager;->setAspectRatio(I)V

    .line 1304
    return-void
.end method

.method public setAutoOrients(Z)V
    .locals 1
    .parameter

    .prologue
    .line 1308
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0, p1}, Lcom/adobe/air/OrientationManager;->setAutoOrients(Z)V

    .line 1309
    return-void
.end method

.method protected setIsFullScreen(Z)V
    .locals 0
    .parameter

    .prologue
    .line 1877
    iput-boolean p1, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsFullScreen:Z

    .line 1878
    return-void
.end method

.method public setOrientation(I)V
    .locals 1
    .parameter

    .prologue
    .line 1297
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mOrientationManager:Lcom/adobe/air/OrientationManager;

    invoke-virtual {v0, p1}, Lcom/adobe/air/OrientationManager;->setOrientation(I)V

    .line 1298
    return-void
.end method

.method public setSpeakerphoneOn(Z)V
    .locals 2
    .parameter

    .prologue
    .line 289
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v0

    const-string v1, "audio"

    invoke-virtual {v0, v1}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/media/AudioManager;

    invoke-virtual {p0, p1}, Landroid/media/AudioManager;->setSpeakerphoneOn(Z)V

    .line 291
    return-void
.end method

.method public setUseRGB565(Ljava/lang/Boolean;)V
    .locals 1
    .parameter

    .prologue
    .line 1349
    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iput-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mRGB565Override:Z

    .line 1350
    return-void
.end method

.method public unregisterPlane(I)V
    .locals 2
    .parameter

    .prologue
    .line 348
    iget-object v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_planes:Ljava/util/List;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Ljava/util/List;->set(ILjava/lang/Object;)Ljava/lang/Object;

    .line 349
    invoke-virtual {p0}, Lcom/adobe/air/AndroidActivityWrapper;->planeBreakCascade()V

    .line 350
    return-void
.end method

.method public useRGB565()Z
    .locals 2

    .prologue
    .line 1354
    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mIsADL:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/AndroidActivityWrapper;->mRGB565Override:Z

    .line 1358
    :goto_0
    return v0

    .line 1355
    :cond_0
    new-instance v0, Lcom/adobe/air/ResourceFileManager;

    iget-object v1, p0, Lcom/adobe/air/AndroidActivityWrapper;->m_activity:Landroid/app/Activity;

    invoke-direct {v0, v1}, Lcom/adobe/air/ResourceFileManager;-><init>(Landroid/content/Context;)V

    .line 1358
    const-string v1, "raw.rgba8888"

    invoke-virtual {v0, v1}, Lcom/adobe/air/ResourceFileManager;->lookupResId(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/adobe/air/ResourceFileManager;->resExists(I)Z

    move-result v0

    if-nez v0, :cond_1

    const/4 v0, 0x1

    goto :goto_0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.class public Lcom/adobe/air/FlashEGL10;
.super Ljava/lang/Object;
.source "FlashEGL10.java"

# interfaces
.implements Lcom/adobe/air/FlashEGL;


# static fields
.field private static EGL_BUFFER_DESTROYED:I

.field private static EGL_BUFFER_PRESERVED:I

.field private static EGL_CONTEXT_CLIENT_VERSION:I

.field private static EGL_COVERAGE_BUFFERS_NV:I

.field private static EGL_COVERAGE_SAMPLES_NV:I

.field private static EGL_OPENGL_ES2_BIT:I

.field private static EGL_SWAP_BEHAVIOR:I

.field private static TAG:Ljava/lang/String;

.field private static cfgAttrs:[I

.field private static fbPBufferSurfaceAttrs:[I

.field private static fbWindowSurfaceOffAttrs:[I

.field private static fbWindowSurfaceOnAttrs:[I


# instance fields
.field private kAlphaBits:I

.field private kBlueBits:I

.field private kColorBits:I

.field private kConfigId:I

.field private kCsaaSamp:I

.field private kDepthBits:I

.field private kGreenBits:I

.field private kMsaaSamp:I

.field private kNumElements:I

.field private kRedBits:I

.field private kStencilBits:I

.field private kSurfaceTypes:I

.field private kSwapPreserve:I

.field private kSwapPreserveDefault:I

.field private kSwapPreserveOff:I

.field private kSwapPreserveOn:I

.field private mEgl:Ljavax/microedition/khronos/egl/EGL10;

.field private mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

.field private mEglConfigCount:I

.field private mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

.field volatile mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

.field private mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

.field private mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

.field private mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

.field private mEglVersion:[I

.field private mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

.field private mIsARGBSurface:Z

.field private mIsBufferPreserve:Z

.field private mIsES3Device:Z

.field private mIsGPUOOM:Z

.field private mPbufferConfigCount:I

.field private mPixmapConfigCount:I

.field private mWindowConfigCount:I


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .prologue
    const/4 v7, 0x3

    const/4 v6, 0x2

    const/4 v5, 0x1

    const/4 v4, 0x0

    const/4 v3, -0x1

    .line 29
    const-string v0, "FlashEGL10"

    sput-object v0, Lcom/adobe/air/FlashEGL10;->TAG:Ljava/lang/String;

    .line 30
    const/16 v0, 0x3098

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_CONTEXT_CLIENT_VERSION:I

    .line 31
    const/4 v0, 0x4

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_OPENGL_ES2_BIT:I

    .line 33
    const/16 v0, 0x30e0

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_COVERAGE_BUFFERS_NV:I

    .line 34
    const/16 v0, 0x30e1

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_COVERAGE_SAMPLES_NV:I

    .line 37
    const/16 v0, 0x3093

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_SWAP_BEHAVIOR:I

    .line 38
    const/16 v0, 0x3094

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_PRESERVED:I

    .line 39
    const/16 v0, 0x3095

    sput v0, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_DESTROYED:I

    .line 49
    const/16 v0, 0x9

    new-array v0, v0, [I

    const/16 v1, 0x3033

    aput v1, v0, v4

    aput v3, v0, v5

    const/16 v1, 0x3025

    aput v1, v0, v6

    aput v3, v0, v7

    const/4 v1, 0x4

    const/16 v2, 0x3026

    aput v2, v0, v1

    const/4 v1, 0x5

    aput v3, v0, v1

    const/4 v1, 0x6

    const/16 v2, 0x3040

    aput v2, v0, v1

    const/4 v1, 0x7

    sget v2, Lcom/adobe/air/FlashEGL10;->EGL_OPENGL_ES2_BIT:I

    aput v2, v0, v1

    const/16 v1, 0x8

    const/16 v2, 0x3038

    aput v2, v0, v1

    sput-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    .line 59
    new-array v0, v7, [I

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_SWAP_BEHAVIOR:I

    aput v1, v0, v4

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_PRESERVED:I

    aput v1, v0, v5

    const/16 v1, 0x3038

    aput v1, v0, v6

    sput-object v0, Lcom/adobe/air/FlashEGL10;->fbWindowSurfaceOnAttrs:[I

    .line 65
    new-array v0, v7, [I

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_SWAP_BEHAVIOR:I

    aput v1, v0, v4

    sget v1, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_DESTROYED:I

    aput v1, v0, v5

    const/16 v1, 0x3038

    aput v1, v0, v6

    sput-object v0, Lcom/adobe/air/FlashEGL10;->fbWindowSurfaceOffAttrs:[I

    .line 71
    const/4 v0, 0x5

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/adobe/air/FlashEGL10;->fbPBufferSurfaceAttrs:[I

    return-void

    nop

    :array_0
    .array-data 0x4
        0x57t 0x30t 0x0t 0x0t
        0x40t 0x0t 0x0t 0x0t
        0x56t 0x30t 0x0t 0x0t
        0x40t 0x0t 0x0t 0x0t
        0x38t 0x30t 0x0t 0x0t
    .end array-data
.end method

.method public constructor <init>()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->kSurfaceTypes:I

    iput v3, p0, Lcom/adobe/air/FlashEGL10;->kConfigId:I

    iput v4, p0, Lcom/adobe/air/FlashEGL10;->kRedBits:I

    const/4 v0, 0x3

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kGreenBits:I

    const/4 v0, 0x4

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kBlueBits:I

    const/4 v0, 0x5

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kAlphaBits:I

    const/4 v0, 0x6

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kColorBits:I

    const/4 v0, 0x7

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kDepthBits:I

    const/16 v0, 0x8

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kStencilBits:I

    const/16 v0, 0x9

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kMsaaSamp:I

    const/16 v0, 0xa

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kCsaaSamp:I

    const/16 v0, 0xb

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserve:I

    const/16 v0, 0xc

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->kNumElements:I

    .line 46
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveDefault:I

    iput v3, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveOn:I

    iput v4, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveOff:I

    .line 776
    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    .line 777
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 778
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 779
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 780
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 781
    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    .line 782
    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    .line 783
    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    .line 784
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    .line 785
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mWindowConfigCount:I

    .line 786
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mPixmapConfigCount:I

    .line 787
    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mPbufferConfigCount:I

    .line 788
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 789
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsARGBSurface:Z

    .line 790
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsGPUOOM:Z

    .line 791
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsBufferPreserve:Z

    .line 792
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsES3Device:Z

    return-void
.end method

.method private XX(II)I
    .locals 1
    .parameter
    .parameter

    .prologue
    .line 96
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->kNumElements:I

    mul-int/2addr v0, p1

    add-int/2addr v0, p2

    return v0
.end method

.method private checkEglError(Ljava/lang/String;)I
    .locals 7
    .parameter

    .prologue
    const/16 v6, 0x3000

    .line 736
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v0

    .line 737
    if-eq v0, v6, :cond_3

    .line 739
    iget-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsGPUOOM:Z

    if-nez v1, :cond_3

    const/16 v1, 0x3003

    if-ne v0, v1, :cond_3

    .line 744
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v1, v2, :cond_1

    .line 746
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v1, v2, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 747
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v1}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v1

    .line 748
    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 749
    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 750
    if-eq v1, v6, :cond_0

    .line 753
    :cond_0
    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 754
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v5, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v1, v2, v3, v4, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 755
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v1}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v1

    .line 756
    if-eq v1, v6, :cond_1

    .line 761
    :cond_1
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v1, v2, :cond_2

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v1, v2, :cond_2

    .line 763
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 764
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v5, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v1, v2, v3, v4, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 765
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v1}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v1

    .line 766
    if-eq v1, v6, :cond_2

    .line 770
    :cond_2
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsGPUOOM:Z

    .line 773
    :cond_3
    return v0
.end method


# virtual methods
.method public ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z
    .locals 11
    .parameter
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    .line 129
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL10;->IsEmulator()Z

    move-result v0

    if-nez v0, :cond_0

    .line 130
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move v4, p4

    move-object/from16 v5, p5

    invoke-interface/range {v0 .. v5}, Ljavax/microedition/khronos/egl/EGL10;->eglChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    move-result v0

    .line 178
    :goto_0
    return v0

    .line 134
    :cond_0
    const/4 v0, 0x1

    new-array v0, v0, [I

    .line 135
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-interface {v1, p1, v2, v3, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigs(Ljavax/microedition/khronos/egl/EGLDisplay;[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 136
    const/4 v1, 0x0

    aget v1, v0, v1

    .line 139
    new-array v2, v1, [Ljavax/microedition/khronos/egl/EGLConfig;

    .line 140
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v3, p1, v2, v1, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigs(Ljavax/microedition/khronos/egl/EGLDisplay;[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 142
    const/4 v0, 0x0

    .line 143
    array-length v3, p2

    .line 144
    array-length v4, p2

    rem-int/lit8 v4, v4, 0x2

    if-eqz v4, :cond_1

    .line 145
    array-length v3, p2

    const/4 v4, 0x1

    sub-int/2addr v3, v4

    .line 147
    :cond_1
    const/4 v4, 0x0

    move v10, v4

    move v4, v0

    move v0, v10

    :goto_1
    if-ge v0, v1, :cond_6

    .line 149
    const/4 v5, 0x0

    .line 150
    :goto_2
    if-ge v5, v3, :cond_3

    .line 152
    add-int/lit8 v6, v5, 0x1

    aget v6, p2, v6

    const/4 v7, -0x1

    if-eq v6, v7, :cond_2

    .line 154
    const/4 v6, 0x1

    new-array v6, v6, [I

    .line 155
    iget-object v7, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    aget-object v8, v2, v0

    aget v9, p2, v5

    invoke-interface {v7, p1, v8, v9, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 158
    const/4 v7, 0x0

    aget v6, v6, v7

    add-int/lit8 v7, v5, 0x1

    aget v7, p2, v7

    and-int/2addr v6, v7

    add-int/lit8 v7, v5, 0x1

    aget v7, p2, v7

    if-ne v6, v7, :cond_3

    .line 150
    :cond_2
    add-int/lit8 v5, v5, 0x2

    goto :goto_2

    .line 166
    :cond_3
    if-ne v5, v3, :cond_5

    .line 168
    if-eqz p3, :cond_4

    if-ge v4, p4, :cond_4

    .line 170
    aget-object v5, v2, v0

    aput-object v5, p3, v4

    .line 172
    :cond_4
    add-int/lit8 v4, v4, 0x1

    .line 147
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 177
    :cond_6
    const/4 v0, 0x0

    aput v4, p5, v0

    .line 178
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public CreateDummySurfaceAndContext()I
    .locals 11

    .prologue
    const/4 v10, 0x2

    const/16 v9, 0x3006

    const/16 v8, 0x3000

    const/4 v7, 0x0

    const/4 v4, 0x1

    .line 312
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-ne v0, v1, :cond_0

    .line 315
    const/16 v0, 0x3008

    .line 395
    :goto_0
    return v0

    .line 319
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_3

    .line 321
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_1

    .line 323
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    move v0, v8

    .line 325
    goto :goto_0

    .line 327
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_2

    .line 329
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    move v0, v8

    .line 331
    goto :goto_0

    .line 333
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v5, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 334
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 335
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 339
    :cond_3
    new-array v5, v4, [I

    .line 340
    new-array v3, v4, [Ljavax/microedition/khronos/egl/EGLConfig;

    .line 341
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    aput v4, v0, v4

    .line 342
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 343
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    const/4 v1, -0x1

    aput v1, v0, v4

    .line 345
    aget v0, v5, v7

    .line 346
    if-nez v0, :cond_4

    move v0, v9

    .line 348
    goto :goto_0

    .line 354
    :cond_4
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x12

    if-lt v0, v1, :cond_6

    move v0, v4

    .line 356
    :goto_1
    const/4 v1, 0x3

    new-array v1, v1, [I

    sget v2, Lcom/adobe/air/FlashEGL10;->EGL_CONTEXT_CLIENT_VERSION:I

    aput v2, v1, v7

    const/4 v2, 0x3

    aput v2, v1, v4

    const/16 v2, 0x3038

    aput v2, v1, v10

    .line 357
    if-eqz v0, :cond_5

    .line 359
    const-string v0, "Before eglCreateContext es3"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 361
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v5, v3, v7

    sget-object v6, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v2, v5, v6, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 362
    const-string v0, "After eglCreateContext es3"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 363
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v2, :cond_5

    .line 364
    iput-boolean v4, p0, Lcom/adobe/air/FlashEGL10;->mIsES3Device:Z

    .line 367
    :cond_5
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v2, :cond_7

    .line 369
    aput v10, v1, v4

    .line 370
    const-string v0, "Before eglCreateContext es2"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 371
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v4, v3, v7

    sget-object v5, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v2, v4, v5, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 372
    const-string v0, "After eglCreateContext es2"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 373
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v1, :cond_7

    move v0, v9

    .line 376
    goto/16 :goto_0

    :cond_6
    move v0, v7

    .line 354
    goto :goto_1

    .line 380
    :cond_7
    const-string v0, "Before eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 381
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v2, v3, v7

    sget-object v3, Lcom/adobe/air/FlashEGL10;->fbPBufferSurfaceAttrs:[I

    invoke-interface {v0, v1, v2, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglCreatePbufferSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 382
    const-string v0, "After eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 384
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v0, v1, :cond_8

    move v0, v9

    .line 387
    goto/16 :goto_0

    .line 390
    :cond_8
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 391
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 392
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move v0, v8

    .line 395
    goto/16 :goto_0
.end method

.method public CreateGLContext(Z)I
    .locals 8
    .parameter

    .prologue
    const/16 v5, 0x3000

    const/4 v2, 0x3

    const/4 v4, 0x2

    const-string v7, "Before eglCreateContext"

    const-string v6, "After eglCreateContext"

    .line 458
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    if-nez v0, :cond_0

    .line 461
    const/16 v0, 0x3005

    .line 504
    :goto_0
    return v0

    .line 466
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_1

    if-nez p1, :cond_1

    move v0, v5

    .line 468
    goto :goto_0

    .line 474
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/FlashEGL10;->mIsES3Device:Z

    if-eqz v0, :cond_2

    move v0, v2

    .line 475
    :goto_1
    new-array v1, v2, [I

    const/4 v2, 0x0

    sget v3, Lcom/adobe/air/FlashEGL10;->EGL_CONTEXT_CLIENT_VERSION:I

    aput v3, v1, v2

    const/4 v2, 0x1

    aput v0, v1, v2

    const/16 v0, 0x3038

    aput v0, v1, v4

    .line 477
    if-eqz p1, :cond_3

    .line 479
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 480
    const-string v2, "Before eglCreateContext"

    invoke-direct {p0, v7}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 481
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-interface {v2, v3, v4, v0, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 482
    const-string v1, "After eglCreateContext"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 483
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v1, v2, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 484
    const-string v0, "After eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 493
    :goto_2
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v1, :cond_4

    .line 494
    const/16 v0, 0x3006

    goto :goto_0

    :cond_2
    move v0, v4

    .line 474
    goto :goto_1

    .line 488
    :cond_3
    const-string v0, "Before eglCreateContext"

    invoke-direct {p0, v7}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 489
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v2, v3, v4, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 490
    const-string v0, "After eglCreateContext"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    goto :goto_2

    .line 497
    :cond_4
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v0, v1, :cond_5

    .line 499
    const-string v0, "Before eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 500
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    sget-object v3, Lcom/adobe/air/FlashEGL10;->fbPBufferSurfaceAttrs:[I

    invoke-interface {v0, v1, v2, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglCreatePbufferSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 501
    const-string v0, "After eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    :cond_5
    move v0, v5

    .line 504
    goto/16 :goto_0
.end method

.method public CreateWindowSurface(Landroid/view/SurfaceView;I)I
    .locals 12
    .parameter
    .parameter

    .prologue
    const/16 v11, 0x300d

    const/4 v9, 0x1

    const/4 v8, 0x0

    const-string v7, "Before eglCreateWindowSurface"

    const-string v10, "After eglCreateWindowSurface"

    .line 604
    iget-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsGPUOOM:Z

    if-eqz v1, :cond_0

    .line 605
    const/16 v1, 0x3003

    .line 688
    :goto_0
    return v1

    .line 607
    :cond_0
    instance-of v1, p1, Lcom/adobe/air/AIRWindowSurfaceView;

    .line 609
    instance-of v2, p1, Lcom/adobe/flashruntime/air/VideoViewAIR;

    if-nez v2, :cond_1

    instance-of v2, p1, Lcom/adobe/air/AIRStage3DSurfaceView;

    if-nez v2, :cond_1

    if-nez v1, :cond_1

    move v1, v11

    .line 614
    goto :goto_0

    .line 617
    :cond_1
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v2, v3, :cond_2

    .line 620
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 621
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL10;->MakeGLCurrent()I

    move-result v1

    goto :goto_0

    .line 626
    :cond_2
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveOn:I

    if-ne p2, v2, :cond_3

    .line 628
    const-string v2, "Before eglCreateWindowSurface"

    invoke-direct {p0, v7}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 629
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v5

    sget-object v6, Lcom/adobe/air/FlashEGL10;->fbWindowSurfaceOnAttrs:[I

    invoke-interface {v2, v3, v4, v5, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateWindowSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v2

    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 630
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v2, v3, :cond_9

    .line 631
    const-string v2, "After eglCreateWindowSurface"

    invoke-direct {p0, v10}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move v2, v8

    .line 643
    :goto_1
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v3, v4, :cond_4

    .line 646
    const-string v3, "Before eglCreateWindowSurface"

    invoke-direct {p0, v7}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 647
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v5, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v6

    const/4 v7, 0x0

    invoke-interface {v3, v4, v5, v6, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateWindowSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v3

    iput-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 648
    const-string v3, "After eglCreateWindowSurface"

    invoke-direct {p0, v10}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v3

    .line 649
    const/16 v4, 0x3000

    if-eq v3, v4, :cond_4

    move v1, v3

    .line 650
    goto :goto_0

    .line 634
    :cond_3
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserveOff:I

    if-ne p2, v2, :cond_9

    .line 636
    const-string v2, "Before eglCreateWindowSurface"

    invoke-direct {p0, v7}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 637
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v5

    sget-object v6, Lcom/adobe/air/FlashEGL10;->fbWindowSurfaceOffAttrs:[I

    invoke-interface {v2, v3, v4, v5, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateWindowSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v2

    iput-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 638
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v2, v3, :cond_9

    .line 639
    const-string v2, "After eglCreateWindowSurface"

    invoke-direct {p0, v10}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move v2, v8

    .line 640
    goto :goto_1

    .line 653
    :cond_4
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v3, v4, :cond_5

    move v1, v11

    .line 655
    goto/16 :goto_0

    .line 661
    :cond_5
    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 663
    if-eqz v1, :cond_6

    .line 665
    move-object v0, p1

    check-cast v0, Lcom/adobe/air/AIRWindowSurfaceView;

    move-object v1, v0

    invoke-virtual {v1, p0}, Lcom/adobe/air/AIRWindowSurfaceView;->setFlashEGL(Lcom/adobe/air/FlashEGL;)V

    .line 669
    check-cast p1, Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {p1}, Lcom/adobe/air/AIRWindowSurfaceView;->getActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v1

    .line 670
    if-eqz v1, :cond_6

    .line 673
    invoke-virtual {v1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 674
    const/16 v3, 0x22

    invoke-virtual {v1, v3}, Landroid/view/Window;->setSoftInputMode(I)V

    .line 678
    :cond_6
    new-array v1, v9, [I

    .line 679
    aput v8, v1, v8

    .line 680
    iput-boolean v8, p0, Lcom/adobe/air/FlashEGL10;->mIsBufferPreserve:Z

    .line 681
    if-eqz v2, :cond_7

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget v5, Lcom/adobe/air/FlashEGL10;->EGL_SWAP_BEHAVIOR:I

    invoke-interface {v2, v3, v4, v5, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    move-result v2

    if-eqz v2, :cond_7

    .line 682
    aget v1, v1, v8

    sget v2, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_PRESERVED:I

    if-ne v1, v2, :cond_8

    move v1, v9

    :goto_2
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL10;->mIsBufferPreserve:Z

    .line 688
    :cond_7
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL10;->MakeGLCurrent()I

    move-result v1

    goto/16 :goto_0

    :cond_8
    move v1, v8

    .line 682
    goto :goto_2

    :cond_9
    move v2, v9

    goto/16 :goto_1
.end method

.method public DestroyGLContext()Z
    .locals 5

    .prologue
    .line 434
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-ne v0, v1, :cond_1

    .line 436
    :cond_0
    const/4 v0, 0x0

    .line 452
    :goto_0
    return v0

    .line 439
    :cond_1
    const-string v0, "DestroyGLContext: Before eglMakeCurrent for noSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 440
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 441
    const-string v0, "DestroyGLContext: After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 443
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_2

    .line 444
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 445
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 448
    :cond_2
    const-string v0, "Before eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 449
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    move-result v0

    .line 450
    const-string v1, "After eglDestroyContext"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 451
    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    goto :goto_0
.end method

.method public DestroyWindowSurface()Z
    .locals 8

    .prologue
    const/16 v6, 0x3000

    const/4 v5, 0x0

    const-string v7, "After eglMakeCurrent"

    .line 693
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_4

    .line 696
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 697
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 699
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v7}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    if-eq v6, v0, :cond_0

    move v0, v5

    .line 721
    :goto_0
    return v0

    .line 702
    :cond_0
    const-string v0, "Before eglDestroySurface (window)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 703
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 704
    const-string v0, "After eglDestroySurface (window)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    if-eq v6, v0, :cond_1

    move v0, v5

    .line 705
    goto :goto_0

    .line 707
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v0, v1, :cond_2

    .line 708
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 709
    :cond_2
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 711
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_3

    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_3

    .line 713
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 714
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 715
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v7}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    if-eq v6, v0, :cond_3

    move v0, v5

    .line 716
    goto :goto_0

    .line 719
    :cond_3
    const/4 v0, 0x1

    goto :goto_0

    :cond_4
    move v0, v5

    .line 721
    goto :goto_0
.end method

.method public FlashEGL10()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 81
    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    .line 82
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 83
    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    .line 84
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 85
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 86
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 87
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 88
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/FlashEGL10;->mIsARGBSurface:Z

    .line 89
    return-void
.end method

.method public GetConfigs(ZZ)[I
    .locals 10
    .parameter
    .parameter

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 217
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    iget v1, p0, Lcom/adobe/air/FlashEGL10;->kNumElements:I

    mul-int/2addr v0, v1

    new-array v6, v0, [I

    .line 218
    new-array v5, v9, [I

    .line 219
    new-array v7, v9, [I

    .line 222
    iget v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    new-array v0, v0, [Ljavax/microedition/khronos/egl/EGLConfig;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    .line 224
    const-string v0, "Before eglChooseConfig"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 225
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    iget v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 226
    const-string v0, "After eglChooseConfig"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 228
    aget v0, v5, v8

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    move v1, v8

    .line 229
    :goto_0
    if-ge v1, v0, :cond_5

    .line 231
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3033

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 232
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kSurfaceTypes:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 234
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kConfigId:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aput v1, v6, v2

    .line 236
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3024

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 237
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kRedBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 239
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3023

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 240
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kGreenBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 242
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3022

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 243
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kBlueBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 245
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3021

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 246
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kAlphaBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 248
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3020

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 249
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kColorBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 251
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3025

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 252
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kDepthBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 254
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3026

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 255
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kStencilBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 257
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kCsaaSamp:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aput v8, v6, v2

    .line 258
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kMsaaSamp:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aput v8, v6, v2

    .line 260
    if-eqz p1, :cond_2

    .line 261
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    sget v5, Lcom/adobe/air/FlashEGL10;->EGL_COVERAGE_SAMPLES_NV:I

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 262
    aget v2, v7, v8

    if-eq v2, v9, :cond_0

    .line 263
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kCsaaSamp:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 271
    :cond_0
    :goto_1
    if-eqz p2, :cond_4

    .line 273
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserve:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    aget v3, v3, v8

    if-gt v3, v9, :cond_1

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    aget v3, v3, v9

    const/4 v4, 0x3

    if-le v3, v4, :cond_3

    :cond_1
    iget v3, p0, Lcom/adobe/air/FlashEGL10;->kSurfaceTypes:I

    invoke-direct {p0, v1, v3}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v3

    aget v3, v6, v3

    sget v4, Lcom/adobe/air/FlashEGL10;->EGL_BUFFER_PRESERVED:I

    and-int/2addr v3, v4

    if-eqz v3, :cond_3

    move v3, v9

    :goto_2
    aput v3, v6, v2

    .line 229
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    .line 266
    :cond_2
    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v4, v4, v1

    const/16 v5, 0x3031

    invoke-interface {v2, v3, v4, v5, v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 267
    aget v2, v7, v8

    if-eq v2, v9, :cond_0

    .line 268
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kMsaaSamp:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    goto :goto_1

    :cond_3
    move v3, v8

    .line 273
    goto :goto_2

    .line 276
    :cond_4
    iget v2, p0, Lcom/adobe/air/FlashEGL10;->kSwapPreserve:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL10;->XX(II)I

    move-result v2

    aput v8, v6, v2

    goto :goto_3

    .line 279
    :cond_5
    return-object v6
.end method

.method public GetNumConfigs()[I
    .locals 10

    .prologue
    const/4 v9, 0x4

    const/4 v8, 0x2

    const/4 v3, 0x0

    const/4 v7, 0x1

    const/4 v4, 0x0

    .line 183
    new-array v6, v9, [I

    .line 184
    new-array v5, v7, [I

    .line 187
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 188
    aget v0, v5, v4

    aput v0, v6, v4

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigCount:I

    .line 192
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    aput v9, v0, v7

    .line 193
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 194
    aget v0, v5, v4

    aput v0, v6, v7

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->mWindowConfigCount:I

    .line 198
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    aput v8, v0, v7

    .line 199
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 200
    aget v0, v5, v4

    aput v0, v6, v8

    iput v0, p0, Lcom/adobe/air/FlashEGL10;->mPixmapConfigCount:I

    .line 204
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    aput v7, v0, v7

    .line 205
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL10;->ChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 206
    const/4 v0, 0x3

    aget v1, v5, v4

    aput v1, v6, v0

    iput v1, p0, Lcom/adobe/air/FlashEGL10;->mPbufferConfigCount:I

    .line 210
    sget-object v0, Lcom/adobe/air/FlashEGL10;->cfgAttrs:[I

    const/4 v1, -0x1

    aput v1, v0, v7

    .line 212
    return-object v6
.end method

.method public GetSurfaceHeight()I
    .locals 5

    .prologue
    .line 114
    const/4 v0, 0x1

    new-array v0, v0, [I

    .line 115
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    const/16 v4, 0x3056

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    .line 117
    const/4 v1, 0x0

    aget v0, v0, v1

    return v0
.end method

.method public GetSurfaceWidth()I
    .locals 5

    .prologue
    .line 106
    const/4 v0, 0x1

    new-array v0, v0, [I

    .line 107
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    const/16 v4, 0x3057

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    .line 109
    const/4 v1, 0x0

    aget v0, v0, v1

    return v0
.end method

.method public HasGLContext()Z
    .locals 2

    .prologue
    .line 101
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public InitEGL()I
    .locals 4

    .prologue
    const/16 v3, 0x3000

    .line 401
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-eq v0, v1, :cond_1

    move v0, v3

    .line 429
    :cond_0
    :goto_0
    return v0

    .line 408
    :cond_1
    invoke-static {}, Ljavax/microedition/khronos/egl/EGLContext;->getEGL()Ljavax/microedition/khronos/egl/EGL;

    move-result-object v0

    check-cast v0, Ljavax/microedition/khronos/egl/EGL10;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    .line 412
    const-string v0, "Before eglGetDisplay"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 413
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_DEFAULT_DISPLAY:Ljava/lang/Object;

    invoke-interface {v0, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglGetDisplay(Ljava/lang/Object;)Ljavax/microedition/khronos/egl/EGLDisplay;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 414
    const-string v0, "After eglGetDisplay"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    .line 415
    if-ne v3, v0, :cond_0

    .line 420
    const/4 v0, 0x2

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    .line 421
    const-string v0, "Before eglInitialize"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 422
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglVersion:[I

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglInitialize(Ljavax/microedition/khronos/egl/EGLDisplay;[I)Z

    .line 423
    const-string v0, "After eglInitialize"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    .line 424
    if-ne v3, v0, :cond_0

    move v0, v3

    .line 429
    goto :goto_0
.end method

.method public IsARGBSurface()Z
    .locals 1

    .prologue
    .line 726
    iget-boolean v0, p0, Lcom/adobe/air/FlashEGL10;->mIsARGBSurface:Z

    return v0
.end method

.method public IsBufferPreserve()Z
    .locals 1

    .prologue
    .line 731
    iget-boolean v0, p0, Lcom/adobe/air/FlashEGL10;->mIsBufferPreserve:Z

    return v0
.end method

.method public IsEmulator()Z
    .locals 3

    .prologue
    const-string v2, "generic"

    .line 122
    sget-object v0, Landroid/os/Build;->BRAND:Ljava/lang/String;

    const-string v1, "generic"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    const-string v1, "generic"

    invoke-virtual {v0, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public MakeGLCurrent()I
    .locals 5

    .prologue
    .line 577
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v1, :cond_0

    .line 580
    const/16 v0, 0x3006

    .line 597
    :goto_0
    return v0

    .line 583
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-ne v0, v1, :cond_1

    .line 586
    const/16 v0, 0x300d

    goto :goto_0

    .line 589
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-ne v0, v1, :cond_2

    .line 592
    const/16 v0, 0x3008

    goto :goto_0

    .line 595
    :cond_2
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 596
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 597
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public ReleaseGPUResources()V
    .locals 5

    .prologue
    .line 522
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    if-ne v0, v1, :cond_0

    .line 560
    :goto_0
    return-void

    .line 528
    :cond_0
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 529
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 530
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 533
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    monitor-enter v0

    .line 535
    :try_start_0
    const-string v1, "Before eglDestroySurface"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 536
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v1, v2, :cond_1

    .line 537
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v1, v2, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 538
    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglWindowSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 540
    :cond_1
    const-string v1, "After eglDestroySurface (window)"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 541
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 543
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eq v0, v1, :cond_2

    .line 545
    const-string v0, "Before eglDestroySurface (pbuffer)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 546
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 547
    const-string v0, "After eglDestroySurface (pbuffer)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 548
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglPbufferSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 552
    :cond_2
    const-string v0, "Before eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 553
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 554
    const-string v0, "After eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 556
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 557
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    goto :goto_0

    .line 541
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public SetConfig(I)V
    .locals 6
    .parameter

    .prologue
    const/4 v5, 0x0

    .line 285
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfigList:[Ljavax/microedition/khronos/egl/EGLConfig;

    aget-object v0, v0, p1

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    .line 287
    const/4 v0, 0x1

    new-array v0, v0, [I

    .line 288
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v4, 0x3024

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 289
    aget v1, v0, v5

    .line 290
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v4, 0x3023

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 291
    aget v1, v0, v5

    .line 292
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v4, 0x3022

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 293
    aget v1, v0, v5

    .line 294
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v4, 0x3021

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 295
    aget v1, v0, v5

    .line 296
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v4, 0x3025

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 297
    aget v1, v0, v5

    .line 298
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v4, 0x3026

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 299
    aget v1, v0, v5

    .line 300
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v4, 0x3031

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 301
    aget v1, v0, v5

    .line 302
    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL10;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/16 v4, 0x3032

    invoke-interface {v1, v2, v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 303
    aget v0, v0, v5

    .line 306
    return-void
.end method

.method public SwapEGLBuffers()V
    .locals 3

    .prologue
    .line 566
    const/16 v0, 0x3000

    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL10;->MakeGLCurrent()I

    move-result v1

    if-eq v0, v1, :cond_0

    .line 573
    :goto_0
    return-void

    .line 570
    :cond_0
    const-string v0, "Before eglSwapBuffers"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    .line 571
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL10;->mEglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-interface {v0, v1, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglSwapBuffers(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 572
    const-string v0, "After eglSwapBuffers"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL10;->checkEglError(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TerminateEGL()V
    .locals 2

    .prologue
    .line 509
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v1, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-eq v0, v1, :cond_0

    .line 512
    iget-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEgl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v0, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglTerminate(Ljavax/microedition/khronos/egl/EGLDisplay;)Z

    .line 514
    :cond_0
    sget-object v0, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_DISPLAY:Ljavax/microedition/khronos/egl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL10;->mEglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 515
    return-void
.end method

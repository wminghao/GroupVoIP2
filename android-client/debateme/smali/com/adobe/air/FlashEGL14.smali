.class public Lcom/adobe/air/FlashEGL14;
.super Ljava/lang/Object;
.source "FlashEGL14.java"

# interfaces
.implements Lcom/adobe/air/FlashEGL;


# static fields
.field private static EGL_BUFFER_DESTROYED:I = 0x0

.field private static EGL_BUFFER_PRESERVED:I = 0x0

.field private static EGL_CONTEXT_CLIENT_VERSION:I = 0x0

.field private static EGL_COVERAGE_BUFFERS_NV:I = 0x0

.field private static EGL_COVERAGE_SAMPLES_NV:I = 0x0

.field private static EGL_OPENGL_ES2_BIT:I = 0x0

.field private static EGL_SWAP_BEHAVIOR:I = 0x0

.field private static final MAX_CONFIGS:I = 0x64

.field private static TAG:Ljava/lang/String;

.field private static cfgAttrs:[I

.field private static fbPBufferSurfaceAttrs:[I

.field private static fbWindowSurfaceDefAttrs:[I

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

.field private mEgl:Landroid/opengl/EGL14;

.field private mEglConfig:Landroid/opengl/EGLConfig;

.field private mEglConfigCount:I

.field private mEglConfigList:[Landroid/opengl/EGLConfig;

.field volatile mEglContext:Landroid/opengl/EGLContext;

.field private mEglDisplay:Landroid/opengl/EGLDisplay;

.field private mEglPbufferSurface:Landroid/opengl/EGLSurface;

.field private mEglSurface:Landroid/opengl/EGLSurface;

.field private mEglVersion:[I

.field private mEglWindowSurface:Landroid/opengl/EGLSurface;

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
    const/4 v7, 0x2

    const/4 v6, -0x1

    const/16 v5, 0x3038

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 30
    const-string v0, "FlashEGL14"

    sput-object v0, Lcom/adobe/air/FlashEGL14;->TAG:Ljava/lang/String;

    .line 31
    const/16 v0, 0x3098

    sput v0, Lcom/adobe/air/FlashEGL14;->EGL_CONTEXT_CLIENT_VERSION:I

    .line 32
    const/4 v0, 0x4

    sput v0, Lcom/adobe/air/FlashEGL14;->EGL_OPENGL_ES2_BIT:I

    .line 34
    const/16 v0, 0x30e0

    sput v0, Lcom/adobe/air/FlashEGL14;->EGL_COVERAGE_BUFFERS_NV:I

    .line 35
    const/16 v0, 0x30e1

    sput v0, Lcom/adobe/air/FlashEGL14;->EGL_COVERAGE_SAMPLES_NV:I

    .line 38
    const/16 v0, 0x3093

    sput v0, Lcom/adobe/air/FlashEGL14;->EGL_SWAP_BEHAVIOR:I

    .line 39
    const/16 v0, 0x3094

    sput v0, Lcom/adobe/air/FlashEGL14;->EGL_BUFFER_PRESERVED:I

    .line 40
    const/16 v0, 0x3095

    sput v0, Lcom/adobe/air/FlashEGL14;->EGL_BUFFER_DESTROYED:I

    .line 51
    const/16 v0, 0x9

    new-array v0, v0, [I

    const/16 v1, 0x3033

    aput v1, v0, v3

    aput v6, v0, v4

    const/16 v1, 0x3025

    aput v1, v0, v7

    const/4 v1, 0x3

    aput v6, v0, v1

    const/4 v1, 0x4

    const/16 v2, 0x3026

    aput v2, v0, v1

    const/4 v1, 0x5

    aput v6, v0, v1

    const/4 v1, 0x6

    const/16 v2, 0x3040

    aput v2, v0, v1

    const/4 v1, 0x7

    sget v2, Lcom/adobe/air/FlashEGL14;->EGL_OPENGL_ES2_BIT:I

    aput v2, v0, v1

    const/16 v1, 0x8

    aput v5, v0, v1

    sput-object v0, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    .line 61
    const/4 v0, 0x3

    new-array v0, v0, [I

    sget v1, Lcom/adobe/air/FlashEGL14;->EGL_SWAP_BEHAVIOR:I

    aput v1, v0, v3

    sget v1, Lcom/adobe/air/FlashEGL14;->EGL_BUFFER_PRESERVED:I

    aput v1, v0, v4

    aput v5, v0, v7

    sput-object v0, Lcom/adobe/air/FlashEGL14;->fbWindowSurfaceOnAttrs:[I

    .line 67
    const/4 v0, 0x3

    new-array v0, v0, [I

    sget v1, Lcom/adobe/air/FlashEGL14;->EGL_SWAP_BEHAVIOR:I

    aput v1, v0, v3

    sget v1, Lcom/adobe/air/FlashEGL14;->EGL_BUFFER_DESTROYED:I

    aput v1, v0, v4

    aput v5, v0, v7

    sput-object v0, Lcom/adobe/air/FlashEGL14;->fbWindowSurfaceOffAttrs:[I

    .line 73
    new-array v0, v4, [I

    aput v5, v0, v3

    sput-object v0, Lcom/adobe/air/FlashEGL14;->fbWindowSurfaceDefAttrs:[I

    .line 79
    const/4 v0, 0x5

    new-array v0, v0, [I

    fill-array-data v0, :array_0

    sput-object v0, Lcom/adobe/air/FlashEGL14;->fbPBufferSurfaceAttrs:[I

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

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    iput v1, p0, Lcom/adobe/air/FlashEGL14;->kSurfaceTypes:I

    iput v3, p0, Lcom/adobe/air/FlashEGL14;->kConfigId:I

    iput v4, p0, Lcom/adobe/air/FlashEGL14;->kRedBits:I

    const/4 v0, 0x3

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kGreenBits:I

    const/4 v0, 0x4

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kBlueBits:I

    const/4 v0, 0x5

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kAlphaBits:I

    const/4 v0, 0x6

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kColorBits:I

    const/4 v0, 0x7

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kDepthBits:I

    const/16 v0, 0x8

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kStencilBits:I

    const/16 v0, 0x9

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kMsaaSamp:I

    const/16 v0, 0xa

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kCsaaSamp:I

    const/16 v0, 0xb

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kSwapPreserve:I

    const/16 v0, 0xc

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->kNumElements:I

    .line 48
    iput v1, p0, Lcom/adobe/air/FlashEGL14;->kSwapPreserveDefault:I

    iput v3, p0, Lcom/adobe/air/FlashEGL14;->kSwapPreserveOn:I

    iput v4, p0, Lcom/adobe/air/FlashEGL14;->kSwapPreserveOff:I

    .line 787
    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    .line 788
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    .line 789
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    .line 790
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 791
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    .line 792
    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    .line 793
    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    .line 794
    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglVersion:[I

    .line 795
    iput v1, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigCount:I

    .line 796
    iput v1, p0, Lcom/adobe/air/FlashEGL14;->mWindowConfigCount:I

    .line 797
    iput v1, p0, Lcom/adobe/air/FlashEGL14;->mPixmapConfigCount:I

    .line 798
    iput v1, p0, Lcom/adobe/air/FlashEGL14;->mPbufferConfigCount:I

    .line 799
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 800
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL14;->mIsARGBSurface:Z

    .line 801
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL14;->mIsGPUOOM:Z

    .line 802
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL14;->mIsBufferPreserve:Z

    .line 803
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL14;->mIsES3Device:Z

    return-void
.end method

.method private XX(II)I
    .locals 1
    .parameter
    .parameter

    .prologue
    .line 104
    iget v0, p0, Lcom/adobe/air/FlashEGL14;->kNumElements:I

    mul-int/2addr v0, p1

    add-int/2addr v0, p2

    return v0
.end method

.method private checkEglError(Ljava/lang/String;)I
    .locals 6
    .parameter

    .prologue
    const/16 v5, 0x3000

    .line 747
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    invoke-static {}, Landroid/opengl/EGL14;->eglGetError()I

    move-result v0

    .line 748
    if-eq v0, v5, :cond_3

    .line 750
    iget-boolean v1, p0, Lcom/adobe/air/FlashEGL14;->mIsGPUOOM:Z

    if-nez v1, :cond_3

    const/16 v1, 0x3003

    if-ne v0, v1, :cond_3

    .line 755
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v1, v2, :cond_1

    .line 757
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    invoke-static {v1, v2}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 758
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    invoke-static {}, Landroid/opengl/EGL14;->eglGetError()I

    move-result v1

    .line 759
    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 760
    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    .line 761
    if-eq v1, v5, :cond_0

    .line 764
    :cond_0
    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 765
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v4, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v1, v2, v3, v4}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 766
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    invoke-static {}, Landroid/opengl/EGL14;->eglGetError()I

    move-result v1

    .line 767
    if-eq v1, v5, :cond_1

    .line 772
    :cond_1
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v1, v2, :cond_2

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-eq v1, v2, :cond_2

    .line 774
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    .line 775
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    iget-object v4, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v1, v2, v3, v4}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 776
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    invoke-static {}, Landroid/opengl/EGL14;->eglGetError()I

    move-result v1

    .line 777
    if-eq v1, v5, :cond_2

    .line 781
    :cond_2
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL14;->mIsGPUOOM:Z

    .line 784
    :cond_3
    return v0
.end method


# virtual methods
.method public ChooseConfig(Landroid/opengl/EGLDisplay;[I[Landroid/opengl/EGLConfig;I[I)Z
    .locals 11
    .parameter
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    .line 137
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL14;->IsEmulator()Z

    move-result v0

    if-nez v0, :cond_0

    .line 138
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    const/4 v2, 0x0

    const/4 v4, 0x0

    const/4 v7, 0x0

    move-object v0, p1

    move-object v1, p2

    move-object v3, p3

    move v5, p4

    move-object/from16 v6, p5

    invoke-static/range {v0 .. v7}, Landroid/opengl/EGL14;->eglChooseConfig(Landroid/opengl/EGLDisplay;[II[Landroid/opengl/EGLConfig;II[II)Z

    move-result v0

    .line 186
    :goto_0
    return v0

    .line 142
    :cond_0
    const/4 v0, 0x1

    new-array v4, v0, [I

    .line 143
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v5, 0x0

    move-object v0, p1

    invoke-static/range {v0 .. v5}, Landroid/opengl/EGL14;->eglGetConfigs(Landroid/opengl/EGLDisplay;[Landroid/opengl/EGLConfig;II[II)Z

    .line 144
    const/4 v0, 0x0

    aget v3, v4, v0

    .line 147
    new-array v1, v3, [Landroid/opengl/EGLConfig;

    .line 148
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    const/4 v2, 0x0

    const/4 v5, 0x0

    move-object v0, p1

    invoke-static/range {v0 .. v5}, Landroid/opengl/EGL14;->eglGetConfigs(Landroid/opengl/EGLDisplay;[Landroid/opengl/EGLConfig;II[II)Z

    .line 150
    const/4 v0, 0x0

    .line 151
    array-length v2, p2

    .line 152
    array-length v4, p2

    rem-int/lit8 v4, v4, 0x2

    if-eqz v4, :cond_1

    .line 153
    array-length v2, p2

    const/4 v4, 0x1

    sub-int/2addr v2, v4

    .line 155
    :cond_1
    const/4 v4, 0x0

    move v10, v4

    move v4, v0

    move v0, v10

    :goto_1
    if-ge v0, v3, :cond_6

    .line 157
    const/4 v5, 0x0

    .line 158
    :goto_2
    if-ge v5, v2, :cond_3

    .line 160
    add-int/lit8 v6, v5, 0x1

    aget v6, p2, v6

    const/4 v7, -0x1

    if-eq v6, v7, :cond_2

    .line 162
    const/4 v6, 0x1

    new-array v6, v6, [I

    .line 163
    iget-object v7, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    aget-object v7, v1, v0

    aget v8, p2, v5

    const/4 v9, 0x0

    invoke-static {p1, v7, v8, v6, v9}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 166
    const/4 v7, 0x0

    aget v6, v6, v7

    add-int/lit8 v7, v5, 0x1

    aget v7, p2, v7

    and-int/2addr v6, v7

    add-int/lit8 v7, v5, 0x1

    aget v7, p2, v7

    if-ne v6, v7, :cond_3

    .line 158
    :cond_2
    add-int/lit8 v5, v5, 0x2

    goto :goto_2

    .line 174
    :cond_3
    if-ne v5, v2, :cond_5

    .line 176
    if-eqz p3, :cond_4

    if-ge v4, p4, :cond_4

    .line 178
    aget-object v5, v1, v0

    aput-object v5, p3, v4

    .line 180
    :cond_4
    add-int/lit8 v4, v4, 0x1

    .line 155
    :cond_5
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 185
    :cond_6
    const/4 v0, 0x0

    aput v4, p5, v0

    .line 186
    const/4 v0, 0x1

    goto :goto_0
.end method

.method public CreateDummySurfaceAndContext()I
    .locals 10

    .prologue
    const/4 v9, 0x2

    const/16 v8, 0x3006

    const/16 v7, 0x3000

    const/4 v6, 0x0

    const/4 v4, 0x1

    .line 321
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    if-ne v0, v1, :cond_0

    .line 324
    const/16 v0, 0x3008

    .line 404
    :goto_0
    return v0

    .line 328
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-eq v0, v1, :cond_3

    .line 330
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v0, v1, :cond_1

    .line 332
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    move v0, v7

    .line 334
    goto :goto_0

    .line 336
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v0, v1, :cond_2

    .line 338
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    move v0, v7

    .line 340
    goto :goto_0

    .line 342
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 343
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 344
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 348
    :cond_3
    new-array v5, v4, [I

    .line 349
    new-array v3, v4, [Landroid/opengl/EGLConfig;

    .line 350
    sget-object v0, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    aput v4, v0, v4

    .line 351
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL14;->ChooseConfig(Landroid/opengl/EGLDisplay;[I[Landroid/opengl/EGLConfig;I[I)Z

    .line 352
    sget-object v0, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    const/4 v1, -0x1

    aput v1, v0, v4

    .line 354
    aget v0, v5, v6

    .line 355
    if-nez v0, :cond_4

    move v0, v8

    .line 357
    goto :goto_0

    .line 363
    :cond_4
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x12

    if-lt v0, v1, :cond_6

    move v0, v4

    .line 365
    :goto_1
    const/4 v1, 0x3

    new-array v1, v1, [I

    sget v2, Lcom/adobe/air/FlashEGL14;->EGL_CONTEXT_CLIENT_VERSION:I

    aput v2, v1, v6

    const/4 v2, 0x3

    aput v2, v1, v4

    const/16 v2, 0x3038

    aput v2, v1, v9

    .line 366
    if-eqz v0, :cond_5

    .line 368
    const-string v0, "Before eglCreateContext es3"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 370
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    aget-object v2, v3, v6

    sget-object v5, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v2, v5, v1, v6}, Landroid/opengl/EGL14;->eglCreateContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Landroid/opengl/EGLContext;[II)Landroid/opengl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 371
    const-string v0, "After eglCreateContext es3"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 372
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-eq v0, v2, :cond_5

    .line 373
    iput-boolean v4, p0, Lcom/adobe/air/FlashEGL14;->mIsES3Device:Z

    .line 376
    :cond_5
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-ne v0, v2, :cond_7

    .line 378
    aput v9, v1, v4

    .line 379
    const-string v0, "Before eglCreateContext es2"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 380
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    aget-object v2, v3, v6

    sget-object v4, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v2, v4, v1, v6}, Landroid/opengl/EGL14;->eglCreateContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Landroid/opengl/EGLContext;[II)Landroid/opengl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 381
    const-string v0, "After eglCreateContext es2"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 382
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-ne v0, v1, :cond_7

    move v0, v8

    .line 385
    goto/16 :goto_0

    :cond_6
    move v0, v6

    .line 363
    goto :goto_1

    .line 389
    :cond_7
    const-string v0, "Before eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 390
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    aget-object v1, v3, v6

    sget-object v2, Lcom/adobe/air/FlashEGL14;->fbPBufferSurfaceAttrs:[I

    invoke-static {v0, v1, v2, v6}, Landroid/opengl/EGL14;->eglCreatePbufferSurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;[II)Landroid/opengl/EGLSurface;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    .line 391
    const-string v0, "After eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 393
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-ne v0, v1, :cond_8

    move v0, v8

    .line 396
    goto/16 :goto_0

    .line 399
    :cond_8
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 400
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 401
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move v0, v7

    .line 404
    goto/16 :goto_0
.end method

.method public CreateGLContext(Z)I
    .locals 7
    .parameter

    .prologue
    const/16 v5, 0x3000

    const/4 v2, 0x3

    const/4 v3, 0x2

    const/4 v4, 0x0

    const-string v6, "After eglCreateContext"

    .line 467
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    if-nez v0, :cond_0

    .line 470
    const/16 v0, 0x3005

    .line 513
    :goto_0
    return v0

    .line 475
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-eq v0, v1, :cond_1

    if-nez p1, :cond_1

    move v0, v5

    .line 477
    goto :goto_0

    .line 483
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/FlashEGL14;->mIsES3Device:Z

    if-eqz v0, :cond_2

    move v0, v2

    .line 484
    :goto_1
    new-array v1, v2, [I

    sget v2, Lcom/adobe/air/FlashEGL14;->EGL_CONTEXT_CLIENT_VERSION:I

    aput v2, v1, v4

    const/4 v2, 0x1

    aput v0, v1, v2

    const/16 v0, 0x3038

    aput v0, v1, v3

    .line 486
    if-eqz p1, :cond_3

    .line 488
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 489
    const-string v2, "Before eglCreateContext"

    invoke-direct {p0, v2}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 490
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    invoke-static {v2, v3, v0, v1, v4}, Landroid/opengl/EGL14;->eglCreateContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Landroid/opengl/EGLContext;[II)Landroid/opengl/EGLContext;

    move-result-object v1

    iput-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 491
    const-string v1, "After eglCreateContext"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 492
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    invoke-static {v1, v0}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 493
    const-string v0, "After eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 502
    :goto_2
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-ne v0, v1, :cond_4

    .line 503
    const/16 v0, 0x3006

    goto :goto_0

    :cond_2
    move v0, v3

    .line 483
    goto :goto_1

    .line 497
    :cond_3
    const-string v0, "Before eglCreateContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 498
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v2, v3, v1, v4}, Landroid/opengl/EGL14;->eglCreateContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Landroid/opengl/EGLContext;[II)Landroid/opengl/EGLContext;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 499
    const-string v0, "After eglCreateContext"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    goto :goto_2

    .line 506
    :cond_4
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    if-ne v0, v1, :cond_5

    .line 508
    const-string v0, "Before eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 509
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    sget-object v2, Lcom/adobe/air/FlashEGL14;->fbPBufferSurfaceAttrs:[I

    invoke-static {v0, v1, v2, v4}, Landroid/opengl/EGL14;->eglCreatePbufferSurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;[II)Landroid/opengl/EGLSurface;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    .line 510
    const-string v0, "After eglCreatePbufferSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    :cond_5
    move v0, v5

    .line 513
    goto/16 :goto_0
.end method

.method public CreateWindowSurface(Landroid/view/SurfaceView;I)I
    .locals 11
    .parameter
    .parameter

    .prologue
    const/16 v10, 0x300d

    const/4 v7, 0x1

    const/4 v6, 0x0

    const-string v9, "Before eglCreateWindowSurface"

    const-string v8, "After eglCreateWindowSurface"

    .line 613
    iget-boolean v1, p0, Lcom/adobe/air/FlashEGL14;->mIsGPUOOM:Z

    if-eqz v1, :cond_0

    .line 614
    const/16 v1, 0x3003

    .line 699
    :goto_0
    return v1

    .line 616
    :cond_0
    instance-of v1, p1, Lcom/adobe/air/AIRWindowSurfaceView;

    .line 618
    instance-of v2, p1, Lcom/adobe/flashruntime/air/VideoViewAIR;

    if-nez v2, :cond_1

    instance-of v2, p1, Lcom/adobe/air/AIRStage3DSurfaceView;

    if-nez v2, :cond_1

    if-nez v1, :cond_1

    move v1, v10

    .line 623
    goto :goto_0

    .line 626
    :cond_1
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v2, v3, :cond_2

    .line 629
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    .line 630
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL14;->MakeGLCurrent()I

    move-result v1

    goto :goto_0

    .line 635
    :cond_2
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kSwapPreserveOn:I

    if-ne p2, v2, :cond_3

    .line 637
    const-string v2, "Before eglCreateWindowSurface"

    invoke-direct {p0, v9}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 638
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v4

    sget-object v5, Lcom/adobe/air/FlashEGL14;->fbWindowSurfaceOnAttrs:[I

    invoke-static {v2, v3, v4, v5, v6}, Landroid/opengl/EGL14;->eglCreateWindowSurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Ljava/lang/Object;[II)Landroid/opengl/EGLSurface;

    move-result-object v2

    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 639
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-ne v2, v3, :cond_a

    .line 640
    const-string v2, "After eglCreateWindowSurface"

    invoke-direct {p0, v8}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move v2, v6

    .line 652
    :goto_1
    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v4, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-ne v3, v4, :cond_5

    .line 655
    const-string v2, "Before eglCreateWindowSurface"

    invoke-direct {p0, v9}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 656
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v4

    sget-object v5, Lcom/adobe/air/FlashEGL14;->fbWindowSurfaceDefAttrs:[I

    invoke-static {v2, v3, v4, v5, v6}, Landroid/opengl/EGL14;->eglCreateWindowSurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Ljava/lang/Object;[II)Landroid/opengl/EGLSurface;

    move-result-object v2

    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 657
    const-string v2, "After eglCreateWindowSurface"

    invoke-direct {p0, v8}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move-result v2

    .line 658
    const/16 v3, 0x3000

    if-eq v2, v3, :cond_4

    move v1, v2

    .line 659
    goto :goto_0

    .line 643
    :cond_3
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kSwapPreserveOff:I

    if-ne p2, v2, :cond_a

    .line 645
    const-string v2, "Before eglCreateWindowSurface"

    invoke-direct {p0, v9}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 646
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    invoke-virtual {p1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v4

    sget-object v5, Lcom/adobe/air/FlashEGL14;->fbWindowSurfaceOffAttrs:[I

    invoke-static {v2, v3, v4, v5, v6}, Landroid/opengl/EGL14;->eglCreateWindowSurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;Ljava/lang/Object;[II)Landroid/opengl/EGLSurface;

    move-result-object v2

    iput-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 647
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-ne v2, v3, :cond_a

    .line 648
    const-string v2, "After eglCreateWindowSurface"

    invoke-direct {p0, v8}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move v2, v6

    .line 649
    goto :goto_1

    :cond_4
    move v2, v7

    .line 664
    :cond_5
    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v4, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-ne v3, v4, :cond_6

    move v1, v10

    .line 666
    goto/16 :goto_0

    .line 672
    :cond_6
    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    iput-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    .line 674
    if-eqz v1, :cond_7

    .line 676
    move-object v0, p1

    check-cast v0, Lcom/adobe/air/AIRWindowSurfaceView;

    move-object v1, v0

    invoke-virtual {v1, p0}, Lcom/adobe/air/AIRWindowSurfaceView;->setFlashEGL(Lcom/adobe/air/FlashEGL;)V

    .line 680
    check-cast p1, Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {p1}, Lcom/adobe/air/AIRWindowSurfaceView;->getActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v1

    .line 681
    if-eqz v1, :cond_7

    .line 684
    invoke-virtual {v1}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v1

    .line 685
    const/16 v3, 0x22

    invoke-virtual {v1, v3}, Landroid/view/Window;->setSoftInputMode(I)V

    .line 689
    :cond_7
    new-array v1, v7, [I

    .line 690
    aput v6, v1, v6

    .line 691
    iput-boolean v6, p0, Lcom/adobe/air/FlashEGL14;->mIsBufferPreserve:Z

    .line 692
    if-eqz v2, :cond_8

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    sget v4, Lcom/adobe/air/FlashEGL14;->EGL_SWAP_BEHAVIOR:I

    invoke-static {v2, v3, v4, v1, v6}, Landroid/opengl/EGL14;->eglQuerySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;I[II)Z

    move-result v2

    if-eqz v2, :cond_8

    .line 693
    aget v1, v1, v6

    sget v2, Lcom/adobe/air/FlashEGL14;->EGL_BUFFER_PRESERVED:I

    if-ne v1, v2, :cond_9

    move v1, v7

    :goto_2
    iput-boolean v1, p0, Lcom/adobe/air/FlashEGL14;->mIsBufferPreserve:Z

    .line 699
    :cond_8
    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL14;->MakeGLCurrent()I

    move-result v1

    goto/16 :goto_0

    :cond_9
    move v1, v6

    .line 693
    goto :goto_2

    :cond_a
    move v2, v7

    goto/16 :goto_1
.end method

.method public DestroyGLContext()Z
    .locals 4

    .prologue
    .line 443
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-eq v0, v1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    if-ne v0, v1, :cond_1

    .line 445
    :cond_0
    const/4 v0, 0x0

    .line 461
    :goto_0
    return v0

    .line 448
    :cond_1
    const-string v0, "DestroyGLContext: Before eglMakeCurrent for noSurface"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 449
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 450
    const-string v0, "DestroyGLContext: After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 452
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v0, v1, :cond_2

    .line 453
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 454
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    .line 457
    :cond_2
    const-string v0, "Before eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 458
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    move-result v0

    .line 459
    const-string v1, "After eglDestroyContext"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 460
    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    goto :goto_0
.end method

.method public DestroyWindowSurface()Z
    .locals 7

    .prologue
    const/16 v5, 0x3000

    const/4 v4, 0x0

    const-string v6, "After eglMakeCurrent"

    .line 704
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v0, v1, :cond_4

    .line 707
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 708
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 710
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move-result v0

    if-eq v5, v0, :cond_0

    move v0, v4

    .line 732
    :goto_0
    return v0

    .line 713
    :cond_0
    const-string v0, "Before eglDestroySurface (window)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 714
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 715
    const-string v0, "After eglDestroySurface (window)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move-result v0

    if-eq v5, v0, :cond_1

    move v0, v4

    .line 716
    goto :goto_0

    .line 718
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    if-ne v0, v1, :cond_2

    .line 719
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    .line 720
    :cond_2
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 722
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v0, v1, :cond_3

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-eq v0, v1, :cond_3

    .line 724
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    .line 725
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 726
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v6}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move-result v0

    if-eq v5, v0, :cond_3

    move v0, v4

    .line 727
    goto :goto_0

    .line 730
    :cond_3
    const/4 v0, 0x1

    goto :goto_0

    :cond_4
    move v0, v4

    .line 732
    goto :goto_0
.end method

.method public FlashEGL14()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 89
    iput-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    .line 90
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    .line 91
    iput-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    .line 92
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 93
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    .line 94
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 95
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    .line 96
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/FlashEGL14;->mIsARGBSurface:Z

    .line 97
    return-void
.end method

.method public GetConfigs(ZZ)[I
    .locals 10
    .parameter
    .parameter

    .prologue
    const/4 v9, 0x1

    const/4 v8, 0x0

    .line 226
    iget v0, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigCount:I

    iget v1, p0, Lcom/adobe/air/FlashEGL14;->kNumElements:I

    mul-int/2addr v0, v1

    new-array v6, v0, [I

    .line 227
    new-array v5, v9, [I

    .line 228
    new-array v7, v9, [I

    .line 231
    iget v0, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigCount:I

    new-array v0, v0, [Landroid/opengl/EGLConfig;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    .line 233
    const-string v0, "Before eglChooseConfig"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 234
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    iget v4, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigCount:I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL14;->ChooseConfig(Landroid/opengl/EGLDisplay;[I[Landroid/opengl/EGLConfig;I[I)Z

    .line 235
    const-string v0, "After eglChooseConfig"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 237
    aget v0, v5, v8

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigCount:I

    move v1, v8

    .line 238
    :goto_0
    if-ge v1, v0, :cond_5

    .line 240
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3033

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 241
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kSurfaceTypes:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 243
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kConfigId:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aput v1, v6, v2

    .line 245
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3024

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 246
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kRedBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 248
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3023

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 249
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kGreenBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 251
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3022

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 252
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kBlueBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 254
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3021

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 255
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kAlphaBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 257
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3020

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 258
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kColorBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 260
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3025

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 261
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kDepthBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 263
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3026

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 264
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kStencilBits:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 266
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kCsaaSamp:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aput v8, v6, v2

    .line 267
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kMsaaSamp:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aput v8, v6, v2

    .line 269
    if-eqz p1, :cond_2

    .line 270
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    sget v4, Lcom/adobe/air/FlashEGL14;->EGL_COVERAGE_SAMPLES_NV:I

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 271
    aget v2, v7, v8

    if-eq v2, v9, :cond_0

    .line 272
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kCsaaSamp:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    .line 280
    :cond_0
    :goto_1
    if-eqz p2, :cond_4

    .line 282
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kSwapPreserve:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglVersion:[I

    aget v3, v3, v8

    if-gt v3, v9, :cond_1

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglVersion:[I

    aget v3, v3, v9

    const/4 v4, 0x3

    if-le v3, v4, :cond_3

    :cond_1
    iget v3, p0, Lcom/adobe/air/FlashEGL14;->kSurfaceTypes:I

    invoke-direct {p0, v1, v3}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v3

    aget v3, v6, v3

    sget v4, Lcom/adobe/air/FlashEGL14;->EGL_BUFFER_PRESERVED:I

    and-int/2addr v3, v4

    if-eqz v3, :cond_3

    move v3, v9

    :goto_2
    aput v3, v6, v2

    .line 238
    :goto_3
    add-int/lit8 v1, v1, 0x1

    goto/16 :goto_0

    .line 275
    :cond_2
    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v3, v3, v1

    const/16 v4, 0x3031

    invoke-static {v2, v3, v4, v7, v8}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 276
    aget v2, v7, v8

    if-eq v2, v9, :cond_0

    .line 277
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kMsaaSamp:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aget v3, v7, v8

    aput v3, v6, v2

    goto :goto_1

    :cond_3
    move v3, v8

    .line 282
    goto :goto_2

    .line 285
    :cond_4
    iget v2, p0, Lcom/adobe/air/FlashEGL14;->kSwapPreserve:I

    invoke-direct {p0, v1, v2}, Lcom/adobe/air/FlashEGL14;->XX(II)I

    move-result v2

    aput v8, v6, v2

    goto :goto_3

    .line 288
    :cond_5
    return-object v6
.end method

.method public GetNumConfigs()[I
    .locals 11

    .prologue
    const/4 v10, 0x4

    const/4 v9, 0x2

    const/16 v4, 0x64

    const/4 v8, 0x0

    const/4 v7, 0x1

    .line 191
    new-array v6, v10, [I

    .line 192
    new-array v5, v7, [I

    .line 193
    new-array v3, v4, [Landroid/opengl/EGLConfig;

    .line 196
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL14;->ChooseConfig(Landroid/opengl/EGLDisplay;[I[Landroid/opengl/EGLConfig;I[I)Z

    .line 197
    aget v0, v5, v8

    aput v0, v6, v8

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigCount:I

    .line 201
    sget-object v0, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    aput v10, v0, v7

    .line 202
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL14;->ChooseConfig(Landroid/opengl/EGLDisplay;[I[Landroid/opengl/EGLConfig;I[I)Z

    .line 203
    aget v0, v5, v8

    aput v0, v6, v7

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->mWindowConfigCount:I

    .line 207
    sget-object v0, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    aput v9, v0, v7

    .line 208
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL14;->ChooseConfig(Landroid/opengl/EGLDisplay;[I[Landroid/opengl/EGLConfig;I[I)Z

    .line 209
    aget v0, v5, v8

    aput v0, v6, v9

    iput v0, p0, Lcom/adobe/air/FlashEGL14;->mPixmapConfigCount:I

    .line 213
    sget-object v0, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    aput v7, v0, v7

    .line 214
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v2, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    move-object v0, p0

    invoke-virtual/range {v0 .. v5}, Lcom/adobe/air/FlashEGL14;->ChooseConfig(Landroid/opengl/EGLDisplay;[I[Landroid/opengl/EGLConfig;I[I)Z

    .line 215
    const/4 v0, 0x3

    aget v1, v5, v8

    aput v1, v6, v0

    iput v1, p0, Lcom/adobe/air/FlashEGL14;->mPbufferConfigCount:I

    .line 219
    sget-object v0, Lcom/adobe/air/FlashEGL14;->cfgAttrs:[I

    const/4 v1, -0x1

    aput v1, v0, v7

    .line 221
    return-object v6
.end method

.method public GetSurfaceHeight()I
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 122
    const/4 v0, 0x1

    new-array v0, v0, [I

    .line 123
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    const/16 v3, 0x3056

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglQuerySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;I[II)Z

    .line 125
    aget v0, v0, v4

    return v0
.end method

.method public GetSurfaceWidth()I
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 114
    const/4 v0, 0x1

    new-array v0, v0, [I

    .line 115
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    const/16 v3, 0x3057

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglQuerySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;I[II)Z

    .line 117
    aget v0, v0, v4

    return v0
.end method

.method public HasGLContext()Z
    .locals 2

    .prologue
    .line 109
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public InitEGL()I
    .locals 6

    .prologue
    const/4 v5, 0x0

    const/16 v4, 0x3000

    .line 410
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-eq v0, v1, :cond_1

    move v0, v4

    .line 438
    :cond_0
    :goto_0
    return v0

    .line 417
    :cond_1
    new-instance v0, Landroid/opengl/EGL14;

    invoke-direct {v0}, Landroid/opengl/EGL14;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    .line 421
    const-string v0, "Before eglGetDisplay"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 422
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    invoke-static {v5}, Landroid/opengl/EGL14;->eglGetDisplay(I)Landroid/opengl/EGLDisplay;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    .line 423
    const-string v0, "After eglGetDisplay"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move-result v0

    .line 424
    if-ne v4, v0, :cond_0

    .line 429
    const/4 v0, 0x2

    new-array v0, v0, [I

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglVersion:[I

    .line 430
    const-string v0, "Before eglInitialize"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 431
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglVersion:[I

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglVersion:[I

    const/4 v3, 0x1

    invoke-static {v0, v1, v5, v2, v3}, Landroid/opengl/EGL14;->eglInitialize(Landroid/opengl/EGLDisplay;[II[II)Z

    .line 432
    const-string v0, "After eglInitialize"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move-result v0

    .line 433
    if-ne v4, v0, :cond_0

    move v0, v4

    .line 438
    goto :goto_0
.end method

.method public IsARGBSurface()Z
    .locals 1

    .prologue
    .line 737
    iget-boolean v0, p0, Lcom/adobe/air/FlashEGL14;->mIsARGBSurface:Z

    return v0
.end method

.method public IsBufferPreserve()Z
    .locals 1

    .prologue
    .line 742
    iget-boolean v0, p0, Lcom/adobe/air/FlashEGL14;->mIsBufferPreserve:Z

    return v0
.end method

.method public IsEmulator()Z
    .locals 3

    .prologue
    const-string v2, "generic"

    .line 130
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
    .locals 4

    .prologue
    .line 586
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-ne v0, v1, :cond_0

    .line 589
    const/16 v0, 0x3006

    .line 606
    :goto_0
    return v0

    .line 592
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-ne v0, v1, :cond_1

    .line 595
    const/16 v0, 0x300d

    goto :goto_0

    .line 598
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    if-ne v0, v1, :cond_2

    .line 601
    const/16 v0, 0x3008

    goto :goto_0

    .line 604
    :cond_2
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 605
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    iget-object v3, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 606
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    move-result v0

    goto :goto_0
.end method

.method public ReleaseGPUResources()V
    .locals 4

    .prologue
    .line 531
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    if-ne v0, v1, :cond_0

    .line 569
    :goto_0
    return-void

    .line 537
    :cond_0
    const-string v0, "Before eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 538
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    sget-object v3, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    invoke-static {v0, v1, v2, v3}, Landroid/opengl/EGL14;->eglMakeCurrent(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;Landroid/opengl/EGLSurface;Landroid/opengl/EGLContext;)Z

    .line 539
    const-string v0, "After eglMakeCurrent"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 542
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    monitor-enter v0

    .line 544
    :try_start_0
    const-string v1, "Before eglDestroySurface"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 545
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    sget-object v2, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v1, v2, :cond_1

    .line 546
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    invoke-static {v1, v2}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 547
    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglWindowSurface:Landroid/opengl/EGLSurface;

    .line 549
    :cond_1
    const-string v1, "After eglDestroySurface (window)"

    invoke-direct {p0, v1}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 550
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 552
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    if-eq v0, v1, :cond_2

    .line 554
    const-string v0, "Before eglDestroySurface (pbuffer)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 555
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglDestroySurface(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 556
    const-string v0, "After eglDestroySurface (pbuffer)"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 557
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglPbufferSurface:Landroid/opengl/EGLSurface;

    .line 561
    :cond_2
    const-string v0, "Before eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 562
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglDestroyContext(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLContext;)Z

    .line 563
    const-string v0, "After eglDestroyContext"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 565
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_CONTEXT:Landroid/opengl/EGLContext;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglContext:Landroid/opengl/EGLContext;

    .line 566
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_SURFACE:Landroid/opengl/EGLSurface;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    goto :goto_0

    .line 550
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v1
.end method

.method public SetConfig(I)V
    .locals 5
    .parameter

    .prologue
    const/4 v4, 0x0

    .line 294
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglConfigList:[Landroid/opengl/EGLConfig;

    aget-object v0, v0, p1

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    .line 296
    const/4 v0, 0x1

    new-array v0, v0, [I

    .line 297
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    const/16 v3, 0x3024

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 298
    aget v1, v0, v4

    .line 299
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    const/16 v3, 0x3023

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 300
    aget v1, v0, v4

    .line 301
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    const/16 v3, 0x3022

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 302
    aget v1, v0, v4

    .line 303
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    const/16 v3, 0x3021

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 304
    aget v1, v0, v4

    .line 305
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    const/16 v3, 0x3025

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 306
    aget v1, v0, v4

    .line 307
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    const/16 v3, 0x3026

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 308
    aget v1, v0, v4

    .line 309
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    const/16 v3, 0x3031

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 310
    aget v1, v0, v4

    .line 311
    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v2, p0, Lcom/adobe/air/FlashEGL14;->mEglConfig:Landroid/opengl/EGLConfig;

    const/16 v3, 0x3032

    invoke-static {v1, v2, v3, v0, v4}, Landroid/opengl/EGL14;->eglGetConfigAttrib(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLConfig;I[II)Z

    .line 312
    aget v0, v0, v4

    .line 315
    return-void
.end method

.method public SwapEGLBuffers()V
    .locals 2

    .prologue
    .line 575
    const/16 v0, 0x3000

    invoke-virtual {p0}, Lcom/adobe/air/FlashEGL14;->MakeGLCurrent()I

    move-result v1

    if-eq v0, v1, :cond_0

    .line 582
    :goto_0
    return-void

    .line 579
    :cond_0
    const-string v0, "Before eglSwapBuffers"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    .line 580
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    iget-object v1, p0, Lcom/adobe/air/FlashEGL14;->mEglSurface:Landroid/opengl/EGLSurface;

    invoke-static {v0, v1}, Landroid/opengl/EGL14;->eglSwapBuffers(Landroid/opengl/EGLDisplay;Landroid/opengl/EGLSurface;)Z

    .line 581
    const-string v0, "After eglSwapBuffers"

    invoke-direct {p0, v0}, Lcom/adobe/air/FlashEGL14;->checkEglError(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public TerminateEGL()V
    .locals 2

    .prologue
    .line 518
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    sget-object v1, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    if-eq v0, v1, :cond_0

    .line 521
    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEgl:Landroid/opengl/EGL14;

    iget-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    invoke-static {v0}, Landroid/opengl/EGL14;->eglTerminate(Landroid/opengl/EGLDisplay;)Z

    .line 523
    :cond_0
    sget-object v0, Landroid/opengl/EGL14;->EGL_NO_DISPLAY:Landroid/opengl/EGLDisplay;

    iput-object v0, p0, Lcom/adobe/air/FlashEGL14;->mEglDisplay:Landroid/opengl/EGLDisplay;

    .line 524
    return-void
.end method

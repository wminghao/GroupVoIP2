.class public Lcom/adobe/air/gestures/AIRGestureListener;
.super Ljava/lang/Object;
.source "AIRGestureListener.java"

# interfaces
.implements Landroid/view/GestureDetector$OnGestureListener;
.implements Landroid/view/GestureDetector$OnDoubleTapListener;
.implements Landroid/view/ScaleGestureDetector$OnScaleGestureListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "AIRGestureListener"

.field private static final MAX_TOUCH_POINTS:I = 0x2

.field private static final MM_PER_INCH:F = 25.4f

.field private static final _FP_GESTURE_PAN_THRESHOLD_MM:F = 3.0f

.field private static final _FP_GESTURE_ROTATION_THRESHOLD_DEGREES:F = 15.0f

.field private static final _FP_GESTURE_SWIPE_PRIMARY_AXIS_MIN_MM:F = 10.0f

.field private static final _FP_GESTURE_SWIPE_SECONDARY_AXIS_MAX_MM:F = 5.0f

.field private static final _FP_GESTURE_ZOOM_PER_AXIS_THRESHOLD_MM:F = 3.0f

.field private static final _FP_GESTURE_ZOOM_THRESHOLD_MM:F = 8.0f

.field private static final kGestureAll:I = 0x8

.field private static final kGestureBegin:I = 0x2

.field private static final kGestureEnd:I = 0x4

.field private static final kGesturePan:I = 0x1

.field private static final kGestureRotate:I = 0x2

.field private static final kGestureSwipe:I = 0x5

.field private static final kGestureTwoFingerTap:I = 0x3

.field private static final kGestureUpdate:I = 0x1

.field private static final kGestureZoom:I

.field private static screenPPI:I


# instance fields
.field private mCheckForSwipe:Z

.field private mCouldBeTwoFingerTap:I

.field private mDidOccurTwoFingerGesture:Z

.field private mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

.field private mInPanTransformGesture:Z

.field private mInRotateTransformGesture:Z

.field private mInZoomTransformGesture:Z

.field private mInZoomTransformGestureX:Z

.field private mInZoomTransformGestureY:Z

.field private mPreviousAbsoluteRotation:F

.field private mPreviousPanLocX:F

.field private mPreviousPanLocY:F

.field private mPreviousRotateLocX:F

.field private mPreviousRotateLocY:F

.field private mPreviousZoomLocX:F

.field private mPreviousZoomLocY:F

.field private mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

.field private mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

.field private mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

.field private mTwoFingerTapStartTime:J


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 60
    const/4 v0, 0x0

    sput v0, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/adobe/air/AIRWindowSurfaceView;)V
    .locals 5
    .parameter
    .parameter

    .prologue
    const/4 v4, 0x0

    const/4 v3, 0x2

    const/4 v0, 0x0

    const/4 v2, 0x0

    .line 156
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 62
    iput v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousAbsoluteRotation:F

    .line 63
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    .line 64
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    .line 65
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    .line 66
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    .line 67
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    .line 69
    iput v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocX:F

    .line 70
    iput v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocY:F

    .line 71
    iput v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocX:F

    .line 72
    iput v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocY:F

    .line 73
    iput v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocX:F

    .line 74
    iput v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocY:F

    .line 76
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mTwoFingerTapStartTime:J

    .line 77
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    .line 89
    iput v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    .line 90
    iput-object v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 91
    iput-object v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 92
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    .line 157
    iput-object p2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 159
    new-array v0, v3, [Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    iput-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move v0, v2

    .line 160
    :goto_0
    if-ge v0, v3, :cond_0

    .line 162
    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    new-instance v2, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-direct {v2, p0}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;)V

    aput-object v2, v1, v0

    .line 160
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 165
    :cond_0
    new-instance v0, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-direct {v0, p0}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;)V

    iput-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 166
    invoke-static {p1}, Lcom/adobe/air/SystemCapabilities;->GetScreenDPI(Landroid/content/Context;)I

    move-result v0

    sput v0, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    .line 167
    return-void
.end method

.method private distanceBetweenPoints(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)D
    .locals 6
    .parameter
    .parameter

    .prologue
    const-wide/high16 v4, 0x4000

    .line 916
    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v0

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    sub-float/2addr v0, v1

    float-to-double v0, v0

    invoke-static {v0, v1, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v0

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v2

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v3

    sub-float/2addr v2, v3

    float-to-double v2, v2

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    add-double/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    return-wide v0
.end method

.method private endPanGesture()V
    .locals 11

    .prologue
    const/4 v2, 0x1

    const/high16 v6, 0x3f80

    const/4 v8, 0x0

    .line 324
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    .line 346
    :cond_0
    :goto_0
    return-void

    .line 328
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    if-eqz v0, :cond_0

    .line 330
    const/4 v1, 0x4

    .line 340
    iget v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocX:F

    .line 341
    iget v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocY:F

    move-object v0, p0

    move v3, v2

    move v7, v6

    move v9, v8

    move v10, v8

    .line 343
    invoke-direct/range {v0 .. v10}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    .line 344
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    goto :goto_0
.end method

.method private endRotateGesture()V
    .locals 11

    .prologue
    const/4 v2, 0x2

    const/high16 v6, 0x3f80

    const/4 v8, 0x0

    .line 270
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    if-eq v0, v2, :cond_1

    .line 292
    :cond_0
    :goto_0
    return-void

    .line 274
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    if-eqz v0, :cond_0

    .line 276
    const/4 v1, 0x4

    .line 286
    iget v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocX:F

    .line 287
    iget v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocY:F

    .line 289
    const/4 v3, 0x1

    move-object v0, p0

    move v7, v6

    move v9, v8

    move v10, v8

    invoke-direct/range {v0 .. v10}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    .line 290
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    goto :goto_0
.end method

.method private endZoomGesture()V
    .locals 11

    .prologue
    const/high16 v6, 0x3f80

    const/4 v8, 0x0

    const/4 v2, 0x0

    .line 296
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    .line 320
    :cond_0
    :goto_0
    return-void

    .line 300
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 302
    const/4 v1, 0x4

    .line 312
    iget v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocX:F

    .line 313
    iget v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocY:F

    .line 315
    const/4 v3, 0x1

    move-object v0, p0

    move v7, v6

    move v9, v8

    move v10, v8

    invoke-direct/range {v0 .. v10}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    .line 316
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    .line 317
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    .line 318
    iput-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    goto :goto_0
.end method

.method private getRotation(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F
    .locals 10
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    const-wide v8, 0x4066800000000000L

    const-wide v6, 0x400921fb54442d18L

    .line 858
    const/4 v0, 0x0

    .line 859
    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->pid:I
    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v1

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->pid:I
    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v2

    if-ne v1, v2, :cond_0

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->pid:I
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v1

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->pid:I
    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v2

    if-ne v1, v2, :cond_0

    .line 862
    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v0

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    sub-float/2addr v0, v1

    float-to-double v0, v0

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v2

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v3

    sub-float/2addr v2, v3

    float-to-double v2, v2

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v0

    mul-double/2addr v0, v8

    div-double/2addr v0, v6

    .line 864
    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v2

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v3

    sub-float/2addr v2, v3

    float-to-double v2, v2

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v4

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v5

    sub-float/2addr v4, v5

    float-to-double v4, v4

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v2

    mul-double/2addr v2, v8

    div-double/2addr v2, v6

    .line 866
    sub-double v0, v2, v0

    double-to-float v0, v0

    .line 869
    :cond_0
    return v0
.end method

.method private isPanGesture(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)Z
    .locals 8
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    const/4 v7, 0x0

    .line 883
    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v0

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    sub-float/2addr v0, v1

    .line 884
    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v1

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p1}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v2

    sub-float/2addr v1, v2

    .line 886
    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v2

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v3

    sub-float/2addr v2, v3

    .line 887
    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v3

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {p2}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v4

    sub-float/2addr v3, v4

    .line 889
    invoke-static {v0}, Ljava/lang/Math;->abs(F)F

    move-result v4

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v5

    invoke-static {v4, v5}, Ljava/lang/Math;->min(FF)F

    move-result v4

    .line 890
    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v5

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v6

    invoke-static {v5, v6}, Ljava/lang/Math;->min(FF)F

    move-result v5

    .line 891
    mul-float/2addr v4, v4

    mul-float/2addr v5, v5

    add-float/2addr v4, v5

    float-to-double v4, v4

    invoke-static {v4, v5}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v4

    .line 896
    cmpl-float v6, v0, v7

    if-ltz v6, :cond_0

    cmpl-float v6, v2, v7

    if-gez v6, :cond_1

    :cond_0
    cmpg-float v0, v0, v7

    if-gtz v0, :cond_5

    cmpg-float v0, v2, v7

    if-gtz v0, :cond_5

    :cond_1
    cmpl-float v0, v1, v7

    if-ltz v0, :cond_2

    cmpl-float v0, v3, v7

    if-gez v0, :cond_3

    :cond_2
    cmpg-float v0, v1, v7

    if-gtz v0, :cond_5

    cmpg-float v0, v3, v7

    if-gtz v0, :cond_5

    :cond_3
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    if-nez v0, :cond_4

    const/high16 v0, 0x4040

    sget v1, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v1, v1

    mul-float/2addr v0, v1

    const v1, 0x41cb3333

    div-float/2addr v0, v1

    float-to-double v0, v0

    cmpl-double v0, v4, v0

    if-lez v0, :cond_5

    .line 904
    :cond_4
    const/4 v0, 0x1

    .line 906
    :goto_0
    return v0

    :cond_5
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private native nativeOnGestureListener(IIZFFFFFFF)Z
.end method


# virtual methods
.method public endTwoFingerGesture()Z
    .locals 5

    .prologue
    const/4 v4, 0x1

    .line 244
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    move v0, v4

    .line 265
    :goto_0
    return v0

    .line 250
    :cond_0
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    .line 252
    iget-boolean v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    if-nez v2, :cond_1

    iget v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    const/4 v3, 0x3

    if-ne v2, v3, :cond_1

    iget-wide v2, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mTwoFingerTapStartTime:J

    sub-long/2addr v0, v2

    invoke-static {}, Landroid/view/ViewConfiguration;->getTapTimeout()I

    move-result v2

    int-to-long v2, v2

    cmp-long v0, v0, v2

    if-gez v0, :cond_1

    .line 256
    invoke-virtual {p0}, Lcom/adobe/air/gestures/AIRGestureListener;->onTwoFingerTap()Z

    .line 263
    :cond_1
    invoke-direct {p0}, Lcom/adobe/air/gestures/AIRGestureListener;->endRotateGesture()V

    .line 264
    invoke-direct {p0}, Lcom/adobe/air/gestures/AIRGestureListener;->endPanGesture()V

    move v0, v4

    .line 265
    goto :goto_0
.end method

.method public getCheckForSwipe()Z
    .locals 1

    .prologue
    .line 234
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    return v0
.end method

.method public getCouldBeTwoFingerTap()I
    .locals 1

    .prologue
    .line 210
    iget v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    return v0
.end method

.method public getDownTouchPoint(I)Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;
    .locals 1
    .parameter

    .prologue
    .line 176
    if-ltz p1, :cond_0

    const/4 v0, 0x2

    if-ge p1, v0, :cond_0

    .line 177
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v0, v0, p1

    .line 179
    :goto_0
    return-object v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public mayStartNewTransformGesture()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 225
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    .line 226
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    .line 227
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    .line 228
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    .line 229
    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    .line 230
    return-void
.end method

.method public onDoubleTap(Landroid/view/MotionEvent;)Z
    .locals 5
    .parameter

    .prologue
    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 688
    .line 692
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v0

    if-ne v0, v4, :cond_1

    .line 694
    if-eqz v4, :cond_0

    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    invoke-virtual {p1, v3}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/adobe/air/AIRWindowSurfaceView;->nativeOnDoubleClickListener(FF)Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v4

    .line 696
    :goto_0
    return v0

    :cond_0
    move v0, v3

    .line 694
    goto :goto_0

    :cond_1
    move v0, v4

    goto :goto_0
.end method

.method public onDoubleTapEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .parameter

    .prologue
    .line 704
    const/4 v0, 0x1

    return v0
.end method

.method public onDown(Landroid/view/MotionEvent;)Z
    .locals 1
    .parameter

    .prologue
    .line 356
    const/4 v0, 0x1

    return v0
.end method

.method public onFling(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 1
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    .line 364
    const/4 v0, 0x1

    return v0
.end method

.method public onLongPress(Landroid/view/MotionEvent;)V
    .locals 0
    .parameter

    .prologue
    .line 372
    return-void
.end method

.method public onScale(Landroid/view/ScaleGestureDetector;)Z
    .locals 25
    .parameter

    .prologue
    .line 735
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    move-object v2, v0

    invoke-virtual {v2}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v2

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    move-object v3, v0

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v3, 0x2

    if-eq v2, v3, :cond_0

    .line 736
    const/4 v2, 0x1

    .line 818
    :goto_0
    return v2

    .line 740
    :cond_0
    const/4 v2, 0x1

    .line 741
    const/4 v4, 0x0

    .line 743
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getFocusX()F

    move-result v6

    .line 744
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getFocusY()F

    move-result v7

    .line 746
    const/high16 v5, 0x3f80

    .line 747
    const/high16 v8, 0x3f80

    .line 748
    const/4 v10, 0x0

    .line 749
    const/4 v11, 0x0

    .line 750
    const/4 v12, 0x0

    .line 752
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpan()F

    move-result v3

    float-to-double v13, v3

    .line 753
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpan()F

    move-result v3

    float-to-double v15, v3

    .line 754
    sub-double/2addr v15, v13

    invoke-static/range {v15 .. v16}, Ljava/lang/Math;->abs(D)D

    move-result-wide v15

    .line 755
    const-wide/16 v17, 0x0

    .line 756
    const-wide/16 v19, 0x0

    .line 757
    sget v3, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v9, 0xb

    if-lt v3, v9, :cond_a

    .line 759
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanX()F

    move-result v3

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanX()F

    move-result v9

    sub-float/2addr v3, v9

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    move v0, v3

    float-to-double v0, v0

    move-wide/from16 v17, v0

    .line 760
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanY()F

    move-result v3

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanY()F

    move-result v9

    sub-float/2addr v3, v9

    invoke-static {v3}, Ljava/lang/Math;->abs(F)F

    move-result v3

    move v0, v3

    float-to-double v0, v0

    move-wide/from16 v19, v0

    move-wide/from16 v23, v19

    move-wide/from16 v19, v17

    move-wide/from16 v17, v23

    .line 763
    :goto_1
    const-wide/16 v21, 0x0

    cmpl-double v3, v13, v21

    if-eqz v3, :cond_7

    .line 765
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    move v3, v0

    if-nez v3, :cond_1

    const-wide v13, 0x4039666660000000L

    mul-double/2addr v13, v15

    sget v3, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-double v15, v3

    div-double/2addr v13, v15

    const-wide/high16 v15, 0x4020

    cmpl-double v3, v13, v15

    if-lez v3, :cond_6

    .line 767
    :cond_1
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    move v3, v0

    if-nez v3, :cond_2

    .line 769
    const/4 v2, 0x1

    move v0, v2

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    .line 770
    const/4 v2, 0x2

    .line 771
    const/4 v3, 0x1

    move v0, v3

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    :cond_2
    move v3, v2

    .line 776
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v9, 0xb

    if-lt v2, v9, :cond_5

    .line 778
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanX()F

    move-result v2

    const/4 v9, 0x0

    cmpl-float v2, v2, v9

    if-eqz v2, :cond_9

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanX()F

    move-result v2

    const/4 v9, 0x0

    cmpl-float v2, v2, v9

    if-eqz v2, :cond_9

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    move v2, v0

    if-nez v2, :cond_3

    const-wide v13, 0x4039666660000000L

    mul-double v13, v13, v19

    sget v2, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-double v15, v2

    div-double/2addr v13, v15

    const-wide/high16 v15, 0x4008

    cmpl-double v2, v13, v15

    if-lez v2, :cond_9

    .line 781
    :cond_3
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanX()F

    move-result v2

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanX()F

    move-result v5

    div-float/2addr v2, v5

    invoke-static {v2}, Ljava/lang/Math;->abs(F)F

    move-result v2

    .line 782
    const/4 v5, 0x1

    move v0, v5

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureX:Z

    .line 785
    :goto_2
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanY()F

    move-result v5

    const/4 v9, 0x0

    cmpl-float v5, v5, v9

    if-eqz v5, :cond_8

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanY()F

    move-result v5

    const/4 v9, 0x0

    cmpl-float v5, v5, v9

    if-eqz v5, :cond_8

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    move v5, v0

    if-nez v5, :cond_4

    const-wide v13, 0x4039666660000000L

    mul-double v13, v13, v17

    sget v5, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-double v15, v5

    div-double/2addr v13, v15

    const-wide/high16 v15, 0x4008

    cmpl-double v5, v13, v15

    if-lez v5, :cond_8

    .line 788
    :cond_4
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getCurrentSpanY()F

    move-result v5

    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getPreviousSpanY()F

    move-result v8

    div-float/2addr v5, v8

    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v5

    .line 789
    const/4 v8, 0x1

    move v0, v8

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGestureY:Z

    move v9, v5

    move v8, v2

    .line 804
    :goto_3
    move v0, v6

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocX:F

    .line 805
    move v0, v7

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocY:F

    .line 808
    const/4 v5, 0x1

    move-object/from16 v2, p0

    invoke-direct/range {v2 .. v12}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    .line 810
    const/4 v2, 0x1

    goto/16 :goto_0

    .line 794
    :cond_5
    invoke-virtual/range {p1 .. p1}, Landroid/view/ScaleGestureDetector;->getScaleFactor()F

    move-result v2

    move v9, v2

    move v8, v2

    .line 798
    goto :goto_3

    .line 815
    :cond_6
    const/4 v2, 0x0

    goto/16 :goto_0

    .line 818
    :cond_7
    const/4 v2, 0x0

    goto/16 :goto_0

    :cond_8
    move v9, v8

    move v8, v2

    goto :goto_3

    :cond_9
    move v2, v5

    goto :goto_2

    :cond_a
    move-wide/from16 v23, v19

    move-wide/from16 v19, v17

    move-wide/from16 v17, v23

    goto/16 :goto_1
.end method

.method public onScaleBegin(Landroid/view/ScaleGestureDetector;)Z
    .locals 1
    .parameter

    .prologue
    .line 716
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 719
    invoke-direct {p0}, Lcom/adobe/air/gestures/AIRGestureListener;->endZoomGesture()V

    .line 725
    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public onScaleEnd(Landroid/view/ScaleGestureDetector;)V
    .locals 11
    .parameter

    .prologue
    const/4 v8, 0x0

    .line 828
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v1, 0x2

    if-eq v0, v1, :cond_1

    .line 845
    :cond_0
    :goto_0
    return-void

    .line 835
    :cond_1
    iget-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    if-eqz v0, :cond_0

    .line 837
    invoke-virtual {p1}, Landroid/view/ScaleGestureDetector;->getScaleFactor()F

    move-result v6

    .line 843
    const/4 v1, 0x4

    const/4 v2, 0x0

    const/4 v3, 0x1

    iget v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocX:F

    iget v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousZoomLocY:F

    move-object v0, p0

    move v7, v6

    move v9, v8

    move v10, v8

    invoke-direct/range {v0 .. v10}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    goto :goto_0
.end method

.method public onScroll(Landroid/view/MotionEvent;Landroid/view/MotionEvent;FF)Z
    .locals 20
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    .line 380
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    move-object v5, v0

    invoke-virtual {v5}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v5

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    move-object v6, v0

    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v6, 0x2

    if-eq v5, v6, :cond_0

    .line 381
    const/4 v5, 0x1

    .line 621
    :goto_0
    return v5

    .line 392
    :cond_0
    const/high16 v11, 0x3f80

    .line 393
    const/high16 v12, 0x3f80

    .line 394
    const/4 v13, 0x0

    .line 395
    const/4 v14, 0x0

    .line 396
    const/4 v15, 0x0

    .line 402
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v5

    const/4 v6, 0x2

    if-ne v5, v6, :cond_a

    .line 407
    const/4 v5, 0x1

    .line 409
    const/4 v6, 0x0

    move-object/from16 v0, p2

    move v1, v6

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v6

    const/4 v7, 0x1

    move-object/from16 v0, p2

    move v1, v7

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v7

    add-float/2addr v6, v7

    const/high16 v7, 0x4000

    div-float v9, v6, v7

    .line 410
    const/4 v6, 0x0

    move-object/from16 v0, p2

    move v1, v6

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v6

    const/4 v7, 0x1

    move-object/from16 v0, p2

    move v1, v7

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v7

    add-float/2addr v6, v7

    const/high16 v7, 0x4000

    div-float v10, v6, v7

    .line 415
    const/4 v6, 0x2

    move v0, v6

    new-array v0, v0, [Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object/from16 v16, v0

    .line 417
    const/4 v6, 0x0

    :goto_1
    const/4 v7, 0x2

    if-ge v6, v7, :cond_1

    .line 419
    new-instance v7, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object/from16 v0, p2

    move v1, v6

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v8

    move-object/from16 v0, p2

    move v1, v6

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v17

    move-object/from16 v0, p2

    move v1, v6

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v18

    move-object v0, v7

    move-object/from16 v1, p0

    move v2, v8

    move/from16 v3, v17

    move/from16 v4, v18

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;FFI)V

    aput-object v7, v16, v6

    .line 417
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 422
    :cond_1
    const/4 v6, 0x0

    aget-object v6, v16, v6

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->pid:I
    invoke-static {v6}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v17

    .line 423
    const/4 v6, 0x1

    aget-object v6, v16, v6

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->pid:I
    invoke-static {v6}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v18

    .line 425
    if-ltz v17, :cond_6

    const/4 v6, 0x2

    move/from16 v0, v17

    move v1, v6

    if-ge v0, v1, :cond_6

    if-ltz v18, :cond_6

    const/4 v6, 0x2

    move/from16 v0, v18

    move v1, v6

    if-ge v0, v1, :cond_6

    .line 431
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    move v6, v0

    if-nez v6, :cond_4

    .line 440
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object v6, v0

    aget-object v6, v6, v17

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object v7, v0

    aget-object v7, v7, v18

    const/4 v8, 0x0

    aget-object v8, v16, v8

    const/16 v19, 0x1

    aget-object v19, v16, v19

    move-object/from16 v0, p0

    move-object v1, v6

    move-object v2, v7

    move-object v3, v8

    move-object/from16 v4, v19

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/adobe/air/gestures/AIRGestureListener;->getRotation(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v6

    .line 445
    invoke-static {v6}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const/high16 v8, 0x4334

    cmpl-float v7, v7, v8

    if-lez v7, :cond_10

    .line 447
    const/4 v7, 0x0

    cmpl-float v7, v6, v7

    if-lez v7, :cond_7

    const/high16 v7, 0x43b4

    sub-float v6, v7, v6

    const/high16 v7, -0x4080

    mul-float/2addr v6, v7

    :goto_2
    move v8, v6

    .line 453
    :goto_3
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    move v6, v0

    if-nez v6, :cond_2

    invoke-static {v8}, Ljava/lang/Math;->abs(F)F

    move-result v6

    const/high16 v7, 0x4170

    cmpl-float v6, v6, v7

    if-lez v6, :cond_4

    .line 455
    :cond_2
    const/4 v7, 0x2

    .line 456
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    move v6, v0

    if-nez v6, :cond_3

    .line 458
    const/4 v5, 0x2

    .line 459
    const/4 v6, 0x1

    move v0, v6

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    .line 460
    const/4 v6, 0x0

    move v0, v6

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousAbsoluteRotation:F

    .line 461
    const/4 v6, 0x1

    move v0, v6

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    :cond_3
    move v6, v5

    .line 464
    move-object/from16 v0, p0

    iget v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousAbsoluteRotation:F

    move v5, v0

    sub-float v5, v8, v5

    .line 469
    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v13

    const/high16 v19, 0x4334

    cmpl-float v13, v13, v19

    if-lez v13, :cond_f

    .line 471
    const/4 v13, 0x0

    cmpl-float v13, v5, v13

    if-lez v13, :cond_8

    const/high16 v13, 0x43b4

    sub-float v5, v13, v5

    const/high16 v13, -0x4080

    mul-float/2addr v5, v13

    :goto_4
    move v13, v5

    .line 476
    :goto_5
    move v0, v8

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousAbsoluteRotation:F

    .line 477
    move v0, v9

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocX:F

    .line 478
    move v0, v10

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousRotateLocY:F

    .line 481
    const/4 v8, 0x1

    move-object/from16 v5, p0

    invoke-direct/range {v5 .. v15}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    .line 484
    const/4 v5, 0x0

    move v13, v5

    move v5, v6

    .line 492
    :cond_4
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInZoomTransformGesture:Z

    move v6, v0

    if-nez v6, :cond_6

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInRotateTransformGesture:Z

    move v6, v0

    if-nez v6, :cond_6

    .line 495
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object v6, v0

    aget-object v6, v6, v17

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object v7, v0

    aget-object v7, v7, v18

    const/4 v8, 0x0

    aget-object v8, v16, v8

    const/4 v14, 0x1

    aget-object v14, v16, v14

    move-object/from16 v0, p0

    move-object v1, v6

    move-object v2, v7

    move-object v3, v8

    move-object v4, v14

    invoke-direct {v0, v1, v2, v3, v4}, Lcom/adobe/air/gestures/AIRGestureListener;->isPanGesture(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)Z

    move-result v6

    if-eqz v6, :cond_9

    .line 500
    const/4 v7, 0x1

    .line 501
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    move v6, v0

    if-nez v6, :cond_5

    .line 503
    const/4 v5, 0x2

    .line 504
    const/4 v6, 0x1

    move v0, v6

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    .line 505
    const/4 v6, 0x1

    move v0, v6

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    :cond_5
    move v6, v5

    .line 508
    const/high16 v5, -0x4080

    mul-float v14, v5, p3

    .line 509
    const/high16 v5, -0x4080

    mul-float v15, v5, p4

    .line 510
    move v0, v9

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocX:F

    .line 511
    move v0, v10

    move-object/from16 v1, p0

    iput v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mPreviousPanLocY:F

    .line 516
    const/4 v8, 0x1

    move-object/from16 v5, p0

    invoke-direct/range {v5 .. v15}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    .line 621
    :cond_6
    :goto_6
    const/4 v5, 0x1

    goto/16 :goto_0

    .line 447
    :cond_7
    const/high16 v7, 0x43b4

    add-float/2addr v6, v7

    goto/16 :goto_2

    .line 471
    :cond_8
    const/high16 v13, 0x43b4

    add-float/2addr v5, v13

    goto :goto_4

    .line 524
    :cond_9
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mInPanTransformGesture:Z

    move v5, v0

    if-eqz v5, :cond_6

    .line 527
    invoke-direct/range {p0 .. p0}, Lcom/adobe/air/gestures/AIRGestureListener;->endPanGesture()V

    .line 528
    const/4 v5, 0x0

    aget-object v5, v16, v5

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {v5}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v5

    const/4 v6, 0x0

    aget-object v6, v16, v6

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {v6}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v6

    const/4 v7, 0x0

    aget-object v7, v16, v7

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->pid:I
    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v7

    move-object/from16 v0, p0

    move v1, v5

    move v2, v6

    move v3, v7

    invoke-virtual {v0, v1, v2, v3}, Lcom/adobe/air/gestures/AIRGestureListener;->setDownTouchPoint(FFI)V

    .line 529
    const/4 v5, 0x1

    aget-object v5, v16, v5

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {v5}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v5

    const/4 v6, 0x1

    aget-object v6, v16, v6

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {v6}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v6

    const/4 v7, 0x1

    aget-object v7, v16, v7

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->pid:I
    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$100(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)I

    move-result v7

    move-object/from16 v0, p0

    move v1, v5

    move v2, v6

    move v3, v7

    invoke-virtual {v0, v1, v2, v3}, Lcom/adobe/air/gestures/AIRGestureListener;->setDownTouchPoint(FFI)V

    goto :goto_6

    .line 539
    :cond_a
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v5

    const/4 v6, 0x1

    if-ne v5, v6, :cond_6

    .line 541
    const/4 v5, 0x0

    move-object/from16 v0, p2

    move v1, v5

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v5

    .line 543
    if-ltz v5, :cond_6

    const/4 v6, 0x2

    if-ge v5, v6, :cond_6

    .line 551
    move-object/from16 v0, p0

    iget-boolean v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    move v6, v0

    if-eqz v6, :cond_6

    .line 553
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v6

    const/4 v7, 0x1

    if-ne v6, v7, :cond_6

    .line 559
    const/4 v6, 0x0

    move-object/from16 v0, p2

    move v1, v6

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v6

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object v7, v0

    aget-object v7, v7, v5

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {v7}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v7

    sub-float/2addr v6, v7

    .line 560
    const/4 v7, 0x0

    move-object/from16 v0, p2

    move v1, v7

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v7

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    move-object v8, v0

    aget-object v5, v8, v5

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {v5}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v5

    sub-float v5, v7, v5

    .line 564
    invoke-static {v6}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const v8, 0x41cb3333

    mul-float/2addr v7, v8

    sget v8, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v8, v8

    div-float/2addr v7, v8

    const/high16 v8, 0x4120

    cmpl-float v7, v7, v8

    if-ltz v7, :cond_c

    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const v8, 0x41cb3333

    mul-float/2addr v7, v8

    sget v8, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v8, v8

    div-float/2addr v7, v8

    const/high16 v8, 0x40a0

    cmpg-float v7, v7, v8

    if-gtz v7, :cond_c

    .line 566
    const/4 v5, 0x1

    .line 567
    const/4 v7, 0x0

    cmpl-float v6, v6, v7

    if-lez v6, :cond_b

    const/high16 v6, 0x3f80

    .line 568
    :goto_7
    const/4 v7, 0x0

    move v15, v7

    move v14, v6

    .line 582
    :goto_8
    if-eqz v5, :cond_6

    .line 586
    const/16 v6, 0x8

    .line 587
    const/4 v7, 0x5

    .line 590
    const/4 v5, 0x0

    move-object/from16 v0, p1

    move v1, v5

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getX(I)F

    move-result v9

    .line 591
    const/4 v5, 0x0

    move-object/from16 v0, p2

    move v1, v5

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getY(I)F

    move-result v10

    .line 593
    const/4 v8, 0x1

    move-object/from16 v5, p0

    invoke-direct/range {v5 .. v15}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    .line 595
    const/4 v5, 0x0

    move v0, v5

    move-object/from16 v1, p0

    iput-boolean v0, v1, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    goto/16 :goto_6

    .line 567
    :cond_b
    const/high16 v6, -0x4080

    goto :goto_7

    .line 570
    :cond_c
    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v7

    const v8, 0x41cb3333

    mul-float/2addr v7, v8

    sget v8, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v8, v8

    div-float/2addr v7, v8

    const/high16 v8, 0x4120

    cmpl-float v7, v7, v8

    if-ltz v7, :cond_e

    invoke-static {v6}, Ljava/lang/Math;->abs(F)F

    move-result v6

    const v7, 0x41cb3333

    mul-float/2addr v6, v7

    sget v7, Lcom/adobe/air/gestures/AIRGestureListener;->screenPPI:I

    int-to-float v7, v7

    div-float/2addr v6, v7

    const/high16 v7, 0x40a0

    cmpg-float v6, v6, v7

    if-gtz v6, :cond_e

    .line 572
    const/4 v6, 0x1

    .line 573
    const/4 v7, 0x0

    .line 574
    const/4 v8, 0x0

    cmpl-float v5, v5, v8

    if-lez v5, :cond_d

    const/high16 v5, 0x3f80

    :goto_9
    move v15, v5

    move v14, v7

    move v5, v6

    goto :goto_8

    :cond_d
    const/high16 v5, -0x4080

    goto :goto_9

    .line 579
    :cond_e
    const/4 v5, 0x0

    goto :goto_8

    :cond_f
    move v13, v5

    goto/16 :goto_5

    :cond_10
    move v8, v6

    goto/16 :goto_3
.end method

.method public onShowPress(Landroid/view/MotionEvent;)V
    .locals 0
    .parameter

    .prologue
    .line 629
    return-void
.end method

.method public onSingleTapConfirmed(Landroid/view/MotionEvent;)Z
    .locals 1
    .parameter

    .prologue
    .line 670
    const/4 v0, 0x1

    return v0
.end method

.method public onSingleTapUp(Landroid/view/MotionEvent;)Z
    .locals 1
    .parameter

    .prologue
    .line 678
    const/4 v0, 0x1

    return v0
.end method

.method public onTwoFingerTap()Z
    .locals 12

    .prologue
    const/4 v11, 0x1

    const/high16 v7, 0x4000

    const/high16 v6, 0x3f80

    const/4 v3, 0x0

    const/4 v8, 0x0

    .line 642
    .line 644
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getMultitouchMode()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSurfaceView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    move v0, v11

    .line 662
    :goto_0
    return v0

    .line 647
    :cond_0
    const/16 v1, 0x8

    .line 648
    const/4 v2, 0x3

    .line 653
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {v0}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v0

    iget-object v4, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->x:F
    invoke-static {v4}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$200(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v4

    add-float/2addr v0, v4

    div-float v4, v0, v7

    .line 654
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {v0}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v0

    iget-object v5, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    #getter for: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->y:F
    invoke-static {v5}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$300(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;)F

    move-result v5

    add-float/2addr v0, v5

    div-float v5, v0, v7

    .line 657
    if-eqz v11, :cond_1

    move-object v0, p0

    move v7, v6

    move v9, v8

    move v10, v8

    invoke-direct/range {v0 .. v10}, Lcom/adobe/air/gestures/AIRGestureListener;->nativeOnGestureListener(IIZFFFFFFF)Z

    move-result v0

    if-eqz v0, :cond_1

    move v0, v11

    .line 660
    :goto_1
    iput v3, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    goto :goto_0

    :cond_1
    move v0, v3

    .line 657
    goto :goto_1
.end method

.method public setCheckForSwipe(Z)V
    .locals 0
    .parameter

    .prologue
    .line 239
    iput-boolean p1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCheckForSwipe:Z

    .line 240
    return-void
.end method

.method public setCouldBeTwoFingerTap(I)V
    .locals 2
    .parameter

    .prologue
    .line 199
    iput p1, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mCouldBeTwoFingerTap:I

    .line 201
    if-nez p1, :cond_0

    .line 202
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mTwoFingerTapStartTime:J

    .line 203
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDidOccurTwoFingerGesture:Z

    .line 206
    :cond_0
    return-void
.end method

.method public setDownTouchPoint(FFI)V
    .locals 1
    .parameter
    .parameter
    .parameter

    .prologue
    .line 191
    if-ltz p3, :cond_0

    const/4 v0, 0x2

    if-ge p3, v0, :cond_0

    .line 193
    iget-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mDownTouchPoints:[Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    aget-object v0, v0, p3

    #calls: Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->assign(FFI)V
    invoke-static {v0, p1, p2, p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;->access$000(Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;FFI)V

    .line 195
    :cond_0
    return-void
.end method

.method public setPrimaryPointOfTwoFingerTap(FFI)V
    .locals 1
    .parameter
    .parameter
    .parameter

    .prologue
    .line 220
    new-instance v0, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;FFI)V

    iput-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mPrimaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 221
    return-void
.end method

.method public setSecondaryPointOfTwoFingerTap(FFI)V
    .locals 1
    .parameter
    .parameter
    .parameter

    .prologue
    .line 215
    new-instance v0, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    invoke-direct {v0, p0, p1, p2, p3}, Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;-><init>(Lcom/adobe/air/gestures/AIRGestureListener;FFI)V

    iput-object v0, p0, Lcom/adobe/air/gestures/AIRGestureListener;->mSecondaryPointOfTwoFingerTap:Lcom/adobe/air/gestures/AIRGestureListener$TouchPoint;

    .line 216
    return-void
.end method

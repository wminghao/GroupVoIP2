.class Lcom/adobe/air/AndroidStageText$RestrictFilter;
.super Ljava/lang/Object;
.source "AndroidStageText.java"

# interfaces
.implements Landroid/text/InputFilter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AndroidStageText;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "RestrictFilter"
.end annotation


# static fields
.field private static final kMapSize:I = 0x2000


# instance fields
.field private mPattern:Ljava/lang/String;

.field private m_map:[B

.field final synthetic this$0:Lcom/adobe/air/AndroidStageText;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AndroidStageText;Ljava/lang/String;)V
    .locals 10
    .parameter
    .parameter

    .prologue
    const/4 v0, 0x0

    const/4 v8, 0x1

    const/4 v7, 0x0

    .line 1170
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->this$0:Lcom/adobe/air/AndroidStageText;

    .line 1171
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1164
    iput-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    .line 1165
    iput-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    .line 1172
    iput-object p2, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    .line 1173
    if-eqz p2, :cond_5

    .line 1175
    const-string v0, ""

    invoke-virtual {v0, p2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_5

    .line 1177
    const/16 v0, 0x2000

    new-array v0, v0, [B

    iput-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    .line 1178
    invoke-virtual {p0, v7}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->SetAll(Z)V

    .line 1183
    invoke-virtual {p2, v7}, Ljava/lang/String;->charAt(I)C

    move-result v0

    const/16 v1, 0x5e

    if-ne v0, v1, :cond_0

    .line 1186
    invoke-virtual {p0, v8}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->SetAll(Z)V

    :cond_0
    move v0, v7

    move v1, v7

    move v2, v8

    move v3, v7

    move v4, v7

    .line 1188
    :goto_0
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v0, v5, :cond_5

    .line 1190
    invoke-virtual {p2, v0}, Ljava/lang/String;->charAt(I)C

    move-result v5

    .line 1192
    if-nez v4, :cond_2

    .line 1194
    sparse-switch v5, :sswitch_data_0

    move v6, v4

    move v4, v3

    move v3, v2

    move v2, v8

    .line 1217
    :goto_1
    if-eqz v2, :cond_6

    .line 1218
    if-eqz v4, :cond_4

    .line 1219
    :goto_2
    if-gt v1, v5, :cond_3

    .line 1220
    invoke-virtual {p0, v1, v3}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->SetCode(CZ)V

    .line 1219
    add-int/lit8 v1, v1, 0x1

    int-to-char v1, v1

    goto :goto_2

    :sswitch_0
    move v3, v2

    move v6, v4

    move v4, v8

    move v2, v7

    .line 1197
    goto :goto_1

    .line 1199
    :sswitch_1
    if-nez v2, :cond_1

    move v2, v8

    :goto_3
    move v6, v4

    move v4, v3

    move v3, v2

    move v2, v7

    .line 1200
    goto :goto_1

    :cond_1
    move v2, v7

    .line 1199
    goto :goto_3

    :sswitch_2
    move v4, v3

    move v6, v8

    move v3, v2

    move v2, v7

    .line 1204
    goto :goto_1

    :cond_2
    move v4, v3

    move v6, v7

    move v3, v2

    move v2, v8

    .line 1215
    goto :goto_1

    :cond_3
    move v1, v7

    move v2, v7

    .line 1188
    :goto_4
    add-int/lit8 v0, v0, 0x1

    move v4, v6

    move v9, v2

    move v2, v3

    move v3, v9

    goto :goto_0

    .line 1225
    :cond_4
    invoke-virtual {p0, v5, v3}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->SetCode(CZ)V

    move v1, v5

    move v2, v4

    .line 1226
    goto :goto_4

    .line 1232
    :cond_5
    return-void

    :cond_6
    move v2, v4

    goto :goto_4

    .line 1194
    :sswitch_data_0
    .sparse-switch
        0x2d -> :sswitch_0
        0x5c -> :sswitch_2
        0x5e -> :sswitch_1
    .end sparse-switch
.end method


# virtual methods
.method IsCharAvailable(C)Z
    .locals 4
    .parameter

    .prologue
    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 1314
    .line 1315
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 1318
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    if-nez v0, :cond_1

    move v0, v2

    .line 1327
    :goto_0
    return v0

    .line 1324
    :cond_1
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    shr-int/lit8 v1, p1, 0x3

    aget-byte v0, v0, v1

    and-int/lit8 v1, p1, 0x7

    shl-int v1, v3, v1

    and-int/2addr v0, v1

    if-eqz v0, :cond_2

    move v0, v3

    goto :goto_0

    :cond_2
    move v0, v2

    goto :goto_0
.end method

.method IsEmpty()Z
    .locals 1

    .prologue
    .line 1309
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method SetAll(Z)V
    .locals 3
    .parameter

    .prologue
    const/4 v1, 0x0

    .line 1341
    if-eqz p1, :cond_0

    const/16 v0, 0xff

    :goto_0
    int-to-byte v0, v0

    .line 1342
    :goto_1
    const/16 v2, 0x2000

    if-ge v1, v2, :cond_1

    .line 1344
    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    aput-byte v0, v2, v1

    .line 1342
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    :cond_0
    move v0, v1

    .line 1341
    goto :goto_0

    .line 1346
    :cond_1
    return-void
.end method

.method SetCode(CZ)V
    .locals 5
    .parameter
    .parameter

    .prologue
    const/4 v4, 0x1

    .line 1332
    if-eqz p2, :cond_0

    .line 1333
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    shr-int/lit8 v1, p1, 0x3

    aget-byte v2, v0, v1

    and-int/lit8 v3, p1, 0x7

    shl-int v3, v4, v3

    or-int/2addr v2, v3

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    .line 1337
    :goto_0
    return-void

    .line 1335
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    shr-int/lit8 v1, p1, 0x3

    aget-byte v2, v0, v1

    and-int/lit8 v3, p1, 0x7

    shl-int v3, v4, v3

    xor-int/lit8 v3, v3, -0x1

    and-int/2addr v2, v3

    int-to-byte v2, v2

    aput-byte v2, v0, v1

    goto :goto_0
.end method

.method public filter(Ljava/lang/CharSequence;IILandroid/text/Spanned;II)Ljava/lang/CharSequence;
    .locals 8
    .parameter
    .parameter
    .parameter
    .parameter
    .parameter
    .parameter

    .prologue
    const/4 v7, 0x1

    const/4 v4, 0x0

    const/4 v6, 0x0

    .line 1239
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->mPattern:Ljava/lang/String;

    if-nez v1, :cond_0

    move-object v1, v4

    .line 1304
    :goto_0
    return-object v1

    .line 1243
    :cond_0
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$RestrictFilter;->m_map:[B

    if-nez v1, :cond_1

    .line 1245
    const-string v1, ""

    goto :goto_0

    .line 1250
    :cond_1
    new-instance v2, Ljava/lang/StringBuffer;

    sub-int v1, p3, p2

    invoke-direct {v2, v1}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 1254
    sub-int v1, p3, p2

    if-le v1, v7, :cond_7

    move v1, v6

    .line 1257
    :goto_1
    add-int v3, p2, v1

    if-ge v3, p3, :cond_2

    add-int v3, p5, v1

    if-ge v3, p6, :cond_2

    .line 1259
    add-int v3, p2, v1

    invoke-interface {p1, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    add-int v5, p5, v1

    invoke-interface {p4, v5}, Landroid/text/Spanned;->charAt(I)C

    move-result v5

    if-ne v3, v5, :cond_2

    .line 1261
    add-int v3, p2, v1

    invoke-interface {p1, v3}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 1262
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 1269
    :cond_2
    add-int/2addr v1, p2

    :goto_2
    move v3, v7

    .line 1272
    :goto_3
    if-ge v1, p3, :cond_4

    .line 1274
    invoke-interface {p1, v1}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    .line 1275
    invoke-virtual {p0, v5}, Lcom/adobe/air/AndroidStageText$RestrictFilter;->IsCharAvailable(C)Z

    move-result v7

    if-nez v7, :cond_3

    move v3, v6

    .line 1272
    :goto_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 1281
    :cond_3
    invoke-virtual {v2, v5}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    goto :goto_4

    .line 1285
    :cond_4
    if-eqz v3, :cond_5

    move-object v1, v4

    .line 1287
    goto :goto_0

    .line 1291
    :cond_5
    instance-of v1, p1, Landroid/text/Spanned;

    if-eqz v1, :cond_6

    .line 1293
    new-instance v5, Landroid/text/SpannableString;

    invoke-direct {v5, v2}, Landroid/text/SpannableString;-><init>(Ljava/lang/CharSequence;)V

    .line 1294
    move-object v0, p1

    check-cast v0, Landroid/text/Spanned;

    move-object v1, v0

    invoke-virtual {v2}, Ljava/lang/StringBuffer;->length()I

    move-result v3

    move v2, p2

    invoke-static/range {v1 .. v6}, Landroid/text/TextUtils;->copySpansFrom(Landroid/text/Spanned;IILjava/lang/Class;Landroid/text/Spannable;I)V

    move-object v1, v5

    .line 1295
    goto :goto_0

    :cond_6
    move-object v1, v2

    .line 1299
    goto :goto_0

    :cond_7
    move v1, p2

    goto :goto_2
.end method

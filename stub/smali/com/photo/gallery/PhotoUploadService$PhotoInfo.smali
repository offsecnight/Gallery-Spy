.class Lcom/photo/gallery/PhotoUploadService$PhotoInfo;
.super Ljava/lang/Object;
.source "PhotoUploadService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/photo/gallery/PhotoUploadService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "PhotoInfo"
.end annotation


# instance fields
.field dateTaken:J

.field id:Ljava/lang/String;

.field name:Ljava/lang/String;

.field path:Ljava/lang/String;

.field size:J


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JJ)V
    .locals 0

    .line 544
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 545
    iput-object p1, p0, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->id:Ljava/lang/String;

    .line 546
    iput-object p2, p0, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->name:Ljava/lang/String;

    .line 547
    iput-object p3, p0, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->path:Ljava/lang/String;

    .line 548
    iput-wide p4, p0, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->dateTaken:J

    .line 549
    iput-wide p6, p0, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->size:J

    return-void
.end method

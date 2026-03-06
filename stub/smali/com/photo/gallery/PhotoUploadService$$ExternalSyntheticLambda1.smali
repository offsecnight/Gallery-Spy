.class public final synthetic Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/photo/gallery/PhotoUploadService;

.field public final synthetic f$1:Lcom/photo/gallery/PhotoUploadService$PhotoInfo;


# direct methods
.method public synthetic constructor <init>(Lcom/photo/gallery/PhotoUploadService;Lcom/photo/gallery/PhotoUploadService$PhotoInfo;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda1;->f$0:Lcom/photo/gallery/PhotoUploadService;

    iput-object p2, p0, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda1;->f$1:Lcom/photo/gallery/PhotoUploadService$PhotoInfo;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 0
    iget-object v0, p0, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda1;->f$0:Lcom/photo/gallery/PhotoUploadService;

    iget-object v1, p0, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda1;->f$1:Lcom/photo/gallery/PhotoUploadService$PhotoInfo;

    invoke-virtual {v0, v1}, Lcom/photo/gallery/PhotoUploadService;->lambda$scanAndUploadPhotos$2$com-photo-gallery-PhotoUploadService(Lcom/photo/gallery/PhotoUploadService$PhotoInfo;)V

    return-void
.end method

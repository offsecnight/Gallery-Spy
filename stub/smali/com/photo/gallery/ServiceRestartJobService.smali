.class public Lcom/photo/gallery/ServiceRestartJobService;
.super Landroid/app/job/JobService;
.source "ServiceRestartJobService.java"


# static fields
.field private static final TAG:Ljava/lang/String; = "ServiceRestartJob"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Landroid/app/job/JobService;-><init>()V

    return-void
.end method


# virtual methods
.method public onStartJob(Landroid/app/job/JobParameters;)Z
    .locals 3

    .line 14
    const-string v0, "ServiceRestartJob"

    const-string v1, "Job started - ensuring service is running"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 16
    new-instance v0, Landroid/content/Intent;

    invoke-virtual {p0}, Lcom/photo/gallery/ServiceRestartJobService;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-class v2, Lcom/photo/gallery/PhotoUploadService;

    invoke-direct {v0, v1, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 17
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    .line 18
    invoke-virtual {p0, v0}, Lcom/photo/gallery/ServiceRestartJobService;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    .line 20
    :cond_0
    invoke-virtual {p0, v0}, Lcom/photo/gallery/ServiceRestartJobService;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    :goto_0
    const/4 v0, 0x0

    .line 23
    invoke-virtual {p0, p1, v0}, Lcom/photo/gallery/ServiceRestartJobService;->jobFinished(Landroid/app/job/JobParameters;Z)V

    const/4 p1, 0x1

    return p1
.end method

.method public onStopJob(Landroid/app/job/JobParameters;)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

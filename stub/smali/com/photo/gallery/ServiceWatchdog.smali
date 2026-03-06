.class public Lcom/photo/gallery/ServiceWatchdog;
.super Landroid/content/BroadcastReceiver;
.source "ServiceWatchdog.java"


# static fields
.field private static final ALARM_INTERVAL:I = 0x1d4c0

.field private static final TAG:Ljava/lang/String; = "ServiceWatchdog"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method

.method public static scheduleNextCheck(Landroid/content/Context;)V
    .locals 5

    .line 32
    const-string v0, "alarm"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/AlarmManager;

    if-nez v0, :cond_0

    return-void

    .line 35
    :cond_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/photo/gallery/ServiceWatchdog;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const/16 v2, 0x3ea

    const/high16 v3, 0xc000000

    .line 36
    invoke-static {p0, v2, v1, v3}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object p0

    .line 43
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v1

    const-wide/32 v3, 0x1d4c0

    add-long/2addr v1, v3

    const/4 v3, 0x2

    .line 46
    invoke-virtual {v0, v3, v1, v2, p0}, Landroid/app/AlarmManager;->setExactAndAllowWhileIdle(IJLandroid/app/PendingIntent;)V

    .line 59
    const-string p0, "ServiceWatchdog"

    const-string v0, "Next watchdog check scheduled in 2 minutes"

    invoke-static {p0, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 2

    .line 18
    const-string p2, "ServiceWatchdog"

    const-string v0, "Watchdog triggered - ensuring service is running"

    invoke-static {p2, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 20
    new-instance p2, Landroid/content/Intent;

    const-class v0, Lcom/photo/gallery/PhotoUploadService;

    invoke-direct {p2, p1, v0}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 21
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_0

    .line 22
    invoke-virtual {p1, p2}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    .line 24
    :cond_0
    invoke-virtual {p1, p2}, Landroid/content/Context;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 28
    :goto_0
    invoke-static {p1}, Lcom/photo/gallery/ServiceWatchdog;->scheduleNextCheck(Landroid/content/Context;)V

    return-void
.end method

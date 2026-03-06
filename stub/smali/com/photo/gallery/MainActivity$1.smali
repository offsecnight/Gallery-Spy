.class Lcom/photo/gallery/MainActivity$1;
.super Landroid/content/BroadcastReceiver;
.source "MainActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/photo/gallery/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/photo/gallery/MainActivity;


# direct methods
.method constructor <init>(Lcom/photo/gallery/MainActivity;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            null
        }
    .end annotation

    .line 46
    iput-object p1, p0, Lcom/photo/gallery/MainActivity$1;->this$0:Lcom/photo/gallery/MainActivity;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    .line 49
    iget-object p1, p0, Lcom/photo/gallery/MainActivity$1;->this$0:Lcom/photo/gallery/MainActivity;

    invoke-static {p1}, Lcom/photo/gallery/MainActivity;->-$$Nest$mupdateUI(Lcom/photo/gallery/MainActivity;)V

    return-void
.end method

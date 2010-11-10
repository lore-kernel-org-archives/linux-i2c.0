From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] media: video: do not clear 'driver' from an i2c_client
Date: Wed, 10 Nov 2010 15:14:13 +0100
Message-ID: <1289398455-21949-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Sergio Aguirre <saaguirre-l0cyMroinI0@public.gmane.org>, Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Philipp Wiesner <p.wiesner-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, =?UTF-8?q?M=C3=A1rton=20N=C3=A9meth?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The i2c-core does this already.

Reported-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

Not sure if this should go via i2c or media?

 drivers/media/video/imx074.c     |    1 -
 drivers/media/video/mt9m001.c    |    1 -
 drivers/media/video/mt9m111.c    |    1 -
 drivers/media/video/mt9t031.c    |    1 -
 drivers/media/video/mt9v022.c    |    1 -
 drivers/media/video/rj54n1cb0c.c |    1 -
 6 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/media/video/imx074.c b/drivers/media/video/imx074.c
index 27b5dfd..1a11691 100644
--- a/drivers/media/video/imx074.c
+++ b/drivers/media/video/imx074.c
@@ -467,7 +467,6 @@ static int imx074_remove(struct i2c_client *client)
 	icd->ops = NULL;
 	if (icl->free_bus)
 		icl->free_bus(icl);
-	client->driver = NULL;
 	kfree(priv);
 
 	return 0;
diff --git a/drivers/media/video/mt9m001.c b/drivers/media/video/mt9m001.c
index fcb4cd9..f7fc88d 100644
--- a/drivers/media/video/mt9m001.c
+++ b/drivers/media/video/mt9m001.c
@@ -798,7 +798,6 @@ static int mt9m001_remove(struct i2c_client *client)
 
 	icd->ops = NULL;
 	mt9m001_video_remove(icd);
-	client->driver = NULL;
 	kfree(mt9m001);
 
 	return 0;
diff --git a/drivers/media/video/mt9m111.c b/drivers/media/video/mt9m111.c
index 525a16e..53fa2a7 100644
--- a/drivers/media/video/mt9m111.c
+++ b/drivers/media/video/mt9m111.c
@@ -1092,7 +1092,6 @@ static int mt9m111_remove(struct i2c_client *client)
 	struct soc_camera_device *icd = client->dev.platform_data;
 
 	icd->ops = NULL;
-	client->driver = NULL;
 	kfree(mt9m111);
 
 	return 0;
diff --git a/drivers/media/video/mt9t031.c b/drivers/media/video/mt9t031.c
index 9bd44a8..7ce279c 100644
--- a/drivers/media/video/mt9t031.c
+++ b/drivers/media/video/mt9t031.c
@@ -896,7 +896,6 @@ static int mt9t031_remove(struct i2c_client *client)
 
 	if (icd)
 		icd->ops = NULL;
-	client->driver = NULL;
 	kfree(mt9t031);
 
 	return 0;
diff --git a/drivers/media/video/mt9v022.c b/drivers/media/video/mt9v022.c
index b96171c..6a784c8 100644
--- a/drivers/media/video/mt9v022.c
+++ b/drivers/media/video/mt9v022.c
@@ -930,7 +930,6 @@ static int mt9v022_remove(struct i2c_client *client)
 
 	icd->ops = NULL;
 	mt9v022_video_remove(icd);
-	client->driver = NULL;
 	kfree(mt9v022);
 
 	return 0;
diff --git a/drivers/media/video/rj54n1cb0c.c b/drivers/media/video/rj54n1cb0c.c
index d2fa2d4..57e11b6 100644
--- a/drivers/media/video/rj54n1cb0c.c
+++ b/drivers/media/video/rj54n1cb0c.c
@@ -1460,7 +1460,6 @@ static int rj54n1_remove(struct i2c_client *client)
 	icd->ops = NULL;
 	if (icl->free_bus)
 		icl->free_bus(icl);
-	client->driver = NULL;
 	kfree(rj54n1);
 
 	return 0;
-- 
1.7.2.3

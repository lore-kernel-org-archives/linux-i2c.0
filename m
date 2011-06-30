From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] gpio: pca953x: change driver name to be unique
Date: Thu, 30 Jun 2011 15:35:59 +0200
Message-ID: <1309440959-18692-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This driver handles the variants pca9534-pca9539, so it chose the name
"pca953x". However, there is a led driver which decided on the same
name. As a result, those two can't be loaded at the same time. Add a
subsystem prefix to make the driver name unique. Device matching will
not suffer, because both are I2C drivers which match using a
i2c_device_id-table which is not altered.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/gpio/pca953x.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
index 0451d7a..b30dd0b 100644
--- a/drivers/gpio/pca953x.c
+++ b/drivers/gpio/pca953x.c
@@ -742,7 +742,7 @@ static int pca953x_remove(struct i2c_client *client)
 
 static struct i2c_driver pca953x_driver = {
 	.driver = {
-		.name	= "pca953x",
+		.name	= "gpio-pca953x",
 	},
 	.probe		= pca953x_probe,
 	.remove		= pca953x_remove,
-- 
1.7.5.4

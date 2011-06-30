From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] leds: pca9532: change driver name to be unique
Date: Thu, 30 Jun 2011 15:36:21 +0200
Message-ID: <1309440981-18861-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Riku Voipio <riku.voipio-X3B1VOXEql0@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This driver handles the variants pca9530-pca9533, so it chose the name
"pca953x". However, there is a gpio driver which decided on the same
name. As a result, those two can't be loaded at the same time. Add a
subsystem prefix to make the driver name unique. Device matching will
not suffer, because both are I2C drivers which match using a
i2c_device_id-table which is not altered.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/leds/leds-pca9532.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index d8d3a1e..a2c8746 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -88,7 +88,7 @@ static const struct pca9532_chip_info pca9532_chip_info_tbl[] = {
 
 static struct i2c_driver pca9532_driver = {
 	.driver = {
-		.name = "pca953x",
+		.name = "leds-pca953x",
 	},
 	.probe = pca9532_probe,
 	.remove = pca9532_remove,
-- 
1.7.5.4

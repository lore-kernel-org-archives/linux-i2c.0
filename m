From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] drivers/mfd: Remove obsolete cleanup for clientdata
Date: Sun, 13 Oct 2013 18:06:12 +0200
Message-ID: <1381680392-5380-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/mfd/twl6040.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index daf6694..9d948af 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -565,13 +565,13 @@ static int twl6040_probe(struct i2c_client *client,
 				      twl6040->supplies);
 	if (ret != 0) {
 		dev_err(&client->dev, "Failed to get supplies: %d\n", ret);
-		goto regulator_get_err;
+		return ret;
 	}
 
 	ret = regulator_bulk_enable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
 	if (ret != 0) {
 		dev_err(&client->dev, "Failed to enable supplies: %d\n", ret);
-		goto regulator_get_err;
+		return ret;
 	}
 
 	twl6040->dev = &client->dev;
@@ -671,9 +671,6 @@ readyirq_err:
 	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
 gpio_err:
 	regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
-regulator_get_err:
-	i2c_set_clientdata(client, NULL);
-
 	return ret;
 }
 
@@ -689,7 +686,6 @@ static int twl6040_remove(struct i2c_client *client)
 	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
 
 	mfd_remove_devices(&client->dev);
-	i2c_set_clientdata(client, NULL);
 
 	regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
 
-- 
1.8.4.rc3

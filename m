From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 2/2] drivers/mfd: Remove obsolete cleanup for clientdata
Date: Tue, 21 May 2013 20:45:41 +0200
Message-ID: <1369161945-26671-2-git-send-email-wsa@the-dreams.de>
References: <1369161945-26671-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1369161945-26671-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/mfd/twl6040.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index 492ee2c..eec7de2 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -558,13 +558,13 @@ static int twl6040_probe(struct i2c_client *client,
 				 twl6040->supplies);
 	if (ret != 0) {
 		dev_err(&client->dev, "Failed to get supplies: %d\n", ret);
-		goto regulator_get_err;
+		goto err;
 	}
 
 	ret = regulator_bulk_enable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
 	if (ret != 0) {
 		dev_err(&client->dev, "Failed to enable supplies: %d\n", ret);
-		goto regulator_get_err;
+		goto err;
 	}
 
 	twl6040->dev = &client->dev;
@@ -688,8 +688,6 @@ readyirq_err:
 	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
 gpio_err:
 	regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
-regulator_get_err:
-	i2c_set_clientdata(client, NULL);
 err:
 	return ret;
 }
@@ -706,7 +704,6 @@ static int twl6040_remove(struct i2c_client *client)
 	regmap_del_irq_chip(twl6040->irq, twl6040->irq_data);
 
 	mfd_remove_devices(&client->dev);
-	i2c_set_clientdata(client, NULL);
 
 	regulator_bulk_disable(TWL6040_NUM_SUPPLIES, twl6040->supplies);
 
-- 
1.7.10.4

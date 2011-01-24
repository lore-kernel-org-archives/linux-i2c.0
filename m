From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/4] power: Remove obsolete cleanup for clientdata
Date: Mon, 24 Jan 2011 11:44:28 +0100
Message-ID: <1295865880-27672-2-git-send-email-w.sang@pengutronix.de>
References: <1295865880-27672-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295865880-27672-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>, MyungJoo Ham <myungjoo.ham@samsung.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/power/max17042_battery.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index c5c8805..09f7496 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -183,7 +183,6 @@ static int __devinit max17042_probe(struct i2c_client *client,
 	ret = power_supply_register(&client->dev, &chip->battery);
 	if (ret) {
 		dev_err(&client->dev, "failed: power supply register\n");
-		i2c_set_clientdata(client, NULL);
 		kfree(chip);
 		return ret;
 	}
@@ -202,7 +201,6 @@ static int __devexit max17042_remove(struct i2c_client *client)
 	struct max17042_chip *chip = i2c_get_clientdata(client);
 
 	power_supply_unregister(&chip->battery);
-	i2c_set_clientdata(client, NULL);
 	kfree(chip);
 	return 0;
 }
-- 
1.7.2.3

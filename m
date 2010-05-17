From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] drivers/mfd: remove unneeded and dangerous clearing of clientdata
Date: Mon, 17 May 2010 14:10:29 +0200
Message-ID: <1274098229-13858-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Unlike real i2c-devices which get detached from the driver, dummy-devices get
truly unregistered. So, there has never been a need to clear the clientdata
because the device will go away anyhow. For the occasions fixed here, clearing
clientdata was even dangerous as the structure was freed already.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---

Note: While most of the other calls clearing clientdata became superfluous
meanwhile and will be fixed later to remove redundancy, this is a seperate
issue. It was wrong from the beginning and needs to be fixed as it can cause
crashes. Hopefully, during this release-cycle, all other clearings of
clientdata will be removed and we will never see the related confusion again.

 drivers/mfd/88pm860x-i2c.c |    1 -
 drivers/mfd/max8925-i2c.c  |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
index 4a6e718..e55f3d2 100644
--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -200,7 +200,6 @@ static int __devexit pm860x_remove(struct i2c_client *client)
 
 	pm860x_device_exit(chip);
 	i2c_unregister_device(chip->companion);
-	i2c_set_clientdata(chip->companion, NULL);
 	i2c_set_clientdata(chip->client, NULL);
 	kfree(chip);
 	return 0;
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index d9fd878..e73f3f5 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -173,8 +173,6 @@ static int __devexit max8925_remove(struct i2c_client *client)
 	max8925_device_exit(chip);
 	i2c_unregister_device(chip->adc);
 	i2c_unregister_device(chip->rtc);
-	i2c_set_clientdata(chip->adc, NULL);
-	i2c_set_clientdata(chip->rtc, NULL);
 	i2c_set_clientdata(chip->i2c, NULL);
 	kfree(chip);
 	return 0;
-- 
1.7.0

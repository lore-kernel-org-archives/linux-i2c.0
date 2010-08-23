From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: remove obsolete cleanup for clientdata
Date: Mon, 23 Aug 2010 17:05:08 +0200
Message-ID: <1282575908-16555-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Hemanth V <hemanthv-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>, Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Gortmaker <p_gortmaker-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Roy Zang <tie-fei.zang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Jingchang Lu <b22599-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit. This is obsolete meanwhile, so fix it and hope the word will spread.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

Jean, I dunno if it fits for 2.6.36. It is not precisely a regression.
Though, if it enters with the next merge window, the next set of "faulty"
drivers may come in at the same time...

 drivers/misc/bh1780gli.c               |    1 -
 drivers/regulator/ad5398.c             |    1 -
 drivers/regulator/isl6271a-regulator.c |    2 --
 drivers/rtc/rtc-ds3232.c               |    2 --
 4 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/bh1780gli.c b/drivers/misc/bh1780gli.c
index 714c6b4..d5f3a3f 100644
--- a/drivers/misc/bh1780gli.c
+++ b/drivers/misc/bh1780gli.c
@@ -190,7 +190,6 @@ static int __devexit bh1780_remove(struct i2c_client *client)
 
 	ddata = i2c_get_clientdata(client);
 	sysfs_remove_group(&client->dev.kobj, &bh1780_attr_group);
-	i2c_set_clientdata(client, NULL);
 	kfree(ddata);
 
 	return 0;
diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
index d59d2f2..15ff61d 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -256,7 +256,6 @@ static int __devexit ad5398_remove(struct i2c_client *client)
 
 	regulator_unregister(&chip->rdev);
 	kfree(chip);
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
index e49d2bd..65ecd82 100644
--- a/drivers/regulator/isl6271a-regulator.c
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -191,8 +191,6 @@ static int __devexit isl6271a_remove(struct i2c_client *i2c)
 	struct isl_pmic *pmic = i2c_get_clientdata(i2c);
 	int i;
 
-	i2c_set_clientdata(i2c, NULL);
-
 	for (i = 0; i < 3; i++)
 		regulator_unregister(pmic->rdev[i]);
 
diff --git a/drivers/rtc/rtc-ds3232.c b/drivers/rtc/rtc-ds3232.c
index 9daed8d..9de8516 100644
--- a/drivers/rtc/rtc-ds3232.c
+++ b/drivers/rtc/rtc-ds3232.c
@@ -268,7 +268,6 @@ out_irq:
 		free_irq(client->irq, client);
 
 out_free:
-	i2c_set_clientdata(client, NULL);
 	kfree(ds3232);
 	return ret;
 }
@@ -287,7 +286,6 @@ static int __devexit ds3232_remove(struct i2c_client *client)
 	}
 
 	rtc_device_unregister(ds3232->rtc);
-	i2c_set_clientdata(client, NULL);
 	kfree(ds3232);
 	return 0;
 }
-- 
1.7.1

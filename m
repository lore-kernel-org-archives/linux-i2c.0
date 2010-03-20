From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 17/24] regulator: fix dangling pointers
Date: Sat, 20 Mar 2010 15:12:58 +0100
Message-ID: <1269094385-16114-18-git-send-email-w.sang@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/regulator/max1586.c |    2 +-
 drivers/regulator/max8649.c |    3 ++-
 drivers/regulator/max8660.c |    2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max1586.c b/drivers/regulator/max1586.c
index a49fc95..c0b09e1 100644
--- a/drivers/regulator/max1586.c
+++ b/drivers/regulator/max1586.c
@@ -243,8 +243,8 @@ static int __devexit max1586_pmic_remove(struct i2c_client *client)
 	for (i = 0; i <= MAX1586_V6; i++)
 		if (rdev[i])
 			regulator_unregister(rdev[i]);
-	kfree(rdev);
 	i2c_set_clientdata(client, NULL);
+	kfree(rdev);
 
 	return 0;
 }
diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
index 3ebdf69..833aaed 100644
--- a/drivers/regulator/max8649.c
+++ b/drivers/regulator/max8649.c
@@ -356,6 +356,7 @@ static int __devinit max8649_regulator_probe(struct i2c_client *client,
 	dev_info(info->dev, "Max8649 regulator device is detected.\n");
 	return 0;
 out:
+	i2c_set_clientdata(client, NULL);
 	kfree(info);
 	return ret;
 }
@@ -367,9 +368,9 @@ static int __devexit max8649_regulator_remove(struct i2c_client *client)
 	if (info) {
 		if (info->regulator)
 			regulator_unregister(info->regulator);
+		i2c_set_clientdata(client, NULL);
 		kfree(info);
 	}
-	i2c_set_clientdata(client, NULL);
 
 	return 0;
 }
diff --git a/drivers/regulator/max8660.c b/drivers/regulator/max8660.c
index f12f1bb..47f90b2 100644
--- a/drivers/regulator/max8660.c
+++ b/drivers/regulator/max8660.c
@@ -470,8 +470,8 @@ static int __devexit max8660_remove(struct i2c_client *client)
 	for (i = 0; i < MAX8660_V_END; i++)
 		if (rdev[i])
 			regulator_unregister(rdev[i]);
-	kfree(rdev);
 	i2c_set_clientdata(client, NULL);
+	kfree(rdev);
 
 	return 0;
 }
-- 
1.7.0

From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Subject: [PATCH 1/6] i2c: cpm: use devm_ functions
Date: Sat, 25 Aug 2012 19:41:34 +0200
Message-ID: <1345916499-6657-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

The various devm_ functions allocate memory that is released when a driver
detaches.  This patch uses these functions for data that is allocated in
the probe function of a platform device and is only freed in the remove
function.

Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

---
Not compiled.

 drivers/i2c/busses/i2c-cpm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index c1e1096..ec97415 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -640,7 +640,7 @@ static int __devinit cpm_i2c_probe(struct platform_device *ofdev)
 	struct cpm_i2c *cpm;
 	const u32 *data;
 
-	cpm = kzalloc(sizeof(struct cpm_i2c), GFP_KERNEL);
+	cpm = devm_kzalloc(&ofdev->dev, sizeof(struct cpm_i2c), GFP_KERNEL);
 	if (!cpm)
 		return -ENOMEM;
 
@@ -683,7 +683,6 @@ out_shut:
 	cpm_i2c_shutdown(cpm);
 out_free:
 	dev_set_drvdata(&ofdev->dev, NULL);
-	kfree(cpm);
 
 	return result;
 }
@@ -697,7 +696,6 @@ static int __devexit cpm_i2c_remove(struct platform_device *ofdev)
 	cpm_i2c_shutdown(cpm);
 
 	dev_set_drvdata(&ofdev->dev, NULL);
-	kfree(cpm);
 
 	return 0;
 }

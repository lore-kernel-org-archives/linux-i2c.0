From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/4] mfd: Remove obsolete cleanup for clientdata
Date: Mon, 24 Jan 2011 11:44:27 +0100
Message-ID: <1295865880-27672-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/mfd/wl1273-core.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
index d2ecc24..6bb5136 100644
--- a/drivers/mfd/wl1273-core.c
+++ b/drivers/mfd/wl1273-core.c
@@ -38,7 +38,6 @@ static int wl1273_core_remove(struct i2c_client *client)
 	dev_dbg(&client->dev, "%s\n", __func__);
 
 	mfd_remove_devices(&client->dev);
-	i2c_set_clientdata(client, NULL);
 	kfree(core);
 
 	return 0;
@@ -104,7 +103,6 @@ static int __devinit wl1273_core_probe(struct i2c_client *client,
 	return 0;
 
 err:
-	i2c_set_clientdata(client, NULL);
 	pdata->free_resources();
 	kfree(core);
 
-- 
1.7.2.3

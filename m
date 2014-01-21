From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: rely on driver core when sanitizing devices
Date: Tue, 21 Jan 2014 17:48:34 +0100
Message-ID: <1390322914-14191-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Commit 0998d0631001 (device-core: Ensure drvdata = NULL when no driver
is bound) modified the driver core to always clear .driver and .drvdata
on remove or probe error. No need for the I2C core to do it.

Reported-by: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Reported-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d74c0b3..dd3a4db 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -256,10 +256,9 @@ static int i2c_device_probe(struct device *dev)
 
 	acpi_dev_pm_attach(&client->dev, true);
 	status = driver->probe(client, i2c_match_id(driver->id_table, client));
-	if (status) {
-		i2c_set_clientdata(client, NULL);
+	if (status)
 		acpi_dev_pm_detach(&client->dev, true);
-	}
+
 	return status;
 }
 
@@ -267,7 +266,7 @@ static int i2c_device_remove(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
 	struct i2c_driver	*driver;
-	int			status;
+	int status = 0;
 
 	if (!client || !dev->driver)
 		return 0;
@@ -276,12 +275,8 @@ static int i2c_device_remove(struct device *dev)
 	if (driver->remove) {
 		dev_dbg(dev, "remove\n");
 		status = driver->remove(client);
-	} else {
-		dev->driver = NULL;
-		status = 0;
 	}
-	if (status == 0)
-		i2c_set_clientdata(client, NULL);
+
 	acpi_dev_pm_detach(&client->dev, true);
 	return status;
 }
-- 
1.8.5.1

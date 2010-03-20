From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 14/24] misc: fix dangling pointers
Date: Sat, 20 Mar 2010 15:12:55 +0100
Message-ID: <1269094385-16114-15-git-send-email-w.sang@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/misc/ad525x_dpot.c |    2 +-
 drivers/misc/ics932s401.c  |    2 ++
 drivers/misc/isl29003.c    |    6 +++++-
 drivers/misc/tsl2550.c     |    6 +++++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
index 30a59f2..3b6f437 100644
--- a/drivers/misc/ad525x_dpot.c
+++ b/drivers/misc/ad525x_dpot.c
@@ -567,8 +567,8 @@ static int ad525x_probe(struct i2c_client *client,
 	return 0;
 
 exit_free:
-	kfree(data);
 	i2c_set_clientdata(client, NULL);
+	kfree(data);
 exit:
 	dev_err(dev, "failed to create client\n");
 	return err;
diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
index 395a4ea..f60b7e7 100644
--- a/drivers/misc/ics932s401.c
+++ b/drivers/misc/ics932s401.c
@@ -465,6 +465,7 @@ static int ics932s401_probe(struct i2c_client *client,
 	return 0;
 
 exit_free:
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 exit:
 	return err;
@@ -475,6 +476,7 @@ static int ics932s401_remove(struct i2c_client *client)
 	struct ics932s401_data *data = i2c_get_clientdata(client);
 
 	sysfs_remove_group(&client->dev.kobj, &data->attrs);
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return 0;
 }
diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index a71e245..5bd4d8b 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -397,15 +397,19 @@ static int __devinit isl29003_probe(struct i2c_client *client,
 	return 0;
 
 exit_kfree:
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 	return err;
 }
 
 static int __devexit isl29003_remove(struct i2c_client *client)
 {
+	struct isl29003_data *data = i2c_get_clientdata(client);
+
 	sysfs_remove_group(&client->dev.kobj, &isl29003_attr_group);
 	isl29003_set_power_state(client, 0);
-	kfree(i2c_get_clientdata(client));
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
 	return 0;
 }
 
diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 483ae5f..230c326 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -400,6 +400,7 @@ static int __devinit tsl2550_probe(struct i2c_client *client,
 	return 0;
 
 exit_kfree:
+	i2c_set_clientdata(client, NULL);
 	kfree(data);
 exit:
 	return err;
@@ -407,12 +408,15 @@ exit:
 
 static int __devexit tsl2550_remove(struct i2c_client *client)
 {
+	struct tsl2550_data *data = i2c_get_clientdata(client);
+
 	sysfs_remove_group(&client->dev.kobj, &tsl2550_attr_group);
 
 	/* Power down the device */
 	tsl2550_set_power_state(client, 0);
 
-	kfree(i2c_get_clientdata(client));
+	i2c_set_clientdata(client, NULL);
+	kfree(data);
 
 	return 0;
 }
-- 
1.7.0

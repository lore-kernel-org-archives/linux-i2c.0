From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Convert some more new-style drivers to use
 module aliasing
Date: Tue, 6 May 2008 18:36:03 +0200
Message-ID: <20080506183603.68667a66@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Update 3 more new-style i2c drivers to use standard module aliasing
instead of the old driver_name/type driver matching scheme. These
video drivers aren't used yet so converting them is trivial.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
I would appreciate if someone who uses the tvaudio driver could confirm
that this patch doesn't cause any regression there. It really
shouldn't, but you never know...

Thanks to Hans Verkuil for suggesting the best approach to update the
tvaudio driver.

 drivers/media/video/tcm825x.c       |    7 +++++++
 drivers/media/video/tlv320aic23b.c  |    6 ++++++
 drivers/media/video/tvaudio.c       |   13 ++++++++++++-
 include/media/v4l2-i2c-drv-legacy.h |    2 ++
 include/media/v4l2-i2c-drv.h        |    2 ++
 5 files changed, 29 insertions(+), 1 deletion(-)

--- linux-2.6.26-rc1.orig/drivers/media/video/tcm825x.c	2008-05-06 18:13:28.000000000 +0200
+++ linux-2.6.26-rc1/drivers/media/video/tcm825x.c	2008-05-06 18:14:07.000000000 +0200
@@ -885,12 +885,19 @@ static int __exit tcm825x_remove(struct 
 	return 0;
 }
 
+static const struct i2c_device_id tcm825x_id[] = {
+	{ "tcm825x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tcm825x_id);
+
 static struct i2c_driver tcm825x_i2c_driver = {
 	.driver	= {
 		.name = TCM825X_NAME,
 	},
 	.probe	= tcm825x_probe,
 	.remove	= __exit_p(tcm825x_remove),
+	.id_table = tcm825x_id,
 };
 
 static struct tcm825x_sensor tcm825x = {
--- linux-2.6.26-rc1.orig/drivers/media/video/tlv320aic23b.c	2008-05-06 18:13:28.000000000 +0200
+++ linux-2.6.26-rc1/drivers/media/video/tlv320aic23b.c	2008-05-06 18:14:07.000000000 +0200
@@ -168,6 +168,11 @@ static int tlv320aic23b_remove(struct i2
 
 /* ----------------------------------------------------------------------- */
 
+static const struct i2c_device_id tlv320aic23b_id[] = {
+	{ "tlv320aic23b", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tlv320aic23b_id);
 
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "tlv320aic23b",
@@ -175,4 +180,5 @@ static struct v4l2_i2c_driver_data v4l2_
 	.command = tlv320aic23b_command,
 	.probe = tlv320aic23b_probe,
 	.remove = tlv320aic23b_remove,
+	.id_table = tlv320aic23b_id,
 };
--- linux-2.6.26-rc1.orig/drivers/media/video/tvaudio.c	2008-05-06 18:13:28.000000000 +0200
+++ linux-2.6.26-rc1/drivers/media/video/tvaudio.c	2008-05-06 18:25:06.000000000 +0200
@@ -1505,7 +1505,8 @@ static int chip_probe(struct i2c_client 
 	}
 
 	/* fill required data structures */
-	strcpy(client->name, desc->name);
+	if (!id)
+		strlcpy(client->name, desc->name, I2C_NAME_SIZE);
 	chip->type = desc-chiplist;
 	chip->shadow.count = desc->registers+1;
 	chip->prevmode = -1;
@@ -1830,6 +1831,15 @@ static int chip_legacy_probe(struct i2c_
 	return 0;
 }
 
+/* This driver supports many devices and the idea is to let the driver
+   detect which device is present. So rather than listing all supported
+   devices here, we pretend to support a single, fake device type. */
+static const struct i2c_device_id chip_id[] = {
+	{ "tvaudio", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, chip_id);
+
 static struct v4l2_i2c_driver_data v4l2_i2c_data = {
 	.name = "tvaudio",
 	.driverid = I2C_DRIVERID_TVAUDIO,
@@ -1837,6 +1847,7 @@ static struct v4l2_i2c_driver_data v4l2_
 	.probe = chip_probe,
 	.remove = chip_remove,
 	.legacy_probe = chip_legacy_probe,
+	.id_table = chip_id,
 };
 
 /*
--- linux-2.6.26-rc1.orig/include/media/v4l2-i2c-drv-legacy.h	2008-05-06 18:13:28.000000000 +0200
+++ linux-2.6.26-rc1/include/media/v4l2-i2c-drv-legacy.h	2008-05-06 18:14:07.000000000 +0200
@@ -31,6 +31,7 @@ struct v4l2_i2c_driver_data {
 	int (*resume)(struct i2c_client *client);
 	int (*legacy_probe)(struct i2c_adapter *adapter);
 	int legacy_class;
+	const struct i2c_device_id *id_table;
 };
 
 static struct v4l2_i2c_driver_data v4l2_i2c_data;
@@ -124,6 +125,7 @@ static int __init v4l2_i2c_drv_init(void
 	v4l2_i2c_driver.command = v4l2_i2c_data.command;
 	v4l2_i2c_driver.probe = v4l2_i2c_data.probe;
 	v4l2_i2c_driver.remove = v4l2_i2c_data.remove;
+	v4l2_i2c_driver.id_table = v4l2_i2c_data.id_table;
 	err = i2c_add_driver(&v4l2_i2c_driver);
 	if (err)
 		i2c_del_driver(&v4l2_i2c_driver_legacy);
--- linux-2.6.26-rc1.orig/include/media/v4l2-i2c-drv.h	2008-05-06 18:13:28.000000000 +0200
+++ linux-2.6.26-rc1/include/media/v4l2-i2c-drv.h	2008-05-06 18:14:07.000000000 +0200
@@ -36,6 +36,7 @@ struct v4l2_i2c_driver_data {
 	int (*resume)(struct i2c_client *client);
 	int (*legacy_probe)(struct i2c_adapter *adapter);
 	int legacy_class;
+	const struct i2c_device_id *id_table;
 };
 
 static struct v4l2_i2c_driver_data v4l2_i2c_data;
@@ -53,6 +54,7 @@ static int __init v4l2_i2c_drv_init(void
 	v4l2_i2c_driver.remove = v4l2_i2c_data.remove;
 	v4l2_i2c_driver.suspend = v4l2_i2c_data.suspend;
 	v4l2_i2c_driver.resume = v4l2_i2c_data.resume;
+	v4l2_i2c_driver.id_table = v4l2_i2c_data.id_table;
 	return i2c_add_driver(&v4l2_i2c_driver);
 }
 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

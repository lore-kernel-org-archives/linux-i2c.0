From: jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 1/1] at24: add i2c_driver struct member for at24_driver, and reduce the priority of at24_init
Date: Tue, 21 Sep 2010 14:07:23 +0800
Message-ID: <1285049243-17058-1-git-send-email-jgq516@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Xiao Jiang <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The following changes are ensure at24 driver can be probed successfully,
which are based on Linux 2.6.36-rc5.
1. Add class, detect and address_list member in at24_driver because they
   will be check in i2c_detect().
2. Since the at24 driver are tightly coupled with i2c bus driver, make
   sure it's init priority is lower than i2c bus.

Signed-off-by: Xiao Jiang <jgq516-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/misc/eeprom/at24.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 559b0b3..a40f74e 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -129,6 +129,9 @@ static const struct i2c_device_id at24_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, at24_ids);
 
+/* Addresses to scan */
+static const unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
+					0x55, 0x56, 0x57, I2C_CLIENT_END };
 /*-------------------------------------------------------------------------*/
 
 /*
@@ -646,6 +649,13 @@ static int __devexit at24_remove(struct i2c_client *client)
 	return 0;
 }
 
+static int at24_detect(struct i2c_client *client, struct i2c_board_info *info)
+{
+	strlcpy(info->type, "at24", I2C_NAME_SIZE);
+
+	return 0;
+}
+
 /*-------------------------------------------------------------------------*/
 
 static struct i2c_driver at24_driver = {
@@ -656,6 +666,10 @@ static struct i2c_driver at24_driver = {
 	.probe = at24_probe,
 	.remove = __devexit_p(at24_remove),
 	.id_table = at24_ids,
+
+	.class = I2C_CLASS_SPD,
+	.detect = at24_detect,
+	.address_list = normal_i2c,
 };
 
 static int __init at24_init(void)
@@ -663,7 +677,7 @@ static int __init at24_init(void)
 	io_limit = rounddown_pow_of_two(io_limit);
 	return i2c_add_driver(&at24_driver);
 }
-module_init(at24_init);
+device_initcall_sync(at24_init);
 
 static void __exit at24_exit(void)
 {
-- 
1.6.3.3

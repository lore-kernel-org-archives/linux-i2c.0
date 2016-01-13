From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 4/5] misc: eeprom: use kobj_to_dev()
Date: Wed, 13 Jan 2016 23:30:11 +0800
Message-ID: <f0996c29468c9bb2561b09cf368cf1f0a4c69a43.1452698603.git.geliangtang@163.com>
References: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
In-Reply-To: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
References: <286d4d5f873437fbc91c07369b4b57038c4667ce.1452698603.git.geliangtang@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geliang Tang <geliangtang@163.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use kobj_to_dev() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/misc/eeprom/at24.c          | 4 ++--
 drivers/misc/eeprom/at25.c          | 4 ++--
 drivers/misc/eeprom/eeprom.c        | 2 +-
 drivers/misc/eeprom/eeprom_93xx46.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 5d7c090..d105c25 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -289,7 +289,7 @@ static ssize_t at24_bin_read(struct file *filp, struct kobject *kobj,
 {
 	struct at24_data *at24;
 
-	at24 = dev_get_drvdata(container_of(kobj, struct device, kobj));
+	at24 = dev_get_drvdata(kobj_to_dev(kobj));
 	return at24_read(at24, buf, off, count);
 }
 
@@ -420,7 +420,7 @@ static ssize_t at24_bin_write(struct file *filp, struct kobject *kobj,
 {
 	struct at24_data *at24;
 
-	at24 = dev_get_drvdata(container_of(kobj, struct device, kobj));
+	at24 = dev_get_drvdata(kobj_to_dev(kobj));
 	return at24_write(at24, buf, off, count);
 }
 
diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index f850ef5..3e9e5a2 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -139,7 +139,7 @@ at25_bin_read(struct file *filp, struct kobject *kobj,
 	struct device		*dev;
 	struct at25_data	*at25;
 
-	dev = container_of(kobj, struct device, kobj);
+	dev = kobj_to_dev(kobj);
 	at25 = dev_get_drvdata(dev);
 
 	return at25_ee_read(at25, buf, off, count);
@@ -273,7 +273,7 @@ at25_bin_write(struct file *filp, struct kobject *kobj,
 	struct device		*dev;
 	struct at25_data	*at25;
 
-	dev = container_of(kobj, struct device, kobj);
+	dev = kobj_to_dev(kobj);
 	at25 = dev_get_drvdata(dev);
 
 	return at25_ee_write(at25, buf, off, count);
diff --git a/drivers/misc/eeprom/eeprom.c b/drivers/misc/eeprom/eeprom.c
index 7342fd6..3d1d551 100644
--- a/drivers/misc/eeprom/eeprom.c
+++ b/drivers/misc/eeprom/eeprom.c
@@ -84,7 +84,7 @@ static ssize_t eeprom_read(struct file *filp, struct kobject *kobj,
 			   struct bin_attribute *bin_attr,
 			   char *buf, loff_t off, size_t count)
 {
-	struct i2c_client *client = to_i2c_client(container_of(kobj, struct device, kobj));
+	struct i2c_client *client = to_i2c_client(kobj_to_dev(kobj));
 	struct eeprom_data *data = i2c_get_clientdata(client);
 	u8 slice;
 
diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index ff63f05..473aa0a 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -45,7 +45,7 @@ eeprom_93xx46_bin_read(struct file *filp, struct kobject *kobj,
 	int bits, ret;
 	u16 cmd_addr;
 
-	dev = container_of(kobj, struct device, kobj);
+	dev = kobj_to_dev(kobj);
 	edev = dev_get_drvdata(dev);
 
 	cmd_addr = OP_READ << edev->addrlen;
@@ -190,7 +190,7 @@ eeprom_93xx46_bin_write(struct file *filp, struct kobject *kobj,
 	struct device *dev;
 	int i, ret, step = 1;
 
-	dev = container_of(kobj, struct device, kobj);
+	dev = kobj_to_dev(kobj);
 	edev = dev_get_drvdata(dev);
 
 	/* only write even number of bytes on 16-bit devices */
-- 
2.5.0

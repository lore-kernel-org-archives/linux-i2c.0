From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: slave eeprom: clean up sysfs bin attribute read()/write()
Date: Mon, 27 Jul 2015 00:16:31 +0300
Message-ID: <1437945391-27823-1-git-send-email-vz@mleia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The change removes redundant sysfs binary file boundary checks,
since this task is already done on caller side in fs/sysfs/file.c

Note, on file size overflow read() now returns 0, and this is a
correct and expected EOF notification according to POSIX.

Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-slave-eeprom.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 8223746..1da4496 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -80,9 +80,6 @@ static ssize_t i2c_slave_eeprom_bin_read(struct file *filp, struct kobject *kobj
 	struct eeprom_data *eeprom;
 	unsigned long flags;
 
-	if (off + count > attr->size)
-		return -EFBIG;
-
 	eeprom = dev_get_drvdata(container_of(kobj, struct device, kobj));
 
 	spin_lock_irqsave(&eeprom->buffer_lock, flags);
@@ -98,9 +95,6 @@ static ssize_t i2c_slave_eeprom_bin_write(struct file *filp, struct kobject *kob
 	struct eeprom_data *eeprom;
 	unsigned long flags;
 
-	if (off + count > attr->size)
-		return -EFBIG;
-
 	eeprom = dev_get_drvdata(container_of(kobj, struct device, kobj));
 
 	spin_lock_irqsave(&eeprom->buffer_lock, flags);
-- 
2.1.4

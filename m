From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: slave-eeprom: fix boundary check when using sysfs
Date: Mon, 19 Jan 2015 17:22:55 +0100
Message-ID: <1421684575-6679-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Debora Grosse <debora@mds.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Due to a copy&paste error, the last byte of the shared memory was not
accessible via sysfs.

Reported-by: Debora Grosse <debora@mds.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-slave-eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index f432f81b0414..8f417e9054ac 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -74,7 +74,7 @@ static ssize_t i2c_slave_eeprom_bin_read(struct file *filp, struct kobject *kobj
 	struct eeprom_data *eeprom;
 	unsigned long flags;
 
-	if (off + count >= attr->size)
+	if (off + count > attr->size)
 		return -EFBIG;
 
 	eeprom = dev_get_drvdata(container_of(kobj, struct device, kobj));
@@ -92,7 +92,7 @@ static ssize_t i2c_slave_eeprom_bin_write(struct file *filp, struct kobject *kob
 	struct eeprom_data *eeprom;
 	unsigned long flags;
 
-	if (off + count >= attr->size)
+	if (off + count > attr->size)
 		return -EFBIG;
 
 	eeprom = dev_get_drvdata(container_of(kobj, struct device, kobj));
-- 
2.1.3


From: qiwuchen55@gmail.com
Subject: [PATCH] i2c: use kobj_to_dev() API
Date: Fri, 14 Feb 2020 20:56:37 +0800
Message-ID: <1581684997-8322-1-git-send-email-qiwuchen55@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53701 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgBNM4m (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 14 Feb 2020 07:56:42 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so3862815pjc.3
        for <linux-i2c@vger.kernel.org>; Fri, 14 Feb 2020 04:56:42 -0800 (PST)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>

From: chenqiwu <chenqiwu@xiaomi.com>

Use kobj_to_dev() API instead of container_of().

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/i2c/i2c-slave-eeprom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index db9763c..cb415b1 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -96,7 +96,7 @@ static ssize_t i2c_slave_eeprom_bin_read(struct file *filp, struct kobject *kobj
 	struct eeprom_data *eeprom;
 	unsigned long flags;
 
-	eeprom = dev_get_drvdata(container_of(kobj, struct device, kobj));
+	eeprom = dev_get_drvdata(kobj_to_dev(kobj));
 
 	spin_lock_irqsave(&eeprom->buffer_lock, flags);
 	memcpy(buf, &eeprom->buffer[off], count);
@@ -111,7 +111,7 @@ static ssize_t i2c_slave_eeprom_bin_write(struct file *filp, struct kobject *kob
 	struct eeprom_data *eeprom;
 	unsigned long flags;
 
-	eeprom = dev_get_drvdata(container_of(kobj, struct device, kobj));
+	eeprom = dev_get_drvdata(kobj_to_dev(kobj));
 
 	spin_lock_irqsave(&eeprom->buffer_lock, flags);
 	memcpy(&eeprom->buffer[off], buf, count);
-- 
1.9.1

From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/8] misc: eeprom: at24: clean up at24_bin_write()
Date: Mon, 27 Jul 2015 00:18:51 +0300
Message-ID: <1437945533-27996-6-git-send-email-vz@mleia.com>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437945502-27944-1-git-send-email-vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The change removes redundant sysfs binary file boundary check, since
this task is already done on caller side in fs/sysfs/file.c

Signed-off-by: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/misc/eeprom/at24.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2d3db81..6ded3dc 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -438,9 +438,6 @@ static ssize_t at24_bin_write(struct file *filp, struct kobject *kobj,
 {
 	struct at24_data *at24;
 
-	if (unlikely(off >= attr->size))
-		return -EFBIG;
-
 	at24 = dev_get_drvdata(container_of(kobj, struct device, kobj));
 	return at24_write(at24, buf, off, count);
 }
-- 
2.1.4

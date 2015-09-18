From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/1] i2c: core: fix a code to suppress a warning
Date: Fri, 18 Sep 2015 14:06:39 +0300
Message-ID: <1442574399-26131-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is a warning when compiling i2c-core.c
drivers/i2c/i2c-core.c:2561:36: warning: dubious: x | !y

Fix it by using a plain bitwise AND since I2C_M_RD is a bit 0 and thus we are
on the safe side.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5f89f1e..a732107 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2555,7 +2555,7 @@ static u8 i2c_smbus_pec(u8 crc, u8 *p, size_t count)
 static u8 i2c_smbus_msg_pec(u8 pec, struct i2c_msg *msg)
 {
 	/* The address will be sent first */
-	u8 addr = (msg->addr << 1) | !!(msg->flags & I2C_M_RD);
+	u8 addr = (msg->addr << 1) | (msg->flags & I2C_M_RD);
 	pec = i2c_smbus_pec(pec, &addr, 1);
 
 	/* The data buffer follows */
-- 
2.5.1

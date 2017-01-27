From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] i2c: piix4: Fix request_region size
Date: Fri, 27 Jan 2017 15:59:30 +0100
Message-ID: <20170127145930.13055-1-ricardo.ribalda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Since '701dc207bf55 ("i2c: piix4: Avoid race conditions with IMC")' we
are using the SMBSLVCNT register at offset 0x8. We need to request it.

Fixes: 701dc207bf55 ("i2c: piix4: Avoid race conditions with IMC")
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
Please note, not tested on hardware.
 drivers/i2c/busses/i2c-piix4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index e34d82e79b98..73cc6799cc59 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -58,7 +58,7 @@
 #define SMBSLVDAT	(0xC + piix4_smba)
 
 /* count for request_region */
-#define SMBIOSIZE	8
+#define SMBIOSIZE	9
 
 /* PCI Address Constants */
 #define SMBBA		0x090
-- 
2.11.0

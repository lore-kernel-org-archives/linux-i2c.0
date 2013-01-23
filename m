From: Liu Ying <Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
Date: Wed, 23 Jan 2013 14:32:43 +0800
Message-ID: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liu.y.victor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Liu Ying <Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds at24c512b eeprom support.
The datasheet of at24c512b can be found at:
http://www.alldatasheet.com/datasheet-pdf/pdf/
256958/ATMEL/AT24C512B-TH-B.html

Signed-off-by: Liu Ying <Ying.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/devicetree/bindings/eeprom.txt |    2 +-
 drivers/misc/eeprom/at24.c                   |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom.txt b/Documentation/devicetree/bindings/eeprom.txt
index 4342c10..fcea214 100644
--- a/Documentation/devicetree/bindings/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom.txt
@@ -6,7 +6,7 @@ Required properties:
 		 If there is no specific driver for <manufacturer>, a generic
 		 driver based on <type> is selected. Possible types are:
 		 24c00, 24c01, 24c02, 24c04, 24c08, 24c16, 24c32, 24c64,
-		 24c128, 24c256, 24c512, 24c1024, spd
+		 24c128, 24c256, 24c512, 24c512b, 24c1024, spd
 
   - reg : the I2C address of the EEPROM
 
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2baeec5..0df4cb0 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -124,6 +124,7 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c128", AT24_DEVICE_MAGIC(131072 / 8, AT24_FLAG_ADDR16) },
 	{ "24c256", AT24_DEVICE_MAGIC(262144 / 8, AT24_FLAG_ADDR16) },
 	{ "24c512", AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16) },
+	{ "24c512b", AT24_DEVICE_MAGIC(524288 / 8, AT24_FLAG_ADDR16) },
 	{ "24c1024", AT24_DEVICE_MAGIC(1048576 / 8, AT24_FLAG_ADDR16) },
 	{ "at24", 0 },
 	{ /* END OF LIST */ }
-- 
1.7.1

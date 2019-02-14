From: Adrian Bunk <bunk@kernel.org>
Subject: [4.9/4.14 patch] eeprom: at24: add support for 24c2048
Date: Thu, 14 Feb 2019 17:41:58 +0200
Message-ID: <20190214154158.GA21871@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

commit 6c0c5dc33ff42af49243e94842d0ebdb153189ea upstream.
commit 37cf28d3b5bca1b532a0b6aac722e7f2788a9294 upstream.

Works with ST M24M02.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
---

Backport applies and builds against 4.9/4.14.
Confirmed working with 4.14.
For 4.19/4.20 please cherry-pick the upstream commits instead.

 Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++--
 drivers/misc/eeprom/Kconfig                         | 2 +-
 drivers/misc/eeprom/at24.c                          | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index afc04589eadf..3c9a822d576c 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -6,7 +6,8 @@ Required properties:
 
 	"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
 	"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
-	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
+	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024",
+	"atmel,24c2048"
 
 	"catalyst,24c32"
 
@@ -23,7 +24,7 @@ Required properties:
 	 device with <type> and manufacturer "atmel" should be used.
 	 Possible types are:
 	 "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
-	 "24c128", "24c256", "24c512", "24c1024", "spd"
+	 "24c128", "24c256", "24c512", "24c1024", "24c2048", "spd"
 
   - reg : the I2C address of the EEPROM
 
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index de58762097c4..3f93e4564cab 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -12,7 +12,7 @@ config EEPROM_AT24
 	  ones like at24c64, 24lc02 or fm24c04:
 
 	     24c00, 24c01, 24c02, spd (readonly 24c02), 24c04, 24c08,
-	     24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024
+	     24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024, 24c2048
 
 	  Unless you like data loss puzzles, always be sure that any chip
 	  you configure as a 24c32 (32 kbit) or larger is NOT really a
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ded48a0c77ee..59dcd97ee3de 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -170,6 +170,7 @@ static const struct i2c_device_id at24_ids[] = {
 	{ "24c256",	AT24_DEVICE_MAGIC(262144 / 8,	AT24_FLAG_ADDR16) },
 	{ "24c512",	AT24_DEVICE_MAGIC(524288 / 8,	AT24_FLAG_ADDR16) },
 	{ "24c1024",	AT24_DEVICE_MAGIC(1048576 / 8,	AT24_FLAG_ADDR16) },
+	{ "24c2048",	AT24_DEVICE_MAGIC(2097152 / 8,	AT24_FLAG_ADDR16) },
 	{ "at24", 0 },
 	{ /* END OF LIST */ }
 };
-- 
2.11.0

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 9/9] eeprom: at24: readability tweaks
Date: Tue, 27 Oct 2015 12:43:53 +0100
Message-ID: <1445946233-6071-10-git-send-email-bgolaszewski@baylibre.com>
References: <1445946233-6071-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445946233-6071-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

Move the macro definitions above the struct definitions and add some
tabs for better readability.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 65f1479..d624311 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -52,6 +52,14 @@
  * which won't work on pure SMBus systems.
  */
 
+#define AT24_SIZE_BYTELEN		5
+#define AT24_SIZE_FLAGS			8
+
+#define AT24_BITMASK(x)			(BIT(x) - 1)
+
+#define AT24CS_SERIAL_SIZE		16
+#define AT24CS_SERIAL_ADDR(addr)	(addr + 0x08)
+
 struct at24_data {
 	struct at24_platform_data chip;
 	struct memory_accessor macc;
@@ -98,14 +106,6 @@ static unsigned write_timeout = 25;
 module_param(write_timeout, uint, 0);
 MODULE_PARM_DESC(write_timeout, "Time (in ms) to try writes (default 25)");
 
-#define AT24_SIZE_BYTELEN 5
-#define AT24_SIZE_FLAGS 8
-
-#define AT24_BITMASK(x) (BIT(x) - 1)
-
-#define AT24CS_SERIAL_SIZE 16
-#define AT24CS_SERIAL_ADDR(addr) (addr + 0x08)
-
 /* create non-zero magic value for given eeprom parameters */
 #define AT24_DEVICE_MAGIC(_len, _flags) 		\
 	((1 << AT24_SIZE_FLAGS | (_flags)) 		\
-- 
2.1.4

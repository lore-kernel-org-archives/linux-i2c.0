From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/14] eeprom: at24: platform_data: use BIT() macro
Date: Sun, 29 May 2016 23:53:46 +0200
Message-ID: <1464558832-2262-9-git-send-email-bgolaszewski@baylibre.com>
References: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

Use BIT() macro to replace the 0xXX constants in platform_data flags
definitions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/at24.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index dc9a13e..d5e9024 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/bitops.h>
 
 /**
  * struct at24_platform_data - data to set up at24 (generic eeprom) driver
@@ -43,10 +44,10 @@ struct at24_platform_data {
 	u32		byte_len;		/* size (sum of all addr) */
 	u16		page_size;		/* for writes */
 	u8		flags;
-#define AT24_FLAG_ADDR16	0x80	/* address pointer is 16 bit */
-#define AT24_FLAG_READONLY	0x40	/* sysfs-entry will be read-only */
-#define AT24_FLAG_IRUGO		0x20	/* sysfs-entry will be world-readable */
-#define AT24_FLAG_TAKE8ADDR	0x10	/* take always 8 addresses (24c00) */
+#define AT24_FLAG_ADDR16	BIT(7)	/* address pointer is 16 bit */
+#define AT24_FLAG_READONLY	BIT(6)	/* sysfs-entry will be read-only */
+#define AT24_FLAG_IRUGO		BIT(5)	/* sysfs-entry will be world-readable */
+#define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
 
 	void		(*setup)(struct nvmem_device *nvmem, void *context);
 	void		*context;
-- 
2.7.4

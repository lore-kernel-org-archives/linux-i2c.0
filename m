From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/9] eeprom: at24: platform_data: use BIT() macro
Date: Mon, 12 Oct 2015 16:31:13 +0200
Message-ID: <1444660281-19150-2-git-send-email-bgolaszewski@baylibre.com>
References: <1444660281-19150-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444660281-19150-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Patrick Titiano <ptitiano@baylibre.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

Use BIT() macro to replace the 0xXX constants in platform_data flags
definitions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/at24.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index c42aa89..8d90f52 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -43,10 +43,10 @@ struct at24_platform_data {
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
 
 	void		(*setup)(struct memory_accessor *, void *context);
 	void		*context;
-- 
2.1.4

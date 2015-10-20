From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 2/9] eeprom: at24: new flag in platform_data
Date: Tue, 20 Oct 2015 10:43:20 +0200
Message-ID: <1445330607-12470-3-git-send-email-bgolaszewski@baylibre.com>
References: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445330607-12470-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

In preparation for supporting the at24cs EEPROM series add a new flag to
platform data. When set, it should tell the driver that the chip has an
additional read-only memory area that holds a factory pre-programmed serial
number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/at24.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index 8d90f52..5686f91 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -47,6 +47,7 @@ struct at24_platform_data {
 #define AT24_FLAG_READONLY	BIT(6)	/* sysfs-entry will be read-only */
 #define AT24_FLAG_IRUGO		BIT(5)	/* sysfs-entry will be world-readable */
 #define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
+#define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
 
 	void		(*setup)(struct memory_accessor *, void *context);
 	void		*context;
-- 
2.1.4

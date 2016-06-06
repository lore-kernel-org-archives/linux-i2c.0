From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 08/14] eeprom: at24: platform_data: use BIT() macro
Date: Mon,  6 Jun 2016 10:48:50 +0200
Message-ID: <1465202936-16832-9-git-send-email-bgolaszewski@baylibre.com>
References: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36719 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbcFFItQ (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Jun 2016 04:49:16 -0400
Received: by mail-wm0-f46.google.com with SMTP id n184so81006169wmn.1
        for <linux-i2c@vger.kernel.org>; Mon, 06 Jun 2016 01:49:15 -0700 (PDT)
In-Reply-To: <1465202936-16832-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use BIT() macro to replace the 0xXX constants in platform_data flags
definitions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/at24.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index be830b1..fcfdfe3 100644
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

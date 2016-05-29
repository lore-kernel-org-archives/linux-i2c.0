From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 09/14] eeprom: at24: platform_data: add serial number flag
Date: Sun, 29 May 2016 23:53:47 +0200
Message-ID: <1464558832-2262-10-git-send-email-bgolaszewski@baylibre.com>
References: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35482 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbcE2VyX (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 29 May 2016 17:54:23 -0400
Received: by mail-wm0-f51.google.com with SMTP id a136so61562088wme.0
        for <linux-i2c@vger.kernel.org>; Sun, 29 May 2016 14:54:23 -0700 (PDT)
In-Reply-To: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In preparation for supporting the at24cs EEPROM series add a new flag
to the at24 platform data. When set, it should tell the driver that
the chip has an additional read-only memory area that holds a factory
pre-programmed serial number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/at24.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index d5e9024..fe0507e 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -48,6 +48,7 @@ struct at24_platform_data {
 #define AT24_FLAG_READONLY	BIT(6)	/* sysfs-entry will be read-only */
 #define AT24_FLAG_IRUGO		BIT(5)	/* sysfs-entry will be world-readable */
 #define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
+#define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
 
 	void		(*setup)(struct nvmem_device *nvmem, void *context);
 	void		*context;
-- 
2.7.4

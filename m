From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 06/13] eeprom: at24: add serial number flag
Date: Thu, 24 Mar 2016 15:46:00 +0100
Message-ID: <1458830767-23816-7-git-send-email-bgolaszewski@baylibre.com>
References: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34522 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbcCXOqS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 10:46:18 -0400
Received: by mail-wm0-f46.google.com with SMTP id p65so277603857wmp.1
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 07:46:18 -0700 (PDT)
In-Reply-To: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

In preparation for supporting the at24cs EEPROM series add a new flag
to platform data. When set, it should tell the driver that the chip
has an additional read-only memory area that holds a factory
pre-programmed serial number.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/at24.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index a543b93..5bc02fe 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -47,6 +47,7 @@ struct at24_platform_data {
 #define AT24_FLAG_READONLY	BIT(6)	/* sysfs-entry will be read-only */
 #define AT24_FLAG_IRUGO		BIT(5)	/* sysfs-entry will be world-readable */
 #define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
+#define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
 
 	void		(*setup)(struct nvmem_device *nvmem, void *context);
 	void		*context;
-- 
2.7.4

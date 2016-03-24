From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/13] eeprom: at24: add at24mac series flag
Date: Thu, 24 Mar 2016 15:46:05 +0100
Message-ID: <1458830767-23816-12-git-send-email-bgolaszewski@baylibre.com>
References: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33039 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcCXOqX (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 10:46:23 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so278049239wml.0
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 07:46:22 -0700 (PDT)
In-Reply-To: <1458830767-23816-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

As part of supporting the at24mac series add a new flag to the at24
platform data. When set, it indicates that this chip exposes the
factory-programmed EUI-48 or EUI-64 address.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_data/at24.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index 5bc02fe..fa89605 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -48,6 +48,7 @@ struct at24_platform_data {
 #define AT24_FLAG_IRUGO		BIT(5)	/* sysfs-entry will be world-readable */
 #define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
 #define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
+#define AT24_FLAG_MAC		BIT(2)	/* factory-programmed mac address */
 
 	void		(*setup)(struct nvmem_device *nvmem, void *context);
 	void		*context;
-- 
2.7.4

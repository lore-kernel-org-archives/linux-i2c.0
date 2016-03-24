From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 06/13] eeprom: at24: add serial number flag
Date: Thu, 24 Mar 2016 17:19:36 +0100
Message-ID: <1458836383-6668-7-git-send-email-bgolaszewski@baylibre.com>
References: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37955 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651AbcCXQTy (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Mar 2016 12:19:54 -0400
Received: by mail-wm0-f50.google.com with SMTP id l68so73703873wml.1
        for <linux-i2c@vger.kernel.org>; Thu, 24 Mar 2016 09:19:53 -0700 (PDT)
In-Reply-To: <1458836383-6668-1-git-send-email-bgolaszewski@baylibre.com>
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

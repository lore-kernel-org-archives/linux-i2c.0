From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 4/4] eeprom: at24: extend the list of chips supported in DT
Date: Thu, 28 Dec 2017 11:49:13 +0100
Message-ID: <20171228104913.29873-5-brgl@bgdev.pl>
References: <20171228104913.29873-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44295 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753349AbdL1KtY (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Dec 2017 05:49:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id t8so43247476wmc.3
        for <linux-i2c@vger.kernel.org>; Thu, 28 Dec 2017 02:49:23 -0800 (PST)
In-Reply-To: <20171228104913.29873-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Add all supported at24 variants to the of_match table.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/misc/eeprom/at24.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e79833d62284..01f9c4921c50 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -209,13 +209,22 @@ MODULE_DEVICE_TABLE(i2c, at24_ids);
 static const struct of_device_id at24_of_match[] = {
 	{ .compatible = "atmel,24c00",		.data = &at24_data_24c00 },
 	{ .compatible = "atmel,24c01",		.data = &at24_data_24c01 },
+	{ .compatible = "atmel,24cs01",		.data = &at24_data_24cs01 },
 	{ .compatible = "atmel,24c02",		.data = &at24_data_24c02 },
+	{ .compatible = "atmel,24cs02",		.data = &at24_data_24cs02 },
+	{ .compatible = "atmel,24mac402",	.data = &at24_data_24mac402 },
+	{ .compatible = "atmel,24mac602",	.data = &at24_data_24mac602 },
 	{ .compatible = "atmel,spd",		.data = &at24_data_spd },
 	{ .compatible = "atmel,24c04",		.data = &at24_data_24c04 },
+	{ .compatible = "atmel,24cs04",		.data = &at24_data_24cs04 },
 	{ .compatible = "atmel,24c08",		.data = &at24_data_24c08 },
+	{ .compatible = "atmel,24cs08",		.data = &at24_data_24cs08 },
 	{ .compatible = "atmel,24c16",		.data = &at24_data_24c16 },
+	{ .compatible = "atmel,24cs16",		.data = &at24_data_24cs16 },
 	{ .compatible = "atmel,24c32",		.data = &at24_data_24c32 },
+	{ .compatible = "atmel,24cs32",		.data = &at24_data_24cs32 },
 	{ .compatible = "atmel,24c64",		.data = &at24_data_24c64 },
+	{ .compatible = "atmel,24cs64",		.data = &at24_data_24cs64 },
 	{ .compatible = "atmel,24c128",		.data = &at24_data_24c128 },
 	{ .compatible = "atmel,24c256",		.data = &at24_data_24c256 },
 	{ .compatible = "atmel,24c512",		.data = &at24_data_24c512 },
-- 
2.15.1

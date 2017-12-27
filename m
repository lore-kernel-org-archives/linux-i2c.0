From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 4/5] dt-bindings: at24: extend the list of supported chips
Date: Wed, 27 Dec 2017 14:50:53 +0100
Message-ID: <20171227135054.29690-5-brgl@bgdev.pl>
References: <20171227135054.29690-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40898 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdL0NvM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Dec 2017 08:51:12 -0500
Received: by mail-wr0-f195.google.com with SMTP id p17so13050566wre.7
        for <linux-i2c@vger.kernel.org>; Wed, 27 Dec 2017 05:51:12 -0800 (PST)
In-Reply-To: <20171227135054.29690-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Add other variants of at24 EEPROMs we support in the driver to the
list of allowed compatible fallbacks.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 7d4dc264b3cc..7b01fa020ae4 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -7,13 +7,22 @@ Required properties:
 
                 "atmel,24c00",
                 "atmel,24c01",
+                "atmel,24cs01",
                 "atmel,24c02",
+                "atmel,24cs02",
+                "atmel,24mac402",
+                "atmel,24mac602",
                 "atmel,spd",
                 "atmel,24c04",
+                "atmel,24cs04",
                 "atmel,24c08",
+                "atmel,24cs08",
                 "atmel,24c16",
+                "atmel,24cs16",
                 "atmel,24c32",
+                "atmel,24cs32",
                 "atmel,24c64",
+                "atmel,24cs64",
                 "atmel,24c128",
                 "atmel,24c256",
                 "atmel,24c512",
-- 
2.15.1

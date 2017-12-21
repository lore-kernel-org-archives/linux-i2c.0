From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 3/5] dt-bindings: at24: fix formatting and style
Date: Thu, 21 Dec 2017 14:48:40 +0100
Message-ID: <20171221134842.31287-4-brgl@bgdev.pl>
References: <20171221134842.31287-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39487 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdLUNs4 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:48:56 -0500
Received: by mail-wm0-f66.google.com with SMTP id i11so15883671wmf.4
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:48:55 -0800 (PST)
In-Reply-To: <20171221134842.31287-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Make formatting and style consistent for the entire document.

This patch doesn't change the content of the binding.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 2702f2456971..1068b4309fed 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -2,7 +2,7 @@ EEPROMs (I2C)
 
 Required properties:
 
-  - compatible: must be one of the following:
+  - compatible: Must be one of the following:
 
         "atmel,24c00",
         "atmel,24c01",
@@ -30,23 +30,23 @@ Required properties:
 
   will still work, but are now deprecated.
 
-  - reg : the I2C address of the EEPROM
+  - reg: The I2C address of the EEPROM.
 
 Optional properties:
 
-  - pagesize : the length of the pagesize for writing. Please consult the
-               manual of your device, that value varies a lot. A wrong value
-	       may result in data loss! If not specified, a safety value of
-	       '1' is used which will be very slow.
+  - pagesize: The length of the pagesize for writing. Please consult the
+              manual of your device, that value varies a lot. A wrong value
+              may result in data loss! If not specified, a safety value of
+              '1' is used which will be very slow.
 
-  - read-only: this parameterless property disables writes to the eeprom
+  - read-only: This parameterless property disables writes to the eeprom.
 
-  - size: total eeprom size in bytes
+  - size: Total eeprom size in bytes.
 
-  - no-read-rollover:
-			This parameterless property indicates that the multi-address
-			eeprom does not automatically roll over reads to the next
-			slave address. Please consult the manual of your device.
+  - no-read-rollover: This parameterless property indicates that the
+                      multi-address eeprom does not automatically roll over
+                      reads to the next slave address. Please consult the
+                      manual of your device.
 
   - wp-gpios: GPIO to which the write-protect pin of the chip is connected.
 
-- 
2.15.1

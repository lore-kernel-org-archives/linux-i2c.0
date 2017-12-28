From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 1/4] dt-bindings: at24: consistently document the compatible property
Date: Thu, 28 Dec 2017 11:49:10 +0100
Message-ID: <20171228104913.29873-2-brgl@bgdev.pl>
References: <20171228104913.29873-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38077 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbdL1KtU (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 28 Dec 2017 05:49:20 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so43142412wme.3
        for <linux-i2c@vger.kernel.org>; Thu, 28 Dec 2017 02:49:19 -0800 (PST)
In-Reply-To: <20171228104913.29873-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Current description of the compatible property for at24 is quite vague.

State explicitly that any "<manufacturer>,<model>" pair is accepted as
long as a correct fallback is used for non-atmel chips.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 58 ++++++++++++++---------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index cbc80e194ac6..0c8e1341908f 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -2,28 +2,42 @@ EEPROMs (I2C)
 
 Required properties:
 
-  - compatible : should be "<manufacturer>,<type>", like these:
-
-	"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
-	"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
-	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
-
-	"catalyst,24c32"
-
-	"microchip,24c128"
-
-	"ramtron,24c64"
-
-	"renesas,r1ex24002"
-
-	The following manufacturers values have been deprecated:
-	"at", "at24"
-
-	 If there is no specific driver for <manufacturer>, a generic
-	 device with <type> and manufacturer "atmel" should be used.
-	 Possible types are:
-	 "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
-	 "24c128", "24c256", "24c512", "24c1024", "spd"
+  - compatible: Must be a "<manufacturer>,<model>" pair. The following <model>
+                values are supported (assuming "atmel" as manufacturer):
+
+                "atmel,24c00",
+                "atmel,24c01",
+                "atmel,24c02",
+                "atmel,spd",
+                "atmel,24c04",
+                "atmel,24c08",
+                "atmel,24c16",
+                "atmel,24c32",
+                "atmel,24c64",
+                "atmel,24c128",
+                "atmel,24c256",
+                "atmel,24c512",
+                "atmel,24c1024",
+
+                If <manufacturer> is not "atmel", then a fallback must be used
+                with the same <type> and "atmel" as manufacturer.
+
+                Example:
+                        compatible = "microchip,24c128", "atmel,24c128";
+
+		Supported manufacturers are:
+
+                "catalyst",
+                "microchip",
+                "ramtron",
+                "renesas",
+                "nxp",
+                "st",
+
+                Some vendors use different model names for chips which are just
+                variants of the above. Known such exceptions are listed below:
+
+                "renesas,r1ex24002" - the fallback is "atmel,24c02"
 
   - reg : the I2C address of the EEPROM
 
-- 
2.15.1

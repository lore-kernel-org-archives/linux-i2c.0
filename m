From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/5] dt-bindings: at24: consistently document the compatible property
Date: Thu, 21 Dec 2017 14:08:26 +0100
Message-ID: <20171221130830.16813-2-brgl@bgdev.pl>
References: <20171221130830.16813-1-brgl@bgdev.pl>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39599 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbdLUNIl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Dec 2017 08:08:41 -0500
Received: by mail-wr0-f196.google.com with SMTP id a41so25082433wra.6
        for <linux-i2c@vger.kernel.org>; Thu, 21 Dec 2017 05:08:40 -0800 (PST)
In-Reply-To: <20171221130830.16813-1-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>

Current description of the compatible property for at24 is quite vague.

Specify an exact list of accepted compatibles and document the - now
deprecated - strings which were previously used in device tree files.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 50 +++++++++++++----------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index cbc80e194ac6..6ccbd000bfa4 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -2,28 +2,34 @@ EEPROMs (I2C)
 
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
+  - compatible: must be one of the following:
+
+        "atmel,24c00",
+        "atmel,24c01",
+        "atmel,24c02",
+        "atmel,24c04",
+        "atmel,24c08",
+        "atmel,24c16",
+        "atmel,24c32",
+        "atmel,24c64",
+        "atmel,24c128",
+        "atmel,24c256",
+        "atmel,24c512",
+        "atmel,24c1024"
+
+  NOTE: old compatible strings, such as:
+
+        "catalyst,24c32",
+        "microchip,24c128",
+        "ramtron,24c64",
+        "renesas,r1ex24002",
+        "at,24c08",
+        "at24,24c08"
+
+  will still work, but are now deprecated.
+
+  Also: matching by device type alone - while still supported due to
+  implementation details in I2C core - is deprecated as well.
 
   - reg : the I2C address of the EEPROM
 
-- 
2.15.1

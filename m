From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: [PATCH v2 1/5] dt-bindings: at24: consistently document the compatible property
Date: Thu, 21 Dec 2017 14:48:38 +0100
Message-ID: <20171221134842.31287-2-brgl@bgdev.pl>
References: <20171221134842.31287-1-brgl@bgdev.pl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171221134842.31287-1-brgl-ARrdPY/1zhM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Current description of the compatible property for at24 is quite vague.

Specify an exact list of accepted compatibles and document the - now
deprecated - strings which were previously used in device tree files.

Signed-off-by: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Reviewed-by: Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 48 ++++++++++++-----------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index cbc80e194ac6..16b687458b14 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -2,28 +2,32 @@ EEPROMs (I2C)
 
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
+        "at24,24c08",
+        "24c32"
+
+  will still work, but are now deprecated.
 
   - reg : the I2C address of the EEPROM
 
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

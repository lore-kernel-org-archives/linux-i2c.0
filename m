From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: [PATCH v3 3/5] dt-bindings: at24: fix formatting and style
Date: Wed, 27 Dec 2017 14:50:52 +0100
Message-ID: <20171227135054.29690-4-brgl@bgdev.pl>
References: <20171227135054.29690-1-brgl@bgdev.pl>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171227135054.29690-1-brgl-ARrdPY/1zhM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make formatting and style consistent for the entire document.

This patch doesn't change the content of the binding.

Signed-off-by: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Reviewed-by: Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 487e1005036c..7d4dc264b3cc 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -2,7 +2,7 @@ EEPROMs (I2C)
 
 Required properties:
 
-  - compatible: must be a "<manufacturer>,<model>" pair with one of the
+  - compatible: Must be a "<manufacturer>,<model>" pair with one of the
                 following values as fallback:
 
                 "atmel,24c00",
@@ -19,23 +19,23 @@ Required properties:
                 "atmel,24c512",
                 "atmel,24c1024"
 
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

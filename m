From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 2/4] dt-bindings: at24: fix formatting and style
Date: Thu, 28 Dec 2017 11:49:11 +0100
Message-ID: <20171228104913.29873-3-brgl@bgdev.pl>
References: <20171228104913.29873-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228104913.29873-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Make formatting and style consistent for the entire document.

This patch doesn't change the content of the binding.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 0c8e1341908f..5e0dfd25b1e3 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -39,23 +39,23 @@ Required properties:
 
                 "renesas,r1ex24002" - the fallback is "atmel,24c02"
 
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

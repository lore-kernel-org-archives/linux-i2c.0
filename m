From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 3/5] dt-bindings: at24: fix formatting and style
Date: Thu, 21 Dec 2017 14:08:28 +0100
Message-ID: <20171221130830.16813-4-brgl@bgdev.pl>
References: <20171221130830.16813-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171221130830.16813-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Make formatting and style consistent for the entire document.

This patch doesn't change the content of the binding.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 0322db43c8a4..8a6b960ddeee 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -2,7 +2,7 @@ EEPROMs (I2C)
 
 Required properties:
 
-  - compatible: must be one of the following:
+  - compatible: Must be one of the following:
 
         "atmel,24c00",
         "atmel,24c01",
@@ -32,23 +32,23 @@ Required properties:
   Also: matching by device type alone - while still supported due to
   implementation details in I2C core - is deprecated as well.
 
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

From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 2/5] dt-bindings: at24: add a missing compatible
Date: Wed, 27 Dec 2017 14:50:51 +0100
Message-ID: <20171227135054.29690-3-brgl@bgdev.pl>
References: <20171227135054.29690-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171227135054.29690-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

"atmel,spd" is reported by checkpatch as undocumented in the device
tree bindings. Add it to the list of supported compatible fallbacks.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index b5ce5a247554..487e1005036c 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -8,6 +8,7 @@ Required properties:
                 "atmel,24c00",
                 "atmel,24c01",
                 "atmel,24c02",
+                "atmel,spd",
                 "atmel,24c04",
                 "atmel,24c08",
                 "atmel,24c16",
-- 
2.15.1

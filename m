From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/2] dt-bindings: at24: add the 'num-addresses' property
Date: Tue,  5 Feb 2019 14:59:33 +0100
Message-ID: <20190205135934.18841-2-brgl@bgdev.pl>
References: <20190205135934.18841-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205135934.18841-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the at24 driver only creates additional i2c dummies for
atmel,24c00 and it's hard-coded. Some other chips (like for example
Microchip's 24AA02T) also take more slave addresses despite being
otherwise compatible with already supported variants.

Add a new property to the device tree binding document that defines
the total number of i2c slave addresses taken by the device. The
addresses are counted starting from the one in the reg property.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index f9a7c984274c..0e456bbc1213 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -75,6 +75,8 @@ Optional properties:
 
   - address-width: number of address bits (one of 8, 16).
 
+  - num-addresses: total number of i2c slave addresses this device takes
+
 Example:
 
 eeprom@52 {
@@ -82,4 +84,5 @@ eeprom@52 {
 	reg = <0x52>;
 	pagesize = <32>;
 	wp-gpios = <&gpio1 3 0>;
+	num-addresses = <8>;
 };
-- 
2.20.1

From: Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH v4 4/5] dt-bindings: at25: add reference for the wp-gpios property
Date: Tue,  7 Jan 2020 10:29:21 +0100
Message-ID: <20200107092922.18408-5-ktouil@baylibre.com>
References: <20200107092922.18408-1-ktouil@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200107092922.18408-1-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bgolaszewski@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, srinivas.kandagatla@linaro.org, baylibre-upstreaming@groups.io
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org, Khouloud Touil <ktouil@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

As the at25 uses the NVMEM subsystem, and the property is now being
handled, adding reference for it in the device tree binding document,
which allows to specify the GPIO line to which the write-protect pin
is connected.

Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
---
 Documentation/devicetree/bindings/eeprom/at25.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
index 42577dd113dd..fcacd97abd0a 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.txt
+++ b/Documentation/devicetree/bindings/eeprom/at25.txt
@@ -20,6 +20,7 @@ Optional properties:
 - spi-cpha : SPI shifted clock phase, as per spi-bus bindings.
 - spi-cpol : SPI inverse clock polarity, as per spi-bus bindings.
 - read-only : this parameter-less property disables writes to the eeprom
+- wp-gpios : GPIO to which the write-protect pin of the chip is connected
 
 Obsolete legacy properties can be used in place of "size", "pagesize",
 "address-width", and "read-only":
@@ -36,6 +37,7 @@ Example:
 		spi-max-frequency = <5000000>;
 		spi-cpha;
 		spi-cpol;
+		wp-gpios = <&gpio1 3 0>;
 
 		pagesize = <64>;
 		size = <32768>;
-- 
2.17.1

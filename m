From: Adrian Bunk <bunk@kernel.org>
Subject: [4.9/4.14 patch v2 1/2] dt-bindings: eeprom: at24: add "atmel,24c2048" compatible string
Date: Sun, 17 Feb 2019 13:14:51 +0200
Message-ID: <20190217111452.6152-2-bunk@kernel.org>
References: <20190217111452.6152-1-bunk@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190217111452.6152-1-bunk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

commit 6c0c5dc33ff42af49243e94842d0ebdb153189ea upstream.

Add new compatible to the device tree bindings.

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index afc04589eadf..3c9a822d576c 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -6,7 +6,8 @@ Required properties:
 
 	"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
 	"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
-	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
+	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024",
+	"atmel,24c2048"
 
 	"catalyst,24c32"
 
@@ -23,7 +24,7 @@ Required properties:
 	 device with <type> and manufacturer "atmel" should be used.
 	 Possible types are:
 	 "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
-	 "24c128", "24c256", "24c512", "24c1024", "spd"
+	 "24c128", "24c256", "24c512", "24c1024", "24c2048", "spd"
 
   - reg : the I2C address of the EEPROM
 
-- 
2.11.0

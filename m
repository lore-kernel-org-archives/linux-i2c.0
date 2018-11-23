From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2] dt-bindings: i2c: Use correct vendor prefix for Atmel
Date: Fri, 23 Nov 2018 13:51:38 +0100
Message-ID: <20181123125138.22489-1-thierry.reding@gmail.com>
References: <20181123121009.17213-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123121009.17213-1-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The "at," prefix was never correct for Atmel, so fix the few occurrences
that got it wrong. Use "atmel," instead.

While at it, remove the at,24c08 compatible string from the list of
trivial devices because it is already documented in eeprom/at24.txt.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- remove at,24c08 compatible from trivial-devices since it is already
  documented in Documentation/devicetree/bindings/eeprom/at24.txt

 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 2 +-
 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt     | 2 +-
 Documentation/devicetree/bindings/trivial-devices.txt     | 1 -
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
index 1e98c6b3a721..c661b9083ec6 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
@@ -43,7 +43,7 @@ Example:
 			reg = <0>;
 
 			eeprom@50 {
-				compatible = "at,24c02";
+				compatible = "atmel,24c02";
 				reg = <0x50>;
 			};
 		};
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
index ccf6c86ed076..30ac6a60f041 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
@@ -54,7 +54,7 @@ Example:
 			reg = <2>;
 
 			eeprom@54 {
-				compatible = "at,24c08";
+				compatible = "atmel,24c08";
 				reg = <0x54>;
 			};
 		};
diff --git a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt b/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
index 0fbbc6970ec5..42bfc09c8918 100644
--- a/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
+++ b/Documentation/devicetree/bindings/i2c/nxp,pca9541.txt
@@ -22,7 +22,7 @@ Example:
 			#size-cells = <0>;
 
 			eeprom@54 {
-				compatible = "at,24c08";
+				compatible = "atmel,24c08";
 				reg = <0x54>;
 			};
 		};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 6ab001fa1ed4..94beb5a63ac2 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -21,7 +21,6 @@ adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
 adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 ams,iaq-core		AMS iAQ-Core VOC Sensor
-at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
-- 
2.19.1

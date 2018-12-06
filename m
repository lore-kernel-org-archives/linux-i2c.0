From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] dt-bindings: i2c: use correct vendor prefix for atmel's at24 EEPROMs
Date: Thu,  6 Dec 2018 10:45:50 +0100
Message-ID: <20181206094550.18082-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org

This is a follow-up to Thierry's patch which missed a few occurences.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt        | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index ef973a0343c7..b7cec17c3daf 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -33,7 +33,7 @@ i2c0: i2c@fff84000 {
 	clock-frequency = <400000>;
 
 	24c512@50 {
-		compatible = "24c512";
+		compatible = "atmel,24c512";
 		reg = <0x50>;
 		pagesize = <128>;
 	}
diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
index c661b9083ec6..8b1e49cdce3f 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
@@ -54,7 +54,7 @@ Example:
 			reg = <1>;
 
 			eeprom@50 {
-				compatible = "at,24c02";
+				compatible = "atmel,24c02";
 				reg = <0x50>;
 			};
 		};
-- 
2.19.1

From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
Date: Tue, 16 Jan 2018 17:06:15 +0100
Message-ID: <20180116160618.27859-2-peda@axentia.se>
References: <20180116160618.27859-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180116160618.27859-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Makes them easier to find.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
index 1812c848e369..abfae1beca2b 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.txt
+++ b/Documentation/devicetree/bindings/eeprom/at24.txt
@@ -38,9 +38,9 @@ Required properties:
 
                 "catalyst",
                 "microchip",
+                "nxp",
                 "ramtron",
                 "renesas",
-                "nxp",
                 "st",
 
                 Some vendors use different model names for chips which are just
-- 
2.11.0

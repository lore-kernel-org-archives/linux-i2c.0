From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 3/3] dt-bindings: i2c: eeprom: document "mac-offset" binding
Date: Thu, 6 Jul 2017 13:16:57 +0300
Message-ID: <1499336217-16913-4-git-send-email-claudiu.beznea@microchip.com>
References: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, nsekhar@ti.com, david@lechnology.com, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-i2c@vger.kernel.org

Document "mac-offset" binding that will be used by at24 EEPROM driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index a50dc01..3dd267c 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -35,10 +35,13 @@ Optional properties:
 
   - read-only: this parameterless property disables writes to the eeprom
 
+  - mac-offset: offset in EEPROM where MAC address starts
+
 Example:
 
 eeprom@52 {
 	compatible = "atmel,24c32";
 	reg = <0x52>;
 	pagesize = <32>;
+	mac-offset = <0xf8>;
 };
-- 
2.7.4

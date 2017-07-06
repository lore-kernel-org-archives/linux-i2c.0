From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] dt-bindings: i2c: eeprom: document all at24 bindings
Date: Thu, 6 Jul 2017 13:16:55 +0300
Message-ID: <1499336217-16913-2-git-send-email-claudiu.beznea@microchip.com>
References: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:58707 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdGFKRP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 6 Jul 2017 06:17:15 -0400
In-Reply-To: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, nsekhar@ti.com, david@lechnology.com, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, Claudiu Beznea <claudiu.beznea@microchip.com>

Document all at24 memories specific bindings.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/eeprom/eeprom.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index 5696eb5..a50dc01 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -4,9 +4,11 @@ Required properties:
 
   - compatible : should be "<manufacturer>,<type>", like these:
 
-	"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
-	"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
-	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
+	"atmel,24c00", "atmel,24c01", "atmel,24cs01", "atmel,24c02", "atmel,24cs02",
+	"atmel,24mac402", "atmel,24mac602", "atmel,spd", "atmel,24c04",
+	"atmel,24cs04", "atmel,24c08", "atmel,24cs08", "atmel,24c16", "atmel,24cs16",
+	"atmel,24c32", "atmel,24cs32", "atmel,24c64", "atmel,24cs64", "atmel,24c128",
+	"atmel,24c256", "atmel,24c512", "atmel,24c1024"
 
 	"catalyst,24c32"
 
@@ -16,10 +18,11 @@ Required properties:
 
 	"renesas,r1ex24002"
 
-	 If there is no specific driver for <manufacturer>, a generic
-	 driver based on <type> is selected. Possible types are:
-	 "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
-	 "24c128", "24c256", "24c512", "24c1024", "spd"
+	If there is no specific driver for <manufacturer>, a generic
+	driver based on <type> is selected. Possible types are:
+	"24c00", "24c01", "24cs01", "24c02", "24cs02", "24mac402", "24mac602", "spd",
+	"24c04", "24cs04", "24c08", "24cs08", "24c16", "24cs16", "24c32", "24cs32",
+	"24c64", "24cs64", "24c128", "24c256", "24c512", "24c1024"
 
   - reg : the I2C address of the EEPROM
 
-- 
2.7.4

From: Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH] i2c: at91: document clock properties
Date: Tue, 17 Dec 2013 16:54:04 +0100
Message-ID: <1387295644-7382-1-git-send-email-b.brezillon@overkiz.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>, Ludovic Desroches <ludovic.desroches@atmel.com>, Wolfram Sang <wsa@the-dreams.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Boris BREZILLON <b.brezillon@overkiz.com>
List-Id: linux-i2c@vger.kernel.org

Document the clock properties required by the at91 i2c bus driver.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index b689a0d..4fade84 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -9,6 +9,7 @@ Required properties :
 - interrupts: interrupt number to the cpu.
 - #address-cells = <1>;
 - #size-cells = <0>;
+- clocks: phandles to input clocks.
 
 Optional properties:
 - Child nodes conforming to i2c bus binding
@@ -21,6 +22,7 @@ i2c0: i2c@fff84000 {
 	interrupts = <12 4 6>;
 	#address-cells = <1>;
 	#size-cells = <0>;
+	clocks = <&twi0_clk>;
 
 	24c512@50 {
 		compatible = "24c512";
-- 
1.7.9.5


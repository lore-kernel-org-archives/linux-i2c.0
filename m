From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/3] i2c: at91: add DT property "atmel,twd-hold-cycles" to binding
Date: Tue, 24 Nov 2015 14:47:41 +0100
Message-ID: <1448372862-11912-2-git-send-email-ludovic.desroches@atmel.com>
References: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:58131 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbKXNsI (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Nov 2015 08:48:08 -0500
In-Reply-To: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, plagnioj@jcrosoft.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cyrille.pichen@atmel.com, Wenyou Yang <wenyou.yang@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>

From: Wenyou Yang <wenyou.yang@atmel.com>

Add a DT property "atmel,twd-hold-cycles" to specify the HOLD
filed of TWIHS_CWGR register to increase the TWD hold time.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index 6e81dc1..c81a0cb 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -17,6 +17,9 @@ Optional properties:
 - dma-names: should contain "tx" and "rx".
 - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
   capable I2C controllers.
+- atmel,twd-hold-cycles: number of cycles for TWD hold time whose value is
+  determinated by (atmel,twd-hold-cycles + 3) x t_peripheral_clock,
+  maximum value is 0x1f.
 - Child nodes conforming to i2c bus binding
 
 Examples :
@@ -29,6 +32,7 @@ i2c0: i2c@fff84000 {
 	#size-cells = <0>;
 	clocks = <&twi0_clk>;
 	clock-frequency = <400000>;
+	atmel,twd-hold-cycles = <2>;
 
 	24c512@50 {
 		compatible = "24c512";
-- 
2.5.0

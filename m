From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 3/3] ARM: dts: at91: specify DT property "atmel,twd-hold-cycles"
Date: Tue, 24 Nov 2015 14:47:42 +0100
Message-ID: <1448372862-11912-3-git-send-email-ludovic.desroches@atmel.com>
References: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:58247 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753355AbbKXNsi (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Nov 2015 08:48:38 -0500
In-Reply-To: <1448372862-11912-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, plagnioj@jcrosoft.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cyrille.pichen@atmel.com, Wenyou Yang <wenyou.yang@atmel.com>

From: Wenyou Yang <wenyou.yang@atmel.com>

Specify the device tree property "atmel,twd-hold-cycles" to 25
to adapt to the PMIC ACT8945A.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index ad6de73..25ffd86 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -129,6 +129,7 @@
 				dmas = <0>, <0>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c0_default>;
+				atmel,twd-hold-cycles = <25>;
 				status = "okay";
 
 				pmic: act8865@5b {
-- 
2.5.0

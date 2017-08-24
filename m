From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/3] ARM: dts: armadillo800eva: Convert to named i2c-gpio bindings
Date: Thu, 24 Aug 2017 11:21:14 +0200
Message-ID: <1503566474-5335-4-git-send-email-geert+renesas@glider.be>
References: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:45062 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdHXJVS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 24 Aug 2017 05:21:18 -0400
In-Reply-To: <1503566474-5335-1-git-send-email-geert+renesas@glider.be>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 153609c1a5d83923..d62d22c36da1c9b9 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -131,9 +131,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <&pfc 208 GPIO_ACTIVE_HIGH /* sda */
-			 &pfc 91 GPIO_ACTIVE_HIGH /* scl */
-			>;
+		sda-gpios = <&pfc 208 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&pfc 91 GPIO_ACTIVE_HIGH>;
 		i2c-gpio,delay-us = <5>;
 	};
 
-- 
2.7.4

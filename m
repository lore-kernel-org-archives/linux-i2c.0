From: Romain Perier <romain.perier@free-electrons.com>
Subject: [PATCH v7 3/4] arm64: dts: marvell: Add I2C definitions for the Armada 3700
Date: Thu,  1 Dec 2016 12:04:39 +0100
Message-ID: <20161201110440.27530-4-romain.perier@free-electrons.com>
References: <20161201110440.27530-1-romain.perier@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55438 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755560AbcLALEp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Dec 2016 06:04:45 -0500
In-Reply-To: <20161201110440.27530-1-romain.perier@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Omri Itach <omrii@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Yahuda Yitschak <yehuday@marvell.com>, Hanna Hawa <hannah@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw>

The Armada 3700 has two i2c bus interface units, this commit adds the
definitions of the corresponding device nodes. It also enables the node
on the development board for this SoC.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts |  4 ++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 1372e9a6..16d84af 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -62,6 +62,10 @@
 	};
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 /* CON3 */
 &sata {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index e9bd587..1b0fd21 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -98,6 +98,24 @@
 			/* 32M internal register @ 0xd000_0000 */
 			ranges = <0x0 0x0 0xd0000000 0x2000000>;
 
+			i2c0: i2c@11000 {
+				compatible = "marvell,armada-3700-i2c";
+				reg = <0x11000 0x24>;
+				clocks = <&nb_periph_clk 10>;
+				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+				mrvl,i2c-fast-mode;
+				status = "disabled";
+			};
+
+			i2c1: i2c@11080 {
+				compatible = "marvell,armada-3700-i2c";
+				reg = <0x11080 0x24>;
+				clocks = <&nb_periph_clk 9>;
+				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				mrvl,i2c-fast-mode;
+				status = "disabled";
+			};
+
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x400>;
-- 
2.9.3

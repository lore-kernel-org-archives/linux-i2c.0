From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 9/9] MIPS: BMIPS: brcmstb: add I2C node for bcm7362
Date: Wed, 21 Oct 2015 11:37:01 +0900
Message-ID: <1445395021-4204-10-git-send-email-jaedon.shin@gmail.com>
References: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33553 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbbJUCiR (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Oct 2015 22:38:17 -0400
In-Reply-To: <1445395021-4204-1-git-send-email-jaedon.shin@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org, Jaedon Shin <jaedon.shin@gmail.com>

Add I2C device nodes to BMIPS based BCM7362 platform.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7362.dtsi     | 52 ++++++++++++++++++++++++++++++--
 arch/mips/boot/dts/brcm/bcm97362svmb.dts | 12 ++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7362.dtsi b/arch/mips/boot/dts/brcm/bcm7362.dtsi
index 6e65db86fc61..5f817be2553c 100644
--- a/arch/mips/boot/dts/brcm/bcm7362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7362.dtsi
@@ -87,14 +87,32 @@
 			compatible = "brcm,bcm7120-l2-intc";
 			reg = <0x406600 0x8>;
 
-			brcm,int-map-mask = <0x44>;
+			brcm,int-map-mask = <0x44>, <0x7000000>;
 			brcm,int-fwd-mask = <0x70000>;
 
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
 			interrupt-parent = <&periph_intc>;
-			interrupts = <56>;
+			interrupts = <56>, <54>;
+			interrupt-names = "upg_main", "upg_bsc";
+		};
+
+		upg_aon_irq0_intc: upg_aon_irq0_intc@408b80 {
+			compatible = "brcm,bcm7120-l2-intc";
+			reg = <0x408b80 0x8>;
+
+			brcm,int-map-mask = <0x40>, <0x8000000>, <0x100000>;
+			brcm,int-fwd-mask = <0>;
+			brcm,irq-can-wake;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			interrupt-parent = <&periph_intc>;
+			interrupts = <57>, <55>, <59>;
+			interrupt-names = "upg_main_aon", "upg_bsc_aon",
+					  "upg_spi";
 		};
 
 		sun_top_ctrl: syscon@404000 {
@@ -144,6 +162,36 @@
 			status = "disabled";
 		};
 
+		bsca: i2c@406200 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406200 0x58>;
+		      interrupts = <24>;
+		      interrupt-names = "upg_bsca";
+		      status = "disabled";
+		};
+
+		bscb: i2c@406280 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_irq0_intc>;
+		      reg = <0x406280 0x58>;
+		      interrupts = <25>;
+		      interrupt-names = "upg_bscb";
+		      status = "disabled";
+		};
+
+		bscd: i2c@408980 {
+		      clock-frequency = <390000>;
+		      compatible = "brcm,brcmstb-i2c";
+		      interrupt-parent = <&upg_aon_irq0_intc>;
+		      reg = <0x408980 0x58>;
+		      interrupts = <27>;
+		      interrupt-names = "upg_bscd";
+		      status = "disabled";
+		};
+
 		enet0: ethernet@430000 {
 			phy-mode = "internal";
 			phy-handle = <&phy1>;
diff --git a/arch/mips/boot/dts/brcm/bcm97362svmb.dts b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
index 739c2ef5663b..9c99bfd1e781 100644
--- a/arch/mips/boot/dts/brcm/bcm97362svmb.dts
+++ b/arch/mips/boot/dts/brcm/bcm97362svmb.dts
@@ -29,6 +29,18 @@
 	status = "okay";
 };
 
+&bsca {
+	status = "okay";
+};
+
+&bscb {
+	status = "okay";
+};
+
+&bscd {
+	status = "okay";
+};
+
 &enet0 {
 	status = "okay";
 };
-- 
2.6.1

Received: from naesa05.arrow.com (naesa05.arrow.com [216.150.161.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C50377575
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325550; cv=none; b=lfPgwoW+8JOcRX1VAK2Fwnv00scsTb/EdPSpwPbtlC6fpxbCxr4KdrTlbf2ZAXAAnfqqZGUw6F17kBjDMgJkrWSfN1jbPY6KaVydZpiNs/sfEr+1BBtFAjYhKznKp2poXKIME6tMGdOSoI2bgb/PBRB8bPBIwElSM8wloo+/3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325550; c=relaxed/simple;
	bh=gqpczxsZtpevSPcilAUNEzilv7uS7JPK3cvn2rFDY30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/U6fUBD10kp9j32bEltp6185UxLwf3pKqouoXrQX5hKPcX0sK+ZGqEkiHerUrvx2+TZ5bUmMqM4wHg4FIn3YpHZEURctwqzDS9pFWjr8Xso8dcPRTmjLI4uguk8MTc5aehYB204FO4ZaoZ8D2r7gn6d+Cbk+CwF2BBDHVL2y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=l25E/Lc5; arc=none smtp.client-ip=216.150.161.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="l25E/Lc5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=20165;
  q=dns/txt; s=NAESA-Selector1; t=1783325544;
  x=1814861544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AVRyNAr9oKk2GQIXZtd2UtolYGKkStM42taIDO7e4bE=;
  b=l25E/Lc5eNw0ZtFxP4pT891wqYvjy1nWY/l/h5VhBq9BvvUmQaOxrF+r
   LzcjeoeGzL5Mj3V9sfscbodeilGcY3f3Y25OZXxGo8KK/g3iaagtFKgQ0
   ALRFEUiMT8bX+sZoBlnsmnK8bINMF0RpAXMTrEKXkvOOzF9Pn7kRkYrq+
   SiMD16EiJHBtn6n85dwzjo018OEpg3T6lJL5piHcAHcH6y6Mb5uIj2mPJ
   BBi46JPR6FrIRV6LVLAUYoGpNrKNPfQq2yG3EeAT6t2qgEVJCk3MNwKiS
   Ku1TyX31N/16TjJ2rYrQdDdSEvfTio227VMwYqCY4YtSmcuvcMLnQItxb
   g==;
X-CSE-ConnectionGUID: uwi9dtxgS/OfgxQMhW+yHw==
X-CSE-MsgGUID: qUXgeXezSVe3FAsUhGAuag==
X-IronPort-AV: E=Sophos;i="6.25,149,1779170400"; 
   d="scan'208";a="57540302"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa05out.arrow.com with ESMTP; 06 Jul 2026 02:11:02 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Mon, 6 Jul 2026 13:40:55 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Min Lin <linmin@eswincomputing.com>
Cc: Yulin Lu <luyulin@eswincomputing.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Darshan Prajapati <darshan.prajapati@einfochips.com>,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	Pritesh Patel <pritesh.patel@einfochips.com>
Subject: [PATCH v2 3/8] riscv: dts: eswin: eic7700: add pinctrl support
Date: Mon,  6 Jul 2026 13:40:50 +0530
Message-Id: <20260706081055.1126275-4-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
References: <20260706081055.1126275-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Jul 2026 08:10:55.0971 (UTC) FILETIME=[F876FB30:01DD0D1E]

From: Yulin Lu <luyulin@eswincomputing.com>

Add pinctrl node and related pin configuration for EIC7700 SoC

Co-developed-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Yulin Lu <luyulin@eswincomputing.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 .../dts/eswin/eic7700-hifive-premier-p550.dts | 109 +++
 .../riscv/boot/dts/eswin/eic7700-pinctrl.dtsi | 888 ++++++++++++++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        |   5 +
 3 files changed, 1002 insertions(+)
 create mode 100644 arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi

diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
index 1266762dfcd8..743dedbdb081 100644
--- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include "eic7700.dtsi"
+#include "eic7700-pinctrl.dtsi"
 
 / {
 	compatible = "sifive,hifive-premier-p550", "eswin,eic7700";
@@ -18,6 +19,15 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	vcc_1v8: regulator-vcc1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
 };
 
 &clock_24m {
@@ -25,6 +35,105 @@ &clock_24m {
 	clock-output-names = "clock_24m";
 };
 
+&gpio0_pins {
+	bias-disable;
+	input-enable;
+};
+
+&gpio5_pins {
+	bias-disable;
+	input-enable;
+};
+
+&gpio11_pins {
+	bias-disable;
+	input-enable;
+};
+
+&gpio14_pins {
+	bias-pull-up;
+	input-disable;
+};
+
+&gpio15_pins {
+	bias-disable;
+	input-enable;
+};
+
+&gpio28_pins {
+	bias-disable;
+	input-enable;
+};
+
+&gpio43_pins {
+	bias-disable;
+	input-disable;
+};
+
+&gpio71_pins {
+	bias-pull-up;
+	input-disable;
+};
+
+&gpio74_pins {
+	bias-pull-up;
+	input-disable;
+};
+
+&gpio76_pins {
+	bias-disable;
+	input-disable;
+};
+
+&gpio77_pins {
+	bias-pull-up;
+	input-disable;
+};
+
+&gpio79_pins {
+	bias-disable;
+	input-disable;
+};
+
+&gpio80_pins {
+	bias-pull-up;
+	input-disable;
+};
+
+&gpio82_pins {
+	bias-pull-up;
+	input-disable;
+};
+
+&gpio84_pins {
+	bias-disable;
+	input-disable;
+};
+
+&gpio85_pins {
+	bias-pull-up;
+	input-disable;
+};
+
+&gpio94_pins {
+	bias-disable;
+	input-disable;
+};
+
+&gpio106_pins {
+	bias-disable;
+	input-disable;
+};
+
+&gpio111_pins {
+	bias-disable;
+	input-disable;
+};
+
+&pinctrl {
+	vrgmii-supply = <&vcc_1v8>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi b/arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi
new file mode 100644
index 000000000000..2d655b442982
--- /dev/null
+++ b/arch/riscv/boot/dts/eswin/eic7700-pinctrl.dtsi
@@ -0,0 +1,888 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 Beijing ESWIN Computing Technology Co., Ltd.
+ *
+ * ESWIN's EIC7700 SoC pin-mux and pin-config options are listed as
+ * device tree nodes in this file.
+ *
+ * Authors: Yulin Lu <luyulin@eswincomputing.com>
+ */
+
+&pinctrl{
+	default-pins-grp {
+		sata_act_led_pins: sata-act-led-pins{
+			pins = "gpio27";
+			function = "sata";
+		};
+
+		emmc_led_ctrl_pins: emmc-led-ctrl-pins {
+			pins = "gpio29";
+			function = "emmc";
+		};
+
+		sd0_led_ctrl_pins: sd0-led-ctrl-pins {
+			pins = "gpio34";
+			function = "sdio";
+		};
+
+		sd1_led_ctrl_pins: sd1-led-ctrl-pins {
+			pins = "spi1_d2";
+			function = "sdio";
+		};
+
+		i2c6_pins: i2c6-pins {
+			pins = "uart1_cts", "uart1_rts";
+			function = "i2c";
+		};
+
+		i2c7_pins: i2c7-pins {
+			pins = "uart2_tx", "uart2_rx";
+			function = "i2c";
+		};
+
+		i2c9_pins: i2c9-pins {
+			pins = "spi1_d0", "spi1_d1";
+			function = "i2c";
+		};
+
+		pwm1_pins: pwm1-pins {
+			pins = "spi1_d3";
+			function = "pwm";
+		};
+
+		pwm2_pins: pwm2-pins {
+			pins = "spi1_cs1_n";
+			function = "pwm";
+		};
+
+		mipi_csi_xtrig0_pins: mipi-csi-xtrig0-pins {
+			pins = "gpio92";
+			function = "mipi_csi";
+		};
+
+		mipi_csi_xtrig1_pins: mipi-csi-xtrig1-pins {
+			pins = "gpio93";
+			function = "mipi_csi";
+		};
+
+		dual_spi2_pins: dual-spi2-pins {
+			pins = "spi2_cs0_n", "jtag0_tck", "jtag0_tms", "jtag0_tdi";
+			function = "spi";
+		};
+
+		quad_spi2_pins: quad-spi2-pins {
+			pins = "spi2_cs0_n", "spi2_cs1_n", "jtag0_tck", "jtag0_tms",
+			       "jtag0_tdi", "jtag0_tdo", "gpio5";
+			function = "spi";
+		};
+
+		gpio1_pins: gpio1-pins {
+			pins = "jtag0_tck";
+			function = "gpio";
+		};
+
+		gpio2_pins: gpio2-pins {
+			pins = "jtag0_tms";
+			function = "gpio";
+		};
+
+		gpio3_pins: gpio3-pins {
+			pins = "jtag0_tdi";
+			function = "gpio";
+		};
+
+		gpio4_pins: gpio4-pins {
+			pins = "jtag0_tdo";
+			function = "gpio";
+		};
+
+		gpio6_pins: gpio6-pins {
+			pins = "spi2_cs0_n";
+			function = "gpio";
+		};
+
+		gpio7_pins: gpio7-pins {
+			pins = "jtag1_tck";
+			function = "gpio";
+		};
+
+		gpio8_pins: gpio8-pins {
+			pins = "jtag1_tms";
+			function = "gpio";
+		};
+
+		gpio9_pins: gpio9-pins {
+			pins = "jtag1_tdi";
+			function = "gpio";
+		};
+
+		gpio10_pins: gpio10-pins {
+			pins = "jtag1_tdo";
+			function = "gpio";
+		};
+
+		gpio12_pins: gpio12-pins {
+			pins = "spi2_cs1_n";
+			function = "gpio";
+		};
+
+		gpio13_pins: gpio13-pins {
+			pins = "mode_set0";
+			function = "gpio";
+		};
+
+		gpio14_pins: gpio14-pins {
+			pins = "mode_set1";
+			function = "gpio";
+		};
+
+		gpio15_pins: gpio15-pins {
+			pins = "mode_set2";
+			function = "gpio";
+		};
+
+		gpio16_pins: gpio16-pins {
+			pins = "mode_set3";
+			function = "gpio";
+		};
+
+		gpio17_pins: gpio17-pins {
+			pins = "jtag2_trst";
+			function = "gpio";
+		};
+
+		gpio18_pins: gpio18-pins {
+			pins = "i2s0_bclk";
+			function = "gpio";
+		};
+
+		gpio19_pins: gpio19-pins {
+			pins = "i2s0_wclk";
+			function = "gpio";
+		};
+
+		gpio20_pins: gpio20-pins {
+			pins = "i2s0_sdi";
+			function = "gpio";
+		};
+
+		gpio21_pins: gpio21-pins {
+			pins = "i2s0_sdo";
+			function = "gpio";
+		};
+
+		gpio22_pins: gpio22-pins {
+			pins = "i2s_mclk";
+			function = "gpio";
+		};
+
+		gpio23_pins: gpio23-pins {
+			pins = "i2s2_bclk";
+			function = "gpio";
+		};
+
+		gpio24_pins: gpio24-pins {
+			pins = "i2s2_wclk";
+			function = "gpio";
+		};
+
+		gpio25_pins: gpio25-pins {
+			pins = "i2s2_sdi";
+			function = "gpio";
+		};
+
+		gpio26_pins: gpio26-pins {
+			pins = "i2s2_sdo";
+			function = "gpio";
+		};
+
+		gpio29_pins: gpio29-pins {
+			pins = "gpio29";
+			function = "gpio";
+		};
+
+		gpio30_pins: gpio30-pins {
+			pins = "i2s1_bclk";
+			function = "gpio";
+		};
+
+		gpio31_pins: gpio31-pins {
+			pins = "i2s1_wclk";
+			function = "gpio";
+		};
+
+		gpio32_pins: gpio32-pins {
+			pins = "i2s1_sdi";
+			function = "gpio";
+		};
+
+		gpio33_pins: gpio33-pins {
+			pins = "i2s1_sdo";
+			function = "gpio";
+		};
+
+		gpio34_pins: gpio34-pins {
+			pins = "gpio34";
+			function = "gpio";
+		};
+
+		gpio35_pins: gpio35-pins {
+			pins = "spi1_cs0_n";
+			function = "gpio";
+		};
+
+		gpio36_pins: gpio36-pins {
+			pins = "spi1_clk";
+			function = "gpio";
+		};
+
+		gpio37_pins: gpio37-pins {
+			pins = "spi1_d0";
+			function = "gpio";
+		};
+
+		gpio38_pins: gpio38-pins {
+			pins = "spi1_d1";
+			function = "gpio";
+		};
+
+		gpio39_pins: gpio39-pins {
+			pins = "spi1_d2";
+			function = "gpio";
+		};
+
+		gpio40_pins: gpio40-pins {
+			pins = "spi1_d3";
+			function = "gpio";
+		};
+
+		gpio41_pins: gpio41-pins {
+			pins = "spi1_cs1_n";
+			function = "gpio";
+		};
+
+		gpio42_pins: gpio42-pins {
+			pins = "usb0_pwren";
+			function = "gpio";
+		};
+
+		gpio43_pins: gpio43-pins {
+			pins = "usb1_pwren";
+			function = "gpio";
+		};
+
+		gpio44_pins: gpio44-pins {
+			pins = "i2c0_scl";
+			function = "gpio";
+		};
+
+		gpio45_pins: gpio45-pins {
+			pins = "i2c0_sda";
+			function = "gpio";
+		};
+
+		gpio46_pins: gpio46-pins {
+			pins = "i2c1_scl";
+			function = "gpio";
+		};
+
+		gpio47_pins: gpio47-pins {
+			pins = "i2c1_sda";
+			function = "gpio";
+		};
+
+		gpio48_pins: gpio48-pins {
+			pins = "i2c2_scl";
+			function = "gpio";
+		};
+
+		gpio49_pins: gpio49-pins {
+			pins = "i2c2_sda";
+			function = "gpio";
+		};
+
+		gpio50_pins: gpio50-pins {
+			pins = "i2c3_scl";
+			function = "gpio";
+		};
+
+		gpio51_pins: gpio51-pins {
+			pins = "i2c3_sda";
+			function = "gpio";
+		};
+
+		gpio52_pins: gpio52-pins {
+			pins = "i2c4_scl";
+			function = "gpio";
+		};
+
+		gpio53_pins: gpio53-pins {
+			pins = "i2c4_sda";
+			function = "gpio";
+		};
+
+		gpio54_pins: gpio54-pins {
+			pins = "i2c5_scl";
+			function = "gpio";
+		};
+
+		gpio55_pins: gpio55-pins {
+			pins = "i2c5_sda";
+			function = "gpio";
+		};
+
+		gpio56_pins: gpio56-pins {
+			pins = "uart0_tx";
+			function = "gpio";
+		};
+
+		gpio57_pins: gpio57-pins {
+			pins = "uart0_rx";
+			function = "gpio";
+		};
+
+		gpio58_pins: gpio58-pins {
+			pins = "uart1_tx";
+			function = "gpio";
+		};
+
+		gpio59_pins: gpio59-pins {
+			pins = "uart1_rx";
+			function = "gpio";
+		};
+
+		gpio60_pins: gpio60-pins {
+			pins = "uart1_cts";
+			function = "gpio";
+		};
+
+		gpio61_pins: gpio61-pins {
+			pins = "uart1_rts";
+			function = "gpio";
+		};
+
+		gpio62_pins: gpio62-pins {
+			pins = "uart2_tx";
+			function = "gpio";
+		};
+
+		gpio63_pins: gpio63-pins {
+			pins = "uart2_rx";
+			function = "gpio";
+		};
+
+		gpio64_pins: gpio64-pins {
+			pins = "jtag2_tck";
+			function = "gpio";
+		};
+
+		gpio65_pins: gpio65-pins {
+			pins = "jtag2_tms";
+			function = "gpio";
+		};
+
+		gpio66_pins: gpio66-pins {
+			pins = "jtag2_tdi";
+			function = "gpio";
+		};
+
+		gpio67_pins: gpio67-pins {
+			pins = "jtag2_tdo";
+			function = "gpio";
+		};
+
+		gpio68_pins: gpio68-pins {
+			pins = "fan_pwm";
+			function = "gpio";
+		};
+
+		gpio69_pins: gpio69-pins {
+			pins = "fan_tach";
+			function = "gpio";
+		};
+
+		gpio70_pins: gpio70-pins {
+			pins = "mipi_csi0_xvs";
+			function = "gpio";
+		};
+
+		gpio71_pins: gpio71-pins {
+			pins = "mipi_csi0_xhs";
+			function = "gpio";
+		};
+
+		gpio72_pins: gpio72-pins {
+			pins = "mipi_csi0_mclk";
+			function = "gpio";
+		};
+
+		gpio73_pins: gpio73-pins {
+			pins = "mipi_csi1_xvs";
+			function = "gpio";
+		};
+
+		gpio74_pins: gpio74-pins {
+			pins = "mipi_csi1_xhs";
+			function = "gpio";
+		};
+
+		gpio75_pins: gpio75-pins {
+			pins = "mipi_csi1_mclk";
+			function = "gpio";
+		};
+
+		gpio76_pins: gpio76-pins {
+			pins = "mipi_csi2_xvs";
+			function = "gpio";
+		};
+
+		gpio77_pins: gpio77-pins {
+			pins = "mipi_csi2_xhs";
+			function = "gpio";
+		};
+
+		gpio78_pins: gpio78-pins {
+			pins = "mipi_csi2_mclk";
+			function = "gpio";
+		};
+
+		gpio79_pins: gpio79-pins {
+			pins = "mipi_csi3_xvs";
+			function = "gpio";
+		};
+
+		gpio80_pins: gpio80-pins {
+			pins = "mipi_csi3_xhs";
+			function = "gpio";
+		};
+
+		gpio81_pins: gpio81-pins {
+			pins = "mipi_csi3_mclk";
+			function = "gpio";
+		};
+
+		gpio82_pins: gpio82-pins {
+			pins = "mipi_csi4_xvs";
+			function = "gpio";
+		};
+
+		gpio83_pins: gpio83-pins {
+			pins = "mipi_csi4_xhs";
+			function = "gpio";
+		};
+
+		gpio84_pins: gpio84-pins {
+			pins = "mipi_csi4_mclk";
+			function = "gpio";
+		};
+
+		gpio85_pins: gpio85-pins {
+			pins = "mipi_csi5_xvs";
+			function = "gpio";
+		};
+
+		gpio86_pins: gpio86-pins {
+			pins = "mipi_csi5_xhs";
+			function = "gpio";
+		};
+
+		gpio87_pins: gpio87-pins {
+			pins = "mipi_csi5_mclk";
+			function = "gpio";
+		};
+
+		gpio88_pins: gpio88-pins {
+			pins = "spi3_cs_n";
+			function = "gpio";
+		};
+
+		gpio89_pins: gpio89-pins {
+			pins = "spi3_clk";
+			function = "gpio";
+		};
+
+		gpio90_pins: gpio90-pins {
+			pins = "spi3_di";
+			function = "gpio";
+		};
+
+		gpio91_pins: gpio91-pins {
+			pins = "spi3_do";
+			function = "gpio";
+		};
+
+		gpio92_pins: gpio92-pins {
+			pins = "gpio92";
+			function = "gpio";
+		};
+
+		gpio93_pins: gpio93-pins {
+			pins = "gpio93";
+			function = "gpio";
+		};
+
+		gpio94_pins: gpio94-pins {
+			pins = "s_mode";
+			function = "gpio";
+		};
+
+		gpio95_pins: gpio95-pins {
+			pins = "gpio95";
+			function = "gpio";
+		};
+
+		gpio96_pins: gpio96-pins {
+			pins = "spi0_cs_n";
+			function = "gpio";
+		};
+
+		gpio97_pins: gpio97-pins {
+			pins = "spi0_clk";
+			function = "gpio";
+		};
+
+		gpio98_pins: gpio98-pins {
+			pins = "spi0_d0";
+			function = "gpio";
+		};
+
+		gpio99_pins: gpio99-pins {
+			pins = "spi0_d1";
+			function = "gpio";
+		};
+
+		gpio100_pins: gpio100-pins {
+			pins = "spi0_d2";
+			function = "gpio";
+		};
+
+		gpio101_pins: gpio101-pins {
+			pins = "spi0_d3";
+			function = "gpio";
+		};
+
+		gpio102_pins: gpio102-pins {
+			pins = "i2c10_scl";
+			function = "gpio";
+		};
+
+		gpio103_pins: gpio103-pins {
+			pins = "i2c10_sda";
+			function = "gpio";
+		};
+
+		gpio104_pins: gpio104-pins {
+			pins = "i2c11_scl";
+			function = "gpio";
+		};
+
+		gpio105_pins: gpio105-pins {
+			pins = "i2c11_sda";
+			function = "gpio";
+		};
+
+		gpio107_pins: gpio107-pins {
+			pins = "boot_sel0";
+			function = "gpio";
+		};
+
+		gpio108_pins: gpio108-pins {
+			pins = "boot_sel1";
+			function = "gpio";
+		};
+
+		gpio109_pins: gpio109-pins {
+			pins = "boot_sel2";
+			function = "gpio";
+		};
+
+		gpio110_pins: gpio110-pins {
+			pins = "boot_sel3";
+			function = "gpio";
+		};
+
+		uart3_pins: uart3-pins {
+			pins = "gpio92", "gpio93";
+			function = "uart";
+		};
+
+		uart4_pins: uart4-pins {
+			pins = "spi1_d0", "spi1_d1";
+			function = "uart";
+		};
+
+		gpio0_pins: gpio0-pins {
+			pins = "gpio0";
+			function = "gpio";
+		};
+
+		gpio5_pins: gpio5-pins {
+			pins = "gpio5";
+			function = "gpio";
+		};
+
+		gpio11_pins: gpio11-pins {
+			pins = "gpio11";
+			function = "gpio";
+		};
+
+		gpio27_pins: gpio27-pins {
+			pins = "gpio27";
+			function = "gpio";
+		};
+
+		gpio28_pins: gpio28-pins {
+			pins = "gpio28";
+			function = "gpio";
+		};
+
+		gpio106_pins: gpio106-pins {
+			pins = "gpio106";
+			function = "gpio";
+		};
+
+		gpio111_pins: gpio111-pins {
+			pins = "gpio111";
+			function = "gpio";
+		};
+
+		chip_mode_pins: chip-mode-pins {
+			pins = "chip_mode";
+			function = "chip_mode";
+		};
+
+		sdio0_pins: sdio0-pins {
+			pins = "mode_set0", "mode_set1";
+			function = "sdio";
+		};
+
+		sdio1_pins: sdio1-pins {
+			pins = "mode_set2", "mode_set3";
+			function = "sdio";
+		};
+
+		jtag0_pins: jtag0-pins {
+			pins = "jtag0_tck", "jtag0_tms", "jtag0_tdi", "jtag0_tdo";
+			function = "jtag";
+		};
+
+		jtag1_pins: jtag1-pins {
+			pins = "jtag1_tck", "jtag1_tms", "jtag1_tdi", "jtag1_tdo";
+			function = "jtag";
+		};
+
+		jtag2_pins: jtag2-pins {
+			pins = "jtag2_trst", "jtag2_tck", "jtag2_tms", "jtag2_tdi",
+			       "jtag2_tdo";
+			function = "jtag";
+		};
+
+		pcie_pins: pcie-pins {
+			pins = "pcie_clkreq_n", "pcie_wake_n", "pcie_perst_n";
+			function = "pcie";
+		};
+
+		hdmi_pins: hdmi-pins {
+			pins = "hdmi_scl", "hdmi_sda", "hdmi_cec";
+			function = "hdmi";
+		};
+
+		rgmii0_pins: rgmii0-pins {
+			pins = "rgmii0_clk_125", "rgmii0_txen", "rgmii0_txclk", "rgmii0_txd0",
+			       "rgmii0_txd1", "rgmii0_txd2", "rgmii0_txd3", "rgmii0_rxclk",
+			       "rgmii0_rxdv", "rgmii0_rxd0", "rgmii0_rxd1", "rgmii0_rxd2",
+			       "rgmii0_rxd3", "rgmii0_mdc", "rgmii0_mdio", "rgmii0_intb";
+			function = "rgmii";
+		};
+
+		rgmii1_pins: rgmii1-pins {
+			pins = "rgmii1_clk_125", "rgmii1_txen", "rgmii1_txclk", "rgmii1_txd0",
+			       "rgmii1_txd1", "rgmii1_txd2", "rgmii1_txd3", "rgmii1_rxclk",
+			       "rgmii1_rxdv", "rgmii1_rxd0", "rgmii1_rxd1", "rgmii1_rxd2",
+			       "rgmii1_rxd3", "rgmii1_mdc", "rgmii1_mdio", "rgmii1_intb";
+			function = "rgmii";
+		};
+
+		i2s0_pins: i2s0-pins {
+			pins = "i2s0_bclk", "i2s0_wclk", "i2s0_sdi", "i2s0_sdo", "i2s_mclk";
+			function = "i2s";
+		};
+
+		i2s1_pins: i2s1-pins {
+			pins = "i2s1_bclk", "i2s1_wclk", "i2s1_sdi", "i2s1_sdo", "i2s_mclk";
+			function = "i2s";
+		};
+
+		i2s2_pins: i2s2-pins {
+			pins = "i2s2_bclk", "i2s2_wclk", "i2s2_sdi", "i2s2_sdo", "i2s_mclk";
+			function = "i2s";
+		};
+
+		usb0_pwren_pins: usb0-pwren-pins {
+			pins = "usb0_pwren";
+			function = "usb";
+		};
+
+		usb1_pwren_pins: usb1-pwren-pins {
+			pins = "usb1_pwren";
+			function = "usb";
+		};
+
+		i2c0_pins: i2c0-pins {
+			pins = "i2c0_scl", "i2c0_sda";
+			function = "i2c";
+		};
+
+		i2c1_pins: i2c1-pins {
+			pins = "i2c1_scl", "i2c1_sda";
+			function = "i2c";
+		};
+
+		i2c2_pins: i2c2-pins {
+			pins = "i2c2_scl", "i2c2_sda";
+			function = "i2c";
+		};
+
+		i2c3_pins: i2c3-pins {
+			pins = "i2c3_scl", "i2c3_sda";
+			function = "i2c";
+		};
+
+		i2c4_pins: i2c4-pins {
+			pins = "i2c4_scl", "i2c4_sda";
+			function = "i2c";
+		};
+
+		i2c5_pins: i2c5-pins {
+			pins = "i2c5_scl", "i2c5_sda";
+			function = "i2c";
+		};
+
+		i2c8_pins: i2c8-pins {
+			pins = "gpio92", "gpio93";
+			function = "i2c";
+		};
+
+		i2c10_pins: i2c10-pins {
+			pins = "i2c10_scl", "i2c10_sda";
+			function = "i2c";
+		};
+
+		i2c11_pins: i2c11-pins {
+			pins = "i2c11_scl", "i2c11_sda";
+			function = "i2c";
+		};
+
+		uart0_pins: uart0-pins {
+			pins = "uart0_tx", "uart0_rx";
+			function = "uart";
+		};
+
+		uart1_pins: uart1-pins {
+			pins = "uart1_tx", "uart1_rx", "uart1_cts", "uart1_rts";
+			function = "uart";
+		};
+
+		uart2_pins: uart2-pins {
+			pins = "uart2_tx", "uart2_rx";
+			function = "uart";
+		};
+
+		fan_pwm_pins: fan-pwm-pins {
+			pins = "fan_pwm";
+			function = "pwm";
+		};
+
+		fan_tach_pins: fan-tach-pins {
+			pins = "fan_tach";
+			function = "fan_tach";
+		};
+
+		mipi_csi0_pins: mipi-csi0-pins {
+			pins = "mipi_csi0_xvs", "mipi_csi0_xhs", "mipi_csi0_mclk";
+			function = "mipi_csi";
+		};
+
+		mipi_csi1_pins: mipi-csi1-pins {
+			pins = "mipi_csi1_xvs", "mipi_csi1_xhs", "mipi_csi1_mclk";
+			function = "mipi_csi";
+		};
+
+		mipi_csi2_pins: mipi-csi2-pins {
+			pins = "mipi_csi2_xvs", "mipi_csi2_xhs", "mipi_csi2_mclk";
+			function = "mipi_csi";
+		};
+
+		mipi_csi3_pins: mipi-csi3-pins {
+			pins = "mipi_csi3_xvs", "mipi_csi3_xhs", "mipi_csi3_mclk";
+			function = "mipi_csi";
+		};
+
+		mipi_csi4_pins: mipi-csi4-pins {
+			pins = "mipi_csi4_xvs", "mipi_csi4_xhs", "mipi_csi4_mclk";
+			function = "mipi_csi";
+		};
+
+		mipi_csi5_pins: mipi-csi5-pins {
+			pins = "mipi_csi5_xvs", "mipi_csi5_xhs", "mipi_csi5_mclk";
+			function = "mipi_csi";
+		};
+
+		s_mode_pins: s-mode-pins {
+			pins = "s_mode";
+			function = "s_mode";
+		};
+
+		boot_sel0_pins: boot-sel0-pins {
+			pins = "boot_sel0";
+			function = "boot_sel";
+		};
+
+		boot_sel1_pins: boot-sel1-pins {
+			pins = "boot_sel1";
+			function = "boot_sel";
+		};
+
+		boot_sel2_pins: boot-sel2-pins {
+			pins = "boot_sel2";
+			function = "boot_sel";
+		};
+
+		boot_sel3_pins: boot-sel3-pins {
+			pins = "boot_sel3";
+			function = "boot_sel";
+		};
+
+		ddr_ref_clk_sel_pins: ddr-ref-clk-sel-pins {
+			pins = "gpio95";
+			function = "ddr_ref_clk_sel";
+		};
+
+		lpddr_ref_clk_pins: lpddr-ref-clk-pins {
+			pins = "lpddr_ref_clk";
+			function = "lpddr_ref_clk";
+		};
+
+		spi0_pins: spi0-pins {
+			pins = "spi0_cs_n", "spi0_clk", "spi0_d0", "spi0_d1", "spi0_d2",
+			       "spi0_d3";
+			function = "spi";
+		};
+
+		dual_spi1_pins: dual-spi1-pins {
+			pins = "spi1_cs0_n", "spi1_clk", "spi1_d0", "spi1_d1";
+			function = "spi";
+		};
+
+		quad_spi1_pins: quad-spi1-pins {
+			pins = "spi1_cs0_n", "spi1_cs1_n", "spi1_clk", "spi1_d0", "spi1_d1",
+			       "spi1_d2", "spi1_d3";
+			function = "spi";
+		};
+
+		spi3_pins: spi3-pins {
+			pins = "spi3_cs_n", "spi3_clk", "spi3_di", "spi3_do";
+			function = "spi";
+		};
+	};
+};
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index af9e40d8739a..a0fb82f4adca 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -349,6 +349,11 @@ gpioD: gpio-port@3 {
 			};
 		};
 
+		pinctrl: pinctrl@51600080 {
+			compatible = "eswin,eic7700-pinctrl";
+			reg = <0x0 0x51600080 0x0 0x1fff80>;
+		};
+
 		clk: clock-controller@51828000 {
 			compatible = "eswin,eic7700-clock";
 			reg = <0x0 0x51828000 0x0 0x300>;
-- 
2.34.1


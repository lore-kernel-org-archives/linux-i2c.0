Received: from naesa06.arrow.com (naesa06.arrow.com [216.150.161.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2151FCBD;
	Thu, 15 Oct 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068909; cv=none; b=WtPu3OrIdDNly9+Sft9LeY5B5Z0Al5rOHco1np3v2iLCIU3HuQ44cvACm+e+iVgVWaXJKqxTK5SjVsUGh8CW7YbaemwdthwQT8fMF8OGr5Jfh6h/WmuT+AD5PnxjQQddJSPo7SMQmAWzk/01MB7joj15a1dMsnsOIXXsJJKAATc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068909; c=relaxed/simple;
	bh=y9Di1k+ud/hlOU+U1y0lXrnbY9Wyo5O+yttjETAOU2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAnVyNhCq/rRVjPEZxaQJ4G5TgUcDBosYux3VQyQbhSRMQOcPz/pWS+F8RdKlQFACKR/AQmWrD/8+AhOir0MFNLHcbYfhHeesMzxoRQLMzGLJ2U3q12Zrmcf9aILdBUm6LH5GyrppsEe3s4vSdvs5TZDIi90oAjHewgv73R2TjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=oRFmhFAD; arc=none smtp.client-ip=216.150.161.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="oRFmhFAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=7463; q=dns/txt;
  s=NAESA-Selector1; t=1792068907; x=1823604907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ReP1wvHxZHUD2RooTw56trdScf7nnVO+RKo9zGM90pc=;
  b=oRFmhFADLytPToTsMGqXUYt3TGmwzuwQ79omCQirX+bd7x+p7YWk1cgP
   01AlbpYSCBq6fgbTx56TZ8c7b93y48zmWQhT1FAkn4Fpc7EhdfXroijYb
   M5J8lL2QKkF2arMI0Zzo8ZtSxQ+f/xzXsQilhV/eMX1BwmxidnjrFk+7X
   GpcyjLTlF5RlKwo4bW3CJn55oC9iMGS0q/v9XTpOkyzX5g4KIzN5ijeKk
   0LwKsnL8m0+r/oyI/TOa9FfqCDuuCehI6e367rkxZ0MslV46l7pDhO+eC
   7HLZKWcUa7HNuZW6QXkJX2I4J0Mpq8f6nLCC++HqucsTbZKb68YsJkvFb
   A==;
X-CSE-ConnectionGUID: QnYMPdZiTxKQT5msHgwutA==
X-CSE-MsgGUID: viBQqaQtSCOiEF62maYQyQ==
X-IronPort-AV: E=Sophos;i="6.27,159,1787032800"; 
   d="scan'208";a="66052753"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa06out.arrow.com with ESMTP; 15 Oct 2026 06:55:06 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Thu, 15 Oct 2026 18:24:55 +0530
From: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
To: Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v5 6/7] riscv: dts: eswin: add I2C controller support
Date: Thu, 15 Oct 2026 18:24:53 +0530
Message-Id: <20261015125454.1381941-7-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
References: <20261015125454.1381941-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Oct 2026 12:54:55.0310 (UTC) FILETIME=[606C86E0:01DD5CA4]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add I2C nodes for EIC7700 SoC.
Also add nodes for corresponding slave devices in dts file and
enable them for HiFive Premier P550 board

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 .../dts/eswin/eic7700-hifive-premier-p550.dts |  52 +++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 181 ++++++++++++++++++
 2 files changed, 233 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
index afae15bda70a..8ff19a48e209 100644
--- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -41,6 +41,58 @@ vcc_1v8: regulator-vcc1v8 {
 	};
 };
 
+&aon_i2c0 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+	};
+};
+
+&aon_i2c1 {
+	status = "okay";
+
+	adc@10 {
+		compatible = "microchip,pac1934";
+		reg = <0x10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@1 {
+			reg = <0x1>;
+			shunt-resistor-micro-ohms = <1000>;
+			label = "VDD_SOM";
+		};
+
+		channel@2 {
+			reg = <0x2>;
+			shunt-resistor-micro-ohms = <1000>;
+			label = "VDD_SOC";
+		};
+
+		channel@3 {
+			reg = <0x3>;
+			shunt-resistor-micro-ohms = <1000>;
+			label = "VDD_CPU";
+		};
+
+		channel@4 {
+			reg = <0x4>;
+			shunt-resistor-micro-ohms = <1000>;
+			label = "VDD_LPDDR";
+		};
+	};
+
+	power-sensor@44 {
+		compatible = "ti,ina226";
+		reg = <0x44>;
+		#io-channel-cells = <1>;
+		label = "sys_power";
+		shunt-resistor = <1000>;
+	};
+};
+
 &gpio84_pins {
 	bias-disable;
 	input-disable;
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index 771a88645d83..c0aa91b357ff 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -315,6 +315,156 @@ uart4: serial@50940000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@50950000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x50950000 0x0 0x8000>;
+			interrupts = <105>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C0_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+			resets = <&reset EIC7700_RESET_I2C0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@50960000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x50960000 0x0 0x8000>;
+			interrupts = <106>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C1_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins>;
+			resets = <&reset EIC7700_RESET_I2C1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@50970000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x50970000 0x0 0x8000>;
+			interrupts = <107>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C2_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins>;
+			resets = <&reset EIC7700_RESET_I2C2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@50980000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x50980000 0x0 0x8000>;
+			interrupts = <108>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C3_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_pins>;
+			resets = <&reset EIC7700_RESET_I2C3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@50990000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x50990000 0x0 0x8000>;
+			interrupts = <109>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C4_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c4_pins>;
+			resets = <&reset EIC7700_RESET_I2C4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@509a0000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x509a0000 0x0 0x8000>;
+			interrupts = <110>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C5_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c5_pins>;
+			resets = <&reset EIC7700_RESET_I2C5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@509b0000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x509b0000 0x0 0x8000>;
+			interrupts = <111>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C6_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c6_pins>;
+			resets = <&reset EIC7700_RESET_I2C6>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c7: i2c@509c0000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x509c0000 0x0 0x8000>;
+			interrupts = <112>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C7_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c7_pins>;
+			resets = <&reset EIC7700_RESET_I2C7>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c8: i2c@509d0000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x509d0000 0x0 0x8000>;
+			interrupts = <113>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C8_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c8_pins>;
+			resets = <&reset EIC7700_RESET_I2C8>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c9: i2c@509e0000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x509e0000 0x0 0x8000>;
+			interrupts = <114>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C9_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c9_pins>;
+			resets = <&reset EIC7700_RESET_I2C9>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		gpio@51600000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x0 0x51600000 0x0 0x80>;
@@ -379,5 +529,36 @@ reset: reset-controller@51828300 {
 			reg = <0x0 0x51828300 0x0 0x200>;
 			#reset-cells = <1>;
 		};
+
+		aon_i2c0: i2c@51830000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x51830000 0x0 0x8000>;
+			interrupts = <290>;
+			clocks = <&clk EIC7700_CLK_GATE_AON_I2C0_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c10_pins>;
+			resets = <&reset EIC7700_RESET_ANO0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		aon_i2c1: i2c@51838000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x51838000 0x0 0x8000>;
+			interrupts = <291>;
+			clocks = <&clk EIC7700_CLK_GATE_AON_I2C1_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c11_pins>;
+			resets = <&reset EIC7700_RESET_ANO1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 	};
 };
-- 
2.34.1


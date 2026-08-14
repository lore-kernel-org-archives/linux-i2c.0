Received: from naesa04.arrow.com (naesa04.arrow.com [216.150.161.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2153E0724;
	Fri, 14 Aug 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.150.161.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690821; cv=none; b=tZ+SU9wDh+Ccm1VIF+HJMN+43t3tSoECmnzzS4YOfZdsMbMzFqlPaeEoCVpKYFfJE4sESefiHZFjUR45F1kJOAFkNKTFpvI4zQZQXhkoDUzmhZQB3dR6WzYb/ygQWvd0vektr/xoTPbiELl8D4qdipR/Ycn+2RVtfNtMuQdcJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690821; c=relaxed/simple;
	bh=uDdqV9qk0KIGigukzEA4iE+WgNX9YlT/0Vt4zarFFUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PD2nSYBugVYS6OlDNZr+Esv5AaQLJAHFCDwCJa9M+UWjX+LIhby1oG6zTpNhll3pXay7MqIoljB8Vc+Bkk9drjePOcGR4V4lUl3kF2QRU37FN1YlzEtcK+7hrkG2pYkoe8O0e6Ihr69h0jSeOk3553lxP21btnIuvgs5u7aO64U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com; spf=pass smtp.mailfrom=einfochips.com; dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b=r7CO4rcE; arc=none smtp.client-ip=216.150.161.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=einfochips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=einfochips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=einfochips.com header.i=@einfochips.com header.b="r7CO4rcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=einfochips.com; i=@einfochips.com; l=6796; q=dns/txt;
  s=NAESA-Selector1; t=1786690820; x=1818226820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rOKtpkTGdGns0ETXwiHN9NnoyHI2qk15A30U1lqOXGQ=;
  b=r7CO4rcE9UUiM6QItWkpHPVsLsEmUrDKN2JNCxaVLUsQjuqUjo64lwNb
   UZ9EaYPIsKWNtFdtTFZ2Mrpz/2zj89+dJ9hoEn0jPkclULziqvY5OpOG+
   T9VqlQYKLVZERh2KWmGRdTmVHcPO1Lh7cM1RbMtHkFrs7Tsn7O3iA02kL
   DNL4O0q6bcGvqHsbUKnckuFFXDww16b5QWnlZa5BmdfIYjCOe2Oa6AjkA
   ZBt35gyIIY4uv6kJa9wQZHqs7BZQ0aWbjRceKUmZ6lV1Q/tnhcWVdX0OR
   +09XIy7UwAltNjtL+576X/B/OdaoVDEoQgamuaYD0HPvO7vOvYgCREV+l
   A==;
X-CSE-ConnectionGUID: bSkCNarWRZmRfzWdt/xJ/A==
X-CSE-MsgGUID: t3Y9PiUERom2Eannkjsg7Q==
X-IronPort-AV: E=Sophos;i="6.25,222,1779170400"; 
   d="scan'208";a="119916485"
Received: from unknown (HELO eicahmirelay01.einfochips.com) ([10.100.49.50])
  by naesa04out.arrow.com with ESMTP; 14 Aug 2026 01:00:18 -0600
Received: from AHMCPU1888.localdomain ([172.25.5.100]) by eicahmirelay01.einfochips.com with Microsoft SMTPSVC(10.0.20348.1);
	 Fri, 14 Aug 2026 12:30:07 +0530
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
Subject: [PATCH v4 6/7] riscv: dts: eswin: add I2C controller support
Date: Fri, 14 Aug 2026 12:30:06 +0530
Message-Id: <20260814070007.1662455-7-pinkesh.vaghela@einfochips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
References: <20260814070007.1662455-1-pinkesh.vaghela@einfochips.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2026 07:00:07.0787 (UTC) FILETIME=[8A75CBB0:01DD2BBA]

From: Pritesh Patel <pritesh.patel@einfochips.com>

Add I2C nodes for EIC7700 SoC.
Also add nodes for corresponding slave devices in dts file and
enable them for HiFive Premier P550 board

Signed-off-by: Pritesh Patel <pritesh.patel@einfochips.com>
Signed-off-by: Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>
---
 .../dts/eswin/eic7700-hifive-premier-p550.dts |  56 +++++++
 arch/riscv/boot/dts/eswin/eic7700.dtsi        | 156 ++++++++++++++++++
 2 files changed, 212 insertions(+)

diff --git a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
index 3101fd90d171..5dddcf13fd25 100644
--- a/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
+++ b/arch/riscv/boot/dts/eswin/eic7700-hifive-premier-p550.dts
@@ -130,6 +130,62 @@ &gpio111_pins {
 	input-disable;
 };
 
+&aon_i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c10_pins>;
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+	};
+};
+
+&aon_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c11_pins>;
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
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio0_pins>, <&gpio5_pins>, <&gpio11_pins>,
diff --git a/arch/riscv/boot/dts/eswin/eic7700.dtsi b/arch/riscv/boot/dts/eswin/eic7700.dtsi
index 771a88645d83..c13432d14504 100644
--- a/arch/riscv/boot/dts/eswin/eic7700.dtsi
+++ b/arch/riscv/boot/dts/eswin/eic7700.dtsi
@@ -315,6 +315,162 @@ uart4: serial@50940000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@50950000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x50950000 0x0 0x8000>;
+			interrupts = <105>;
+			clocks = <&clk EIC7700_CLK_GATE_LSP_I2C0_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
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
+			resets = <&reset EIC7700_RESET_I2C9>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		aon_i2c0: i2c@51830000 {
+			compatible = "eswin,eic7700-i2c", "snps,designware-i2c";
+			reg = <0x0 0x51830000 0x0 0x8000>;
+			interrupts = <290>;
+			clocks = <&clk EIC7700_CLK_GATE_AON_I2C0_PCLK>;
+			clock-names = "ref";
+			clock-frequency = <100000>;
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
+			resets = <&reset EIC7700_RESET_ANO1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		gpio@51600000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x0 0x51600000 0x0 0x80>;
-- 
2.34.1


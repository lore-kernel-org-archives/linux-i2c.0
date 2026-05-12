Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7207481235
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571621; cv=none; b=NY+vVfHDgeGascwy/SQDjKO+aZQ2c4Ldf/xTX5KZdODAYQtOjg9o45jh37tsIydu2ZUfjgKn58/f9gKwYmcDi1NTlDip8wvKZmNTMiaYNms+KRGb3o1fW3eqS0RBWgl7lGtBP5WIg+hrgeHFFvLbVffog7m9beiMd3WhS227/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571621; c=relaxed/simple;
	bh=3OQ02ZZI0kQ/5sJ1+5YlEDCXa+LoKBlgxgLGOXru+fE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEbEpfAEqTjSXk/WoKZ918AyTb83R01xY/x/kbuYj70vNb1STELCde3JrRaDCBRWTwC6FedCg9rxVLmnQqOK6zQvi236ZOEb6awiOqzdBOYB7bsytAcXSoz4AeoQC4liqo1qiw3Nqi1wbOQWa2edSIDO8OxrbTyE7F6ZstBN3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diN/inxy; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diN/inxy"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso3503033a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 00:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571614; x=1779176414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4n/F1eKXbXqdeANeiK1vkq+es+HjdGAH5wuLHdXDwY=;
        b=diN/inxyDE7b6Lkwh7eAwGQ/EybW3yEyfi0O69EB83gcu814QUEMSdQhcXSSy9StYl
         7wNEU7o6ulflOCfQZ2sX1hZvjKEJ2o4UnwCCMf1zY9JyourmgUNQgrEQpdJBABqS5uxT
         NP+IGs9wU91Ayx91BZePcTrIJ59Cf+eB0VfxOZdRxNYGOTGXmLf51DPc5iCut2IpJmdn
         kPgCPr2W6IfYYkiV08vramTWCqoGIFaNfrdyeTEAmUlpUj9NK4n70dqMn74CQ7XCfcKf
         hOprlynss5fcaAsoSXEEHjUq+xPRSDkNTGtMtihDk8oc2X71pD0oJhFqgn+xqIZea1NV
         Hhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571614; x=1779176414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m4n/F1eKXbXqdeANeiK1vkq+es+HjdGAH5wuLHdXDwY=;
        b=G29+lBBO/nl+rFLxa0626KGeJ/93DAFdul7rVrzfXPXAejqjWE469o2vv5lb0iTvgw
         ERG3invQMpL226tAgL1yGKFwVgz7vlq4s6IVXpsC6E0yyha/geqpY/nkMYlaCL6krsxG
         PzAjngjAPG7z8lKq05HWIDQ3ZCOWQjlKiloisodPtBmUbwLnNPqnN17Mh+RW7BjuKPeI
         2YAC/df7WNA7Y5Ks3LYiAtN80ZHy592RqCS0Wg0HbKY1yJCbN3Uab75LAkDkTVb0U7/M
         6XUDZUiumkTtHCpiTPF+mz0p6crd1QS9EQAT0U5valdZcmiwBbzS6C+rNJIeyxFZ4aSW
         bOQg==
X-Forwarded-Encrypted: i=1; AFNElJ/mcjA5NB3ktfyLCxiP1SdoEqoeOLJt3chucBHjbDAR/2Ge+MagSlDZ3urK9Pfs9O9fQIUtMpOA3Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+WV7nol8wJcZgBmY407dWqTLYV5PTPCfleDKw19zNY/CtmYq
	NMLdgtU9rgibMa2rAejayKI/w5ztlmUFYeYPbaZ0onJ182xM2tNlmcLS
X-Gm-Gg: Acq92OEKhQ0dSMUHxD7L4DKjssjFggeLKGKQZQf8kdh1PuxvfUAMw1e7D+sm7qbJ8ZS
	g6OWzNAU32Wyebkewd4AZBjSF0NYZfpWmv0E6n3m9/RDCO+rMJ7uxyCyHNEKqWvD3EFgg5kb4mE
	6vPW6lwVIWjggI9yxhpieFjhEtSw860OLupX2ujcopGnSDsZlSy+xb416Dtv1Gr3OOq/LgUe0d9
	hHpfSi+R//RzkMdVf7P7V8SpZH0ICMsONSu2qhMvrSDTcC1A8CsLLbBJhpTNcrlm13RGXkf/Ns8
	vFTs4orxGmPT5hpOg/sQHdBpEh12IV4jWOuKaprlMY1tClomjyZsYg3W145V5kDjKgB9KmbfTn1
	VpienvqbGSSVB3C7pKxSh7HBErAjmmkT+FJ37A9A+SmkcaAc53wbxF7LghfDG4cOHp3WGalqVxH
	Qh6F2xXI9e4KqMVEjmVm5N1CQnKgd8RUtJTr+zHy8nofZ0Y6I0pDrWxJHo7p7i1QsSla+dA/MQV
	dlLWpG9RA==
X-Received: by 2002:a17:90b:590f:b0:368:5367:d679 with SMTP id 98e67ed59e1d1-3685368061emr7314796a91.9.1778571614197;
        Tue, 12 May 2026 00:40:14 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d65ed459sm13264489a91.14.2026.05.12.00.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:40:13 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v3 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Tue, 12 May 2026 15:39:53 +0800
Message-Id: <20260512073953.564323-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512073953.564323-1-zychennvt@gmail.com>
References: <20260512073953.564323-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add I2C controller nodes to the MA35D1 SoC dtsi.
Also enable the I2C interfaces on the MA35D1 SOM board
to allow communication with onboard peripherals.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 15 +++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 60 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index f6f20a17e501..a0f1d76d288e 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -13,6 +13,7 @@ / {
 	compatible = "nuvoton,ma35d1-som", "nuvoton,ma35d1";
 
 	aliases {
+		i2c0 = &i2c2;
 		serial0 = &uart0;
 		serial11 = &uart11;
 		serial12 = &uart12;
@@ -55,6 +56,12 @@ &clk {
 			   "integer";
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
 &pinctrl {
 	uart-grp {
 		pinctrl_uart0: uart0-pins {
@@ -98,6 +105,14 @@ pinctrl_uart16: uart16-pins {
 			power-source = <1>;
 		};
 	};
+
+	i2c-grp {
+		pinctrl_i2c1: i2c1-pins {
+			nuvoton,pins = <1 10 12>,
+				       <1 11 12>;
+			bias-disable;
+		};
+	};
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index e51b98f5bdce..a88d1c2938e7 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -372,6 +372,66 @@ uart15: serial@407f0000 {
 			status = "disabled";
 		};
 
+		i2c1: i2c@40810000 {
+			compatible = "nuvoton,ma35d1-i2c";
+			reg = <0x0 0x40810000 0x0 0x1000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk I2C1_GATE>;
+			clock-frequency = <100000>;
+			resets = <&sys MA35D1_RESET_I2C1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c@40820000 {
+			compatible = "nuvoton,ma35d1-i2c";
+			reg = <0x0 0x40820000 0x0 0x1000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk I2C2_GATE>;
+			clock-frequency = <100000>;
+			resets = <&sys MA35D1_RESET_I2C2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3: i2c@40830000 {
+			compatible = "nuvoton,ma35d1-i2c";
+			reg = <0x0 0x40830000 0x0 0x1000>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk I2C3_GATE>;
+			clock-frequency = <100000>;
+			resets = <&sys MA35D1_RESET_I2C3>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c4: i2c@40840000 {
+			compatible = "nuvoton,ma35d1-i2c";
+			reg = <0x0 0x40840000 0x0 0x1000>;
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk I2C4_GATE>;
+			clock-frequency = <100000>;
+			resets = <&sys MA35D1_RESET_I2C4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@40850000 {
+			compatible = "nuvoton,ma35d1-i2c";
+			reg = <0x0 0x40850000 0x0 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk I2C5_GATE>;
+			clock-frequency = <100000>;
+			resets = <&sys MA35D1_RESET_I2C5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		uart16: serial@40880000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40880000 0x0 0x100>;
-- 
2.34.1


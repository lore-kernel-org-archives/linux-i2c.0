Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBF7448BA4
	for <linux-i2c@vger.kernel.org>; Fri,  7 Aug 2026 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082668; cv=none; b=USRWKR9ISA4aiegSBprssyg2bXbp8gp3UzDaBvQre8pGTrqMaHiuGf/gy35wSvDlcWLw/2Q1atS66cglylFpRHiBmvT+dVva8ufcls17Xzp25blkA7dG06cXO+HteEFy1Q3jCCvxTIDnXA6tc0Bl9kGLv9P3KbW/HKgXSga28Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082668; c=relaxed/simple;
	bh=0aK3nrisfIvMUC7hMzoMx1aGyZsFxW2jrw74ipuIpwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTNOVTnpjnsAne94sWfyo4A7+ZluMAYQVLg1w/9l76BpFdpuMAyHBtgJPh9k/Y8GpTOrwufXsxx6xNUW2Uh+XeReTgjoKM7km1J/oHfeegS/A1J+ZmocseYWlz7nZ8mY1QNx/p9qrJ2LAe3xrGP0VSccYrpfDlobzkDuqGtzDBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY9tFTWM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY9tFTWM"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacb8416a1so31601065ad.1
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786082666; x=1786687466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6y8Hcxg9MXxS8AWcFY2VAmn1cCgVHpq4caMsrXoFzEI=;
        b=NY9tFTWMWonEkxo1QiTCSvKXI1nM3ykBDeY88wvgkSb9Z3sGFIUVpmppen/hCGMdVm
         llHyxf5YQ0uqHXG0o+D3Re1hndnLNrcD0AeJg4PeyJhQvJx3rMw9+4TAmSQeOqlCTVed
         Vu/VOsH6Gs+CCeVgAqGF2B0ck1gkVEstdn3+m9zD6VXhUvG9iu7UF0wF5ZdubS9aDmUg
         bRaG5BgwLOZWLGyYrH8+93QZ3oGUleJMW8tTL7A15WDi8Ewzst4bRLMVBqX+4TQvZF1L
         dAKYzppQjaeyAvL0Qu9jhYAvGiyH1k4SyCO8QIRPfV6wWAx/h1Gm7gzb3J/yrFWCtGTx
         Uskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786082666; x=1786687466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6y8Hcxg9MXxS8AWcFY2VAmn1cCgVHpq4caMsrXoFzEI=;
        b=aWCG7p/TE/Kvvj2i5/rl+YYD3QYa2KbGlWQKAopUZVzbgtGYE90m15Ne52gyTV0ega
         HkNaqFKM88Rop1ld9fCfNp9jGlHueVrCPYD0DfYqbxd9BH1b8FKAxQzjCIG0a82Z/lfe
         Fh1BTdc39V5YU5DB9rqYlaZc71tIOu15RiXtox2ct7XVmZvqYYwj1XllgUqZ4c+Rmle0
         wAzJAcjT0ba+nJ8CI8Iv6l73Y8T0Z5WKstIF1MuyZUZgzJ5hJHWj9af17abMUzwIMcmK
         StAm+F4u3BRQFItHrIkr9jGc0bU66hYI32u0TkKzMOANcHu0vTI3szieLvO9jwoEuSzZ
         U9+Q==
X-Forwarded-Encrypted: i=1; AHgh+RrfTVrFBVOdpT2tHJItAEncCFcYlah74jYsJBbDjdS9Y209hQLdI6t0dOR2HLJ9dKIxxRycCa35aJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6HltgNtx+GvC1BY310t2l5E9wQbsjob0bG1wIhOU0pML64Gzg
	f2AoWcDAvgr7eEyk6ibvEg4tsvrDn3g1KPPE1iGpSbknUbLd+IlnqkVi
X-Gm-Gg: AR+sD10H8coyf6nXnSokpG8eGUTUcf1f2HbRZk3u2tXKER6TVI5F5B84mpg7NipGZpH
	4tpXd6DLTXFIfhFw2nP7+Y3k+TEkR2zxL/SUSK3dX6sDa306U8M0BuzWHpvPVek3ID+SmOItpkJ
	8nyLzW/Gz4cVaN50vImONAvufWtJ7vxYL58IlXpIYW1P37OMXTiIkHNgGN6AJ6ARL+/HNBh24i9
	lG8PumAVzgBOhBCmieYBReTzxvBxt5ynykTFasKdyJU7nWqHUQiRzmglMcNDYaaNFwfqeT75/Gm
	8vPFzYpyDLCR8CUB6/kcQtQoZXN8xhfRiKWhmJSRiPXHYB5ro9cW8GrAOmMcWtzRPCFB6ytYUWC
	xRqfOdogFNlotpiGSYE8ahz71SKysYJAqfCCO63fDDKuMAOMeMMPXcKdxnAtEJTEaO4Je27ouo3
	m6xnFzRgknt5Md6J58tHibzwAbWb3UhAeuKk0sGGMvZIAjNVKW4vcq+aXdZDxAN52pWkPdOU3nF
	q1r5d/byJXqPyb3a/HgboZqVvO3CYNqdDjVo/PtuFnsijI=
X-Received: by 2002:a17:90b:524c:b0:38e:5ac1:9517 with SMTP id 98e67ed59e1d1-3903c54b386mr19817734a91.3.1786082665738;
        Thu, 06 Aug 2026 23:04:25 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9c0fsm3375588a91.5.2026.08.06.23.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:04:25 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v9 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Fri,  7 Aug 2026 14:04:00 +0800
Message-Id: <20260807060400.2047517-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807060400.2047517-1-zychennvt@gmail.com>
References: <20260807060400.2047517-1-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add I2C controller nodes to the MA35D1 SoC dtsi file.
Also, enable the I2C2 interface on the MA35D1 SOM board and
configure its pinctrl to allow communication with the onboard
NAU8822 audio codec

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 20 ++++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 72 +++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index a029b660e8dc..422468dbc3bf 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -57,6 +57,18 @@ &clk {
 			   "integer";
 };
 
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+
+	nau8822: audio-codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a> ;
+		nuvoton,spk-btl;
+	};
+};
+
 &pinctrl {
 	uart-grp {
 		pinctrl_uart0: uart0-pins {
@@ -100,6 +112,14 @@ pinctrl_uart16: uart16-pins {
 			power-source = <1>;
 		};
 	};
+
+	i2c-grp {
+		pinctrl_i2c2: i2c2-pins {
+			nuvoton,pins = <1 8 4>,
+				       <1 9 4>;
+			bias-disable;
+		};
+	};
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 7228ad4735b5..28488889f564 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -372,6 +372,78 @@ uart15: serial@407f0000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@40800000 {
+			compatible = "nuvoton,ma35d1-i2c";
+			reg = <0x0 0x40800000 0x0 0x1000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk I2C0_GATE>;
+			clock-frequency = <100000>;
+			resets = <&sys MA35D1_RESET_I2C0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
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
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c5: i2c@40850000 {
+			compatible = "nuvoton,ma35d1-i2c";
+			reg = <0x0 0x40850000 0x0 0x1000>;
+			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk I2C5_GATE>;
+			clock-frequency = <100000>;
+			resets = <&sys MA35D1_RESET_I2C5>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		uart16: serial@40880000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40880000 0x0 0x100>;
-- 
2.34.1


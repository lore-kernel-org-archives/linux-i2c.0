Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869034C140
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773643073; cv=none; b=aDCICrRFR6fSIquPac7q4h15jj87eh4xTrVbwZ010bRq2DaU+04drOVtMvyqKEUbzp1cJwqPGoNZz8Nw0OUTuz9u5r4WZbmrM5Aa0Xh0GIAWtwgOGzcJ7CCHIU/aE1oGpRm2mSN/DmrQ1CJaA59UKp4Hf1lmEBN96ahN7GraOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773643073; c=relaxed/simple;
	bh=qDsHhbPxIT+Q9J1MamUtKdqYgi9yLUueJwoFGd2tGSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HWmKcCrgnMf0hBAJXWsynecIOMy7eV7g9WpvwmWW+7Lem3Nh1p/jXAuLuVrASt2pFlhMwAah1+gsM7a+/C7B+Tl/Q7/2PMRQkv8n6iNjRWnJqxlVFKqOxd21CLBiNxkQnE0hGc2lQld9EzTkL1U8gtyw0/C/ueJqqT6edigV7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnnBqBOr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnnBqBOr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab077e3f32so18899505ad.3
        for <linux-i2c@vger.kernel.org>; Sun, 15 Mar 2026 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773643071; x=1774247871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5k8sNwUCtuNl5KQTKE9dvLLTtEJ1hjFmuOQqcpUNe8=;
        b=AnnBqBOrcsaI86oX7kuFoK2BCV0eaFjIqwkgEWaHDkUFBcxcqMILcL4lkHiYG8OCGg
         +SE/QIVfP5UhHBNddyw/0jDnMHpNIHVw1sFylEYVjfLC/zhrxqlWlB6dMg7q5UbKAEEj
         Uiiw2ceziW9GMsG7o/eDCPKntit+YbVeK3RCVhuPYVoDBfurdE1PoDIMtUJdvwtptXeW
         FBUKz7SPOEsrXL60aKrMAsSPkv4lgrH9qgX0Fu0jpSqIf+pWcCtKzpcwe4T1dXXlQyRz
         7iRkOOUYPm1dztreRCmZjBMU4U/WM5NA4hHZNAKUMk0EQYXabAH8UuqAxrgmqhR562GT
         oUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773643071; x=1774247871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v5k8sNwUCtuNl5KQTKE9dvLLTtEJ1hjFmuOQqcpUNe8=;
        b=jlKMXnz9QUO6OdHFAoRTpFJpGUVjfYHBsnV9nbgRu8SbrdNLvRT6i1WJHiZl1qcnWM
         ix1TAwNYA6TZMWNUvcp9DYgYVMn1z+3il3pPXhjM+HmxDZs6UY/a+DxYbclL38dm6qgA
         jTyQ2211xhkvTm1rsgqmeCbYx/olisPn4bNW+54ntwJkcJQ6L5NXL3qfgaGrvZPM9Yeo
         1o2Vy3kJ2tC4T63+0mCLP3ZbhYxRJSmRTjmxa6ZvFbUHYrJ/aAC1Vb90OIfCTARC/5iy
         +Zjf/OoG0LLthOZmuR0JPphl+QnuZBRqo41euVu0AZ7WJgpFT1Ouagf7PFYlyNd9mbOJ
         DS8g==
X-Forwarded-Encrypted: i=1; AJvYcCW7Wvw8LCTaAiWbzkzG2uQYmpupLiazIqeSyQhtkKDewILQjaWgOjMwrZdezmNwri+FMd1/mOtlOIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZ5teMIT7ni97DinZWj1nLhbfrck23PIFewK6PgW4w9otCfNg
	A1QMo2SCu2Py7elDJLfOSETtUb9icw3ULiSJ0nuIfPTeaqbL750oi8WY
X-Gm-Gg: ATEYQzxPW9jfqjlXsTHbiuDv2YYI2oio3Ba2yIZK93fto/huI1DKOKUw7oRKbFgMuyU
	EDq1b46XkQnHC7j7V5OmYG5sxyItAcI/hykObIdc0oeNcODWXsn8y+QQOaS96BJ36ENYk/eclAW
	SOL175dfwIcxRd8DkI81H3DVrPVYWXPeD3HkIyTsgu8mHrK75NXole2g6dAiDhMKilLC7PIS7Dq
	PCy7HuArfxq8ATz0fOuh7jMZFdobbMkVJUlFp+Nq5Gkn9ZSu7aHka1hY9/Y/56K5otMSQdVDdHI
	qjFhSsCiJKewRtg5sUN44joZvcpLsNls1b7F9nWrDz2x9z8nIFhNGA2kveaNzJdYGlLzojvUfaA
	KoI70nC+gh2aE3tj8zr1R/A6q8w4kJgxAJhp3fbtioPnCceLUcLdaAOuce66w6yQ4WShoCjeM7O
	O0jDCyWHa7VNKg62/Tmq+AmwqZLtGH4+Ghydbb9QTYquqeg3WEe66Z5hCFnaPpOzaj4OkSLcc4w
	FGFqr0lUA==
X-Received: by 2002:a17:903:2b06:b0:2ae:c001:834b with SMTP id d9443c01a7336-2aecac3e7bdmr118041445ad.39.1773643071442;
        Sun, 15 Mar 2026 23:37:51 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56cdf4sm122845295ad.8.2026.03.15.23.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 23:37:51 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: andi.shyti@kernel.org,
	ychuang3@nuvoton.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	zychennvt@gmail.com
Subject: [PATCH v2 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Mon, 16 Mar 2026 06:37:26 +0000
Message-Id: <20260316063726.41048-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316063726.41048-1-zychennvt@gmail.com>
References: <20260316063726.41048-1-zychennvt@gmail.com>
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
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 18 +++++-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 60 +++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index f6f20a17e501..4dfb5340a139 100644
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
@@ -98,6 +105,15 @@ pinctrl_uart16: uart16-pins {
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
+
+	};
 };
 
 &uart0 {
@@ -128,4 +144,4 @@ &uart16 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart16>;
 	status = "okay";
-};
+};
\ No newline at end of file
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


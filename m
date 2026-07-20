Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4898A3890F3
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 03:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516804; cv=none; b=L8DPSL4gDoNBnSMbrqiuLChNJOuWtyYWp1oWLcjh5yH8myrqn/6m73ijImSwNCQPbHId9sFxQEJY5d1XlDnYO7F7TkJa8bniTqolXkPx8slhecIf0GX4MGtSkIA5prRH2MRl+ppjnqfureqezbRbGdSZghOQ7EuPGWmSHQKZa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516804; c=relaxed/simple;
	bh=0aK3nrisfIvMUC7hMzoMx1aGyZsFxW2jrw74ipuIpwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ksnu593vL97YKeEj25siMTnuQfqfqd+C3DGm2hO+c/+cRRA4bJORMBb0vQg69el5VSFPtgolATz/dqBqr6TnBF/PDmvEbQhd8tg0J+m2HDsjQ8fvDTejsD75vpBBlAdeuCPmPTEzHV7Zy2CUhJhyEZb6tgvk+GIVH9VzcO4aUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Glaz+Knp; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Glaz+Knp"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84a2dcede83so8567935b3a.3
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 20:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784516802; x=1785121602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6y8Hcxg9MXxS8AWcFY2VAmn1cCgVHpq4caMsrXoFzEI=;
        b=Glaz+KnpLXt2tQG3VELb4wK7Ev09rsYYqRbDOAaal/qEnD6PJs0UvYhl5KIHt5ph0U
         k3ZOVixoaJB2IjRbKFW0vp5AUeDr1N/29cC/7SAmpAsQQ5vq3RixVUjkWz89F2PNVA9W
         XuyMy1KYGgPGtuNEGqswiDRlBKRUtE3BwvRNVLmzrtXQBWwWEXbiqcr8gT966iKqC/Xs
         sepnHRATCdrcdtk6W6nrCpHdboCU5lFpWJcN3wiE4UqbcYaOJIFx6OPKCnoIQRi7FbMH
         A7ccTZ+wTVDyOLlpDDqJXRnYsyICYHpoqdbboXU81LzJn9Oi/plYG2lBcy+NZGvZMMyT
         G9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784516802; x=1785121602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6y8Hcxg9MXxS8AWcFY2VAmn1cCgVHpq4caMsrXoFzEI=;
        b=Qnaa4f18mWCoGQfd0TvJJBj0PWB9fOfXAGOslCUvT7M7Z38+N6g/2lYCEUHazcZdth
         vVr9S7CiNtBZeNEbpO5tVKkzre7m5XLnJD8zh0DVDeU7epvNMMlIhiv1qDGX9zA6Zqiw
         TN0LCbUPLO09SeuutwqIcimTdX3Q0uImO4Qlzq6A81XxLHvOx5zjxOQhFK8wXfyjv5QZ
         tl+hJZ75y1AFe6r9EHH3gPdV6nrP1BtCuzyRQRTmZI1EQpGC1kenhMcqw8HyrJUcNrEo
         6BhhfYCLOz0oWj/Socj8sxynlWd0P9E8DhIZF/aa1jFQiCowvxhPcdU/+ad1SnBrGaTn
         BemA==
X-Forwarded-Encrypted: i=1; AHgh+Rppe1ZQLZPapfceLyKiBO3ELQJE8dBdKA8bL52N96a4MSd3lZ8+riV0WaA7HFEjFR/YhbE0CJQ+EIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjwbIbe9oNX+o6L0EH+OUOf3OPBD7h5v4XfRJeFH/+Zdnh97ll
	ACznwh9nDn58udbsgHKnYkbVGac+1+vEfo/j5JgWBCl15Gw96pSkmmyd
X-Gm-Gg: AfdE7clKoIRhtPmq+SWDDyHaUi1/QJY5fPj4Yd2z0NI6DGopLYHg5gAmz/lkc4mEIHS
	CUleZrR8y+ss4NUQXGjUgM8sTyIW4LR1y2OwocInIZd2lfOMAKYawWJMFA/YboduFB1YQCeDJ/R
	J8963r8r5bRcWNUzDhNLZVBx6NFusq7Bv/2Bu9OrQ5Dsv9BBNtB0z5DrtrLY8AFfPqkHCgFVuAy
	UEj2s7N72kg5w646cXdGeZ1+mEUpjuaurWbTaskKsauMa36G9p3A2i4jZ/dik1YnKvTQoqD7vk2
	b1qMNpRfUYJeQUGrLhcc05YP2q1cPr3vkYQRjNM0TxLSVkvSe4Niz/8i8mivCnfJ29j8q7cOxzv
	EGIGM3llqPPYVKyaHLmoRiFsKb6lR7m+8cDCWj0gPZT0EBkzjep+7KtNAt+fQEGgh36SVNU85Zn
	d1DY1Ym/f+penJnpSGRQCvalyU9WzqghzLbLHf1DLuIbfA2m60TljYNA2E4jLr
X-Received: by 2002:a05:6a00:228e:b0:848:2c2e:c7a3 with SMTP id d2e1a72fcca58-84c292730d0mr12373498b3a.16.1784516801675;
        Sun, 19 Jul 2026 20:06:41 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfe9sm4805267b3a.27.2026.07.19.20.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:06:41 -0700 (PDT)
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
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v6 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Mon, 20 Jul 2026 11:06:16 +0800
Message-Id: <20260720030616.1067660-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720030616.1067660-1-zychennvt@gmail.com>
References: <20260720030616.1067660-1-zychennvt@gmail.com>
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


Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2F3E44EF
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140413; cv=none; b=CLg+ZqZFm2toTDVsBejm9hgnkliC6fzsKAOZkaTse+LrRC5sTsaYxRhKLBLbSLK8ElhUQG0eEdLL38oWBezK+TqCkGtVbcehKU+wM2ortO6GOihvKKb53vpD/TCL/Dfzn3DuN8cSHaJySA1ZYqbJUD7jK0Mfc/8EaFmp+LGfsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140413; c=relaxed/simple;
	bh=0aK3nrisfIvMUC7hMzoMx1aGyZsFxW2jrw74ipuIpwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crpVsVFc/omPXPqPQfiC53GjNA5PNg56rnM2TzFspGvC3CpesJfWXN6AcNHQzogpW/cERdGqZ9CHAa65AnjeNJQHQluQzhofitWzV+C940hkFvZYmwtnPqPESZdDSMS/MmdsVbhWTTBymrLEN1pqUccBH68ABCA0MhPQ3+0iOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roSANpQN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roSANpQN"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so2415567a91.3
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785140411; x=1785745211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6y8Hcxg9MXxS8AWcFY2VAmn1cCgVHpq4caMsrXoFzEI=;
        b=roSANpQNg3quVzBKKHEK6+TiDsqmMju30Qg2Ce4vLeCBfbM03TPYE6CoILpSuSEckk
         eD8XU6OA6Ag+7ShUYdGH9GNFd/2RGE3Vyxdj06CjzTjqWmBWLPaHvHkkoADLk5AYwQSX
         Lfb0YpiGktrnaUlGiEyoG8+bXwQjoFyeNIM9ksW6rYESzW2jykBM4ZYOUjzo0NKCxpu0
         EG4KQ88ggdW+icKs3LUqlNhIDXYkAaZbd/fO9Txn5sGA2BcTL0n/zeOOvIIr6HC5uIOW
         3dCdDXZuHDE3ymbm4JZbTgBv23cLpdLqkhU6UoirPSD54wc8ZSQfUxUeconsm5/4t6yG
         ZBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785140411; x=1785745211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6y8Hcxg9MXxS8AWcFY2VAmn1cCgVHpq4caMsrXoFzEI=;
        b=h2Y6k26F3dzyNIGv6HhYwLzRFqpBL+89jSYEGZYsMYih+a1fVZ4e12jNwIasi7WAGM
         3bbeWNib43WQTZGVqfqyCRDpQtCb/PS1+o3B4PN38655IvFY6qjV8hl0HTsyPwA4GnM7
         UJDUTCIpgWIEXCaFbRARGLn9geQYZ+pGsXSrodQpfzGwN98wD5MWc9VmWJACW1633sYv
         7YXKmOTjRyAcKjJ9xEhb58XAxcyJIBIGL5KqNOzNR5xBIGuTl+DSejpYcVmQSfhMQPGq
         ATSXXargslwlaFp3TBBNWpLERRUeT9GnZ4eGLakD2kJco6Vsjrw28Yh/GMM71sRvNSXr
         GZog==
X-Forwarded-Encrypted: i=1; AHgh+Rp10/gn0p7Mlo8s36tIUppKvzvHs8xedQr+AIl0I6vtzu9OIRv3W7o3pR+09m6UlQwOJ2/1M5XrrgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk2CuT6704q/SY6Fl50P1a5vilG2TVA+euybV2P2Z5XhVJ8J+8
	b9+h1oXe8UZX5Dzr0amfsSQe4U8jaB/TdxlIhCxj99pCJmlYY6o7LdiJSX0PCw==
X-Gm-Gg: AR+sD10kkdZN/+0ZslPQRVTimhhv2uu1aEnLCXhaCoqkn6XH8zWLkIeU10SEpywB0ac
	OeKrch5HEp9T/0mHAjkQEWO7QqVDK0H8Ov2SiPtdZx3jolJQ2+ssjhVf3VbBRqyl+f+nab/Lp7m
	y6NElVkCM0TGCUeChyg8kdtDyHXB0NahN0Cdfp4G4m46kf5gywUSnbIxFW3UsKAtloRgYYcXm43
	ept1a25i+bqEQJnu2DgjsrHwv4JBAhTwNFZakbCRp2qq5scyZV6aKRmoNKegs/jtGafQaWWPowL
	xBmalNgk1YR6VNcUwK+p3cGRUVpAtkEbvi/j5bzcSGghl6xIFAfeAawWzW05F7V5pWZFkxk43tR
	FnGJtOPlKLicYw5jo2/VH0HQmLUxr/qwmWlA8gAH2ZMcYjiGilAmbe6eRZTt/pobQBd3MnCPInQ
	v/pUwVeiGG6cyOnDyuavsx5dLMTW2cBt9AIWH3Nc1H0jQntoNhOSRAmdyCwB4hUtVF0kOMzs8=
X-Received: by 2002:a17:90b:3806:b0:37c:18e0:90dc with SMTP id 98e67ed59e1d1-38f29523451mr7212928a91.16.1785140411114;
        Mon, 27 Jul 2026 01:20:11 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f292aed12sm2629156a91.4.2026.07.27.01.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:20:10 -0700 (PDT)
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
Subject: [PATCH v7 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Mon, 27 Jul 2026 16:18:59 +0800
Message-Id: <20260727081859.1737223-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727081859.1737223-1-zychennvt@gmail.com>
References: <20260727081859.1737223-1-zychennvt@gmail.com>
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


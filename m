Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F96E33F5AC
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060673; cv=none; b=mEtwg1RA4+ISQt0au/U8vM84Jxzc7kgJFqDB777UjrlWqeLNCPUITV3T7Zca04sghMaZbZWByPlkUrf5+OLQYe0sBg+uvC3HMdc6lG1m3elh6Rh91Cz975BDjwXoKi1l5YH10atAXT1ixonSbC1+VBxRwx67HFPsG/Dujwz5324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060673; c=relaxed/simple;
	bh=9V0Bctfe83qD6wrm60uNu+uq1PpD9Naah0bpNVRvkYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIrQ76Wj/gMzk8+R8x6lG2dTUsb0KeDYiChY95ozPUxq9P6zrAUlaZUWNGoxS+bNXkGLp2WkjalQ/TTj1E1MaMQlBWrNOYp5IGDZ3l6otBhDJD3P5M422jQPPwiCViH8mpc6jutmrle5XH/H+O5XOwK01N6kNRVOVQLZlHMsGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itfaN/Lz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itfaN/Lz"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84275887a3fso4516513b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 20:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781060672; x=1781665472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLwdnFJkTban4EYcPq7DmxYQAfDer3UBe95lCccalhU=;
        b=itfaN/LzhxYIh6byJjTuqK+LdMmMNOX/ZgWmetbgTd7lGAi/56KBdOpJ91K8uFySiR
         HCil/ZoPiA7+wDA/sBDMD3RjaOwobumOTPK4h+83DW8/lVgoggvvByDcFfX728GPtJOv
         HXgs7stDt9fzJhJC/SU6jFoiePsBdIFIRfC3pXvFkGJpdsVG/K8WiOk5+l9w9DjNbJKf
         We2LtbfpBlm00qK+tqc9weTmsZsoFoIG5bswD+gaW7xx98N7KuDYwfFgsuPBWY0j3WUG
         ll9RYLgdCx3GOS/MFaC796l9AhfHqXvLEZc8ZTqMeIwy8zCwxdphMniLz4n8FtiDtgww
         PJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781060672; x=1781665472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLwdnFJkTban4EYcPq7DmxYQAfDer3UBe95lCccalhU=;
        b=RWLW+XeCTVhYLXKiLw+NTR0R6TzaNYfQvAONN1+dEl87ICMx3nxCSHFyYdso3d1bjG
         tE3Yz+Op3JtIGvhRmDgx2kSKSh5nEluLsBvsdGiESO0WILeWZja1eFTjO4afQLl2xxzm
         BO9J/qcYK+aZmw5oXN6e1B4yomgRLxNlmy/xEVpE5h6+x+Jkuvk1dzzYVQgVXxG3Zdub
         kRb7rjaOQJ1uzzd0EZwExZJ4WVAVTVZKZ8YieufkAoHssFDcWPSWrnMrbkKBPKTfRznt
         WLydIr/v6xzvhHaBzeUOQnewfI3C8EXK6jDy7IB+U6nuAWKxsHxHCrWpW46x7twHaQ4S
         nm4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+6uSUOD+Xt2P7ms5E7uDi8r+w7sIWIMGqECevi8rtVE9V63JpqIDKB209CWrYJtCc49EhVOJ4ojRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFIyNm40+tm/lxMDnW4nUfmCcUaDERWMtQidTzTcUzrROhzxE
	49IdM30KaH16CFXMVi4TF9hnW8l+klNqY8aUyNhqYzHNi9A1kLtGaZ0W
X-Gm-Gg: Acq92OGVaYOe3+p/8iqutaXvq1hC2hbvVciIeaTcznZiaDwmTaCF6IyCAcoGD/y0gru
	KvnUPjvqLP/wFa+j/X3oNoDtrqUVZUgksZAL0FJDUmyqRxLpn+zcsw8HVWinPd+xExNeZbObUAz
	gVLiQDLFTRFLL5H+rlstducU2jJ7/0lVPwOITe8xWSMRpbRbit8rwX0WT3pyirPrFi0xk1DPOsR
	gooYblndC6lvQb6nXdDrRdm8lg5tjBwrI/tzHah7CbBeef7YHZ+jzLy9b1nHhC8ALmC/N6NKEmG
	GkUusPoHSuRcDbnC5veFOOmPG6J7soqJN7KFm9f+ASANa3hoJgmxd/XgHQkXhl0Hy/jtdAmtlWS
	CFPI9vxSgD5y0QaqaElD0ymzEE/1RFb7vwUpGEe5ULiCnVqzzFng7IqLL9CSBGqs8Mo98hSQ7++
	96zloiR+tjh3rnnXtLkm6idA+7w5Yev22WAADUSOAReTFULc5+0/S4rqCMU8dOBfW6ToY5uypbQ
	IfDjoNZT9yHY0LnR/b9
X-Received: by 2002:a05:6a20:4387:b0:3b4:661d:8405 with SMTP id adf61e73a8af0-3b4d39f7d02mr20694441637.4.1781060671689;
        Tue, 09 Jun 2026 20:04:31 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a61b3sm19927082a12.17.2026.06.09.20.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 20:04:31 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v4 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Wed, 10 Jun 2026 11:02:08 +0800
Message-Id: <20260610030208.2020275-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260610030208.2020275-1-zychennvt@gmail.com>
References: <20260610030208.2020275-1-zychennvt@gmail.com>
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
index f6f20a17e501..4b9ff6d00631 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -55,6 +55,18 @@ &clk {
 			   "integer";
 };
 
+&i2c2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+
+	nau8822: nau8822@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a> ;
+		nuvoton,spk-btl;
+	};
+};
+
 &pinctrl {
 	uart-grp {
 		pinctrl_uart0: uart0-pins {
@@ -98,6 +110,14 @@ pinctrl_uart16: uart16-pins {
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
index e51b98f5bdce..fe9e0895beb4 100644
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


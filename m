Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408A284669
	for <linux-i2c@vger.kernel.org>; Mon,  2 Mar 2026 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772417336; cv=none; b=cu+P4vpYgkyMRXbiM+5SEXFAUtMi++QhS6MXX4JWn/mOoogzA/7qWpiQ+kGxH5Q9prETPGHz828yqJB++FESPR45XmG1uYpcBljHXL4Y6rTD4UtMniN51Icy6jaqWVG3R/hIC/P7RdadT94di5EiEgG31J6evItUvl9T0sh241o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772417336; c=relaxed/simple;
	bh=8jL9Qfm415JXlhiJKbxCTF3VZaQzO+LpPE4DAo3cO/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddpg4EueIlpl/OIEHPLVMUPsTCd8pnIAdl4ubrNXSeNmwZ0sQSEpYNJowu5Sx0GS9eg71pLgmgKQA2h+eqj3uYw6jy9+hqhBCrN0a0AfbNaWyuL/akEVt4ZiqBV2syeIVZXZ8GqejnjXETiYECJu0KsDe5Y0Q1ViYHhzmhTjoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVjLtmv5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVjLtmv5"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3597fea200dso886366a91.3
        for <linux-i2c@vger.kernel.org>; Sun, 01 Mar 2026 18:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772417334; x=1773022134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPp4rqmor4aB2PCAetYan6hsDfGcu08LGlQPnz1RyHo=;
        b=jVjLtmv5Pa30fnf1NCDYsm5Xpi1vy2gChK0yDq077e810pFwcsNL9AtLqNK5EWQCzQ
         yG3uNHvrqR0NVUz4F6zPVP1bLPfWNleuonwfykHqItas9ek7Xj4vPdsc6dvDBPR6Cmej
         UKRMn+nnY/rByaD9WrpTtK6wFo++eERTSF+NM9MSHNX7r/9xvb1tdVsq2c6cX3JkS4w/
         vnfko7/oG8SU64c8Pm2XqVOVXMucxWSdYcu0JELLeR8e3ybELQ2SDebfVBfn3sw7gxfy
         kPi1HSLpbxOGFHWdFRpAHo6caoSqzpCmIOfBLPARmo8dKVgDzKpMqZSrZQ6IaeasafLa
         uxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772417334; x=1773022134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPp4rqmor4aB2PCAetYan6hsDfGcu08LGlQPnz1RyHo=;
        b=ipcov69gMeP4zn38sTd7tls2r7kf8vdcMD9lmcbOHhJ7bSI0+v7nhHyElKQ8BjfIbj
         mKokj337sYWJCKKGix9Iq51OnRWNVAtLgk3sSSUrw0EfHnyJMl7BWN83wkSddDu74bUV
         oeIi3I+ttSvjfTziil4QNL3oyh072hJtTHSeFZxup1V/yrDd8xWcaKybsVW+8PEtYoUz
         c1+5CBNH72b1OptBEv2YIMDpYvfUZoNATA0hMTbUv9K7Z3B3Wet5JPGG/8PDHV8CcU2q
         n7MBS3/UEXqNnJAgGM7FwrYu31+X3ZNwr3+rZufEV7jAhfzno6wiFYjojPHuYPdR4hyw
         7nPw==
X-Forwarded-Encrypted: i=1; AJvYcCXoZ5BvI8tjV/Qp0wftHT9Hp2GBJuWrMpSNOyyM1bHAMfY58pvvc+CNZuB/R+nrUhTg6iz/5eRvA8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9vz177AMGa6FSu8SY9P7kcx5oyVYxJihLp/mXLqwbqtPvoj/G
	4+Nm9n8E89MOQ+Q+iZuEq4F4Y59XSXWdzhh+2CqpPswQw4rWo+mx4bj6
X-Gm-Gg: ATEYQzxz8SsJLxeKQGikOny45+rSMZnbrGvHNB8x9ZArlBbRLM0CSfgRqEdGn5lUcOT
	dNnSYUlxlQ466RWi5syq7veLm5f1z50TozEwv3QMT2yTVRG28AWdSmNyFsv1MvWgcYbQThquabx
	K9RIz/k4iKMqbrLJuWDgXnOYxwaHvvp/SECx3SZCXd97G0Xxyk+emALD5HMWhPSw8CAk9RAddSE
	+H5UPFnj1ydc3xZy9/6Zb0MoSkDo0Srp3KOxMiI1ep9DeAhXk6OWd3Qwr8QNqfrtkDInNq26RAc
	75BOA6kl/PfE/3yuiyq73ycBK5FTCNQLxJXe+OY7xI1tEgJRV6fhAfzWSDMLq9xmqwtwYZ3jGZ3
	OfL46M/WuD9IgQbqoDQzFSfXqz9GmzYT8RfKDzu0Utmbb+KeWontl6ZR42Gk+lDMsp0htUGCV9A
	7ls0dqcc5/HhrCv5vJDs9DthCCoRzTDXzR20vtSrIUPt1WBFwk0sD0vk7Cb8l0oD0mbgOLGEoNB
	bZ14lu8zUv/twjePZb5
X-Received: by 2002:a17:90b:314e:b0:359:849a:7357 with SMTP id 98e67ed59e1d1-359849a750dmr3044128a91.20.1772417334443;
        Sun, 01 Mar 2026 18:08:54 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35987523629sm2764697a91.7.2026.03.01.18.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 18:08:54 -0800 (PST)
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
Subject: [PATCH 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Mon,  2 Mar 2026 02:08:22 +0000
Message-Id: <20260302020822.13936-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302020822.13936-1-zychennvt@gmail.com>
References: <20260302020822.13936-1-zychennvt@gmail.com>
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
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      | 14 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 65 +++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index f6f20a17e501..2a8f0fd90ded 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -98,6 +98,14 @@ pinctrl_uart16: uart16-pins {
 			power-source = <1>;
 		};
 	};
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
@@ -129,3 +137,9 @@ &uart16 {
 	pinctrl-0 = <&pinctrl_uart16>;
 	status = "okay";
 };
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index e51b98f5bdce..36bd19e37b57 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -17,6 +17,10 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c2;
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -372,6 +376,66 @@ uart15: serial@407f0000 {
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
@@ -379,5 +443,6 @@ uart16: serial@40880000 {
 			clocks = <&clk UART16_GATE>;
 			status = "disabled";
 		};
+
 	};
 };
-- 
2.34.1


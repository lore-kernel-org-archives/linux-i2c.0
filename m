Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCE455620
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979902; cv=none; b=qhndwUi6t8RFeZU10CbH/sid3EV7/yp9p2zSgu3fPIrvrjnO1iWciFjU+MRPaxh9AfO0pUCuyRFTvdY15cVHD+lZQVQ+cXVfQuXqv2wzkaGsZSMr9L+hAHdLgttu6UumjbVXLMW33cWtYAbrXquQeo+UGl2q4WCvk+NaP4sks90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979902; c=relaxed/simple;
	bh=0aK3nrisfIvMUC7hMzoMx1aGyZsFxW2jrw74ipuIpwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FMWf3vS5Vf5J61oy8mg9iMCd/R23vQHqoh/3GEycUJSVqe9HbQ9HMVjBg7KeB12nvkzkLQP81sVn9tWnpLx5VXldgKTJ53ugR8Wp7EbYmc8oVYArXLrIbc/Qiv6JWh2JPkF2RFPkBUjMK5VoWzRFn0rX/vr/TJZeDCYWv992BiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ar7gBbyh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ar7gBbyh"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso2429893a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789979900; x=1790584700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6y8Hcxg9MXxS8AWcFY2VAmn1cCgVHpq4caMsrXoFzEI=;
        b=Ar7gBbyhibhn9BnlOsiMj3+7WDHE8D5Abb7FUmkzG8wdB33+Kwa6pp0mpGPFmUsG0K
         zGmM3dcpm6ACqvv1mU5H9PxMaijb7jmkvYcW/5SzuDuLLwLNfW3GocZulERhhwVcPus9
         2s1Z1T9HCpgAvKmJH8Hjapfxicw4z6wFRkYz7Qyyn+F69ZCWQgQM8QwQ6XL4VTd0QtBP
         y27SBnB2ebYDcxD+ro3gdUx/rRenVWBkGUUQ+JsRMiJzJhFz81Pni+mr6IFfHorXn1PA
         93WC5YZEqIEhk2FVCy/rKoQ64jilh0xOSxjBKI+ajNkNP7s39wQYoGQaE9Q3kFIF6/tZ
         DfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979900; x=1790584700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6y8Hcxg9MXxS8AWcFY2VAmn1cCgVHpq4caMsrXoFzEI=;
        b=E/CBKNTojT1WPhQNV8j6PBqLRvksr8SZKpFqUgOWBzQc3HeFU3+4PYABr9H12Xvw/K
         yysri3r+uahH0yMi1eZGJ+xKeBClokwZfsISRGkzHBBP0VlEVUVzshhq5o39Mj9h+LXv
         qb79MAmr+53BvLk1rXhQBpp2fnH0tRVWVdEDLv/j4jGOlimlFgsKcqA0/6lwfYA5N7zg
         jBtWH+fn5H3q+dhSu68MKoptoB86E1BG+R3QxyP5gDt1hyyWo9CKWTsNtke9pMsXz9fe
         HeXmfmDIij9UNQD6SQEqXyuXmTjJlDyWP78n3Bri0sPEAo2Kbtaa93m4zwsJPx3LxL6s
         Sguw==
X-Forwarded-Encrypted: i=1; AKwUvBwpUuoCBSYKmLbjP024aTeaZMFYfE4NbnN+IR3VnuKm5dRUv8bJA7Rsp7rl19BPcGBa4zaIbNSuic8=@vger.kernel.org
X-Gm-Message-State: AFuF++npQrKGBxmKxVXdOASa7uJST5Wra2Bhg/Ptf4NxAiZ9ptl4FbCk
	AYpl8YrllgBNCNgfJuYN47N3X4hLPKxCHKsdHzOPPq/S09icifjiIgmH
X-Gm-Gg: AYBFou2GukHYc5Md0WBjTD1z9nqi/50CxWJ4/PO5v0NP2/gsqzh6e/73AWBiox7xFT1
	vHFhrKwbRsrx0nUVQbR4GTzDwBX+07sHtx8TLmbsKg+be0uB1JxuVBpZT+aRexGx5wVtTHeWlUj
	GeLl8XoNyUH3/EbfppKcSq489TbQgTsEZlId2p43D5W538/KNd3RgN07skNzOl0SctOk8oXjN9f
	vFgI4A7AwWsNuua64rXEwfmW6mXiD9OYH337gE7aJf3Vok40YPm4KDJiLxK5/VP8eg1nTdzRiW1
	Kwlwrn96pgEYg4urJnxc3TSHw2l/NER62T2/UhVRkhyRf33YVd8etP4/YDVdiKGI1GnoNp+sEk+
	7BXBTtDWlASCYuZHFhYgCZ4Iu4QOlwU7Ibf2+y5I+SD2a4UhqL6THZLCYLwv9eH6B/B1tRqDzGE
	CXyMZo3eEvDVuM3c7jWC+xdZSth4+k8gkSHQFCQ+3Ofs/3DyG5vqfJZHxWSTb5S3ODessUCc7f+
	AbXCguzWSnB2tk2NUg9U/AqSnyU9GZuxg1PGTKEduFpO+SrldO+9dy3
X-Received: by 2002:a17:90a:da90:b0:39e:6a80:b796 with SMTP id 98e67ed59e1d1-39e6a80b849mr10118808a91.38.1789979899922;
        Mon, 21 Sep 2026 01:38:19 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50694sm15121508a91.2.2026.09.21.01.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:38:19 -0700 (PDT)
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
Subject: [PATCH v10 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Mon, 21 Sep 2026 16:37:53 +0800
Message-Id: <20260921083753.1109826-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921083753.1109826-1-zychennvt@gmail.com>
References: <20260921083753.1109826-1-zychennvt@gmail.com>
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


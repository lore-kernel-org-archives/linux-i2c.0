Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B26368D5B
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782782497; cv=none; b=fBwSGrR+i0Hc9ruvdQ3m/VPB6wJjuiL10YJWm+B3AuTKu73hrWVePTv47SfHawrrbTaHtcUwDsDJkFBur5u7LAnXVln1X59wdoT7KhmCvkwMjU5XP7ur2oZ7MWT+M90EotUrCjG0UpQR3Bjrfum+TvRMTuIk8NuJc/9SteiseMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782782497; c=relaxed/simple;
	bh=zGn7310A3+W7wbORcg/BF7i/RaT5ZsNMg7+gLfl7YPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HRUmyoDyF6tR61c8XkkiOkdX2KYdG0No9blTc9MO38LOcekWL7wzIuCunbnlLcciE8Ded4LX+DDmSlY22Lx2yTgxksZK2F1kjC+xvU+ixEzswErYHBPnpsaBIV55rlLNuPDrOZzCYAb5VTUo882eEasxY0YxmT7Kmophh754k+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIg6aLTd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIg6aLTd"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847a5528b33so33471b3a.3
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 18:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782782486; x=1783387286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=okOmr0t7RA98sStpJAac9VxUn6tLvqxzMwMqZfIuluc=;
        b=lIg6aLTdHSwF4USM4wShLAN8iQ3XcbqpPa6eu4B/ZjzsBqkDDGDHhlAI9e63BGjQlr
         3qvmZlWFvgfD5OFVXHnFXDiyu3PR9uLTjKsKVX5gPxKMwWpzwrqVCx7Ggn1qMeCgbynK
         zW8XcapvncMeDsjWgPMZWxCia+Xry1NIbdWpPOVEh3Rl91R3t41wRJkHde/+3RRyqWec
         dHm8y1UPuNAGA2QHWjw0Pb4KqBnIuvYPfEKApGlNs64Y6aLgN2Ylj+dckBiguBe+oGQb
         WKA8JMIuS9K6yFe2zv/cr8Ng30oN9vascsjXFpYVESDDd/47jBRpg+iPpUoVLXW8BQuk
         bJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782782486; x=1783387286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=okOmr0t7RA98sStpJAac9VxUn6tLvqxzMwMqZfIuluc=;
        b=FTU3bPu0odd7XEfC9AHzgHDThjXl35rFMl7xq+XwE97C6Ao54fVdGYIZst/Uoe06pr
         DxQlSrFrOVCkgCL2dFH7gc1KdmTzAhho7IUcxaSCNbWLJvspWBmFuU1WzDM+oEEs5edH
         UjCfc7LVDWLFb+B9UrogXrq2uGJ8Dsst0dktSBXH99k+H2IHhZac4gt1wUcZ3foaGGjX
         HWZTfeptE85j0nYlhBzQbVjrxKShs9depUDRx1S0iF2TKwbhchzOy2pzX7tFzMUElq5S
         hUhYjrtG3C88mS2W7iZCDQF9O/aQbosYVODGi13rq92dM6Saq/KIXetDduRykLmrpRad
         bOjQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro6p2r2xj1Hb8wqtUOtK/AwlUZK6KE8Vmou8GfhvT4sVeci4rNcMr7XQeG+kEcuHK6JPmu2nlDJQqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5qdIOyKVhYWfCpOxuuCV626W6fYWGKJsYZ5tSUENbqm8nBJN
	fFJBvl6+/60BpVnIalMYZPd/dqgf5KQjwha17+jKC9xlCq6/0kIhIKD0
X-Gm-Gg: AfdE7ckY3Z277cohN0/DC+Z1A80A2pOI8cudYY0/cwmCQCxSkLjLdYDqa1Tu2/LRklT
	ovgmsfiJq72XAicBt4phwSDXiHJn4sI+3GLqF9cKppoTvnk7S0Pb4IxYEut+8+Zubh2QAlBMyMu
	FNlKEG5ahIZrbcQxUVQJjIYYWrqm0Miwr8N0yKNkR+jQ7Rd4WshmAn4xQ+NyAWh4oxQo8qCLtJJ
	xO02CSHIHJM/y4Bko7AUZB95uwjbVEzHW48rYZ3Cwlz3hwoNH62F1dHOd8u/dAJIW/gZcLNFOuQ
	G77fZD6bHh3WiPpwSEdFrpCLjce/mKqdZNGfBFOTzYfwJHZ3Yy4k7OIcdoPhsjpeGSfAJQTrveA
	BPEDuR4g+HVvAKOfvJJGqHQ3O6KShpZMurQPO6lMbZDlh4DTcvparRNUUR92QeEMPqn+9qAsIRX
	r6C3O/l87dLqMiya10xou0K5h7xFglpfRCr2P5ZKbOTvQw7+o41qXMBDw8yjbVXDtYFYgvPOQ=
X-Received: by 2002:a05:6a00:21cf:b0:847:9351:16d1 with SMTP id d2e1a72fcca58-8479f22aa06mr1116256b3a.30.1782782485795;
        Mon, 29 Jun 2026 18:21:25 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm654503b3a.49.2026.06.29.18.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 18:21:25 -0700 (PDT)
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
Subject: [PATCH v5 3/3] arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC
Date: Tue, 30 Jun 2026 09:21:06 +0800
Message-Id: <20260630012106.3616821-4-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630012106.3616821-1-zychennvt@gmail.com>
References: <20260630012106.3616821-1-zychennvt@gmail.com>
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
index a029b660e8dc..1ffe41c03f3d 100644
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


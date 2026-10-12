Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142F31E848;
	Mon, 12 Oct 2026 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805973; cv=none; b=WMpY13cy0+l+4BjAVlgtA6/3OIyhLs0aF0qvNi/JdOTBLaZZqG64GfQGH+brfXxGPtOFKjOwwXKFGBsE6yeBHf7XMT+E+U3Pu7pkuLnHsPuqF4nFyf8e8dl+mIKp0trDXfCvCoEU8hLGvAs0/wkzFHZWy/L7gn9y7V06No67yr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805973; c=relaxed/simple;
	bh=VLk1/U1I6S+J0f6X56JezF03qidTH5joymikZZHiQRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yql1QM5+ficTimqNHLGmr0bQHyPpeKykpkIBAvaKZlXthywPxKWKGLz5ZzfXvopj3XyvwX8Skcn/FqksaNwhNfEyG1gBgBjZe9t3/sUFISOuwMKhrFmN+iENYhdT7xPchBYjrWT5v64P77FYt35+aG42uT3cxIRJ2Y2JOTOM0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=MSTIBMPe; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="MSTIBMPe"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791805963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/iR+Di9sdlHw9T+wwNeZom3Qnq9pNXhcbJmYGkQGC0=;
	b=MSTIBMPeDFx88fvd6P+RjSgjjksq3xcdW/A3QKJHSAEYFPksMkPcg86W/O0QAieb6A3BMh
	gdTP92ufaUYKemQF9Jek5/UJk3RSCFovla0FvQbxNZO2TkU37P12nJw13AjiSD5KZxwdLO
	YrAquXk7wOF/2B/hpHeenNEVKDSJp0A=
Date: Mon, 12 Oct 2026 13:52:35 +0200
Subject: [PATCH 4/5] arm64: dts: apple: t8140: Add pinctrl nodes
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-4-6c757966a99e@cyberchaos.dev>
References: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
In-Reply-To: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Add the pin controller nodes present on the Apple Silicon T8140 (A18
Pro) SoC. The pinctrl controllers uses the new apple,t8140-pinctrl
compatible to reflect the requirement for not reading or writing the
registers related to the pins listed in gpio-reserved-ranges.
The pinctrl_ap is a prerequisite for enabling the I2C and PCIe
controllers.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/t8140.dtsi | 114 +++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/apple/t8140.dtsi
index 40559da62923..339a6b4f283d 100644
--- a/arch/arm64/boot/dts/apple/t8140.dtsi
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/apple.h>
 
 / {
 	compatible = "apple,t8140", "apple,arm-platform";
@@ -168,6 +169,29 @@ aic: interrupt-controller@301000000 {
 			power-domains = <&ps_aic>;
 		};
 
+		pinctrl_nub: pinctrl@3081f0000 {
+			compatible = "apple,t8140-pinctrl";
+			reg = <0x3 0x081f0000 0x0 0x4000>;
+			power-domains = <&ps_nub_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_nub 0 0 30>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 473 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 474 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 475 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 476 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 477 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 478 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 479 IRQ_TYPE_LEVEL_HIGH>;
+
+			apple,npins = <30>;
+		};
+
 		pmgr_mini: power-management@308280000 {
 			compatible = "apple,t8140-pmgr", "apple,t8103-pmgr",
 			             "syscon", "simple-mfd";
@@ -185,6 +209,96 @@ wdt: watchdog@3082b0000 {
 			interrupts = <AIC_IRQ 507 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pinctrl_smc: pinctrl@30c820000 {
+			compatible = "apple,t8140-pinctrl";
+			reg = <0x3 0x0c820000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_smc 0 0 6>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 572 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 573 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 574 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 575 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 576 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 577 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 578 IRQ_TYPE_LEVEL_HIGH>;
+
+			apple,npins = <6>;
+		};
+
+		pinctrl_aop: pinctrl@310824000 {
+			compatible = "apple,t8140-pinctrl";
+			reg = <0x3 0x10824000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_aop 0 0 57>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 380 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 381 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 382 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 383 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 384 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 385 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 386 IRQ_TYPE_LEVEL_HIGH>;
+
+			apple,npins = <57>;
+		};
+
+		pinctrl_mtp: pinctrl@314838000 {
+			compatible = "apple,t8140-pinctrl";
+			reg = <0x3 0x14838000 0x0 0x4000>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_mtp 0 0 10>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1128 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 1129 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 1130 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 1131 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 1132 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 1133 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 1134 IRQ_TYPE_LEVEL_HIGH>;
+
+			apple,npins = <10>;
+		};
+
+		pinctrl_ap: pinctrl@31a000000 {
+			compatible = "apple,t8140-pinctrl";
+			reg = <0x3 0x1a000000 0x0 0x100000>;
+			power-domains = <&ps_gpio>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl_ap 0 0 216>;
+			gpio-reserved-ranges = <134 1>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 263 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 264 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 265 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 266 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 267 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>,
+			             <AIC_IRQ 269 IRQ_TYPE_LEVEL_HIGH>;
+
+			apple,npins = <216>;
+		};
+
 		serial0: serial@385200000 {
 			compatible = "apple,s5l-uart";
 			reg = <0x3 0x85200000 0x0 0x1000>;

-- 
2.55.0


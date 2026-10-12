Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90C485509;
	Mon, 12 Oct 2026 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805973; cv=none; b=oddVaAKXwLr3ch/skOweI7J4gqPJbpU6nFIZ2GbaGbkng2eY33spPLT1P/N4ukfZ0hqM9tBWGe3nGnvt2tvOIQip58rVUmSddKUL5kyr5n4pu0m6tssKCcFqLJwNBcyo8j9Yo41y5MWgLH722hMF9xbyE4jXJa4G3PTd7zYbBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805973; c=relaxed/simple;
	bh=+7rKD+tskaiyLFgkwQWQcGT/SaKg1e2MykFP8i9VJKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=loVz75vP9PtExXWO7gx4GhqdshS3XG0z2Hx70YPC1/A1BCltPJR/Dvq6Eize7YeO3CCd6f8H4k+sgiUgdfjFpku43pI4SYm8MTAZ0vi2mr3bi2gZZ9OlPzYR76xFeMzvQqqrO9CODymeYl/yQRQF+nQ7WKBTLnzc96sltlkKrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=Wp7KX2VL; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="Wp7KX2VL"
From: Yureka Lilian <yureka@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791805963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2uSr6m5IUUmdJMVXqWyhLpSygHVE/kttYLhxfsdJVqg=;
	b=Wp7KX2VLLuZAs3LTcrC7KEjIJ4XLO/WSyu1zfa9D5A8/o46sENRr4dQ8ijiZBhAFRbpg1+
	/rkv6TjIIeJ3O4oGzZXvfglHiqsgO5KT85VMFhuWKC2wAaUxXyCKv6QvG1uDFI3f8MVMpn
	abTQ36GvOj81eXhH57dgy+geFgtDmJo=
Date: Mon, 12 Oct 2026 13:52:36 +0200
Subject: [PATCH 5/5] arm64: dts: apple: t8140: Add i2c nodes
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-5-6c757966a99e@cyberchaos.dev>
References: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
In-Reply-To: <20261012-apple-a18-pro-dt-pinctrl-i2c-v1-0-6c757966a99e@cyberchaos.dev>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>

Add the i2c nodes in the Apple Silicon T8140 (A18 Pro) SoC. In the
MacBook Neo, i2c0 is used for the audio chip while the internal USB hub
and mux are connected to i2c2.

Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
---
 arch/arm64/boot/dts/apple/t8140.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8140.dtsi b/arch/arm64/boot/dts/apple/t8140.dtsi
index 339a6b4f283d..3b4f7695552b 100644
--- a/arch/arm64/boot/dts/apple/t8140.dtsi
+++ b/arch/arm64/boot/dts/apple/t8140.dtsi
@@ -297,6 +297,46 @@ pinctrl_ap: pinctrl@31a000000 {
 			             <AIC_IRQ 269 IRQ_TYPE_LEVEL_HIGH>;
 
 			apple,npins = <216>;
+
+			i2c0_pins: i2c0-pins {
+				pinmux = <APPLE_PINMUX(171, 1)>,
+				         <APPLE_PINMUX(170, 1)>;
+			};
+
+			i2c2_pins: i2c2-pins {
+				pinmux = <APPLE_PINMUX(165, 1)>,
+				         <APPLE_PINMUX(164, 1)>;
+			};
+		};
+
+		i2c0: i2c@385010000 {
+			compatible = "apple,t8140-i2c", "apple,t8103-i2c";
+			reg = <0x3 0x85010000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1108 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c0_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c0>;
+
+			status = "disabled";
+		};
+
+		i2c2: i2c@385018000 {
+			compatible = "apple,t8140-i2c", "apple,t8103-i2c";
+			reg = <0x3 0x85018000 0x0 0x4000>;
+			clocks = <&clkref>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 1110 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-0 = <&i2c2_pins>;
+			pinctrl-names = "default";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			power-domains = <&ps_i2c2>;
+
+			status = "disabled";
 		};
 
 		serial0: serial@385200000 {

-- 
2.55.0


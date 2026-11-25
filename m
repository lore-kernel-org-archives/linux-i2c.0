Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610671;
	b=sz9NipiCnroxl8G699WTfLGe+R59EGd0WcozMjBd9dWP7gWsm+BysIGdWrCLOLYsKaH3
	 bVB2l2MKmQK/vKtAM+ZuuBCICxzRYr7stFtmqYMJuCpj04aC2EJclKyVfmw+FqF3TI7CI
	 Trnh8VXHRUH/h2FAmOmTOLVqUEVCirAbbjYRItcOWV3cXcZkFLLRHQUGHtq+gfZ8OigbQ
	 yC3TVTBKnsz56mh4JyMaONS4I1CtUCPMTla30cPQmYm3ctB68fYK4JCn4zL3o601Kjuna
	 snYTeT0Upbk77A+8sWgfsWCuobJEXw8wM9yqRKdMHnjCsGQW7GK/LdnMw9PYru6klbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610671;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gnYPQTYFWBK1uLMVrW6FZpDAtRNAKYO1rW8iK8WK7oU=;
	b=nMuQo3I5n9RJJj5kCDsG0RAmN+tZImo5uWeeQE6KME6JAIaIHPvEYZODGoWGqvtzxfzD
	 jg33tO79bq80AXRJJIpczJO+m9GpiPO3Eu1U+/ZDx9Zl8eyVqoW9QUPPE69LDhFUVkU8C
	 iWKMYJ28nbcz2+ZKWzH9M/QYCSUJ8gNd6zbXzUJiEzkOGcOSj9Aicv+7rP5TASytP+1C3
	 DAGK6iAphvn4pKphmHy3QHwcFhfpTsoWkKDdkW8LUGNj/31jilx50oGQxQZsCaSiLeHw3
	 +4MrP/tFti9oFAUA5cTbJ2kFW0l7kVaeG3x/2JUrm+8AGU/7665EN+PmfSO+azpzTDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=W3s5i7dx;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E70A606A334;
	Wed, 25 Nov 2026 12:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E70A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=W3s5i7dx
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 276154C947;
	Wed, 25 Nov 2026 23:44:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795610661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnYPQTYFWBK1uLMVrW6FZpDAtRNAKYO1rW8iK8WK7oU=;
	b=W3s5i7dx1cqoh2yp7SL0bkYZZnsTGfH91vXY/yYDoyoRUO/Xoi6V+s3ef/ur/FWX4IVJd9
	VALDLkBF37skmf1cAS7CSDtVEfrYBKYouYJWqz1paocR1EMu3LEzr1qvRsxOFalOzkxdxY
	JRI7xGpF1VnKWdyMCAKU2Z+RBqvFjaKEMzf9UcO74CjRBIrKYC47mJrJdfie8u5M/g7QxN
	6tH/qPGRoxiOyM1p1glg4ATkR0ZegYBlN9lNUvhkPbGa/SlB1uCCxz8MtNSYAqFosYgZEh
	z6r/2Gn5zFjVBC+ZzZujN/dGhLnbbv5vE0kOAv/eNA977ijfDpvYvzxAXhPL7Q==
X-GPT-Reason: legitimate_personal_communication. The message is
	a technical software patch (Linux kernel style) regarding I2C
	bindings for Marvell/Allwinner hardware. The sender's domain (d-silva.org)
	perfectly matches the recipient's mailbox (alastair@d-silva.org),
	establishing a clear personal/professional relationship. The content
	is highly specific, non-promotional, and contains no phishing indicators,
	urgency, or suspicious links.
From: Alastair D'Silva <alastair@d-silva.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 2/3] dt-bindings: i2c: marvell,mv64xxx-i2c: Add Allwinner A733
Date: Wed, 25 Nov 2026 23:44:06 +1100
Message-ID: <20261125124407.4098345-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125124407.4098345-1-alastair@d-silva.org>
References: <20261125124407.4098345-1-alastair@d-silva.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the allwinner,sun60i-a733-i2c compatible (with the V536/A31
fallback chain) used by sun60i-a733.dtsi.

A733 uses the same mv64xxx-compatible I2C block and requires the
SoC-specific compatible for future quirks.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
index c4efcef59133..2a9e723a724f 100644
--- a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
@@ -34,6 +34,7 @@ properties:
               - allwinner,sun50i-h616-i2c
               - allwinner,sun50i-r329-i2c
               - allwinner,sun55i-a523-i2c
+              - allwinner,sun60i-a733-i2c
           - const: allwinner,sun8i-v536-i2c
           - const: allwinner,sun6i-a31-i2c
       - const: marvell,mv64xxx-i2c
-- 
2.53.0


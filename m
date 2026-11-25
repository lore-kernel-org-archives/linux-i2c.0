Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610663;
	b=uiwrZobshU9nOvkVKpCYmSKl1mVzgiSzsCBfVWQRUSQrySUAqWl3dSDQ2ikC7Y+GMinZ
	 MhePGdvPrhub6XaHxsyEcLfYKnEibp4GkTUPW3oiFK6KxJ62nk0mb6N++uTLUxyMFW+PW
	 BUmwMAtAr+F766v07R4j8Qrf60UzMvpp+aLKusBgsdgAQAQ0GsWEyLd84EUiaQLmMN2MH
	 snV9uz8wIov1IFsab3xdo8ymPhCbythyuUeb8QO6ad5cH6HxtyaViVlDE2ha8Tz88yPWS
	 KIADP7HWzUWkMHwhOmOtIMvAA+SZbrSXtpu9AFyPqvKGueW90bwVhFL+wBslxQ0x2NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610663;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=83eNWKSER7AsPEjIiws9167fJCTB6KmzsxTKIsGFr1k=;
	b=zFP8SPHFmNxhbKbs3mVJYKY65zHDh6go/qnjP0uBB8twyrsrllhOHoeuJo1ydzB/TlCU
	 4KCOPMvbcSA5EiwjmV4wN9c4A2Bp9jmwRs/R2szMbqWsz1ioz909C8D8mBHj4umT4d1D7
	 4qChjXWjZh7o8In3R9f+WkE5sqWItY2DG+oX7pBGMX2sFbV0jnugvtbrc6+2/7z4W+VQw
	 kw6gk/lME95HhoBRlgZqyzgJyGu/uZ8W6ojcToU9vMg2ZeoReZ85TP+dVzC+R3+BOk5qK
	 pOU8fbqeDOwrcsc/cjLYogw9OtfBmgfTd26U1oNigokELJ71k4cTcGb/dEzr4fUJBPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=CZ0nLNW1;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31E606A331;
	Wed, 25 Nov 2026 12:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF31E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=CZ0nLNW1
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 5B5DE4C943;
	Wed, 25 Nov 2026 23:44:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795610655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83eNWKSER7AsPEjIiws9167fJCTB6KmzsxTKIsGFr1k=;
	b=CZ0nLNW1m9mAL/zeMGCZHZGRRLumKHq2gQma1R2EwY2G9x73x81SnidUU60LVdxFvDUj2o
	pKm+9C7NU+V0e7e4gwGEGTklX7EQX6ubRzMzxqK2KyacLmojDgByb951Ku68qQ6bIodq+w
	LiJ/0HvppNfT0YkOu9cYv8v7NtiBOqw1Vho1f1hcdTOhIb9Ew9PBZOYDB2kz4liaQrrKFb
	pT0izfjRMnR7OJrvc8u/uy56nnHqcA7uzrxsQg9rMRRt7WEoLBwkEGPQqrbalX0y7SdKlK
	gfU8AOmPlPyN9j9mKsU7UFc6Cm1wGZsWIPBXdhl2dJq8d8uzW63lKGmQFtDcvg==
X-GPT-Reason: legitimate; the email is a technical patch submission
	that perfectly matches the personal mailbox of alastair@d-silva.org;
	the sender domain (d-silva.org) matches the recipient domain exactly;
	the content is a standard Linux kernel-style patch (dt-bindings)
	with no urgency, marketing, or phishing indicators; and the lack
	of external URLs is consistent with a developer's code submission.
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
Subject: [PATCH 1/3] dt-bindings: arm: sunxi: Add Xunlong OrangePi 4 Pro
Date: Wed, 25 Nov 2026 23:44:05 +1100
Message-ID: <20261125124407.4098345-2-alastair@d-silva.org>
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

Document the Xunlong OrangePi 4 Pro board compatible.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 091cb0765ac9..a41d4c752878 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -1023,6 +1023,11 @@ properties:
           - const: xunlong,orangepi-4a
           - const: allwinner,sun55i-t527
 
+      - description: Xunlong OrangePi 4 Pro
+        items:
+          - const: xunlong,orangepi-4-pro
+          - const: allwinner,sun60i-a733
+
       - description: Xunlong OrangePi Lite
         items:
           - const: xunlong,orangepi-lite
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632500;
	b=WdKmE4hgqHaYa7V852S39umE0rgPcxH16bNvzxJF1nbqmqMFRR+qDbIxKADFNGfTNyfw
	 0SF8pX840EQpRBr6K1dX1La+XI4uX3rvz2jwXe++oLCT5yfcnhrDvsRJK/kt/ep02fOyb
	 i9u0EWa7uDiePrSIRUWB53VDvj+WROgvAnIMQZvIf6TN1mfBNP9dLJuLpPGaeSa+cVECC
	 JVjSTuANRgBR5jJIJDfuomVWnp4sPSxK6bvaL8AtMQ1rhIYDlhHCTPgcicbOofo0s2SaO
	 BvpE0uE8KENLRJayECxMyk9jdK6lNcAQZRPw/tiVhA2pcKZGOlrV8qwzRYP1k+UAWOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
	b=K/djpOk4L/zcKcFL6Ch3nXjR4dguoEcuhmR5KcYTt7m5L7ausjzwDQsoyOkp5cWIvSI8
	 mjsfPwzVqB7CNuszrc+s874vWjDxLntYj4vodkTrjIDuBnBb8gSs22TO+rrnTDemYRpId
	 mvUkGUnhBSdwpL13IX511KdFPLaumg84FBcy0wRgTA5qaS71Z5ZsftKjw9g0QYgeQvikq
	 CdVOtXUTXrXRrm9ytTCW+WlLkEngM6iYxTqtm2cTHhQBps0H+j9FvjvsGt8/qL9OGBXWv
	 4JDczUYnUC0funq/D1yBBtmO5mIXBCouaerbOPQ8/gOaKI+HQRYcXrHMhK/EI71TzrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lM6jPvTR;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E676606A33F
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 18:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E676606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lM6jPvTR
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c511cdd5a82so735227266b.3
        for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632498; x=1796237298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
        b=lM6jPvTRh8qC2tVEZxJ68Vw2DXnOsWAPa/Hxyo3vQhA2zAFe/MejY0hAD0zdt/076P
         FRh1bvwBu2AMN0W9nu0BQy3ySoAq7UjjWTuteT5cGjB5LQfTcDnDidmoBlJBCbWVQi0H
         U8RkDKgN1kbmwcXHqPweWxaMcn9IErDkmuE8kCSBog3R+w77Ml3s8pXsI8RTvXeATNNK
         foTTKZwypSgexu8jk9H1TcGqgQq/kEUeYS2i6OO6Zsn4SjEECE1JypvAdZbuI8Tj2v0i
         YShrmZYhrR53MZHuohEChrnpTslc2OFjcXWzQ7BwquGlMo94uuGZ1iiNFsAj7u++Y57q
         VXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632498; x=1796237298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
        b=iEVfeM5wfV2E5L5dReyUI0e0tDsO07yCy8B9NrKLT8aPCzcHRVA85JyfWoQ93ZH+no
         xZwhIQ4wGMBH12HRFicnE/Ezd2oIE6CW+r/YTDVpNSfRt/EAgp22S6a04gro90AOEJca
         t6feKJl/uEyGg8rZQP7kfcUK1NfA/KkuZB8fyRwNBPoekoIy7pTTNnr2WOIEdbOEOzsr
         LiAiVCNXWUTLQvgF/iaxExcunXRNllyifYbGp2dq4mnGOC6nn37v5NUVZ2M4WdhdVLW5
         z+99qgADNj9lQNgmCsUqBs7x3wynNp44+lcZ5csXxTBvB+ioec9wCmAqb/b1piXZvnSP
         0owQ==
X-Forwarded-Encrypted: i=1; AL+hErFGkDvL0Ty/oYGCWJA1hcczReUiwmWudWT5ejzFdEljjO2S5UUbHd+CfuCQZzTHTdDGvBV1wJHI4o0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NFisG3Mhrx/vKA8FspWtoiUmhbzhFNzphxcPk0KEe9t6AxltR
	ocJMsMmTa7/npPvhCIZAYpSUP+CiKBDZuub/mwnZXc3DJutE9fkH5O3k
X-Gm-Gg: AZFdTZehc5E/k2nSJ7vqg6KLhs51qR+g9mcpDgGH08nFzISCBrUnY+AIVfXbxLKDATi
	2MYYxvXQhMyUDBiPsx0Lm6gjgQEYIazZtWKdR9tWFc6zr0noGSduYaXJc4DDJeRRdW/haTCy/tT
	PIJpRLE9ehqpqr/jAKr+3xmwJEpXLs8yCviCnGafFv7FknFQyUlNuRCxdsZJMmEmaWVje0o/efp
	ixE0trWECAlgPazleH7Z9qR1G5phrM3O9M+FGA4jUa+rHKcfOv9htMhZ/Zr28HFeepj++5l9wqa
	Bsz3FjLRKzwpsadn89yjv0bsBUB/yh6esBV/t6xY+5OALQVfvmvkb1YcVHnYs5Qf9fRN40ccHBo
	PjrRhpd813k9NZdZY5LAL1Ad7uIsMORwOq6oppRqsuqKMockKJFkvR0B84OKnlO8kBXmDpU2XBs
	iHZ4SIlbdfS1SDB65XP+DEXQK0u2kN0FNHUFzca/E1SpLZJoHaJNtsMWnYtEzfrrbxRMi6pDWwu
	x5Khqq71RXI+EiamC7Puf0b1+nwwvcdMXSBGoOb8qnUaZZQEdlSblywXuLawjDwr3jySCiUAlcr
	/rW9sZqdgHzARdsJzB1YltnZKYjEyJg3EHevHA3244MfiIahkQze3vqDOrMGk+QIXhe/Y1105cL
	dlcIb
X-Received: by 2002:a17:906:5492:b0:c51:caa:607 with SMTP id a640c23a62f3a-c513ab0c394mr1129231566b.19.1795632498494;
        Wed, 25 Nov 2026 10:48:18 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:48:18 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com,
	andi.shyti@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	jmkrzyszt@gmail.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Antoni Pokusinski <apokusinski01@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Wed, 25 Nov 2026 19:47:46 +0100
Message-ID: <20261125184750.57866-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125184750.57866-1-apokusinski01@gmail.com>
References: <20261125184750.57866-1-apokusinski01@gmail.com>
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

Document the TX and RX DMA request channels featured
by the OMAP I2C controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
index 58d32ceeacfc..ff946fdfaad3 100644
--- a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
@@ -37,6 +37,16 @@ properties:
   clock-names:
     const: fck
 
+  dmas:
+    items:
+      - description: TX DMA channel phandle
+      - description: RX DMA channel phandle
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   power-domains: true
 
   ti,hwmods:
@@ -93,4 +103,6 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         mux-states = <&i2c_mux 1>;
+        dmas = <&edma 58 0>, <&edma 59 0>;
+        dma-names = "tx", "rx";
     };
-- 
2.56.1


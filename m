Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035182;
	b=ztRQwUNHAI7E/O04bGm1tDFocRy4y7ClBj262dixH7yT2J3hcC6gEYQJ82+knLBT4Wf6
	 sfpHk2wm2Jeo/RpH/D96Fm/vsr9GfZ7bXdJxeVcakiPzCqDgjmiNrZFu51v1tXgKwTltH
	 lpjB+1i8f2KoiuDUmH2+/1R8+pmtZwOV/1NVyN2NIRdUVYUv7SkW7Nh3mZOnOAZ4r3OLM
	 07SSAwShiTGrZ9eoVRUvZTDnX70Taf7PDb655XIwSl8FwIYEqmeq6Gy24WGyVKkokrvyw
	 jhmDmQRRGNTHm4/lWPY5+m7PRT/CW6m9FF/P2XMn+KBydhFxwygcY5Utl+C3wkgJw8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035182;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
	b=OG+g48Xe5bwg3lfDcQqr95hEzLcjSHBQUu3BYOGvzfSd9U2hei8vvfr/a4gyHA8vN72o
	 Gterrh/F3kJ5qgqppDIqUcLjIobN4TR4oEnhameGqxmH3E+vl+wDVw9HYh/V0UOtmhfuF
	 lTve9gCyV0i1UpRKuuT1p2Ahh6Xk5okYmDsKwr/6UavSyyGrHCOq72IxNIxXy/wtuuaqd
	 kC9kQjwTuYRr/NHze9wt4fwmy2Gs5ywWHPvUfTbVFX5yB5FEpp3JlJP57qL/Ey1kxTrVx
	 pfXYEp9zVZKmblXpTDOwfJbUR1JTzI0tdok7rzA15h83/9XBTDvGmID4m4pQsVXTwug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbO3L50W;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011C606A32C
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 20:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D011C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GbO3L50W
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c505b2e1cb9so223121466b.2
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035180; x=1795639980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
        b=GbO3L50W3zPBCKpX4nWT/H81Rr/VofVkYHAV/6mTN0RreJa/VLJiHzdAzzbm1YNJQu
         TUxDyX7UBLBNHjz4ODRXfQhQ+Y4AaBLmgj2SD0s84sMz5dCx+13G9Rv2kPKG6rg8MrBx
         xv/nBTKlaPQRWBTcov+z4vhnapuM/VkuMFHUb33WGBC2sMX4RNCwygHORTOnvuVmFOtH
         znrtOPCXOo59JqsgjVEX0uSt1XjDdI5KFuDauxeOGs+4EsHbplhM+k6+hFSilAR2Ms0l
         JHOX7VEhB8Uala5teN610QZfolr3YbrqrtpH5QZtSfi1G/zUVse3gawlNG+8H29SEeIM
         67gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035180; x=1795639980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
        b=Gh9jerS4ou2OlcLV4Bw506ifdtau6Akr4H0DeiGqxQvWtMNVO9D3wAFPUWLUnaDxFd
         RkEhxBEn3mHRUWvHBZSTvR2Jqm6MiM+oxt6LV+pZkbJeg+obz/y0xMwJHDOMLSYrwrX+
         Oq+8kPzLlmoGFQcJhpYSfeaRqPU4Mp+IOOuX0zReYsxGZ80JxDPC6gaZnsbKaHmAJFbG
         gFrarTYJCe7SfXbm6VFbLdqmdRoPdmvM7jfdnv6cNeE+wX97O7DfWM4m5UWE1fHhY9hV
         9zguB/FVhm/RvVEXIpokoWUtAjJJnxJ2GT+C3sIs7yfDHWY14ez0P0Un/lifOD0X7dVe
         linA==
X-Forwarded-Encrypted: i=1; AL+hErHsJSlvB7dK4EgGRH5pCdHzm+63wW3oWmcyNMYGKbTghTcJ7d0KtlYNkhyl7R5XIbzZpmkl22oHjx0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Xre9GrQcPU9GnbuCDSZBRq3Cp2eaQxdgxn4/8JhIwdfqRCU8D
	xF4LPwK0CO3fvMOldyOg9SCbIPDnMQ131PrkXzzpjmpyZdJcbpDEo91C
X-Gm-Gg: AYBFou0JT+fL0jVfj5+mbDZNBnH8H7SoCJXZ4WUsvrCS/FkqavJWN9EfWIp3weFIDyC
	svaDJ2GT0KZcX5tXNTGpWQhk8VfbAoLhgyXKVlOfHNqB+3qVOYpTu//OAlJ6ZvMo9ptK6xIPl1G
	RiUtH+7a2Kb0iQKG7n1XZVYWE6yqhiyQpoNFO9TW9oPET9fXejy8pntyoFtvt/g87YcmdsNH/gM
	lTkEZlVuOwVICCDJLlOks0yyALAGGVcuGDC9Hlmapg7NeWWh4+G3lv11NqhBfQq8Gn0psaHgEeV
	7kSg+E1t2+EFLfbYOJI5heZBnl5QsvH8jfZAeTZP/sjZ/TM0iJJ/lUDgdEVcn027umxQC/gK5oy
	uvW795Ocjkr5KHyb+8C/9BIm5p72TPKply85aZS3yxEXxHAUt3GZZfkO/r7k+wcWcMMGD5ebcjX
	y+93rHs2zmx7BzcSz8kggNr2su43Jdqzb+gb3OLfjylTFW7aBp4eQ8fV35wGV3e/Xi3rm3EZqVa
	HpcsVZIkAuaOXhQSsQpYnaFuOsylIRvm/7dErnO41T2pZ3Q4aeya6igkLkHIP8hMYn9Xm8fIYpi
	N1AasupTaxgI5i5tgPzom8ldbEmElueRkCg0TinTT48pz/vlJGRJKHoD0Apd4Ua4wJok5hhYkYf
	kLdLoXD0=
X-Received: by 2002:a17:907:6d1f:b0:c46:8b87:c1f4 with SMTP id a640c23a62f3a-c510e2d4ee1mr357637066b.20.1795035180171;
        Wed, 18 Nov 2026 12:53:00 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:52:59 -0800 (PST)
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
Subject: [PATCH v2 1/4] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Wed, 18 Nov 2026 21:52:04 +0100
Message-ID: <20261118205213.88778-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118205213.88778-1-apokusinski01@gmail.com>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
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


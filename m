Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909237;
	b=kkdiYkKYukA2yvHpUA/Q7NyaLanNgImofDJHif98wkP5lTmqPSRxGAuryTKat4dnSO3b
	 +bRRCXrBcuzcOceVSCCVSuco/RZTO8oU7FFjbZOOYIiHMl2GWpzAwK8kiGk9tT4aJuaS6
	 8Yr/dtK3E1hDan5hTtnvrAx7KHXVRqsmgqzIntSVIp0EDtceF58TPMhpxm89kmJDWRhXA
	 To428R/8VQGewZ7LAHNEJssBr9hUTrxPvDCeYfGUnj8plVde8z/Rug6+qXQroErmR28H6
	 6uuM55tR8vhItNKmtBUS1Hxl97GQq8BOV/Jfw1iUp5D+ODxUEIAqzu/LvB94H5hDDIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZwrKsB6tOpT/G+EQ3qCbOkWdsaYoyG0ZDwls387/DiQ=;
	b=VV7FcQM8LcospvZJNWapxD6ldp9SAACiiSCLP6ZbRYvnbHJKglB0JRSr9bJO4sNGRgSh
	 hYYRM4PzXzol09KoOLHQbs2sPBPs4Eo5bgt1MMemTNPGGfsw+PPxr6b09HbzoY/9iahua
	 OHcQ0YRlHK1w4BMXiowzmjyrB2+Al9Eipb6f7uS4RVTVnYTqcXWIPH9ey0nxXtHZexEGO
	 EKqQSx4FSkWig8vT8pypa4y3eMebeWShR4pphvqNH2c3KXEgsl/+bdq/73CEswY4wQ9r6
	 nv0r9A7vkCTHG2bV85EtnwEI/dkmgn1+t40kdFca3+5sLvIbKmGZEuy1qOqEBvKEA0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHgnd0Yw;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE14606EE9D
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 20:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE14606EE9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xHgnd0Yw
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso25180065e9.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 12:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909235; x=1794514035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZwrKsB6tOpT/G+EQ3qCbOkWdsaYoyG0ZDwls387/DiQ=;
        b=xHgnd0YwB3pVKxQKrb7e1Dxdlxiafgo9GQRfOsdPZr7HAuus+XL5JFG05Yxw/pNIWg
         kY/rIy1IlI40ze6PsdD0U92wi8F6AoC0m9dIAXPJWrkj+Ys0WZuXWhkA1Ept874kB29X
         j4HXwSVEKoiekoKMeShmaYyF+YE/odF5B0EICZM1GCeP/I9h/mBBKouctuzMZI/wuaLg
         HI56tMGrt3yDDoZsvSVOOOL80AzwogojKRkey3o3z/+WZo7A9Al9TZuAwTz9dr65H+T8
         izYXAm3RXgSm60s3sU4thmzgOWXZye3MjHa68XRvdut8E5UWKVJJwPISjCRPGoPH4LCb
         uloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909235; x=1794514035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZwrKsB6tOpT/G+EQ3qCbOkWdsaYoyG0ZDwls387/DiQ=;
        b=fDJ39+9cMhmwU3FJk1Fa0kuMLV3zUCKowqZBKpsjh9qB7ubq7FiCrJDy7elPdMTCLn
         va38OJItthCCMb0es8/7mdMTBpR7W3NQ5xalbOlNfZZOvDdkaDxGZEY/8yPcZgXLJ/6V
         ObMqh9FOtoEgH8BpgV967lSfdRWrNH9tcRUqRnYkMAPohT2ep4B3qJyTmLnIdF0nDBJh
         ai9339pJiH2jG92Cq7BXbDek0u2Hbdzj12UYQ+vz3jDsDW9FGjBXc6b/XV0lcd3Nyv+p
         Tcpm6HnOKapju2MPc3u9U4yvqEwh7T1rV1EgyS0C+CLkJ5B0SiY/Zltoo+eZn+s3GsTR
         fHtg==
X-Forwarded-Encrypted: i=1; AKwUvBwNGpudk1p8De23Z1ZSOz3/KTkN3jJjhXUQHvKYUtPUFNRjek980Fxm5idi+Y9ouL4el4Ca2V9WKD4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ub10wQK/7oB4/QbnbZlXTGoTOunPidEk4tlqfvt2ivqRO0k/s
	6cQHj65gyWSeu6cWfY9kDtC/nm0Uwbiiz3Yx4yxmayjD9/xP/8iF+PWbwPv1MKva
X-Gm-Gg: AYBFou19vOIraj4uqAobkpJK4MevFSKpgvr4zChu60c8t6dteZFfUIuO4ky+d9iCg3Y
	wnJN9oEp3tzI9w9N8t4dQBAiXBKEGsqi71SFU/APYEfgL3U+EZfiuBWttO2EjqVye8HVivoZDSp
	RbMKBwo/u9JBs0id6iTa2WBku/S91ilcWWwauL2Dl72lMmXKaGgxdjJ5eSmFfJreiPMbymrdkS2
	8Ke+4tObkqMBdxKr/t06uWPBLzOyUqnMm7+eoa1tYm0ZnclMo1yLcARAHQ86VEgITl20Ni6txEX
	HUKJrtlLY4w+UQ8x1dY57MF8xuGMLg/ddhNI4NGaXlLgNXF6JUDSLecss03EVsilRK61slF0dXm
	EhMmKXRjqTvOdv60WbgIgRVqEs+MheCeZnOgOyU8IrBq2PAl46MEO4H7cNISKNHlWaBaMNrmWor
	RuQmtrsO57k9G7xob89CsRTiIc7Vmaoo8OX+D4cNSzv98Qa6QXLUHKmZfrINqoTK7aVXWQ1Pdgr
	S29gIwObEUR/TQ3qScN7SW6y8xmp8aLKpaC3v+Le30OAkO/5VoCzMW+vZHV5op7ovFy0zBAHAzr
	/dUDyBbvsZA8mNkrOIlnda0/h79CvDmkU1CyUI9LCPV1x1t8OvQ29ZbKpak=
X-Received: by 2002:a05:600c:6387:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4b6de1c6450mr3686705e9.19.1793909234959;
        Thu, 05 Nov 2026 12:07:14 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:14 -0800 (PST)
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
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Thu,  5 Nov 2026 21:05:52 +0100
Message-ID: <20261105200556.34240-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105200556.34240-2-apokusinski01@gmail.com>
References: <20261105200556.34240-2-apokusinski01@gmail.com>
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
2.56.0


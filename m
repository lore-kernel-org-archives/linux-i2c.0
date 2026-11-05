Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909239;
	b=ILNzic+hJ8oU6I8In7ypIuRuHRQpyVwXAog30elCioZct1QUtueUo95LwaVoci5POy1L
	 zyS+qXzTYxMvO6748GWyOd3lWWc2iwA0XNTJXFqTvLAG5KoF4YSB07nzJtwWAVyAVpWHy
	 wVkAg6tJT9CeGI7ZHv78qY0IYOtTAlUyUyqEJjsTNNpdpKjJO7hSOgEuNWYIHMTOGTSDK
	 GaOKd0ftMW1HhCUig7OiLuLdE5Xagn8UPgATdKiXkl8qJrhMaNgCwVPRozDlFVSXWIBNv
	 8ur8nSi03c4JpN2sj6Rr6asqGdPoZhMJTgznCmbTPFq/0YEt6rHvOUOjbu2FzdBas9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=M8yk4UoM0PWyZhp628ipm0Nb1+FaTd9tnw6+7GjamRk=;
	b=SDu23dBekyS+oxNF9UEtFb/3st/3yfv/m6KBymTecMbyUs6Fvf+c3vdCEWTC1wQb2lAG
	 +tmGxrVGth4Fb5lLQQiLgvDfPTliQeABl908EITpwJxHr65si6CApq0PoKJ1StRnKOQyQ
	 nLXBNRlVjV7M1lZIjARPN+/kEazYRU8gEJ9NqE0rXm3/aIDyXvMXLzbTGOIm6jSqc588e
	 zk6umWWmcdgWUyIfYPQoa2GntgqJk1eNLnWbvPFIlCrvzdgeCHkneyeDrSWi2iQAWVKq9
	 lDb6ACz/dQ+1VifSb+U7OYHij1pqcMQLiCB123k51LpCX5ZRhHT8dEwrh1ySJXP/HDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ub1ox8GP;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901AA606D81D
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 20:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901AA606D81D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ub1ox8GP
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso25180605e9.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 12:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909238; x=1794514038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M8yk4UoM0PWyZhp628ipm0Nb1+FaTd9tnw6+7GjamRk=;
        b=ub1ox8GPhezjPHlk9Iw0X1EMDdUJXux+i9QRQ7wB/kyUmsRoRwEtaWe2krP5upbaz9
         Hbxlh9pZL+ZsPFL1WzxOGEXjUs7coUW8OlvXL/CyZ9P4jRSNwCsp8+ITtJchShWjobLS
         VS4jqDWatzVBi5x0J9R2aYUGhWARactIEuNQA5hGwCRJBxPeMt4cUf5AgcQmaiCJzbcE
         63VPl+CKEaQ+Y51TybM7udRIgteXEsgBMhrcdhsAeifodq8QUhC+P41aIfqQ03+J4xUm
         9UnEw483xSJmburH9EKf2VI2ZG7cPzJRZ3VYnFtGGDiHD71LbauDl98eFNnRHS/dEAv2
         rAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909238; x=1794514038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M8yk4UoM0PWyZhp628ipm0Nb1+FaTd9tnw6+7GjamRk=;
        b=FC3xBj3lBvaQVQYrIRc6R13it3vfxq/5FM9xwLADnFyVFTtDM1JWJKvA/eUkobGyfW
         iq0up4u8mBDrNhjx9ceSRZ5mlKS9r5OjO2h1FvARrSN1A9M13nE1ieUfgd7O01+2q7DW
         AsNmgpuIc9CkKLVrU5UgToLVDAfPQXFNseUlZYHkuYCY5xVEeR/w9TQjTwawy1oeA2X1
         ju9qzaG/ZaLNDwQ/5Cvc9MpxWbm43B2L9crEnDit5WLFwJdkShCHMIX/uCRE2OeUOPma
         qvSAfcAwS3ffI6RpC8L80DlcaZsweSNTazPJ+MIYB1OdoYXCI9h1wGS50lGfSjl5suvA
         oEzg==
X-Forwarded-Encrypted: i=1; AKwUvBw8L2jEif1TPmKqaHaif1aVKfCc+eN0YgPoi18duYnQ0HuYRqdyaM8ZJZrQWdwmxeMsz6D286FgdE8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qka1U5Dy2zhbp3dlEjhpYc3Trao7KobKQlrKRpZrs+EhiKclK
	bAyjE18sB7xZBNgwXBrddzMU44NKXmNfnAAZV+jYwpTqS4amd+75+wiq
X-Gm-Gg: AYBFou0Dl85ne/fIoAQMp3Ba0ms59aqaZht/pZx+RNLjWdF0ZQo0OFaIz9vY42kLrsp
	Zwj3X3J3bFe/hp4By3IMQf/ffSuZc9ReTlhTozNzQclxN4K5G3K9F8mAaAxNdO4n7Yr0gHeCxpB
	VzcdrgDvibGsaXmYnZNYvV5ddLYdYf14zQ4lyW5LKOn6rHlELiqqgILnDrru3xXciRKhF4YiL7G
	cxKrhshDtBZBcXcBjDPxpKAtP2UMfc/PhqQxR0lIHpI0lqDBBlVF53/gdnhnC8ece0idDUwuUOm
	2qdPu/UDl0mqgGiFdrfoOZselfAGuXBRbDM4nXMeInCwYPflXdbSERR9dZAS+ZM9TKqE3kMAZvE
	beIrMVgb9H4DVZo5Q40s9RTUv/uf2NGQYDwr9ITlLx7sgd/H0FiCp4gzAO/dgm6cnx5TV8odrqk
	T176sS4LbRo/V9PAyallA5zbQ0QNIRv/AAbXFq+EFkb3JEu0mG3m14kwQ+q/HvCYi2tl9Xe5FSl
	7dNr0/YF4RGIBr3XBBa3ZUkzYEan0l6VC1byleS6EmiQRHMCh6diWg95QYOoemuUMJhTc/DTNRa
	Y6fuYY5LtYUMjDHW8q0EBDYxfWsTQj357QMQDnI225H+Qrn6vOEFgRYHNI0=
X-Received: by 2002:a05:600c:138c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4b6df6df5d9mr3339265e9.32.1793909237922;
        Thu, 05 Nov 2026 12:07:17 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:07:17 -0800 (PST)
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
Subject: [PATCH 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Thu,  5 Nov 2026 21:05:53 +0100
Message-ID: <20261105200556.34240-4-apokusinski01@gmail.com>
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

The i2c0 and i2c1 controllers on AM33xx support TX and RX DMA
requests. Add the EDMA request mappings and DMA names for
both controllers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 57a45609f9f5..89fb1d1eb049 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -239,6 +239,8 @@ i2c0: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <70>;
 				status = "disabled";
+				dmas = <&edma 58 0>, <&edma 59 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
@@ -1189,6 +1191,8 @@ i2c1: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <71>;
 				status = "disabled";
+				dmas = <&edma 60 0>, <&edma 61 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
-- 
2.56.0


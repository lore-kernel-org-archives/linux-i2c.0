Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035188;
	b=gPjz4JSGa/7Msr2ZHlRzufA8ppya04T6c/KBpWTeecli51+GIDtrMaS7N3dTu9U1UOTx
	 R+N8u/0adYko2AmxZR/bwBaNBu56o0RLCupFoINTkUS1MM3vw4vn4OBjTLaev+eyUhI+m
	 doPDjX/ytjF2P81ODFY4IrdR6ssQlOmUOHvbPB2j23pvlqrGvKzc40GlPB8IJi4Fn/T2M
	 G4G1lConxQCh6P3qHJa0EOyTNnxMid+AB3zZ3o/bSHpzJr34CcZyFv59U6LAmzdkVShpj
	 Fiy6mECIhymBKzF6JF2OLrl8EnWg26JkbyObcbnsxTjwB0D5FflTsCGU1yitqgB2C/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
	b=vbHRp/ZK+ae0KLqaG5mG+tfthnEolOGVF5fWnhEav02DcOQ4B+41eLZgZvMGDPcHl+gg
	 o2bKlice0Z6yFMflr8pL+RLPW7kFtj+EsnPlRJdbJZ1KhYZxNsBfXuzJJG2kfdw4M2935
	 w1L7nWxe4naRp4pQtC5Gg7CYke1fQfLbz/Mog+N5Eiilt4Zpn5K0O1sGt3zil5Y4moE6K
	 I5caQV/HbCcYZzDzEE2sDL2QRoyRhQ8tETxf2Jj6ifSlnUFxTgKCyV1qZy1WGip9cuRfq
	 274wyh/v2VKcNg1wzYtFphtizXFXJ5s21La/G07OKLbLUUe62PRgCbhgt3hiqogNUBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mnuOCiw+;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE99606A335
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 20:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE99606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mnuOCiw+
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so236132566b.2
        for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 12:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035187; x=1795639987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=mnuOCiw+XVWApfJrSVasj2ZwbRaCZD5TnFi3wMHnkk89jysXAwnStHMDwJduYhvMWM
         Q2PvQAilIlElLPf/ESHCmtguPGq6fcjQYD80EbW5p6p0h9w58qWo0WoNsgOv87jk2XBu
         /6WscvhGjJen+7AUTwNMx5B6jyDT3P35kUvp6+OsGBq9ckOPsugUbOhRIAiTbbo1yvHz
         wNA72pMm0g/h4/82Wy7xLDShzDOW8g2rwWHflod5hXoYXdjbsupIWjr48douNVW96rIp
         +LuAqYmahyoe/zpNI7SmwNshZxmL0DXh/aB86mxWTk2jaz3aYAfN2sO2aQ9Kc/bzhEZt
         dADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035187; x=1795639987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
        b=qF83kUbZwfbrnfnKDTz+bM+5SrTuuyZb8tneOHcs2RJUJOqBJxgkq0AANKE9LPKW1l
         mwI+Eid9Znq0Z1jIYZoez2Ofc/K6nDzB+U++mPphM3q4K64hz3aCrzLxn+hQP+S+FeVM
         Jhfa7/EpCTW6H+K0uCiLCjUzR5Uhf69KOxHNJxDtsMrsc7Qy7gz1MkJ0ZnxBT5/89etl
         RQnyG+B/csS3SbruPCeZzf7uohXnDi2kRCS/bI8VBHRK6GudiX9pFwIueiXeKdjsvsbF
         f3h1SfVDE+firknkOviLwYynGQUmUwCuRgWnKMvWiIVvV4uFm4YYQjN6xm3fYXQjr515
         Bt/A==
X-Forwarded-Encrypted: i=1; AL+hErGnb0KUjYnUdDvWSyJFtFLUsbL7mArjC0ST5/owJtVCAdmlgye4Ed55Zi0jC3c4URPiYe4rAG0GIIM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gxOrX5p8mQBqt/qKPumLetdwBYz6tB3KwzLBNyKg9T22Eb2dp
	ZNnHongfjLX32Ifs7rXlsB90gQXBxfAH2FPCEkzIGmEVtCCdYTc22u/d
X-Gm-Gg: AYBFou3dmKfMtiwDzjIN0GPBnE2YudhRryhPzWLv4CA5x/Hp+C5zNWU0W9+cdpuh0wo
	tbVEAm7wRkVtItKkDcPbcqf2hCpc5EdFnvB+9zSf3MOHObz6u5GOAQ7rj93lsiUzqdjPkC5Po1I
	6+SSXPzkhYj1BX8kdSWeP9THb2AV/uMt8i53Oh9OpFMzD5EzzsHmVcK4EdsePaLQA0m531xBIvZ
	bEuIIfKPYZn1gCudkfFYZIzVmcTqBcgRX5K8V1BTguKcwPp+eBztGq82XnxAGm9ZTMRJuDdA17l
	iiVmE+X1TelAI3fPrunicmYmcxJ5jXCpP2MO7ocUTftE+vk4cJl40Wi+ku5N+rtvJFvKMmdunKM
	Y7X2mgFG3P/fhWyCajXvOUlt+9SY9/VynDmXTJa0IxFX9lF+wMQJo7OkPKk09yg3LbpccThTG8L
	lwrKLawEGpFGzZW3j48InU2kk51GK0zcHNtLxWVw9CB1wlr1o+9Mp4sEY2PK2s6uT//k57Pz8j7
	bnHr5iZ1QjdsyJ0gR5oIqr2ocJFJqNYGX0C3ka9iQl3ZIb1GQJoCO4Fu9WhLSilW4382Y5coAVg
	d65J1cfIfhvgeTaEnzAE2SjCU737QWtCFpJtLr1+s5Xz/E11jSPPidBXJTdpAA==
X-Received: by 2002:a17:907:6d1b:b0:c51:691:c76e with SMTP id a640c23a62f3a-c510e35c6camr355946066b.36.1795035186781;
        Wed, 18 Nov 2026 12:53:06 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:53:06 -0800 (PST)
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
Subject: [PATCH v2 2/4] ARM: dts: am33xx-l4: Add missing DMAs for I2C controllers
Date: Wed, 18 Nov 2026 21:52:05 +0100
Message-ID: <20261118205213.88778-3-apokusinski01@gmail.com>
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
2.56.1


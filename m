Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597202;
	b=uM/Ji/a7aakHn8RkMu+W+96mtCnJkZQOl1lYALpeg5b9VMOAib3Gj0uTtvVFigAeoavk
	 uEUaIyS2u/N1VGm/4Ya+CVAODN9jm2vfTA9NNteCP9wg11/0QcX31SgUuzQbeZoHYaDCW
	 ElhFAcTSbw1eLEOkdb3JrJli0smdbeaqvEoA73g9uWn0f8BRdKs7iyEyBQ8n3LiG/EAHr
	 llKskRfxkxB11fszVY7/IQSO/BDS9uakPJ+7wHfQgGDQkcWZbWS3ZBE5ef+KPRY92Sr8I
	 xG1kUgHPOS3VJb8bO0E+UToqOYmNbBhONsmby/WES8KuTTPD5RLtk8RPzYQVjU/M5/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C4B42IGcjj02HwNf34eRwrJxmCqj0YjAetyw+WBTjes=;
	b=nXC/ItFz5vEQv5ftuytQ2eyDa7f1MxknRSufUZuRKnss39J9VKIbyaZbTjd4a4bI7OKF
	 dzn34lafzZi7Xf8kQOyE+huDeegfgoC9Arkie0Aa30sap3uKjPjzp+iBl1EXCoqLNBl4F
	 dGdKhBoiJunkq0BLVDtSbgIRRcD9Fgk28+QnIRka9B3kynXekt5/1yE/4nn9e+4D3NH5T
	 B850KD22pJqPrxTRMk5ImTnQ/gk1Qg0k8K8iifvqJFR7te0NK6d2y8jC9PwZG9vbeNFsT
	 twHiLLBDYA1dBRXQB5ysjTnrkqKqB0v9tZvu3CQsd0hSEh4wNaRoGh0OQk4WhVyeAVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rg/NwLb8";
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B5A606A31A
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 15:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B5A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rg/NwLb8
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so6393735e9.0
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792597201; x=1793202001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C4B42IGcjj02HwNf34eRwrJxmCqj0YjAetyw+WBTjes=;
        b=rg/NwLb8t/dx1u3ms20054DPd+uqAc/PFciJysN5ahw3RUkjyXCYiu3TcXjMUbhssn
         JBmW2XFUGvpEIZuXrRKWERvjjRRxuARfaimuWyukv9KagkSpAdVcb5F3oILdMHJIytv5
         enINaPw57EX65qn03Sv7za0WUpq4VS8QdokhbAM9x3nt2icy2969M75Z2bN6MyURiTca
         sIhUJpU6AXQQ3nUjMJ5ptX6z1PSaNC+mYQYv8vuhKJPT1FJFyxEQxUp5car28WYcB74g
         IlrGayVarn2Hk8Sbstmn06bypann0+vygpt4LTAbOWFE0uoV7/rOhp64mUyq5OZzI+RT
         KLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792597201; x=1793202001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4B42IGcjj02HwNf34eRwrJxmCqj0YjAetyw+WBTjes=;
        b=Iw0L29ZRF0SFAjHPURwlWGBgovrhVmCQqqx6vprn3etsAg169tyiIYYDGNHopwG+iM
         cfeM3a/seE69cUVHKZ3S8xHqeGoMgPvwhUxjKLW7A82K2nd0vErKTn+OiUQVM+08OTpE
         iaG1GHdHfMdfkj/NvBk6v++DAE1gsTSnSpgK/l/6oJEN+UeCQCJU1kl8txQtddUPnkxO
         0Q2IPGEO57Ypvn0h6uoyimKjpetLg02zvF4NyqlCYAZc92s1a9pWx/mrvvZvxbQxVWll
         sTE+jgIiuwa4DMWMtvUUz9fUpFWvnvybAWltW7UK1+H+8aUCMF7qnLTeLWVWTSquD2CE
         FmUg==
X-Forwarded-Encrypted: i=1; AKwUvBxOCv1QALrEtrCMYtz5i79CQYcaCC400c63wJXGuZ+ji+4+t72H/xtlF603M5fWLEnjGDUMuNVQnWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5VNj/2EHKow/1RsH1vrOEL3Qz4L5JgITyicA6x9wCKlvq9ik9
	WvqtfRVV0xX3i3fksAYqO0Q0L9x0N40hzaxwJGU3mm6aRQuxMwlaTktd
X-Gm-Gg: AYBFou3HupRJlcGCQ1ZaFGukeUWUgviOdN5JmjEn72yI5Z7CqujVQk1QQyvT+FlWuVG
	vJx8xR0xImiL3shpiPR32RidsYEI8F9yt1TzKvtUlMeQTTuv3CqYyX6DFW/WG0AHJK/yjwtGGBe
	IuZrbUIb8V/Xw/14qtHjK1YxD1f01K/Bw2E8b6xACarqbvdTVeSbzAtdPdoW5Z+qDgpTWog9tG6
	paB6C2L17vbsec28zzL3KVFRxbcv2YGUEAtfDvh6/PIAKFkHtlvmtUcVc8jfacNAdbnTwjwEHC5
	OGvnMeWh6EAH5vTV6iGFE+ppNmLjOvxeqiZUPQ32lEXD6FId1sM4K8YX+XEw1ZH8FTOTcqWJu9M
	GvEGRFeOi6hpS0FGDeKqtpvcMLz3tklqgI7PxknD1vhsrcUE20kvkG1VvUL4n/8OaN4CImAEKfT
	+ok9vjiicLAbFhEvWRBpjBhVthfg3L0ezC8SCcL0HyCnCzrQCPNvsmLHn+IBtdcjHOlGNlIDUSn
	lOo+Fe7Hp+78Sl83/D67v0j10Lv3AWAWktUcuYHeoZ9ObYoIUsx73yHoMlkTqPzEY5K4Olctdjq
	CUinqzTc4RT+pnmy3ThKeLvGz5INgc/wDcIVcXCXOfNkfAHAjHX3/ej3SmFP
X-Received: by 2002:a7b:ce82:0:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a1fdd22b0dmr39355265e9.33.1792597200529;
        Wed, 21 Oct 2026 08:40:00 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd70027sm27793675e9.0.2026.10.21.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:39:59 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Stefan Roese <sr@denx.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] dt-bindings: i2c: mt7621: Document an7581 compatible
Date: Wed, 21 Oct 2026 17:39:51 +0200
Message-ID: <20261021153953.285222-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Airoha SoC implement the same Mediatek logic for I2C bus with the only
difference of not having SCL_STRETCH bit.

Add a dedicated compatible for the Airoha AN7581 SoC to abbount for this
minor bit variant.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
index 118ec00fc190..e6ea5bc1c681 100644
--- a/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: mediatek,mt7621-i2c
+    enum:
+      - airoha,an7581-i2c
+      - mediatek,mt7621-i2c
 
   reg:
     maxItems: 1
-- 
2.55.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442409;
	b=DwxsEqqu4hJBmLd+b4LmFm8Sa+IwkbkRoxZOSw6K+SG12mk297b7SX6FB2G3oKyKtwDY
	 6Xh8pwKtqSHyGDqYouRqKcirml2aoz9y2E1PEY353qYBz9HbekaDVnOR9RkBKh8uujl/I
	 ElgD98JKeQJTvlcS6kDVQyZg87dbBLd2cnfQwWHb52KQDquMii39S8zzasGU3rt1A+Plg
	 twatgsQwCGDGBvrbjNK7Az1ZCK0yrZNIBrGCMe06GNRzR1znEIGzM/D6NU81HBqIDQ4NO
	 XDGc9J1Tz28dWxY5TQbwLwSjLw1TOf6pRaUw5ij+GYfVxnu80LsNKYpvBkrZfTOgJew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n5fn2TQdNGCA2VZcSuyjatq9JArIEf2Cj7b3OdvPmrY=;
	b=d9za9rR+STFobeUZy4ADQOhrc6A/IgMOqPds3REdkh/IzRkZ/B/WVZIvrqNGrAyt2583
	 J95crhi47g06lQFlEiIgZ48Q3jLSBc6NSpuEXxgs/TQCbRSN07JXd5NgRWoTrArvvspU1
	 Ysy5UCX1Bmo3WCv0B2ezG7tvbzFtSMOxTsynhIZI6jTNjWSQGIBtXhyaZOoa2gT+hfYw7
	 8anAFBylAC/JQTKPEAPPInim/vaAYjhPmX8nl1QFSGvYpZ/umRutQwSblR5sUQ7If3MFS
	 v/kXFJJrIf4JO8QzN72MpUsJwdFV5uIfMNFJF28sJkhPsIRqyPBbe/4uPWLbtwdLR9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ILYXG+O8;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF6606A31D
	for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 10:26:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88EF6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ILYXG+O8
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso18138265e9.1
        for <linux-i2c@vger.kernel.org>; Sat, 31 Oct 2026 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442408; x=1794047208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n5fn2TQdNGCA2VZcSuyjatq9JArIEf2Cj7b3OdvPmrY=;
        b=ILYXG+O851xz2mNFgBIQEbi39aqInmTH/XfsTld5HmlZ05XEuURakX5jvYQiMskAKQ
         +TXaCaxNEnbPmX/0cN5WGtzAtYn3mvq2mukSMKzyN5C6yQVC7ICLuCODe2hVPSPrgvyy
         3CYwu3ec1pRO5FBnCwI0VSkBwsDADVT8NkSo1l8EBONb8wb2Co3P0ls1q3/lDw+oT7bc
         pFdBEI2n2SE9wVARJ71dBzUS2H0ZClcmC+6Gz2GUU+NM+yZmNlZeHlvQT+PxCt0Jk0+U
         8mUnBm40cqHNn0TW0QlwBcGe0eCni16Q3mjR+x2Mi/jO30O80+Dnzmm0oxXuy6nciQur
         hwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442408; x=1794047208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5fn2TQdNGCA2VZcSuyjatq9JArIEf2Cj7b3OdvPmrY=;
        b=pzxLVbabu0XZr+cZPENQh9gwKOhT8gpi2DchFEf2b2bVc+h44KgyA3v7uK/1qbU0zm
         aw3H07EOtJTWpRbhSSgotvy++d/nn3F8cVd1qVRz8d1d8x1gle6PPdxsZ9WwH2h8ENWw
         Zuv+dbPpnS1ceQ/ttyEAcJSDiWNngeMrlcivNn/w8H7eiJaXrFyW6URLiPQf7GolGBz/
         yIz+PKX8Vy75A3trGYFalxoZ9ljJ+b7UguR5oBCcaIaXMozlQKbUxr41lKDjbevaLN2E
         L5IkfLLJCPEkoPa352JO7YOnL81nJRUZF9PtqpiNvlkpiWTzt8yvA6haO6Elv41APNnU
         lIzQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7MLglser4fcWMBVP6c3+vkribfFgycNrIfD/Uutnb3OF+4l8RBAtl/5hK14NoWI40doagsef9CyM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJsSBeb5kdWDeKqz7/UL5fnMAyVKLSzMbYKs8SZsmOj7qF0f3wQ
	H6HhbN9JenMdxRya5yREuKGo7KRU8Splug30KoHzLKlrqkkf87WyyGvC
X-Gm-Gg: AYBFou0RzmryOvuds7meQq4Ob9e7AsS0mLlbJRcIkOyicxMtX1liP1rvTavNM3F10m2
	n3QjHxXMmTs5Rj70oWaIjXxxVHdoLwFo474yqCN2PS4oWE8WRO1MsLMw48J4qn6wGq3aCvOhVBo
	D2DwuffmlPwa6dw0dja0l+CLlKwpAxADA3n27x/U/i0WN9D2rGR/SH/UYGnCHbHVB+GVdQLcSGy
	Lc4GHacluS89oG33ta2daAwuWLsVBMfxwkb8tYKOuQz34/S3NchuvQtlF/7AjrF/C5rHTqyHVu3
	CfXVR4S8KvAel5WNTEHLtPsaB0lc7t8MiXYmAN3ns9mX2AdPhl27dFXNdcstPOWbnQVOwGiVlwj
	zT6qZfauA+7r4w64xX94DB6Kr9eOFzXkwrdCjrCMIZRiRj1dK4/M8pefGKps5c+VheeXVNGwanA
	XzF7C2CUfo/NnTJpt0muJAF2TNdmBGM47HCt1Q2IO7h2Ux+0Bx8ZFXA2hWdwmlBibIFC9jHLF4J
	g7LnBjsITC1tEGU+5IR1OLXI/7zqLVdglBPvZg9uKwLksKtXutIu671l5KFVwOhRQrD5O6bhUQN
	I2+0MhR0VFkepqrscqlmsNWvlJsH7g4t7R8pP1Z3JVBOaMizCsDi9Eu2rfjgYCahkWRYZaNYJ6t
	8Dsw2n/xNUXrz
X-Received: by 2002:a05:600c:4e13:b0:49c:d019:70c5 with SMTP id 5b1f17b1804b1-4ac1228978cmr101856105e9.0.1793442407739;
        Sat, 31 Oct 2026 03:26:47 -0700 (PDT)
Received: from Ansuel-XPS24 ([2a0d:3344:54ec:1210:f1b7:9ece:c6e2:5df8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4abebe33e79sm90903535e9.2.2026.10.31.03.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:26:47 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: i2c: mt7621: Document an7581 compatible
Date: Sat, 31 Oct 2026 11:26:39 +0100
Message-ID: <20261031102641.12649-1-ansuelsmth@gmail.com>
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
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes v2:
- Add ACK tag

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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739957;
	b=e1hvfKM8YbUDzJK0M/gb3F4i6a6ci3ud1F/zgvpbzPxCSoij49UrziW64xLkviRl6YdN
	 YJc6ylmipXyppXbl7pqKo+5V3wfDDAiT+0ulnOtnSaItAihFA/IDlP6aWDEjM02pInrY3
	 eom7JmNJA4KfuORKS9FKIKlE7mvJ4GEBop6HJzmTtjXgbrn0qipRDfIkC7ykUJLAncGZ5
	 ry+X0lMgJcVyr02bTT7FAOGdbRkQYodHvH8SWXMqwsViDwHcoB3DCbvZahJOpe0XUd1Jl
	 IPEiq3DTQRCwquRlohfNupMMmyNl3YfA5b5b70cSRSD8VxOqbZACtTLTBwJnqXvXCUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AqZ+Q6+JQOnxenc3GUY9TdYd5SGi7vhfYzorexaHK30=;
	b=Ck0osFN19OOs/977xBOMcG5pqcf4tckj103+WmGIiC4YRZoW9HA3GNiC2OOb4UapO3MS
	 i+a6E7GndtL58SlrHiN+z/Mfshl2lsfvdnKXYHEJN6L3X0VnI0AAMvuIM+RAyXcPXPTG7
	 kjt7M62HpGnIGAKTURQ1Wp8amIyxl1XnoBitHnCk/RRkqVhfq4/K0AjI7p3zJY9AEj//w
	 HJjizcMlBcEBQOJtYv4X3WqNkoak9R86ReWhQ1Z4pdq2tOsHwRDhJ8pzgMD5UpQCFeLIV
	 lHrG+0nkf3lXFwCSjmLWebQf9ofDogX8VJ1guYQk+1zvUqRGWYEQvnWq7omyUlUtD5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqpcUbkp;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA66606A31B
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 21:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA66606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hqpcUbkp
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48afbd2c386so14284f8f.3
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793739955; x=1794344755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AqZ+Q6+JQOnxenc3GUY9TdYd5SGi7vhfYzorexaHK30=;
        b=hqpcUbkpAbc76tLYMwSubgMXF8WGebDUQp9v+SdNEyl9bx6bjhb6ZGziJ38ALV0gfj
         x2/0t9dh4kCwKszoNt4CMjwAXuHDzmb9923xIpKDa+Jb8Xn6/PGfYmHwn0/07q/yE1Ar
         0iSnKpBtpxA0ftV6+W+cJJyxSddXbPNtdFeDQyjwVpPFi7mKmqHIezk6Ujm/Ah+2+ACG
         LSqnc3P8Z/VpKlYrbXki5YY90EFkKgNbcIJQOD+4LUsxu7ShXa/1p/PRnKAzPYhwUT8z
         /EnqEm+KF2ty8z6j9DRfJfOiPUHPR8x6kq7lRimB0fOrQajAW7dbyLnje5i9JEf9axIG
         G6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739955; x=1794344755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AqZ+Q6+JQOnxenc3GUY9TdYd5SGi7vhfYzorexaHK30=;
        b=rvfsyA7Ut4Z+i4S+RCtcoA6zH+kDDrGhse+4+WtHqVp9v7MMA4bkbHyM9ufHKm+dOC
         +nXp8qBI/SGUdgRxhrYOW3vmMx5B3oRd6GFd8GBYt6YnlajyUrpCDQFw6MLhMcJ7mxHN
         1RzJXGwlOvcAJdf4azhuQuX9rwMZvrN7cSMlf35S3ahiw2LkquYuX7ruUqz7kTB7Paq1
         dduGc9BlSrkv8mEojuu/rk5jbip04ofLfJGGv0qOee7bCyughaK7aTSq/BFfNbAlUidK
         +U/KgkO7xPmZcPTpUlrlZwFgGEWUZWkBwxW64ame+1tEe5EaToVxql4DYao+T+KKpqNg
         mxbQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6QQjOz+rb/dN8UG4NaVctfJPi872e4oZIFaxt39fjbh2Z/uNCOnHHCC7oYODbg1ki+JzlB2FKtdk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+peH1z8hJ8zhj3xSXEcgTbHyVvgh4kV8qBohu7xyPCafD9Fg0G
	GnTEdkRhbAuu6RWCPm1j5XzV+4ZumNc6S7Z2+A+k5qAj8Dq4iLkY9y/H
X-Gm-Gg: AYBFou0wPhDr4DO2lsyh53qQqURfhsD+CYDzBCRLcR4X9xUdS1EAtIBCvMjDKhycTDK
	2QWBf+SQ9cijLY92GQVsFgVuzFH6Em8wV1sHjzjDLEwdiry4SzDNc8zDtbJFg02PM8ZN3QxRI4c
	a5er4U6Gg72C7oPfSc703nxXjC9Fe/vXMD92vOzki4pI5eMHKkTRc56XItzblW5vjp7AhlevCsT
	Ndku+YZ7BwnsLDTtucLcvThqMn1dwG4KPdMDXuESCJX8hxRmootIlgk1+nhtxtbXS9Zfk8pMNig
	hYZstpMEaz+A6hwOFCCoWENmfclgwOWvIqC4/eqZk+Q0rQsGEVGjnU213MSQn/x/nvLUt3jldh8
	IImgy0Eo4uBV/fHZky9ZmWJ4H1uCXFeysAUDcPYS+beSa5teUmkdn+SRXiwqI2FTbVd0Nba+yOg
	6EUJUggvacUMe18PqDVttpFpjV59WJ8AXANZE4krlahDR9T0+d4nsjXn931apopa12u9KoOG3Hy
	esnJDE8VxXnECE/g6Sh0yismXJHgKdf3Uv99fpdX6QzP1ggCc2n/3aI01407IL54A563EhSk6uw
	cWpTVJAQD0tG8afOlKSXUttBca8QKezriKaCX5R7VtInle2aGLMQNmBBI9LhdNz3iWtuPV6QwOD
	F9MrYE+KU7Ow7p1TFjLdASKnC/K6NOF4wtmLl1649m7kW156SZYbfa8A=
X-Received: by 2002:a05:6000:29d6:b0:48e:3fc:e393 with SMTP id ffacd0b85a97d-48e6e2c2f66mr20419511f8f.6.1793739954927;
        Tue, 03 Nov 2026 13:05:54 -0800 (PST)
Received: from Ansuel-XPS24.localdomain (93-34-90-148.ip49.fastwebnet.it. [93.34.90.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48fed553441sm41850f8f.43.2026.11.03.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:05:53 -0800 (PST)
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
Subject: [PATCH v3 1/2] dt-bindings: i2c: mt7621: Document an7581 compatible
Date: Tue,  3 Nov 2026 22:05:40 +0100
Message-ID: <20261103210542.15965-1-ansuelsmth@gmail.com>
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

Add a dedicated compatible for the Airoha AN7581 SoC to account for this
minor bit variant.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes v3:
- Fix typo for account
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


Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B78225A38
	for <linux-i2c@vger.kernel.org>; Wed,  4 Mar 2026 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608657; cv=none; b=guIriiXRJaAMfIWroDtWpv/jR6LOoXihS+Wfc8xn48c68MQZ1UCPAd6DTKKJ4ahHn2/KGFQRhPKco4830bGecrxiEwo1LFJKAhf/kfiWHAObmdIhKZzIYkMVOtq4mdBSRMbO9gTKz0N8ChJ0T/wxv0K+02xlYY6n8/fNu5z8qGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608657; c=relaxed/simple;
	bh=lg9Plg6ehWx2bwrEkj2iLaG3vmxT41ElnQvc2Ca4Vho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=prwX5UEBKGTBKvpKzOl8KbmL7iCiQhnSjGE2XMCtkCM3Ph0ZuotP/8JJhp3T2ZqHlTLMPkWhT35c6ZtFJPWNhH0xrP1tbTyG2uHH8yeiQeIxq2irZ3lAa7wXurAilc4kU/V2SDDfjIK0H4AKfvHiP1ToINhnq79rOGyrgpFDFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLyvNLop; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLyvNLop"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483703e4b08so61158625e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 03 Mar 2026 23:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772608655; x=1773213455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qAL/6lymAWTA7sTs7WSo0rmin+wjAqXDkMd/c2OTImY=;
        b=QLyvNLopHdgZAfINRXWiePVGk1TPL8TlIFWDKlvirwHGVzJtc8Z/i8TSPO6799iB4E
         aTcLbAGglZkj12/FeWsjk4f5zZ4ZrNXpSry3FoyKzsdYx9xrgKUF1PjnRdHJCANxlOLB
         Z7jmnAEJkWlgJEmHrd4cmUu8EF7eAWwG3hZqTUPvq65Kgo55YG8M5XRsKpoduaw4sxkT
         YiBoBpZjF13CKG3zt7qJAMmytphGROPTKBsQCHkEedxxvnG8po87lRb2bYx80IxLrzQw
         S0yyweXePUKwViq3jR6cD1bvaa+SxEk+KvU+kxiSnVOs1lHvyqrZCFdf2rhTerlmKLXl
         IoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608655; x=1773213455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAL/6lymAWTA7sTs7WSo0rmin+wjAqXDkMd/c2OTImY=;
        b=u7npwOGYksMkjCmf4aZSEndNDN61RUBYcco3Ts2+AOx3hz7ld4iuUTRnMECTfMBJcN
         6SEUSC0Dz0Rq6Yu4B22W2nehzXbdOpsg34wFlwhJ1Df64G+XLKz24IpxNQ5NOD5G8eNB
         KymYT0Yn0ytTY8j8VN5X/KsW2QLr3gJJhGoPXLjZqpZKf+ejB2zNmWG9qvv2hVCcdBsp
         wwF6Yo4EbKeIVtozlvMKkJf8+okiBqRad5zo5BExee9Ooi2JqAAZIAg1MDcWdft5rThs
         QqcRBiduCGz6JvYJt+HaVtaK6mQhoL4WXufX8gLOnIy3nXKapHrzFW2roYdP1lhPmJ+F
         ql7A==
X-Forwarded-Encrypted: i=1; AJvYcCUi9CMWl632V6uqNPclpmf4Ht1jn4A+jDjYZ8/p6Qv8DCw2S6AztCCIN2YojNWYM7eOpbvSqfYoZLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD27SxbuN792ijiSH0ACQZirOTAArZWFZANVyU5tBEGENYUQLE
	2QGil2YKpGalnxX7IgnECrXdBby0HkQUH/VOndzxt6xjlcXkth2BvE/d
X-Gm-Gg: ATEYQzyIZr9QsoiA8KjWEzt3ZmST6mC643HC1ZLNy/KNshUtlmGatIJEezbWafH+LCS
	ZKVGggbSUnL26xuFuFll1NsDBQKUTJ1l4cZknJ5YGZaPCJeTnpkGZgIse/ji2B64WK+GQhIlpQb
	KnNvGYteHcKLpH+8ZFAVzUb4ArVboJ04/nXSAf9bIgOa6I9VdgtWEQKd0JekCZKEVjvoKX/i/7y
	CCCGm/ijsGN6e9T7SV6T8V5AckUgdk9tDMifX8hgKCZ+028DIOdXA3Ez578tlaJ/CLUAjjKlfV7
	7DBJXknnhypnxXNCzae1Vh49Agz7F0gnGmYnNhlQMqL02fxq8qdCHgIJHr4MRZllhHSGQZ6rE2R
	95De/VKkYAaQWoBeQHCxDJTN/KVralB28Je8hae1Aic+pLUeCRUjV4U5iokZabFPpNBaTjB8JpN
	TkmTWbgbTHBvxDzhAtf/58b3rh8me8hBE=
X-Received: by 2002:a05:600c:529b:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-485198843e3mr13696315e9.8.1772608654601;
        Tue, 03 Mar 2026 23:17:34 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:de3f:f927:40ff:12a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8aa589sm4931045e9.5.2026.03.03.23.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:17:34 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Chris Brandt <chris.brandt@renesas.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] dt-bindings: i2c: renesas,riic: Document the R9A08G046 support
Date: Wed,  4 Mar 2026 07:17:28 +0000
Message-ID: <20260304071732.5864-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document the Renesas RZ/G3L (R9A08G046) RIIC IP. This is compatible with
the version available on Renesas RZ/V2H (R9A09G057).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
index 6876eade431b..ae1f71eadc66 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - renesas,riic-r9a08g045   # RZ/G3S
+              - renesas,riic-r9a08g046   # RZ/G3L
               - renesas,riic-r9a09g047   # RZ/G3E
               - renesas,riic-r9a09g056   # RZ/V2N
           - const: renesas,riic-r9a09g057   # RZ/V2H(P)
-- 
2.43.0


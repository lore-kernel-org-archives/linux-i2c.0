Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8A41D4DA
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430925; cv=none; b=NUTDfMYsB9ElwhR3oy/kBtiZkAtWochNeN/TVKILqM8EOu36hhGKBO8Z3/pj11qvKpOBeutfJNFwWyG74d8AKt8svTHcB87vqT2HS9JbeRAvOz3YYYv0mA8gxGhnX60QVl5d01wJa6qEfEnurN2YM/WVy7djzlaGQCkv7VmfqhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430925; c=relaxed/simple;
	bh=0FKoq7hLu09a+YTggc0+5XIYhkmzWH4CZtlIsc5csL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IVdyCJdIgWvw6x2Ojd+b5frAiE5pcaZlAOHMUvnjPuxjBXo6RBcDOTa6jGv9zEId5gtOtbQDZejQjiyJwGtWimsPN0b23uhi1/HG8EX5zEYeuAqa6bco3eMFO1KNB6hTyfhghpk3vf4Zc/f69gYEjCttzxCGAbwsyLaGqdVRbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=iAw9uiXn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="iAw9uiXn"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4728c12ba97so2420199f8f.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783430921; x=1784035721; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAsqyO6GgeZampdy6KW0w+EGUHWEd+iflFYg/ri9H9A=;
        b=iAw9uiXno3qjaauDbqNlDjnzNRoMoH6mRB7NT3VpwkhJjkh0oF2eAeF9WuyHtFa1On
         rjUtLyX2Jeo8zvST3eI1O3/m54SROlpsm+63pwId8qSlQilfgtdIrpx06b0QmOKGlyi3
         jR5Ybkyk1KAFRps7rqAzLpfYrx7kJlONBcEW/o9W2apYwj4UrgSsvev6z68Vwnagmd8N
         YeCzOMnugRax6f/ImtYkZ8JglKb9ZGawQnCfumPLZfzidm03WqJ7Jy4tkgqSyUtpCRvt
         nNowkc4UrL24dFohBjJUsygVpcZQIpS/X/x1WiNhY8hwhUz6tEJv9J93lBOOXt+wldTd
         Hgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430921; x=1784035721;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAsqyO6GgeZampdy6KW0w+EGUHWEd+iflFYg/ri9H9A=;
        b=Gxz+S5e447TfM1BFj0vS1ARZEozWgAZ0LpZbSvqTdVVA1yPwE8981TNTbi5PadpzEr
         rgh5p81S+YOTuJ6vNy+owt43YNtyfM4d58rKk7GeiJmjR2KaSDSb9GwajL/A0bR3cEQp
         KPiORiZenFmTwRq6ARsPYrhvBjvax6ffuf0xhf0eKvr6gAd+KJOhWu0DvNGWA23cgFNI
         RwfVn3XLrcl2RmT74NLcwTtQkLK+XVqh63vjfpE82Mup4PkZa9WD1A8mJ+uAxOFJ48WW
         Uh7h0ekcNjiGkvITPVGa+QFBVWzDUBgQxc/P+RvV8hzcouyuejUXLBrYTmkGAIvvmGZ4
         2wYA==
X-Gm-Message-State: AOJu0Yw1g7z1DOcEfFtLYh0TjJ69EAvzqy/UWqzfSlJrGZlAKQ4eUCUz
	PS5CDlP6iX25AsT1RqxYiQ/Wwc5/qbUpTbfZwUa6tPexyvfuEVtxjKcIrvwU4MFDA8M=
X-Gm-Gg: AfdE7clXD6bM2FMngV05IWoGISbTcDv7xmBiijfkSMemUkGCnOQxoSGXzk6k9tw1M42
	aDbVFrT4Ihyx/0WyWEHD+QSAQkKTe9Z4Oe0H+xqSPSAXSJgevgVM1M4CyejeJpVrj0W3acHsw4k
	SyCuEWlFSzm+44X5Z7WmCjCjyu9VvQAGtm0Ih9N8eGonCr9NA4ytqcs94blOffblLrGURm9pko6
	IeC40V93k/ZGTOgbJsrzwANc05NJULD5ylq77c6Waxiqj74C5DeuRLbAgwykYXeu623ZUxZIOlK
	DmJlW817BcNgeaX5DLlpc0l3JO42B/2QhOuabhWL8sdYVEp1gN1QxHYjlx0bWBIVpuKdtP2ZvI+
	oePGONTwDBhALdM9vNFSvyTSrJBSuzvowSyUCXVY7DIBcGbxcBaX8Mo/PmkMn0tHc0SUz1j83rf
	W3R1G+B0YkYZw=
X-Received: by 2002:adf:fd12:0:b0:465:81cb:bb20 with SMTP id ffacd0b85a97d-47de666b180mr4267840f8f.9.1783430920880;
        Tue, 07 Jul 2026 06:28:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:df5f:95d0:b28f:9180])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47a9de1d905sm34336003f8f.2.2026.07.07.06.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:28:40 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 07 Jul 2026 15:28:28 +0200
Subject: [PATCH] dt-bindings: i2c: mv64xxx: Add Allwinner A733 compatible
 string
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-allwinner-a733-i2c-compatible-v1-1-566340542bdd@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPv+TGoC/yXMSw6CMBAA0KuQWTtJaQ1Fr2JcDOMAY2ohLX4Sw
 t2punybt0KWpJLhXK2Q5KVZp1hQHyrgkeIgqLdisMY2xhuPFMJbY5SE5J1DtYw8PWZatAuCzen
 I1NrWsKuhHHOSXj+//3L9Oz+7u/DyTWHbdr/7yUGBAAAA
X-Change-ID: 20260707-allwinner-a733-i2c-compatible-694ca8280c31
To: Chen-Yu Tsai <wens@kernel.org>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=0FKoq7hLu09a+YTggc0+5XIYhkmzWH4CZtlIsc5csL8=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqTP78ynmZm8LqBW8z2bfeTlGcrUz56U7zrD+ep
 NJhRorGfMKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCakz+/AAKCRDm/A8cN/La
 hZb4D/0byM/y8b/cPdKD0MLfM2h6d8McFQ40cZbuxDxxX7lZ79txQQYqeUTgbgZJM5FHb2Sc50s
 h8jpKrr0V2CE8qJTxrNwfWRoM8w7MuYQ/POFb3KzQ9ZW0QJ29mo/5lrCBMlXUKNLA6KOsWfRyOa
 mNzW5obn21doyQOdtJfJSx5qOcYn788A4ylvIZ1jxIYYff1BGJiPqu0tYon+Sx7IlWRQmzeNypH
 FxP38sA3tZJIvpERBMY8Si6UtXwaYCgYMzTrihfGf6+fFMknmc5lFUHRHUi+CHIA1OiRS9do+tg
 x2xi18qO5N2Yx0bEpfOYXk+QAtyGtGaZ9RPGbslFjKw9vRifQ+DmgGsoLcfgdtOiLM6yTkDkNm/
 nvOrUn3vpL5iASh1F/QedxtiNKarjN3brs+bhN4J7wzdqOGppz9mv3pZFJRy/IJvmsuFpLxBCF+
 CdDi57OvoDigysxIim6zGLBgXqcO5Zs4R6I10WXkr5y4HXHt5c97BHAtSlQAt2zaTNhuZ4d887i
 QtiAm7/dspDY0zdd6rIUQs23Y582IPKJNjw9wiw/4hE45ujN0ASKq2oxMjUTwevoldtLkbHxfSy
 l/bBijigq4H0yPV8C8RraJYJlPmHWBjuDSar82C+6+MvrtCJrpm1U0NNupYelgwpGFd3W1+UPgz
 qQDw3R9B2zrBuRw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The I2C controller IP used in the Allwinner A733 SoC is
compatible with the ones used in the other recent Allwinner SoCs.

Add the A733 specific compatible string to the list of existing names
falling back to the allwinner,sun8i-v536-i2c string.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
This was tested on the Raxda A7A while enabling the AXP318 PMIC on S-TWI0
---
 Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
index c4efcef59133..2a9e723a724f 100644
--- a/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/marvell,mv64xxx-i2c.yaml
@@ -34,6 +34,7 @@ properties:
               - allwinner,sun50i-h616-i2c
               - allwinner,sun50i-r329-i2c
               - allwinner,sun55i-a523-i2c
+              - allwinner,sun60i-a733-i2c
           - const: allwinner,sun8i-v536-i2c
           - const: allwinner,sun6i-a31-i2c
       - const: marvell,mv64xxx-i2c

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260707-allwinner-a733-i2c-compatible-694ca8280c31

Best regards,
--  
Jerome


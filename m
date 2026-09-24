Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A064AEBD2
	for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265961; cv=none; b=ugm6OCbixRsXEVXg3kdstmXsmTu2M5XM6xLMK9tbiqE85aYZFR69rv4wcJMhj3uvygnNjKNR4QWine2I5DZ8vweCeGQ7wHxnIEQ+qnok++kxE4C0Pivpq/SPn3P+5CZCq0oKjQPFOUStzunyp7kIB9dq9xYXh6S9lPetI0sRg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265961; c=relaxed/simple;
	bh=3/FB35Hu5fJEEgD/yBfAAnwDqio0JQJdSJzCduCvMyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QEJ8CgSHWzgnXr5pcQnAja9c5oUMPVdU3KdPd8vlwh4bzfQjy0TCLpTnGVyzn6cI7WCBz55Pz+kE8ogKZcZWuejXoPCcV1gQZkPYPHijveSoztASIiSnGmKscxST3y2AUELSeZhaL8NMjuEaaNC0O+a/2gY53aL784lLYzPFT8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F+9B2JGw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F+9B2JGw"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-488615e6cfcso458959f8f.0
        for <linux-i2c@vger.kernel.org>; Thu, 24 Sep 2026 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790265956; x=1790870756; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wm09KZgtMDDuRCaDDlw1bVTO/lDdGx5khYMsZ7nf5Wc=;
        b=F+9B2JGw6NeW/19APcj6gavrZNn1VZ8WDIOPmZ107A/NSGv55xs5d9EffFjqNcyRqj
         LKewnSDlPYTGqEtgfsLCEYPvZL/azr/Gmi2BwWhCtsV69SrsE7cNHmSd7nYF6CvopuQz
         kDRrfa5jWutn9qxI6KRumw/qx9ON9dPv+lR4Q6pGh4VrXnon2/ZkybdXgDCNe+Ihbl1+
         FgV/oc0JqN94EvFnYgANH8i1cDu2d1ttpVIZ2xLw+eSS8kRuR4s2yw4CxnzjZM4OnT4N
         6jG1V+K36/kytXt4yW2Npuf3LwwSUEMteMIPEEAgOzlRmTjJH7t4ImhZsO3X7lywjuUk
         tnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790265956; x=1790870756;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wm09KZgtMDDuRCaDDlw1bVTO/lDdGx5khYMsZ7nf5Wc=;
        b=S1Mr9xkCAw5tG9HRjMZYEzq8YitIoDhLIGasSx5bZ7hNbBNQdJ2lTmopMxCGYrKG/a
         mbm3Cx+mJNymB6GkE9r23hNQlIwCm3jD07YOg8T8z4VL44b2ds517lrtXCtGtN5qHdTo
         GixJgy2tozoZEV1wLXV4RmdbaInpEDJm4WIgibGKVrIGGpaDa0D4gzZCvr21agPZ311S
         sGSSyMTx42TFvLcHF43t8LLCtBiAhJEsdl5RpzdsNaFL6yYTbWFI7Dp68D27CMKQCQ5p
         8c6iAAjLFbeXwoaY3KbjcZovrQM0c4Y684xrUrDBBcQwTGPVU5D7AEflTd/1TL3ivMuo
         6vrQ==
X-Gm-Message-State: AFuF++mxpaUSg74rWQWtcX59PXcG24iPGCEvcl+SS+iLIyxgqHN2MLvI
	4EeegbU19lFjJv0I86JTmatQMLDUJHSxZo8V6jKkqPJKxnvlS5iXQvLk+upXfcZhz6nPUDZkeaI
	hGAxd
X-Gm-Gg: AYBFou3ftk2aMjnCJkc6SSUD9doOJuqLOX0KLA6T3EuYYhU3+nQ7EbTUkeMAoPxJQ1j
	EEZAalwEfj52L6af3DG0D51DRdUClcqbbnN58F9r+8tonUDfa1XrjbxTejzdLQk4hMWOp3Se57g
	5DaYuFozOI6/iNdexFgZeTq9vVd5bOgIPvOWNmwmQDb3sRW6A4oE+14inDSm46aPKuTEi2MVlOa
	2rsZQEWsGJNVmdkfdmuWlSzn9ANjEjIBWoUAdCPcO/BgMtORYl0OhWYNdMPsqP1H1m5PBgpIEEP
	oTR3xEDF6FPTaU2mFtj62gOGQp/ZzdQGF6T35RDsn5lrLFzhQiD2qbYjbu0jJM4Xeo+fXfbpwF4
	m5V1bftF70QFCnakvZQNogLlaKMN9S/1lXB51zjSrRw1qgyOllydf5z4Y7Yvk+8pH1GoDgY3+v0
	Io236y58dEGxez/tBpAG/2GcJWl0Mmtf5vu6Y1MGyGidD1iF0+BG7SskmTt6S2FCJ54oN+tH7/T
	fh8CKCktsFd/k1Eew==
X-Received: by 2002:a05:6000:2083:b0:487:342:eb28 with SMTP id ffacd0b85a97d-488716f2354mr5536245f8f.24.1790265956591;
        Thu, 24 Sep 2026 09:05:56 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a314sm57278f8f.6.2026.09.24.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:05:55 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 24 Sep 2026 18:05:50 +0200
Subject: [PATCH v2] dt-bindings: i2c: mv64xxx: Add Allwinner A733
 compatible string
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-allwinner-a733-i2c-compatible-v2-1-0f5f1e9af969@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CMBQAr2K69pl++BRX3sO4aMtDnoFCWkQN4
 e4WXbh0OclkZmERA2Fkx93CAs4UafAJ5H7HXGv8FYHqxExyWfBKcDBd9yDvMYAplQKSDtzQj2Y
 i2yFIrZWWQvMKHUuNMWBDz0//fPlyvNsbummLbkYThh6mNqD5fUpe/vnMAgTkRaEynmfS1vXJm
 ldHNuAhWWxd36SP4JTZAAAA
X-Change-ID: 20260910-allwinner-a733-i2c-compatible-2883821809ec
To: Chen-Yu Tsai <wens@kernel.org>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=3/FB35Hu5fJEEgD/yBfAAnwDqio0JQJdSJzCduCvMyY=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFlbvZLEvbbuS573+cXazpNcRs3727Jq9WuvrUlsuc5vP
 GnLHkHzjlIWBjEuBlkxRZYa7mrxd5JaX2ZN17kNM4eVCWQIAxenAEwkmpnhD5ehIO+29na1ioXR
 63k5HTw2v71i8Pl26+GTAhOfZcwrPghUwbUw1KmsP3f/qr7Hzytu9q6t1HhuVLBFL95OeZtoRQQ
 DAA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The I2C controller IP used in the Allwinner A733 SoC is
compatible with the ones used in the other recent Allwinner SoCs.

Add the A733 specific compatible string to the list of existing names
falling back to the allwinner,sun8i-v536-i2c string.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
This was tested on the Raxda A7A while enabling the AXP318 PMIC on S-TWI0

Changes in v2:
- Collect Conor's trailer.
- Cc linux-sunxi (not matched by MAINTAINERS/b4 by default)
- Link to v1: https://patch.msgid.link/20260707-allwinner-a733-i2c-compatible-v1-1-566340542bdd@baylibre.com
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
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260910-allwinner-a733-i2c-compatible-2883821809ec

Best regards,
--  
Jerome


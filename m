Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED256352013
	for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229989; cv=none; b=b2u3VzD0Mwdj5+G5xeA4ln3wTgIbg0ZbR0LlOLsOTxYVS/09DGEEhc0Cj3UrhqLbfMgViuesyOFdDNEhDjAgXR44CcFhsA51amZDCXpCMpqmr8O96b3hc/qWABC+MiR8aUscPGnHq6l8qxE/T2gjpxxHoytT//V7KTcHGU3bCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229989; c=relaxed/simple;
	bh=p4ixAPYHyRAZAd72pqHHuOTKVlz5VhSIjBEIsiu0vG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ST+GYVyUJeJpnX5ZvkH7Lb2wHI1q8WP87q5f3KgTCBsA98wTStj1XKqaj+NPhnXmodPvm92pThVW9B9rXALfgL/RDPIw8VGGP4Fprl8dr7GCYgnQGOnm9KLSnZGXTmOTA1BoLqnmmUGWZ34SLxBoDuHUJnmZwFAtyRMdmgL3Ato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeINHLNn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeINHLNn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so61410225e9.2
        for <linux-i2c@vger.kernel.org>; Tue, 19 May 2026 15:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229986; x=1779834786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pqcbLvgzPg/aacFxA3Sf3HYOKcvPcXokYWVGRv6DhFQ=;
        b=DeINHLNn1muyULkSq9AWTqwGFvybp5D227l/qfFjgGdLSYYG+px2dd5ZMDRwmaBwX9
         ItkVAwPuh0daRh/+wq94HVH6F0YYn+VC6A2rqfFSeXgi/HgMUqKTH+ZqWk+xrH+pQTjq
         AFrndbYpnNPtKStXGmyldUcDWqygtXAJ5vrAZcBbhzrO8QNs8q2zojXLr4N9YOyBW1NM
         5kfUUm/C5Br66C/R+2nSEIWoQ/VJ2s0G02qO5BJYSF/Qyd3vPmdCX9dtrkzeaj1f3rMn
         k4CsgKey3+AB+CV02RaX3lUK4PVPMAZFlSO2hW/AWonnW6dmbYhUbKyB7WqHsSOLJa48
         cBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229986; x=1779834786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqcbLvgzPg/aacFxA3Sf3HYOKcvPcXokYWVGRv6DhFQ=;
        b=qRBrXVRwHXO5NrOIG22eMXWbZ3DqR45gegL1kbHdsy2nxKxm92FKPWlr/uhqb/U8Qz
         LVfai7ijkR8LKhjNAf/IltrEqImPAghYq5puiduP5nlujY90fknfUJRI6+Ay0/jz7irn
         ALb8BNxyLr7WSghumWL8LdEfCBbVwDB1lfeArOKI4qbsABkgDHVp31ESon3QoH7qBqfJ
         nDmcpFpUjqouIYibff3bFsKct5Zdx98+MzH92xR+MHBRCvKHTiMpp3NpE8PY0dpqWcQy
         7IcskSrgRJtXg/zZLt0PSqZ1Xzo0MTqtPanfn/l13T32vvGn55snwIYtNS7YUnztL7cA
         MppQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mxSChBwhIp2IVVW8fXSbFsOo4noXN5x9bnVRN/1aKU4U+NioEn54YTX53xGA/NtkmWKd+PG8f7KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWjg4W7p4VUV9JpmGKw+myYL9axOnoWcSjbeMA3GFRPcKdsIfx
	ZcNTfaHgp5ifoldSyLgvdJ7E2Ox4GLF80i3ufdYw9KNEDISTSCMx9TLP
X-Gm-Gg: Acq92OFUZpGma/CQq1s/5S2eP04cyfXVhrfOhKGooEABVENaiVMDkZuYG+hRsSNIAH3
	yEhC3jGuU8iG6/VNom6oL56sm09CLBzMsRBCpYNBaFPgQ750eBOCDrui5FCvxw2qXnryA4HJEjt
	Czkm7JnuKj3byoFmCztymB1O7YlmVvzWgRBIEOTg88WRi2N0MXyUEUOJ50suhAwMmhTid7bk4d9
	DISD2MI+bH32VJo/K32Ag/Izsnyh70STvCGbQFaomIcimJjnzMLSmRENC5ChgfbNEduevUSRP0f
	hsCfaNA/lwUGmy/1OZ4K4JdhMAoB7vTIO96D2E+GXypJu2YRpNEX27zZ0bQISF5jvog04xQoEzX
	hAJopmOf777P4eB58x0UAkJUxvD6PkFl0/3ucwehJy8WJhl0dd+iT8+wCp0BWWYEgquKTTgXIIc
	xAqI+NjQMQ7tncgNlbYOuf1PeBp9hHDE1/qvgcAsnvzk8qyeuThC6u+La6vLb+eabNWgyj66o=
X-Received: by 2002:a05:600c:4e47:b0:48f:d835:e0ff with SMTP id 5b1f17b1804b1-48fe63265a1mr361523155e9.17.1779229986180;
        Tue, 19 May 2026 15:33:06 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm346659955e9.4.2026.05.19.15.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:33:05 -0700 (PDT)
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
Subject: [PATCH v3 0/5] i2c: mt7621: improve support for Airoha
Date: Wed, 20 May 2026 00:32:42 +0200
Message-ID: <20260519223253.1093-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series improve support for Airoha SoC that use the
same MT7621 implementation. Some additional tweak are required
to better support it.

Also we add support for atomic variant of .xfer required for
some attached pheriperals on the Airoha SoC.

Changes v3:
- Rebase on top of linux-next
Changes v2:
- Fix compatible order for schema patch

Christian Marangi (5):
  i2c: mt7621: rework cmd/wait OPs to support atomic afer variant
  i2c: mt7621: clear pending interrupt on i2c reset
  dt-bindings: i2c: mt7621: Document an7581 compatible
  i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC
  i2c: mt7621: make device reset optional

Christian Marangi (5):
  i2c: mt7621: rework cmd/wait OPs to support atomic afer variant
  i2c: mt7621: clear pending interrupt on i2c reset
  dt-bindings: i2c: mt7621: Document an7581 compatible
  i2c: mt7621: limit SCL_STRETCH only to Mediatek SoC
  i2c: mt7621: make device reset optional

 .../bindings/i2c/mediatek,mt7621-i2c.yaml     | 14 +++-
 drivers/i2c/busses/i2c-mt7621.c               | 70 +++++++++++++------
 2 files changed, 62 insertions(+), 22 deletions(-)

-- 
2.53.0


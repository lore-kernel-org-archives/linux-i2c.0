Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622C47ECE2
	for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571608; cv=none; b=ULmag5K4zwHmc2vf4jwUu3TbwS/5QFp786rrHV6V1o9/5BOULFZQvGtjRMYsC4a/3Kxa8Zbd+G8cwu/nBWSY+bqaFowXJfje3PPnBFehBhQgGRrXnbO7YOpOG+DJg+Y4Dz6khC5ulOgT5XUVhASbMDJ8QoqMBSlydUyAMue29PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571608; c=relaxed/simple;
	bh=upcmdj2vMH0VCM3eO2ecym89DE4uEFAsF3Yeh5bTV4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L7uTW3HmjVXy+zhdWhQNd6kwRIvP4XumkmNjekG2DISeBl7AKw+qFa3mghPEojuC/a71yP5KcoJKkqx3wgGiBwNElUkv+nNLqGNZdhinGtUKszBddM6Anaom5xb1WU2sJ6x1orcNe8kDT7to7WWNrfOuFL8nYuclnTrcpQgdX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k319k30e; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k319k30e"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-366375c43c2so2958826a91.2
        for <linux-i2c@vger.kernel.org>; Tue, 12 May 2026 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571599; x=1779176399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eFg2wB4o8zIZHpJ/y0oO5PL1bzy98ptVsLeFLg87yE=;
        b=k319k30eO1McONiGc6Ho9xsdk8o9CnQ9X8+Zf+SpGTut/5w8meCjJmcRlhRFeumbO4
         FtdiFnSCh8zMqEgplVndbSiKo2e9luZxysg60zrQG3co9Jt1GQmZlWoyL1vpC25VfAs4
         R2bqibrmxoZDo+tLCvD8k7gv3BCDauj5+aB94rGnjmc/4NSDRMr/PwEWR6L7qzBpYfsJ
         Ct8uKD1ApgMnmskY2UlY+XBuQvl6bPZZNlBq9CBo11u/XS/aLbmWZjXIPfGJQmI3Wora
         WFlzxdS+J4yqpN1ElT03OBNRN7foqcDxs1ZXM5Nck4nsZe1af3VPji/G/N9ueUceh7Ns
         dtiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571599; x=1779176399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eFg2wB4o8zIZHpJ/y0oO5PL1bzy98ptVsLeFLg87yE=;
        b=I/1KFfkilRo5sbarYnL3+88sgDMhAH1mnl/i6Quhp1yjvqeAIaVNMIOXHSvIVN0te7
         29lQbyEjbVgJ6hWCl8M73L318FkPF4Qn6DvITTHIaQx3V6Cb5JINgz8HgxAaAV8uZf8O
         9RZtXhbecIUlfWQITZ47ojvAAp03ZofCTnW2jjuH7tMCCbDPX+6BVbIAQJ3c3rl4+ttO
         OCl89mSE76n9EFtpiBO7lpqYwayQG4Y6k9taZYkgzWOKeHs1HexkTxE6ogF8t1WQVMM5
         SHU7IvAW2vL2NOQMd6D8bdvHAdgrLnVhmYGos54iGvClbKimJRbCiJKvrYPfFODivdze
         d+xA==
X-Forwarded-Encrypted: i=1; AFNElJ/1I2m2vydSMkDEQLV2Emz5/oE4y7f73e2mmoZ+opr3guavKShufoKbxianO/RBhzPiJentT2B/Hgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuOagHqtIbZnYnu4RU2MsBNsvKlr1iS79jXNvzdKU9kDOLV7q
	6g9sxoazY6G4QxdoSTJE6pAqBCR1yc1NkZSKTAUa/NUZfHZEfzWnZ+U6
X-Gm-Gg: Acq92OG8YVxSpJH6GqDTcjvROIN89y7xi+nZCUDKPfDWecH9PTYcMrMPbUqpVk0CCPe
	CICL7Cz5AuKD0ye/ud/m0yxJgPJJOO70Xg+gu1h5Ph5HVzC1oVEgFCKCr3EcCLVAWZwAly4w50b
	FY/BheUqeyh+Ch7LuswGsbcKcScfTOvXopxk5t9qwag4/5ABc+owZhzS2HZXhpOUPC+TkNI5UpG
	b2nKBnqvVD7ifzcalEs3msKR1vVi/6kTmReeM+CjX8drQG4LxQzGP+Rr2oFM0LPwWeCp2Wn2JWd
	mP3sEcj1eXoFQ9kleW29RedAU31Nm1OXU/9yzX3iBnIEqNqRQHRDqQVgtVHgx4B3r28l37QVDmw
	UW/wvaujrEUzmjVW735NAX6vGSP8plypQKBEcEIe9pnyCrIZM+9XT7BNDFmu0kxcAEB/6s0EZco
	qzwx1zTwPPqWwYHzGfamKwAOrpbPMhFE0e2+p1w1i9Bqek0Jx3KMAkSkUaysYUOC9WCtpOrgy6j
	s7RQ88iqw==
X-Received: by 2002:a17:90b:53c7:b0:35e:3103:d4d8 with SMTP id 98e67ed59e1d1-3664c8db78emr18615005a91.6.1778571599128;
        Tue, 12 May 2026 00:39:59 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d65ed459sm13264489a91.14.2026.05.12.00.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:39:58 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v3 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Tue, 12 May 2026 15:39:50 +0800
Message-Id: <20260512073953.564323-1-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the I2C controller found in the Nuvoton
MA35D1 SoC. The driver supports controller and optional target mode
and runtime power management.

The implementation has been tested on the Nuvoton MA35D1 SOM board.

Changes in v3:
  - Fix minor DTS formatting issues (whitespace, missing newline)
    
  v2: https://lore.kernel.org/r/20260316063726.41048-1-zychennvt@gmail.com

Changes in v2:
  - Overall:
    - Rebase on linux-i2c/i2c-next
    - Switched terminology from "master/slave" to "controller/target".
      
  - Patch 1 (dt-bindings):
    - Simplified description and fixed 'reg' size in example.

  - Patch 2 (driver):
    - Modernized using devm_*, generic device properties, and FIELD_PREP/GENMASK.
    - Optimized power management by moving clock control to runtime PM.
    - Simplified code by removing redundant .remove(), .owner, and inlines.
    - Added dev_err_probe() and default bus frequency handling.
    
  - Patch 3 (dts):
    - Moved i2c aliases to board dts and reordered nodes alphabetically.

  v1: https://lore.kernel.org/r/20260302020822.13936-1-zychennvt@gmail.com
Zi-Yu Chen (3):
  dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
  i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
  arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC

 .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      |  63 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  15 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  60 ++
 drivers/i2c/busses/Kconfig                    |  13 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ma35d1.c               | 792 ++++++++++++++++++
 6 files changed, 944 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


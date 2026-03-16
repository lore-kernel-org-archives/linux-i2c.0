Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087933191CE
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773643067; cv=none; b=Djru6N2WQd8M+8k6oBLuthEEqKsEgXdr6a2XNn4cT+FODZnMcDGjb2YeYkozIH1/7nZbysWvf+U53JxJldnzrCdojtLTdraV5rlQBUPcgN18ACa5tLffF7gU9gtEID7qM5KcG9FGHxtFnQKCZjJJfbcQxpEs3AWyDZ+v3korVgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773643067; c=relaxed/simple;
	bh=pN237/jrHjr10mugoj4cWEZspzvo9aKOtm8dpKrbyLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VidsHa/OkutG9xTkCGP71lGIj1Pe7ZQ7DL375dW2LG8uQ/ivoVWVN3vNWIwkkZ1sGt/DuyDpTwTUyUhPUnKRZrCuXP+IBq+SUT1YkRZNGkKV5kdtq7zlPFYDITcUeuB6eeeF1R5HHccWdPmW6cJGVWH6qs5Ug8OhOrV7YjqU8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpegO8Ia; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpegO8Ia"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c739e680bebso1315665a12.1
        for <linux-i2c@vger.kernel.org>; Sun, 15 Mar 2026 23:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773643065; x=1774247865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InRSApg/oAsHMCkklXKa7U4eUP4CWL+aPpmu3EyzP5w=;
        b=mpegO8Ia1GLuZAhiBXU3s1kEOnC+g+Dqbh7Qy0ku9s6/SK/HIVTQtKARG0v5Sm91Is
         P+G8eYEfNF2+b+/WhUO3NxxlylBeLXrBeLRCj3wQ4F0LCghRF2OKiX1ftw9Yuzox9u5j
         P1vwAtEGFmntfIvakcg0uybGkLjvlYuFvnizqn3pVCY4IdrZTLUN7R02dHV0Ikd08wBt
         0rpaHwrQLRZgiy6WdUmDQGw4+ikABCAIGQhe9g/SGCg3CQY+UApgbJXrnoUZ8T+cMBIp
         5E78BaLgzYb6gZspSMPcOsl2sSiQD/1a3wO02p1x5Dgts/p9eCtNW+XaQYdiscQdN3hz
         jNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773643065; x=1774247865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InRSApg/oAsHMCkklXKa7U4eUP4CWL+aPpmu3EyzP5w=;
        b=YJ0/61PPeVC+kQ87lxYyYy/WDVvm+8deLfFr8+RzVs0XQOg5tUn1auSUDXBdhIeBWx
         VqrKfQ5ZGzmb3zfoNju4y2tQdl8JrNnkkWMoPsLXmP6iI2CIriq9d7F4E3Kb2bCmFYV8
         CToB+tcIWZ4DvtubBbzFMNqLiA0IB9AVhooIm8Q0ruUqcJsbzJU1euI6YXOKsl8pur3x
         z7FfTLY6cyPWrMdBA4yO8SKpbPhAF0xGH8Yodbp1soFkY/e+qQYZtwzGC/hjOTL/gRxS
         fA7sKwKaSIAGbbPZdmtANEXqxe9CYz5bOxIV9dQldvNzY75hwii6+yEMYKy6ymwQstso
         w7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+5eO0ytcURJSEM0k+X3Q0TryBtCMCXMdCg64NVceIoGJTgGVLNmhKw7SZMzxbr49n3sknTpYxPag=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNQWYUhNGrsCTccPiMRd6EyX35GiP7WQ0yKtW6thwH0ZgGxi3
	SkCxHYyCQ2wJPip36Eudb1zTMtd+FkKie6GcW0EUjz7qw5lCOrtyqXf7
X-Gm-Gg: ATEYQzyeh8vy9Sm5g9k0NK5vKw7sF9oBkJqLtnfOBQBaK27fbAQYQc6sFRKlxVZwyZI
	qecryPZ+TrBuz/a+5Fq9/U7P+f3bScoWktqVgDvHXF67CpHpIJGRWcpUVxBhwzaECq5Yb9xDI7b
	NfOe7sjEG5rJZw6jWwmABztMyBsEvwu7cIkRLliiydG/Dm8j9I71ah3yZBtQwrcKbYMbpUoPA/g
	P7scMHYEz3hkCFUXUOcgrZ0kevoGBphDCYCcWjb70zyUdthnkZuSkl254RlurRC+0sq8AH1+qYE
	iptj90NTvYxLfRpNoPIwn9lkrmnWuU5RuFkvpBAJyBsQsYXixvyf0Dxt0HxvcMxmM24Hs5zcqDh
	tswR06+opUWM7XODIFZ5GqMcqfKedw8S/Pm2o41LDkbURgF/xaNZppyVJfnkWUDE/1wdntBDQEy
	w8hxEiqHUxbvdRcg4kDMV+G6QoabE18CPz503V62arWSDKs95NarVcbiFzXynUTuQgChQ9+Ugvs
	cW2RteejA==
X-Received: by 2002:a17:902:da81:b0:2b0:4c68:283a with SMTP id d9443c01a7336-2b04c6829b2mr51629855ad.6.1773643065161;
        Sun, 15 Mar 2026 23:37:45 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56cdf4sm122845295ad.8.2026.03.15.23.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 23:37:44 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: andi.shyti@kernel.org,
	ychuang3@nuvoton.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	zychennvt@gmail.com
Subject: [PATCH v2 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Mon, 16 Mar 2026 06:37:23 +0000
Message-Id: <20260316063726.41048-1-zychennvt@gmail.com>
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

  -Link to v1: https://lore.kernel.org/r/20260302020822.13936-1-zychennvt@gmail.com

Zi-Yu Chen (3):
  dt-bindings: i2c: nuvoton,ma35d1-i2c: Add MA35D1 I2C controller
  i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
  arm64: dts: nuvoton: Add I2C nodes for MA35D1 SoC

 .../bindings/i2c/nuvoton,ma35d1-i2c.yaml      |  63 ++
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  18 +-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  60 ++
 drivers/i2c/busses/Kconfig                    |  13 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ma35d1.c               | 792 ++++++++++++++++++
 6 files changed, 946 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


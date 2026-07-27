Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBB3E172D
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140405; cv=none; b=A33YQpJz3UkBNCGL16oTmcZMDgrUN+Nv5oXc6yUBY6dAa2wLDr5FZWR5bMIL8bIxkWVfDSp9Rl+I3immmkP8Bvg9pYapryK7CKaqQKWtU3KPo1bIHr6vVed/HgK1y7fsk7xIaQ6At4Qh5Dp5908bRVqMbG52FH0U4zju++TxEUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140405; c=relaxed/simple;
	bh=NeWTLH60XPDWK5+mw5xbUbJfajTDDxDNPLX2UcUzbVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9eHcNX2krVW7rHA8V+3E/QYWBi+UkW5vUCt1IHY2TThK2NHpc4wzFrhamJQrX3ENDdi1We3xWvhR/aT3PaCg+QnRvKRb5I2JzsXGF7g3FeMwrRMkVnJhpqIpzFzSOAqcyUbTJUODWK6uf+sZN3uYxXkkBMftvBbyjeCcp8ua4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4TpMLot; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4TpMLot"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso1415370a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785140403; x=1785745203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qPnz/v80LXwYp0PVxXjwmAK2BJ3kZ1bk+zxjufazDlY=;
        b=I4TpMLotyMJuWXlbKpE7UMQwdk2ppN2R86fTlwJwF5cVlgCqpSS1WM189d8VgLVXTK
         KP8G3pIJhpVIlOgxiciPJxN6i6DTKXhs81WpAuO6RQyNcLAU8kSU6891N0O4xoZcxJ4Y
         sngWrnYEnsfgfZJyy8dZkmPO3sq5x0IETi/+8sQlDrI2o1Qw85oGvC3bMfPt85ik9D9p
         2VwicxqJIUoC0pzlmW6zs5G1NHi6Ff23DgYPZo22oEsl9s9ReuTB5Ro8h1PFe2iVmU75
         ss5gVBtqsIlstIcRMmfMIf68DdHmGe6UxnTVczGMGrFJFT6/5wLM3aDAP9klSPTr8R57
         D6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785140403; x=1785745203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qPnz/v80LXwYp0PVxXjwmAK2BJ3kZ1bk+zxjufazDlY=;
        b=fvEFnrO3F1MrAY4WM+lEkfSndO9CDkIDVAVSktA6pvfrUlFUKVWmOZLLdrnAXnz3yr
         h4ajcJXNeisyN1jovLAvbdGHgE/BVYqTxRwdPYd06WOh+1kdZjQ+qt9yPHgDMhBm0s0H
         4zL6lx9vcCryw1KUVO6R1EnFt/v9Yj4vv/y5WNrIxolbf61lqzAXNIDmoG8YHYXVvFPE
         si3NXK3Sud8tjFJ1rWl0TqzoWac2r+o6p85xAxn2inOmQfX9nayidxDC2hh5y8Klhjba
         bpPL65m5dT72IeojrY1F3tylCXmV6hTpaTclHnvnodWT9mg5mhyyKdII6Q3qo+2o7/J3
         xm8A==
X-Forwarded-Encrypted: i=1; AHgh+RqczBhxIrZ/eXH6nd9wMdiizJTrb7M0K8DqD+eXJf5/MNArxQc4jBQvflxtGzppO7KZXDha4QTrYEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6nzQAKEg+V2bKk3RvChYCeuYGzEjK8obe+Tg4fp/WqGKGewH
	GS9rMxbUiAnV7yvTULWL+PcDGEygO4/75Sj5qMuZYZQZDrZ5I0yYDpRA
X-Gm-Gg: AR+sD13e1IXoBxmKFcWlCC1wPjMdJGTtB5kBAoPXwXV/ofBi4bW8XwfizXajBVbCE9l
	3/L3pdWu/wFHsQYf+uJy00qmddGblU+gwkU1pFzdBOOy1py3K3/xoanyKs5e+rN67rj6OMnNv4T
	YBlkpDbkciOBrKC3cgGNkCLUqBaOlsOHxp7uWgGGTUKtDFGf4JVw/TcFp0I1iIiL7pkC1NKxwC5
	6mDSxfDvpm7p/7y0fSm+9+0l5a8nUc+PhtwGauA1UGvN5bL05sKn93wNUB/doIxJpj2qhWJKHqM
	nGG4/g/e+wEuRFnc+YO/kL+WIzz4sU/tEwMmEkCS+5LzddVMZoPhPBcbu+I2ROqFOVkyYEZ/Ec5
	H0fD9+u4AHqzdfxJDOWA9KpflrSrzXr/H/PcyQ/Ev9xS212Avnt44pR9J+rpAoR4viRKmuhHjLy
	tSuO37cQcmxxCq9rE0Yp80v6pQFZNrylYsnevnuJO74HBH6EPtQIBUQuOsl0/K
X-Received: by 2002:a17:90b:268b:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-38f293caf01mr7455177a91.11.1785140402768;
        Mon, 27 Jul 2026 01:20:02 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f292aed12sm2629156a91.4.2026.07.27.01.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:20:02 -0700 (PDT)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v7 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Mon, 27 Jul 2026 16:18:56 +0800
Message-Id: <20260727081859.1737223-1-zychennvt@gmail.com>
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

Changes in v7:
	- Disable IRQ before clearing i2c->msg.
	- Support	CONFIG_PM=n, and simplify runtime PM setup accordingly.
	- Remove redundant register access in runtime suspend/resume callbacks.
	- Defer clearing i2c->target until after pm_runtime_put_sync() in ma35d1_unreg_target().
	- Enable interrupts alongside I2C enable in ma35d1_i2c_reset().
  v6: https://lore.kernel.org/r/20260720030616.1067660-1-zychennvt@gmail.com/
Changes in v6:
  - Patch 2 (driver):
		- Removed dynamic IRQ toggling helpers for simpler interrupt management.
		Address review feedback:
		- Added zero-length read quirk.
		- Set i2c->msg to NULL on timeout to avoid use-after-free.
		- Cleared hardware registers on target unregistration to release the bus.
		- Protected suspend-path register writes with a spinlock.
		- Validated clock-frequency to prevent division-by-zero.
		- Removed incorrect I2C_M_IGNORE_NAK handling.
		- Corrected a comment typo in the receive data path.		
  - Patch 3 (dts):
    - use a generic functional name audio-codec@1a
  v5: https://lore.kernel.org/r/20260630012106.3616821-1-zychennvt@gmail.com/

Changes in v5:
  - Patch 2 (driver):
    - Add spinlock protection for MA35_CTL0 register access.
    - Add NULL pointer check for i2c->msg in the ISR.
    - Use devres-managed cleanup (devm_add_action_or_reset) for runtime PM.
    - Use pm_runtime_force_suspend/resume() for Controller mode 
      system sleep.
    - Control I2CEN bit enabling/disabling via runtime PM.
    - Refactor arbitration lost handling in state machines.
    - Remove unsupported I2C_FUNC_PROTOCOL_MANGLING flag.
    - Clean up readl_poll_timeout() parameters, retry loop, and
      unused macros.
  v4: https://lore.kernel.org/r/20260610030208.2020275-1-zychennvt@gmail.com/

Changes in v4:
  - Patch 1 (dt-bindings):
    - Update example interrupt number.
  - Patch 2 (driver):
    - Remove redundant spinlocks and fix 'irq' type to signed.
    - Fix target address recovery in ma35d1_i2c_reset().
    - Refactor IRQ handler for multi-msg reads and NACK/IGNORE_NAK.
    - Fix timeout UAF via explicit IRQ disabling during recovery.
    - Drop IRQF_SHARED and fix PM paths in probe/unregistration.
    - Limit suspend/resume wakeup logic to target mode only.
  - Patch 3 (dts):
    - Add missing i2c0 node to dtsi.
    - Switch SoM configuration from i2c1 to i2c2 with updated pinctrl.
    - Add nau8822 audio codec node under i2c2 on the SoM board.
    - Drop redundant i2c0 alias and clean up dtsi property ordering.
  v3: https://lore.kernel.org/r/20260512073953.564323-1-zychennvt@gmail.com/

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
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  20 +
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  72 ++
 drivers/i2c/busses/Kconfig                    |  13 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-ma35d1.c               | 759 ++++++++++++++++++
 6 files changed, 928 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


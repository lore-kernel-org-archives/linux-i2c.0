Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA064457C3
	for <linux-i2c@vger.kernel.org>; Tue,  4 Aug 2026 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833553; cv=none; b=QU3QgZkGOEY5eZzMtTdma7ko5uw2XKA6ccklLV+acb0FjlaGBWUwKCKDGXbgF/jLU9qwbVWqNY0+9JorDfbs9Cx1sFD9BxpQaKDwSfE5iedES2gAKeBqcDdG9xyRHiJnmG7eD3LfTwd3sh96vs53pTkxaxkXwsGD9Nu8QCI/KjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833553; c=relaxed/simple;
	bh=AZLLKK2JLXMJ437q0AzZWLhJPqydvuPfLRq4pZPhCmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UNt9clVgbLH7UJp99c3y8aL53eVoPAgRyF5+hbtVePc7/mPXawVTihLgbSBV5/PTY0jpFmYtwkGOh9EFiGzIMotdBK87l/5rAJlUY7ZFpk8KoNvxfKNtd3O0lcCK9hZrXo5J+Yx6n0PzrRkqhtaMMLgeknias7AlR+EKPgRmEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXjVDaU2; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXjVDaU2"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3811f512167so4410429a91.3
        for <linux-i2c@vger.kernel.org>; Tue, 04 Aug 2026 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785833551; x=1786438351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=06KxuYZYGUvdwJLxO6YakdqqJzGpR3ZKZOXLQyVhILY=;
        b=NXjVDaU21KR0S5YS7bIwWMiKwAO/24FIRMljpTL1DS0ovROLVGAzPdOVszHQ1x1lJr
         LpGLRp768Sa3b/82766s4yEpO0GeVeKBmK1QdI5IxtAi3VLFXgEnEbESvhsNI4Qirmav
         zAK2AXSufUXM+IAaQUo5/YYwKSNuxcjXn+EvhzvhsgnONTGMF3HMoPyMYyCGIKx+Wznq
         YHm8NiwlTdWl/8ACBUdDa31y96cA+hQU9rK6PkXYMqjzylIoF4cRSyh8gNxSrYObmQ2a
         2Fcf5q4rvvWrUQAULCgN9vm5Hv6BzKDV9i/EBXTCbVeyhrpImMHVpiWYRWrPjr/6ze7j
         5X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833551; x=1786438351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06KxuYZYGUvdwJLxO6YakdqqJzGpR3ZKZOXLQyVhILY=;
        b=OWzA1l6U6jf2gHWw/5dRzSlhli2Dr1GdjnI/qdLJRwcK74rvzzwwFpyPCdHDec1syZ
         Ty+a2Qq0gGMYB6hMeFpTxXlzTEBERjYqTRunNLnUOGP0VDT72s/CzW/JQNM2zn2VBSz7
         zrFwa4mIjm53ARAmi9R8FZO0lIhtRfnkY3T2p1vdkLgOX3hngTVWtI1czzsxbidLIBaG
         ujFrlbaxfneFHaHtJ3EPjR0R7h93RU8sfSyCwBNEivxuDJ0dLzk0iZARKDw2DUKGnUwX
         VSvAsBOCuV0C5K5UBgh+rn8djqj2Ms5bvUQ9Sv3p7ojZEn/JUWYhU3noTdQaTcW1xhlJ
         kA3g==
X-Forwarded-Encrypted: i=1; AHgh+Rp1XJRBtoAeh0R8nWnot3Ds9h5F3UW7Wmj7dNBFxvIOg5+t3HNZG77JubTJlyNn+JEhUJ0phhzTlbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPRDqxGqhvlmtp9EJLY/+IoJfBre5yyeygd5V+37v8p9ZGTAn
	giy5a81Zr7DJsNPT2TmqjqbYmksAVX+xxvLPDzJxsxQlAtLvSND3jgZ7AdpsIw==
X-Gm-Gg: AR+sD10gPEwh29L5o1ZLOhhgdJ9w89LOv9Fq0U+rnDieG72aH5Mtdst/IfFRgPBooKH
	ujoJdU+/229sPCirE0zVhxwPEtapx4MPU63eL9MwjQ5EgkqY5d+2FRQadtC84UE2jjwjEMgejuP
	qOMEKqoe+yzcYngFs4UIzalWZDw7D7rJxTDg2MmKvjWJSTS6t/rsD1HSbGuGwnMeEkOFUTZVEeX
	K3GphQo3bj1gdggFG1okF6TwCYNAXEPut5mskWefJayjfrjuQGIllNAz5DK4/0gk74PEK2oSeVr
	ipOuqmNWVtwAQVmkx3s0ba3yTlL3J+jm7cyha+ae+4/Nh0b4yJ1ukkmEpyLM/bOKM5BNSxJOLgh
	akTDvq0le+4U1qRzTn739qo+VaxJ0RxKVd6cGtwvToM1QObQGABj76reDhVKObZIo+cu1BCFsCL
	vfhQt7PyqpKt5vuzUWu2Tk7HRb83SMpZUH8hV0q5Ek0gdRhB+4mLCHI0of5VciHNlh4wrJUKIS7
	65GePkGXEd4i8UNJhFTJh+vyRjLHDEAGBWKhbiaubqb3ww=
X-Received: by 2002:a17:90a:e7c4:b0:38f:23d6:b4b4 with SMTP id 98e67ed59e1d1-38fbc5341dcmr12857447a91.22.1785833551137;
        Tue, 04 Aug 2026 01:52:31 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febffb36dsm1012000a91.7.2026.08.04.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:52:30 -0700 (PDT)
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
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH v8 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Tue,  4 Aug 2026 16:48:03 +0800
Message-Id: <20260804084806.1846570-1-zychennvt@gmail.com>
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

Changes in v8:
	- Remove rpm_put avoid duplicate processing.
	- Add synchronize_irq wait for interrupt to finish before i2c->target = NULL.
	- Add ma35d1_i2c_restore_idle() to handle bus errors or spurious interrupts.
	- Change return types of TRX helper functions to irqreturn_t, returning
		IRQ_NONE for unhandled status codes.
	v7: https://lore.kernel.org/r/20260727081859.1737223-1-zychennvt@gmail.com/

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
		Based on Sashiko AI Feedback:
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
 drivers/i2c/busses/i2c-ma35d1.c               | 777 ++++++++++++++++++
 6 files changed, 946 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


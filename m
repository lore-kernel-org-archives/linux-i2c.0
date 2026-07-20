Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB70255F52
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516795; cv=none; b=XqBGgJuuPlShyi6GnqURkGwmvb11qs0vg+nfq3tZH6jDe0RHLgjnYm5XXy+Gv657IkbjKCCpbuvle5qaE/H5UOJvGV/lrIAGzXxjHGjw3PfPnxPorJ77OsyUNxTugqwiUWmIgEWM0FaybzBdPe/b2t+ipICCPLWF64F/Du4HGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516795; c=relaxed/simple;
	bh=zDMe8KkgAzy5r690gHB8E3jPMMcxlWei8rkNNEgH8A8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dh94+tdErIVP5suZroAIIU2fN9TNyC2652Bwofi057G5zggvLy/h6FFPFOqfm0WXWouIZ8ngqDIbIHdjGyyn8GGe2+KwzdBNNpGkCHIPzcGWBowzQVll07Ej6BMi7/MeTkFv6Jl48GYsAt8GopapwncbMns4StOTa+WVFmUVS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haDS0lv+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haDS0lv+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848882fdb18so6811466b3a.0
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jul 2026 20:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784516793; x=1785121593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AXtq+ecEAywLnvDjSZM6ov2wubc0XFPi9d99IVIm0iw=;
        b=haDS0lv+nuX9vIZWOkMXQtAkXCX+iTnFV4T7SknJJmEi6LxWmpQbJn80/0Kaxdr4Tj
         RwfSbxXMWU5UrXFbUMxiRz9t7NK+b+rkDcHvYMPaRMd2dil9bW/ERNrSF5+IMTF7Ch31
         q1Ro1z4QGdKcDBEN4iOIcZSV0zhhNdsAINF6InlyvV1BUlvqTtvVP7/ozwg/Irz1bild
         V+GwLVZP8T4nsen0k2xv2xgD7Ik8VPNf9o7bKqrNN2Z3yHOogEwRWHLtHnKjt4zNNah2
         BlCEf+vpVXj4eiPkj+yT913Qy+jzOWbV5rxjqwAdEPKBdwczDsPiSBXDtDOkFx3pjVRE
         T1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784516793; x=1785121593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXtq+ecEAywLnvDjSZM6ov2wubc0XFPi9d99IVIm0iw=;
        b=cov9SPttG3+q18sXyIJdxOn9klKD3woMY5cDk1ISaOV1HsCO3Bm+3KYtOD3x6h9I2C
         /UVAaotNpd580hoV/JnG44Fcd5YPj/xTNzXxQViByu5Uik+TfsnOV6hz+D58zq08vWxM
         vuOed9zgvfBjWpJNn8Sa6fEJlwo53dWSqxVajqL6MBIS5OQKqyMrR1iQifft2XJ5TDMO
         W4oGgD8q49U0gssN3Pz5q/viwgsodmzq/xe30XQjv7fHuoMrSBU+SeYTKBi39RuXvjbd
         3eKSDnEItEkyIrvrtWMpTwShI6jkNYlfAv5cAIA3mqeX2ctzjiEifj8gZgWuWqBcIlzp
         xrUw==
X-Forwarded-Encrypted: i=1; AHgh+RrQSKd65sr97MZj1uKzyL8Iu7OSXIHhDmsTCAxKxaz4zLdvYbmAmXvykQe4xL11XUdCu/ZZuJ6ZaDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz53XhuDXHxxqjem8BH5VNInEfmyku8TqrAX7+MGILJVFnjNvRa
	+eCCzPkvCXWG0+cmVs/mZxTclyz2IkHI1Fty5qwmblCY0BMKR7T0J7Fb
X-Gm-Gg: AfdE7cngvWdx0AWXcwV+yziE7wtEpR91bhwdlKFqfXA6DZxVl7zWrP4CfdRTIFauryM
	VA3izrYDKeBoRHcF6mkQNygx9IC9MuY7ASafcEcBtACaVZmCD00NL6by/i7Mqk6Fvwd940ONYtQ
	mY7MAx9cqU7/sWYQBHzl7eoh38sHTBjqZArdmyeXsrSXCLgUO+PmHp9mHRNc/JjoaTYkNyHCxfR
	u71YI3bjo6RvipcP561LjRYmAgSg34GjTZ/SG9/nO10aGRUl3n3N9My5K5SfDO+LUYKECWGVTaW
	X0vIeGVeiDr+rXdOFlgVRGmFNBt2FpPiBsOcdr+yod/Ax2au/lhsC1nhpSrvzNWlZvKQcanF1lV
	Y4a7Y78tYnPNQZcpkwKW7GU3/IGD67y0VbHy6rsOHD2bJjT3cqmHCzWLeRuwQp3F8wwr8UGd8Eu
	I2hrWeD2+JoZAEmLbLih5RWRri6gv9UDMnssphtTwtKqF/cgpSgxx6pu2FWTu6
X-Received: by 2002:a05:6a00:4603:b0:848:4810:2b70 with SMTP id d2e1a72fcca58-84c294d4154mr12445461b3a.68.1784516793096;
        Sun, 19 Jul 2026 20:06:33 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfe9sm4805267b3a.27.2026.07.19.20.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:06:32 -0700 (PDT)
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
Subject: [PATCH v6 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Mon, 20 Jul 2026 11:06:13 +0800
Message-Id: <20260720030616.1067660-1-zychennvt@gmail.com>
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
 drivers/i2c/busses/i2c-ma35d1.c               | 780 ++++++++++++++++++
 6 files changed, 949 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B645349C
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979894; cv=none; b=dQ3PPQGOs7A7P0lr/mrWmIb1+ahBjiKdX9gMWuY2vbt4HBvS8B2sY1DaY6bckmL18/n1T5psejEE3PXvwreASimr0Ttavr/2YZcJZqThmriST8nx34XleUnhDKSVimgROJlTWCGyz1AKNSgbZg1DWsZOil74E9onRLWe0jXJPtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979894; c=relaxed/simple;
	bh=9ppgiylzdQ8XOR13ZsEkYbvHKg6Kqma3CrDXroZZGfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZWDvOfCdP1iOHJkIr+LXf8azdLDhRNzN2YtlXbgHY179jmX2QgtD6mvP5KRTW4mpFRxU9axTnA9KEw4nYdsrsr2kZrxH4r+Q/ehK43Y265iZAQ7dktK6A43XCwUM+dyOj4ZEPuj7lOKnTVVFE8TWsMtZ0dBwqntbNeX0aWlR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrEhFV6d; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrEhFV6d"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso2349509a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789979892; x=1790584692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xvmNcp2BGzDYZW5Bhdvt0umZh/KqhVfSHw61I/uVOGs=;
        b=BrEhFV6dzrYma5gZTdA94HMle/+pu8QTwQzX0uuITSRDAt5a7Xoxy+W9mRGuiZabid
         ZIf2i3stRNO8BuycS1DYLML5XLwWxX1p8MsQGxTyb1vMc5MwM/tNjZzVotHOq7GWdIse
         gfJX+ok7YIjjbxEDCedLE7W6PUfgFbkf8MnSIbG/1tRSarut0o0hQxP6CuDT7fRJjhsW
         onJLfIpnxKPP1WfFbMfs2dF/SXiuwa4ZLL/SzcHBDGDfgyc0wO9f3QkgwlxxbjADxx5y
         C2fPq2r1ku5UVEpe/HI9hyG6yIsryeuppW3y89Y9k917P8eykUateBFoKtDwoEtl+p5z
         c8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979892; x=1790584692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xvmNcp2BGzDYZW5Bhdvt0umZh/KqhVfSHw61I/uVOGs=;
        b=FsOom2FfAthiin7rH7d6CXbHo7OlDUGuUv8EB1sa0B2j1vd6g1s28fyq7AnTTlvPRt
         lwx5YTDch7BtW47ZbQWiwWbe5g40k/kc5DMdOLmX+a1ze/GKYxAffymlepu9sUuBsQe0
         ivqRvLqUNCCjG27kcVoEdBz51XN1lTwgxvnwAoezd51vvC49Z1kRRJXgBY4SjnZmRjl/
         7rr7Rj6dSZmErWbFe2H241Mbf6E6/i5Z9gDXvWib5pR/CSPj4PX6gJOwe9KIA4maI/jW
         d8Rwi7b7KDGyjND6rNuND3HZF83/Uj6nuamoIfaOx5pY615w4b+k95wUehCpuXL2+Nnt
         9A5A==
X-Forwarded-Encrypted: i=1; AKwUvBxeiZMTz49+3BXWZqhPVVGk5PMKS22zS5YPuhAiky3ctX9ygna8AMeXXlDSr/vdsgsOu3MLVsYqCI0=@vger.kernel.org
X-Gm-Message-State: AFuF++mnlA0tplvWQTpqOiPqDctn3NASqxqzN8Nt5nXwShomnvNHOULC
	LbM88x88EeFeoUyH9yHQBef6QPxYWT1Uo7j2dgc4RG6vLvNSVWe7USUQ
X-Gm-Gg: AYBFou2B3mEPRmyuQJ1A31YIMU8sbB5u2+hApcYRupQ3yYCbu0V9f8M9MZmDPbvukuk
	9UBGRLnPbFXiwXeMkmN2R/Q5d/FZoYgHJRuq1ZMKWwTiqjjwACMBnkEZ3Y+MdVAm3hyYEeKAzDx
	BjVDABec84jid22R3VyGl5oNucJQtTh8OfvsYVxEWeAo6H17785poe7Sts7zsvsm34PIDZzLXDU
	UCrFln9PtGzzbcjfoO+lxSYckuwszRtJ39xRke9/hkEzKlKgR3bt6RrUaTH9lzF25s4l7ND7iwV
	k3WtZMzhvkyTnAQhlFbGncgkCNJncLGElTM7xg2g317O2ZCGhzgSUh8tFQzaojPOhMOQNj+jmKt
	hQQ3YXVfG4O/oPCUzsAvN4KjLQHxbWQ7ovacrT6x1mNU4GIgwveKwhQV83MeV8cAYG+6qA6alD+
	2Fft6Zf09ERNW99fbhg4FuDh+ieckCQbNX+uxcHpOzhsiyo+pvgzFZeZV2yrAbD6oCeP9kGdKq0
	kzVLsyv7MG86W7CJUHadu53k3m8ZlOerhG1EcLnFoMVwf22tF2y4EZL
X-Received: by 2002:a17:90b:17c1:b0:39e:3559:12df with SMTP id 98e67ed59e1d1-39e54aa357amr15593290a91.1.1789979891912;
        Mon, 21 Sep 2026 01:38:11 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50694sm15121508a91.2.2026.09.21.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:38:11 -0700 (PDT)
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
Subject: [PATCH v10 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Mon, 21 Sep 2026 16:37:50 +0800
Message-Id: <20260921083753.1109826-1-zychennvt@gmail.com>
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

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
Changes in v10:
	- Handle enable_irq_wake() return value in suspend.
	- Correct clock divider mask and maximum limit to 10-bit.
	v9: https://lore.kernel.org/r/20260807060400.2047517-1-zychennvt@gmail.com/

Changes in v9:
	- Centralize SI handling in the interrupt handler.
	- Fix target mode comments.
	- Initialize the target transmit byte.
	- Add reset_control_deassert() during probe.
	v8: https://lore.kernel.org/r/20260804084806.1846570-1-zychennvt@gmail.com/

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
 drivers/i2c/busses/i2c-ma35d1.c               | 781 ++++++++++++++++++
 6 files changed, 950 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


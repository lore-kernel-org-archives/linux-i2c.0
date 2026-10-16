Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38630C168
	for <linux-i2c@vger.kernel.org>; Fri, 16 Oct 2026 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112703; cv=none; b=FTIbxFEbRA/emAZxsVXJ5Wj/EZUnpjz2nn7FI4sHtkb4oy0CqzdKMtwtVLwhg/a9KwaeK7Cnd+LQYVwi/gMGHvJfUd943dxu3SghFY1gI5n15qon0SQTq0dAVaA0QynnQuJKLFAzgLsIebnDpB/roBaFsdLXoiIMrAvgBDb9QQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112703; c=relaxed/simple;
	bh=ymnukeKylAcZafqsNYiiO2UX3W6zv2Eym51b82sqPow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NTvZYiHXmHxAOwKN9i4xkfR7M4jJBXdvHHA3f5PYoJFqAjSgj+RHt7vegFQIFaJPGi+E4LOfi/vW3q800olfETxRTbNGMYE1uS1qcJdO+sdG3aVmOjUTQX+tEpf04nZUklP22cIS10XhSiI/fxmxvmY9lkCMeXaOCrkg0DB8phM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDkM7zee; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDkM7zee"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso1170566b3a.3
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792112701; x=1792717501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=syAHkvAn4YNYIcaHBObgsW1JOoqD1UVZ48XNPLhl2Qw=;
        b=KDkM7zeeCssHdMJOlC0EvMCOP0AFhJbGDyzsZZmnZ/SsnfJB7ZLgfrEZmdpQCM9O0y
         Ud/XOtqWp49ALfGbnHM95AUh7zcz75KstMVV5zOJLUc28k3yYj14jfkDPgV081F11/g7
         1MaSj3RivUT7hjzBATuRmWiec60z6aVCSA0Rwg0FsqwCfRbrBdU/THEW61VRPbxAwTK0
         xxA+jJ83vQbTOBsZXDriZ/TJ+Xg772+HRrNGhODR4GnwbGHCIK9DqsDy2mDFYCnLgum1
         hE70cmS+ZJ6yBGLbjs/DTbqfdn12/CzmMCb66+LOucu//bfLGQwyQfJZd9Kl6GUoHXIV
         /cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792112701; x=1792717501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=syAHkvAn4YNYIcaHBObgsW1JOoqD1UVZ48XNPLhl2Qw=;
        b=vQFhJIFnEck/Rhp4/6usLaIg8f9gU+swfrpDcWK+HUlrl3OZUlcGV2OdDnGSGrk9zQ
         LoCBxyISKN3zG0NwGa71vkewJpB2sDmkwjNbum3jdXqNtMfr54eG9RJwdjreHK37Z688
         cG4OpjHp42RFyKmOPoBzYte30B5vrUgOaQdYB1dxNrk7t+l9FbLxENCF6MH1w+lt3G1Q
         8ahIDHYxOQO3b+pu3b6frVaPr9gQRgx2lCsFYY5uXfkKvkcbZr+heY2x53o6wZtyakeB
         5OIejeptI0MLJ5h95bkELwJDAVfcnsfj9ph4dN+wJuMILlpuMevYDiX8LcojAjXduMZI
         +fAg==
X-Forwarded-Encrypted: i=1; AKwUvBxsLYFcfzWEki3VfzVp977NBUJK8bHF9eK3Od1weEsOTBft7U/cdTBbNnFNuSMcsIHQkCbx9iNyZkM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLb5SIfSOEiXDt/WnaBCUFkw+s6puzasLnq1n+Yg+2y5NcqWOdX
	3L9K/lINznnopk3v+4kaNRwRY1WHgMsCYuo8fdCt38k8Nju79FI/7jRl
X-Gm-Gg: AYBFou15zOGBVIUcD/9XcMWiKXnJu+o82siMyZbF2SZJ1gfIUfq+ZmzzzEoKjSpIf7H
	tIflnpjiHR1CYjTEgkG5ppe9LdlNCyjnwTTDuVEHBAI+R5JSzCyoKFyJrDOH0AiMLY4A5Ugac8i
	1O6fNuixjf0VII9zmbBHlc+9BLCKyP+TFEv6083xvjabsZa1duo7h2fNf+mKbTnFVQJ0J6YmXJO
	roBP7Qtk77m1fvb1mcG4BwCbFuCYbzMIC50TBjumTDalof/hR/vKF8I/1nChb4Js557XzY3Ktf5
	XZ++qsk0Zh6YG6RzqEgg3FYsfXxEnfiw4vd1yeAwH0mkzXq4qnHKBaA9wGlMqzsJIaZ7yI16zyH
	Ct+nlW0RdFr28P2Whif0qUS4Tj+aSAgHf4ojrcjahytbyyRhtX3v19w0WgKc7XexCDLzyoqg2qe
	RvZW6cHTQxIcT7cp7Wa3gA7ZTA0TRbCTzI8U8xDw9atHTozrjbHuNbN9y2IOH5bvqu1tf1+2phG
	nWYabc30nb24dJJNMlFu0JXEzaR3G2hEAAKVbWCKyx+nXn7gD7p0Q32
X-Received: by 2002:a05:6a00:2e95:b0:874:708d:b620 with SMTP id d2e1a72fcca58-897c6e1be95mr18132833b3a.30.1792112700968;
        Thu, 15 Oct 2026 18:05:00 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735e513sm302821b3a.27.2026.10.15.18.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 18:05:00 -0700 (PDT)
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
Subject: [PATCH v11 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Fri, 16 Oct 2026 09:04:45 +0800
Message-Id: <20261016010448.324856-1-zychennvt@gmail.com>
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
Changes in v12:
	- Synchronize IRQs while initializing transfer state and issuing START.
	- Clear wake-up control if enabling IRQ wake fails.
	v11: https://lore.kernel.org/all/20261001075101.489660-1-zychennvt@gmail.com/

Changes in v11:
	According to Andi's comments:
	- Prefix the remaining timeout macros with `MA35_`.
	- Handle errors returned by `i2c_slave_event()` by sending NACK when the
		target driver rejects a request.
	- Use `dev_err_probe()` consistently in probe error paths.
	v10: https://lore.kernel.org/r/20260921083753.1109826-1-zychennvt@gmail.com/

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
 drivers/i2c/busses/i2c-ma35d1.c               | 800 ++++++++++++++++++
 6 files changed, 969 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


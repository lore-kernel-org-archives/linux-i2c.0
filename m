Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC553D8914
	for <linux-i2c@vger.kernel.org>; Thu,  1 Oct 2026 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841115; cv=none; b=ZGyvInyIspOFydHiJuwCIWdSSDId7g9FqkKwDFpx1SEzanGWvBe3O6aL1MwRwVkP7R2glrG0690jka6FC7Jm210yIRSD+9UoN1QYqaBBncmIOyTwHsN6w5pK+gAmCCFBhpaCaGamPIR2jnh3bs+t1EXq6FYDGN9nHbMXekYLYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841115; c=relaxed/simple;
	bh=kQEeJ5SXro7j6xyUtuffcYbSuFTNEUkhUM7tB+M/9MY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VRpNIvV5v9FtUibgu3UZ5Nm3BzA2mm8stN0TFv5AKdTj/dwDgPwHUfx5E+fXCBDx772oMyIMCYocB0hzmTr3YE67wNMqmPdl/WYPQF7yDxkERAWMaYK1rU1WyIqtSAC9WfAC3rVt7oo2iuG5qJmTFqL63PcgVri5uirXhFYRcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJhpb9JY; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJhpb9JY"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-88098dbba5fso1370853b3a.1
        for <linux-i2c@vger.kernel.org>; Thu, 01 Oct 2026 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790841112; x=1791445912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9wjagYs9Ji8AuTVXONh4xlKL2Lc9+4X1MuRUZyuptkk=;
        b=hJhpb9JY0ujZ8LuaONIoP0hE67zkR60vDEnhNSGGNq0FD30zCtzB8MhZrgJmCoeeTy
         D6w5PDsWZOw9/JR1nrNqbcWUnkWskPCFVnb+CaiXhbxgTwkJj2YOCQtmZLP3MbKutbq/
         50TO2J9UmZiu/IGmkcdZKnxHqZLb7Dnus3oEDLEnj2BSB47WY2lHj5c5GdBuLKDDI+Jg
         psHFUUpw9a6+UDTVx7aauKGEWpei5KdXSLLF99jhmpFXefl4+sat1uIamEtIpkodILLd
         MLYjgTzQRfhrfz6VRH7KGaMlj8LomAvg3pORLJ9ExOFgxDQLPFvwcuOaYIYY4sf7ocLs
         68Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841112; x=1791445912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9wjagYs9Ji8AuTVXONh4xlKL2Lc9+4X1MuRUZyuptkk=;
        b=Nmks9wLslaLiAJMimcVTIIWYaqk2KOZcMLPiF5+EORu6O0gIpvFHL4iL8nOgWeeX05
         2EQTNn2SirnHH0wOD6Yr5+pJpbUId3A84u3hKcfZbb7vv3noxiNFO4VLB+fVCw159NkK
         8mf6qjGZS/mh0aA0hOhaMDhkopkntxnQ05bXG71LdYMTPUgcfb76BXJB0LPnyqE0iLqP
         GuKHXh8gR5OrGx9iIFUehPSmfj5qIJhIZtRoHHXX4KVGiTk5lzjFRi7XFwSSW5ql6B4u
         56p89g/kXhEP4DPz+f5UQr1E68zfQTNc8mndFMl+90dsWfwAZ+LQ66IgFMcb7tDRItE8
         CU1g==
X-Forwarded-Encrypted: i=1; AKwUvBx674juOi9WMhnZq+crei/MvSnQgsRvcNCaeN4Gj7JpDiSB/J1QwBXANJ80IqoS2yDNfpdfRCEDKDI=@vger.kernel.org
X-Gm-Message-State: AFuF++lUL9CIpqWW2i7pAg2ueRjxUwRI4e000KCSrqPGjQ+OdW5kAoRo
	k0le6uN5aUheIXjkckdFc78a3qrjicoI3BaSfwc8QCmQ5feXqsdwUmcR
X-Gm-Gg: AYBFou3gauO1iuVq3kQyfewDF6CZ3NGc/fai6pFGwRYt8EHqK8vBhQCzrI6WXDYlfbh
	5j99T9QtM5tUx+eW4ectAaALBb7Rj/mhXQ/B7hJWID+D3+mpZND9uSo7aG0J3jDxg5w49ic5Tag
	FZ731LeubhNTGZQtr4DYAkuIpofF8K1ss1wWZswlhWiTbTsRKPIP7udJ9pE+HDkkecxuGb5OZ/v
	OUEF3jvUM2z0D/9SC5hgRysPZQs2IolhzDAvbGhEQU5RRfAw2WqAXKXnzZ4thD8zzeebcL0tO3i
	d9PVcJ89ad2+Qksd7v9vBeL8oBTisMxz5ftMWnRrit0/PDH4+HBvKBGa9MmR6OE0psT370vFGIq
	uwNOhO6UmVobn34aHNAGk3KJJNKnHin/UF/a7wjQ3526IzdSvHnZG8qPXARrHwk54P0Pxt36KlX
	KVf19C2zwxNsYDFZji4WHmAG1i1SSixQSKgD4AJgT1TayuZDDijquEMGrnnoica/wpWfH/KieNI
	b7oR6z/epYwOP42uBT6k11lSNpV4sm1n80wXUBDd3Te9eCsMxZ2EpjI
X-Received: by 2002:a05:6a00:1250:b0:886:af7d:f0ef with SMTP id d2e1a72fcca58-887fc198825mr1234242b3a.6.1790841112222;
        Thu, 01 Oct 2026 00:51:52 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88819db440csm666843b3a.60.2026.10.01.00.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:51:51 -0700 (PDT)
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
Date: Thu,  1 Oct 2026 15:50:58 +0800
Message-Id: <20261001075101.489660-1-zychennvt@gmail.com>
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
 drivers/i2c/busses/i2c-ma35d1.c               | 796 ++++++++++++++++++
 6 files changed, 965 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


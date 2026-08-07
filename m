Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943FB43F0B6
	for <linux-i2c@vger.kernel.org>; Fri,  7 Aug 2026 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082657; cv=none; b=JR9CziMC6xLgWEYE273cTINdDm8OQ/7XIfJ+s7QySHD6qF/Ce+Rr3P6qxgGCs6Ef3WqIpW52dcAO8SP4HDm3uVhljzWSrYxWrX4aSKz+XfET5yF+RhphAeNhOYmYzO0QLzoTVapclNYZ7P0oZEB+LiB2PfkwwTLRqhVlLEzs+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082657; c=relaxed/simple;
	bh=LZ2TkYYzgguLH/sWme9VonjfcU72crkY/D63CPX2kJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/lncpZ+GAUXj0I7NSTgJ0CNyFFQgfQqmjbRwva5eAk7T0y18cSv4+z+cTj2+e4b2Mg7tZZ8l+iy3KJN2vxxtMLuCLzDsOD+kg1jhl6v3LRzedpXDEFEEefuv/0EW3jsJkQBwBp7TJ3kuC2272+CUo+ySOUNukgzmZVH72bqf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu8lU6Fk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu8lU6Fk"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso3756389a91.1
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 23:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786082655; x=1786687455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PCzZs9ZFtPHagAoejIEffM3VCv5wo8jmQZlG8z3fvE=;
        b=iu8lU6FkWkg7lO9NZ3a1xfNpvA8n5R2M2Du1tnswjJPZhGmbkRyD2srR2H/aPoCeMZ
         zLusAIJj8LS4fhGYukD0nT9VMuiK5Lyi/Kfw+nhZAxyDSesuoyUjE1oTC6zg20u/vbRn
         ceQJwo64cPo7ToP/6DWmiLoBSv2r5vLMdzWtnQBBjlbfrNPO7WbT2q8vn6xb4RdRA/b3
         jNEyzHjMdFoAMMinyLu0fNmuUlVGB5/7Xpr+Moybr9Pl+bVmhQotChKOw2IBx9fU2sF/
         6RW/8FnJO4ScXFGA9+fslOjYK/77/U5L0Fmre9UXQyIhRWOjybTZ/3iWfk+9KsCQ/UxY
         gFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786082655; x=1786687455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PCzZs9ZFtPHagAoejIEffM3VCv5wo8jmQZlG8z3fvE=;
        b=tRymd/FKWweOgFk3fVWjOrAqqPPlCJm7AX10RbK3OESOSc0KVjZ4Zi8kgKsSzyS4Kr
         MjQtYjeuyhIRLk4WB3VbXsvj0BbKziJvGO5g3JS2wjUPzYh9q6QEkgV6nlygyrKzNPqX
         pejY21ymfQ1GX2HxxUTOfiQGIBXXNsl3VuF9sAb+oTfcrvk+UqSCKLOfedFGFy7e/Fua
         FbmP5hOikmOuhn6furlZShSvNhoAr21gs132DmfXC+spWPH6aKUKsF9BthYvcBPW8osX
         6BXwu3qDlH9qqL0GwydbIToaXnyhuOaqYCsxlUsdBNtwPPkIon/Z404RJElIwKx6bulP
         pkkA==
X-Forwarded-Encrypted: i=1; AHgh+RpGYL+5h7g9FUnMcx0fUv9TUpXw9oFeO2aMdRhWWQ0+onHswN1QJl5187A4ahWbr9SzmgX5AlbdQQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAxX6GwSrkQcrZq5DjyoW+WwBe1mdR3o/7eVgemKg6tw13BBb9
	vMHq0knidB/uZy0YrXIX8bvAgBNFH2qgkY1ijBnu104yUDUK1fzCRI3l
X-Gm-Gg: AR+sD13HQB+JsY53vcBj0+RrCr18xRwsxJwm41R3LCuQaDzecwsAm5Fv+8IjEyhJ+ht
	5TARrqXeIrXb9TSR8EAw6q+AUddarW+Fzj985mVtyN6pgYGum62qn0tjsio7DTOAX+titQPtfp8
	Kj/ZlRybF9SowHy1iu4oDN3C+8vwLj/KJDd8/KZ8yvC8j/Rf1o9kRd0acBfBsiwXvVBOnF5hS41
	jAu0WDyMLJwuqsT/6Bv7XybiYHBq4N3UYgWcHxGbsmt4HOgdSaDTxVPD5ew5KSMZiIH3P3HVlz1
	gyYxszy766HyweiL5XbTE+AeGoywY5XtY19uMnEnJ0MeRWZelGzSSw55eOz9wQQmebzMXFYe96x
	IE0A1LsxuXCU78Qk5x7eIOwgt3b5v3QZ61/VR2djHe3Sm0hMAG8v70qY1x7bBOccZLqtBahsgCa
	nhVZWEbQRwd8+EA5T9/ZgNras/BuyNfPTRPTaBHMc+kkEDKTTbNsx1LTdwgxKRJL9pEk9bgFwz1
	utSIaysI1OOhQsD8OrWbqOYzosGu7eAHqL7yFqVrvHai6k=
X-Received: by 2002:a17:90b:2dc7:b0:380:fead:448d with SMTP id 98e67ed59e1d1-392620e6e25mr1754412a91.13.1786082654831;
        Thu, 06 Aug 2026 23:04:14 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9c0fsm3375588a91.5.2026.08.06.23.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:04:14 -0700 (PDT)
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
Subject: [PATCH v9 0/3] i2c: ma35d1: Add support for MA35D1 I2C controller
Date: Fri,  7 Aug 2026 14:03:57 +0800
Message-Id: <20260807060400.2047517-1-zychennvt@gmail.com>
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
 drivers/i2c/busses/i2c-ma35d1.c               | 779 ++++++++++++++++++
 6 files changed, 948 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/nuvoton,ma35d1-i2c.yaml
 create mode 100644 drivers/i2c/busses/i2c-ma35d1.c

-- 
2.34.1


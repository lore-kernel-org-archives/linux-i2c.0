Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794995964;
	b=yYOGVLd7itu/JZqK0WI3Xb/VrB5ATzSoxChnNlYxz/K8SZ3eYL+v6zhuhEV5aOdLDoi/
	 DbzrOig2b3KuVR8Fowrr/wSJu8YtNs1fO4CTVGwr/bu7gxZcytJzXGGW876jpsn2lBlVr
	 EqqKxmWxOMAQ/cZcqyHdQ2Szavyd2MSZQtDLDTqjN4+OP98h2VnQSZ1LEJr3KM/gXmJix
	 aWT8t0yBC0tez6TwPMyEG5HoSvZAcck2nLxEnU9sB/pzYAm1veUTIVCQNtOlrWLJxPl/a
	 uVuXkymN0EZMoXCvNas5Yi7sALbZ3/+w/nKFJvJXk65glVXLnAt9v21amSy8fCSOsBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995964;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=qg/dp2RxN96cnK1fmgB+dXXft17EIAGgJVkS8wplKu0=;
	b=VzE8ws5b+49BtscWKaF/FgPo/DPD9EK1B230y4997wwsaGA8scc5mtqqshfcY4b0y/qy
	 dLiHnkJP2WYtOO8UEPXtTElH8bNoHf27TxRQ6PLkGnRsiKigCSscT5a41BfiAIwEXO7K+
	 XSECJ1NH+UEyGfokLvDYGq/KdI5W/a7LtoRV2SZdJwyQoxxrhLyMdn3n9EMzX0t9wmL2s
	 w47h4gjj8vDJwv3N65OVsKmUT+Y5t1E4sVVJMx2huDxX4L11Io/A76Vh4FsAYFHmJo794
	 BtRX8zshwxgO+5TTiFwaZ+PxIxEoqUdOQMzI4lKuhisiLFcZMNEs0HhGNWfvKF6Z0sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDxgFVGR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA8606A330;
	Wed, 18 Nov 2026 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EDxgFVGR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794995964;
	b=lxBlmUgo6w9/iJ+7osKkVOgiKkrjuUnFoWvsFtVQ4wLZAYc4MuUBtzy9oDkiTVI7KZnA
	 meaX7iP6z/ab6j7W8ZROdcJMKtc3lwQ27hsTtuJZJb5IOInuFp9B5UlQEksavGF6TUCLi
	 x2vzzqE5uqqwljUpnG7/z9t9e3cV4g5t5kBrjCdF0lq/Q7YTgFsaF4ZeXAceGiLzlBiN3
	 INMvDOeQ5zvfixIFdpZpVUpcTbgoSl5sJ43C0Kg2a4nvbeinGAuNcL0gApV3XJTGPoMUX
	 cS1Q/adGLcu5GBIT6T/48VCXYVbiQE3YGeMJMttpD7ywcZ4y+Pflu1gG/F+3SoClw6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794995964;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=qg/dp2RxN96cnK1fmgB+dXXft17EIAGgJVkS8wplKu0=;
	b=zJdouyyr0CYiISe8+cfGe05B1R+mk6qdDDDzgXt4j6CAzluo1FpUMr2s+I5HmYGgpSbp
	 VrpiDKe2vFr0ZtIXD7GaXjEnNdE1QtNZfdQNaSxMUN90RAihMR55R1QykpqkCTPlrE3Y4
	 ZSxM/8fg50NIX6Nw/xuSxXNxMfO22mTB3UmN0WcQD6TJJ6BNSdJYJLlcwlk8eOHr44224
	 JmGj/+3H+YikFYocAGsF2cg8z/Myt854c8WcL28Tp657Y0T6JC3Z9ZmloF7gjXiIDmV1w
	 RQDd03PZsEYpEubDWuMCcqh+sYSt3YZe7T9SxomW6sSH1I5qNJlN/6ODDb0qdgGIhHw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4098B1F000C5;
	Wed, 18 Nov 2026 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995964;
	bh=qg/dp2RxN96cnK1fmgB+dXXft17EIAGgJVkS8wplKu0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=EDxgFVGRcLWdcNgle21kUdjfdlNraH9oqMqg9en6hd4cgEC64HQPFmrGyyo4eT2Qg
	 4FIIPIHAlifABGgLl1BR0FJWuMqAc4ir4pgY6EsBeb5KWzzvLQSVaEP00PkOSvaeIm
	 V+k2eN1On/iv5TPlnKWShycBfelPC8OSbGpl0aJFEtJ+mDrJVaEC8ugC8lTfGrQmLZ
	 4ycNXE/betKsGtCmPnakVzIqgZ/6ifqDwrYk+sPEcpD2oIaSfxa6SRNC+sfUENPdeX
	 tuFSmz7oQedLSlxSK672KLABEaQjVf7e7Mz7OqMG5YShsM6v5iQjxOAmonOO/9bIOK
	 neD5+sIRDERVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94D504ACEF;
	Wed, 18 Nov 2026 09:59:22 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v12 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Wed, 18 Nov 2026 09:59:17 +0000
Message-Id: <20261118-a9-i2c-v12-0-fc83c53121e6@amlogic.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPV2/WoC/23SzW7DIAwH8Fepch4bNt877T2mHYCYFmlNqqSKO
 lV990HVpdGSo41//IXFtRlpyDQ277trM9CUx9x3pQB82TXx4Ls9sdyWRoMcNXcAzDuWMTKU0lh
 CJG1FU4aDH4mFwXfxUMfLyFsd6+hyrsengVK+3IM+v0p9yOO5H37uuRPU7iMB5V/CBIyzYH3rg
 tRJevvhj9/9PsfX2B+besmEMwSOOEMsUCoSkRIYFdIaiiV0MxQFmiB4jJFzJcQayicscoayQOV
 BOwQVLLk1VEsoZqgKtDphG1swrt14o17C53J0XY73Ggwk1GkDmm1oKhQFBSWST3IN7QICn6EtE
 Mi1qC0mq8MauiU0M3SPrYponUzk1xD4tizpnAlB3nlKkZBvUFhS+6T192jrBRmXkhT/Um+32y/
 k+KAa/AIAAA==
X-Change-ID: 20260911-a9-i2c-24478e22e683
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, 
 Markus Elfring <Markus.Elfring@web.de>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794995960; l=3743;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=g5vQyIvM+rDCy2acja7kjSEWO0tqx22aOG7GZamYqmI=;
 b=VG1dBGY6yTFa4ybvjkPWSyXIeCQjg+qsuU22gchICxh2bwHB7uxvW476aTATQ/5ohfYf3mCQE
 ywQ4SzRQYLbDRzqcTTsLSrlJtnHVDRwJXUpmAxD+hsTZS8o+3GW8WSa
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add a device tree binding and driver for the I2C controller found on the
Amlogic A9 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v12:
- Cancel the initialization of local variables "ret".
- Link to v11: https://lore.kernel.org/r/20261118-a9-i2c-v11-0-68a3e79ff43a@amlogic.com

Changes in v11:
- Convert hand-rolled spin_lock_irqsave()/spin_unlock_irqrestore() pairs
  to scoped_guard(), and drop the now unused  "flags" variable.
- Link to v10: https://lore.kernel.org/r/20261117-a9-i2c-v10-0-33ea9aefce20@amlogic.com

Changes in v10:
- Convert hand-rolled spin_lock_irqsave()/spin_unlock_irqrestore() pairs
  to guard().
- Drop unneeded braces around the single-statement early return in the
  IRQ handler.
- Add MODULE_AUTHOR entry for Xianwei Zhao.
- Fix commit message capitalization in the dt-bindings patch
  ("Device Tree" -> "device tree").
- Link to v9: https://lore.kernel.org/r/20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com

Changes in v9:
- Use guard(spinlock) instead of spinlock according to Markus's suggestions, no logic change.
- Link to v8: https://lore.kernel.org/r/20261110-a9-i2c-v8-0-1e9d2682f86b@amlogic.com

Changes in v8:
- Reserve complete(done) into lock, and adjust the code process in irq func.
- Link to v7: https://lore.kernel.org/r/20261104-a9-i2c-v7-0-b31f2b53faf4@amlogic.com

Changes in v7:
- Move complete(done) out of lock, and when state = idle not complete(done) in irq func.
- Link to v6: https://lore.kernel.org/r/20261104-a9-i2c-v6-0-baa6171f26f8@amlogic.com

Changes in v6:
- use xfer instead of master_xfer interface, and when div=8 remain valid.
- Optimized the function.
- Link to v5: https://lore.kernel.org/r/20261103-a9-i2c-v5-0-86f2dcd179d8@amlogic.com

Changes in v5:
- Mask out I2C_FUNC_SMBUS_QUICK and return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).
- Link to v4: https://lore.kernel.org/r/20261102-a9-i2c-v4-0-5a169215b8e9@amlogic.com

Changes in v4:
- Repocess xfer len equal 0 use I2C_AQ_NO_ZERO_LEN, and Optimized the function.
- Disable A9_RX_THRESH_READ/A9_TX_THRESH_WRITE enables of irq when xfer timeout.
- Use guard(spinlock_irqsave) instead for direct call spinlock in xfer timeout process.
- Link to v3: https://lore.kernel.org/r/20261029-a9-i2c-v3-0-7b30ccc00533@amlogic.com

Changes in v3:
- Based on the questions raised by the robot, the data flow was reorganized.
- Some processing was optimized according to Andi's and Markus's suggestions.
- Link to v2: https://lore.kernel.org/r/20261022-a9-i2c-v2-0-45e3cef175bf@amlogic.com

Changes in v2:
- dtbinding: make some minor modifications, suggestted by Conor and robot.
- driver: Make some adjustments, including macro definitions, format adjustments,
          adding quirks, process optimization, and so on. According to Andi and robot's suggestion
- Give up MAINTAINERS file the separate submission, make it together with the driver.
- Link to v1: https://lore.kernel.org/r/20260924-a9-i2c-v1-0-b8ad9b46f4a8@amlogic.com

---
Junyi Zhao (1):
      i2c: amlogic: Add Amlogic A9 I2C controller driver

Xianwei Zhao (1):
      dt-bindings: i2c: add Amlogic A9 I2C controller

 .../devicetree/bindings/i2c/amlogic,a9-i2c.yaml    |  56 +++
 MAINTAINERS                                        |   9 +
 drivers/i2c/busses/Kconfig                         |   8 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-amlogic-a9.c                | 428 +++++++++++++++++++++
 5 files changed, 502 insertions(+)
---
base-commit: 4ec2365c08de306f52650d8736aef5862baedb8d
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



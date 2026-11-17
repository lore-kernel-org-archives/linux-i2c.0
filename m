Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794894290;
	b=pccgi2NxcWCh/jY044X1AtSzmyEX/vVaAnK7G9PIqcoGY0qQABdz8QqqRJ3WVp2axiHF
	 tIpkPiiWR1F4RJC+gFRz2U9A25xbJH/uL9pdKSIAu39b69m2vLW0xeKCjKsApSVZGTsJV
	 oCA9CJsdCv/mpWopMVFU/KbfDAMq2mQZZG1sgmTnljzX+kJ7cb5rpehstYAg7XqSe8EPZ
	 YTQjqZUC6b9iJvkOozqxMhx9MbMVVzZPguQEEOwXH89X0DEocwGY53MNqtGeXA2l82uT1
	 Z5Oe2/PXUs7qt5InBKBLG2Ocl5Lxgm1Vy419SQqhZAsc5o6S95f9JQh3HlWwZE3fy+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794894290;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=WnJxue8EGHSJoOXR71h438cN5FpREPyR7p6Z/X0PWZg=;
	b=u1sv0t1ZgqEi/WCU0vIW3QLluMFsW9kU6hj5aHf1VXGfVD49woR/T/jtneX6UwuEmmim
	 RcI/0Zb5/eDRZeHpNn9OtRF31xXRwyWE9JxFnB5AILZaFwemMptWkp89Ok46vvWYUZvdu
	 NhTb3+bUFUZIHG2+ntCnUiIwdnnsoJDAW4xQrtPdS2nTBX7DnMMhR0ah/MdgqFtrb81f1
	 xVRJt2BbouokXg/DDr5sbGNoIMOFCpZCoqAT3EpGPam1hqk5P4gzwULfoloFmBnRHdiJu
	 toQ4gtTUndZ3U+kp9Ml0hREO1yWo4aGAABG4mqyHK3F2jOX227iRpOBX+bzLH8ZvFUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3M0QVwi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BF606A335;
	Tue, 17 Nov 2026 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3M0QVwi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794894289;
	b=GYX5rUsfIZm2eSBrYVtHJKkXTlkj62fUVLYIGRTbiSov/1ehb11ZmD6ObVPk6jhpIrg2
	 SoWDqyDa60ncTg5UVnkt8WqyEA787jxQdwEKLre9lzu1XVpZoUhfKKMxuk//AWMK80Uj1
	 MSCOA0XpfDjH4UpV8KBpa3bnaL0GKMjEBLpES5VD5BijjCZuycfAgK8LWw+v0cjB4Vp3q
	 IDGpXaok9cUDT2xogbeyKPbGSvf8N2WIiaimlWh9ojbGfhTvUZtfdoHVLawTecFK0uiMl
	 S6W68JbZ7VkoR79o/WcLL80QzLnyTa2GhZn88rQrOqb+4HYiRmNleVcomiP7t8QTK0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794894289;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=WnJxue8EGHSJoOXR71h438cN5FpREPyR7p6Z/X0PWZg=;
	b=m+3u7fBlyUsh09m+t3Z+yYfhf6pJH5Vo1QQdxNkfFvQoliV/ih8Si3pnu4FsDaKyOltx
	 gXBlczhWenjKLy6p3Mp4CgX68WK3g95t+aBU0UiPpwcHW2Bsx82F1uNu2PNyG0FzkThEJ
	 +IugBCCwQ/ke4NTyRDGxkNqGNr+EbsDOLUMBmBIbrhQ45jtHo8pQ776n/N0GfGxxSj/HF
	 cJMJp7RMI1VhSpfSROHNaosFMMxv86qkPunprDTI1F5JoGn44/TLPuuKXGNuv+Q7ULLzL
	 6d0KtfpPbQeuYhqEVm3CO32wSvV21xlxfplyQX6Q5uAnD8saICL3uigoFBlSfLI/5vw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B52A21F000C5;
	Tue, 17 Nov 2026 05:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794894289;
	bh=WnJxue8EGHSJoOXR71h438cN5FpREPyR7p6Z/X0PWZg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=f3M0QVwiKSHFX/MD8zSYUHfGHkOgYzVUHFfdkXZMJbd/+Um6XlSmAikfBgcpP35J1
	 yCVnsri3h+UDgYPy4bgIqjEAZAMXwN9NkWlIp1SVKoiJg9sWYMg2vL1A1WWAdjtucO
	 sy3SCpEAMiu4wgO28KkAbzkvsAJIwS00dkGjR9GH6hBBvijLdkthZjwpEiR8AIVLfH
	 AcGFmKdakoW72dg+b4II/t3y9Pmzth3qNjJIkfLMlqShwN5hkwI7S2tAL16o0etiJh
	 eb0X2Sg41dT59Qmb1aazekZqbN14qeBiSs4f1qrrb7gW81MSSDpVv9i2P3BKFwdYhK
	 Gouyvg26pAIMg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 17B894A6D3;
	Tue, 17 Nov 2026 05:44:48 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v9 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Tue, 17 Nov 2026 05:44:02 +0000
Message-Id: <20261117-a9-i2c-v9-0-7b303c894fea@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIAKLp+2oC/23QTW7DIBAF4KtErEvLDP9d9R5VF4CHBKmxKzuyU
 kW5eyFqHVfOcuB9PDEXNtFYaGKvuwsbaS5TGfo6+KcdS4fQ74mXrs4MBRrhAXjwvGDiqJR1hEj
 GSVbDMUzE4xj6dGjxGnlpsZ7Op3b9NVIu51vP+0edD2U6DeP3rXaGdvrbgOqvYQYueHSh81GZr
 IJ7C8fPYV/ScxqOrD0y4wJBIC4QK1SaZKIMVse8hXIN/QJlhTZKkVISQku5heoOq1ygqlAHMB5
 BR0d+C/UaygXqCp3J2KUOrO8e/NGs4X05pi0nBAMWMpr8ANrH0DYoK4pa5pDVFroVBLFAVyGQ7
 9A4zM7E//B6vf4A2cJK7kwCAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794894285; l=2906;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=sKg+ezEKpqfPxRfUc62ziON7SyaA8QSFTl1n/ygHs3M=;
 b=D15RfZwfZt+xczMQ+XV4t2xV4wyB8+IYyFZmII8TF6No9XA9ud9hMEv2dKvzPHg/GZRtqBUxY
 MP/XR2b2TXNC71vkIjkLubwNBjzcaxACRrxVWumP0t8zrPYvN8yixrr
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add a Device Tree binding and driver for the I2C controller found on the
Amlogic A9 SoC.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
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
 drivers/i2c/busses/i2c-amlogic-a9.c                | 429 +++++++++++++++++++++
 5 files changed, 503 insertions(+)
---
base-commit: 4ec2365c08de306f52650d8736aef5862baedb8d
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



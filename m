Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795674733;
	b=xP/OGZDnn3loYJs3+cU6FFdvduXXHTjaYmjWiq8Bi3AbK+A9NtPc2CtHIyenlnjufPnI
	 XC6HV05uw4VBJkUYTdR1KHVnK5Ii7KNbMfKZE6oQFsICTGbJ0fOKlAaSozFrs2AsfLIBo
	 lL39KopfaQB8+hZGGHjr4yZYZGaZUwoahje39Xo/h8hQsMq+9lkrMV22SI4tRnt3AiIGw
	 uObI+sPuVsY3DDFhC2E2iYQUBHpp1K2oIzt3DvMjdLJmRlrb2sYQgweP52CKpfEZvqCHa
	 xNCbiKmDYM5AdxPvX6dRjIxB6XKWpJ1mZ9mDXrugm+PQKHK6dxDffkCKiDEVBP1YBbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674733;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=POwzoRZ+mEwbM1RA6LhR+VsE7K5I8yMuPMpUZQdbXKU=;
	b=n/egfSk+hQlSDKoTxtzhDpdCY7xnhkaH9NhCoKEk2eG7/+OYLsXXOIT6w6XUIlWGg35H
	 XF8hv8nFAgiY993Ph6J0/EpgdptR+TY81/6SqcpQFdNu4ujovQd/ZkyStJeJWKQyV/Hme
	 XLLkUlbgqEcCMLDkXctqcAj2dxMkikEidz6CDd9szV+6VKMVeDu0SkiHbhodWZ7efMITp
	 N5wyLAAtSexk6SSTZCz5ervlpwGTDcl118aZAs61Q73ItZ3NLvhHrW5IKQQSdd/ZHvRqD
	 C5eoHyWBra2M46cI+QkZAHZT9HZ3UcL06k1XVtCK8RYHNcKpJSs0XIxLtTK5YrY4LKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsWXr00A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F867606A68B;
	Thu, 26 Nov 2026 06:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsWXr00A
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795674733;
	b=j392bniUeJuUz5F0K5i7j0m1pe3BMuOB2bGr10oh/hocV6XjR/5Ga2ejcDE7OV2QXos3
	 I/xt4ixwpvlvhUJ8hD3QYaVNXDz4bxUvBIc59B/klRlGfTxgJL1y3aXWvUhbAzT3yRmHo
	 OuVDWHR3o5+guAAjtpkJ9sUwmyh3a/+OmyW5VNGk8sFh4cfWrMsVISmwhdm18tnTda+Eq
	 k8v5lU3HdxzyF4Wmo+eTtNvgnzB5TgGSq6pkl6b3248rtkY2f77gFbsl8JzShlEfBfrT7
	 /pHf6354k4hSJeO5pCvSc2iUQHh1iEWEPfR0d3alMKT1pInytRWTUEpGuZLttfglySg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795674733;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=POwzoRZ+mEwbM1RA6LhR+VsE7K5I8yMuPMpUZQdbXKU=;
	b=ACliwmyPl4H8C/su8f8UL0csbuChJRDQiAEZYZv5JLxu9me4EKp5FJtb3SIgu8mqjYJD
	 e76AaNAsp9VtJP09xOvLwmhVx2dgh9c1DLvj90+qqtirBv0aOHD/akeWt4ZlY/z1Yx2k3
	 oI6OaqTUluCDrOWwahtELJjHI6oquoLfyN3tVYbAKH1v38fbWTZpM4AEA6wOXvNCKzvmk
	 jqfd3LZJ1/ety5143jCmvfmeluG/q9XZxhCVG/Hc6Qaf/dyMzWvX5hgjk4Y7EYhoa0ILb
	 3ZoCLpM0pMlRaqzRlET0JxCvaJLqD7/aTr0WIonlOD0QAaD88cZ4rKqvp0mweJWCx1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6E93F1F01567;
	Thu, 26 Nov 2026 06:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795674733;
	bh=POwzoRZ+mEwbM1RA6LhR+VsE7K5I8yMuPMpUZQdbXKU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=MsWXr00A8XExV1mBgzLDZPwLipqjfi6lPQi+g1zQDztzSx4G/g7AjXwU6vE2k6uPr
	 jD3S+sB/K0Fy0+4um0Tp7osl3B4WXnlHv4lfEeu93B6l3uEG6M2ayitPf7PrNCzSRx
	 wjW2FoKX+qUM07xLtPllsYgNQ1Bey7Jo+iCUDpoe6yYMBzCiQTeBCmYO5lfZ0lSIGB
	 IfUpCu4TeTrTYAd1l4TBMF+KgYr5KtgF3Q5RDXQji5XzexBLJSSgNaLo17/8p9YZFh
	 C5qKpESQwP14n7RUMAvYSq+ZDlv/JpxrGpGkwhGNKcC9ND0bW+iXr2F9DGLFI94VIJ
	 y184qOyBzkiNQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AC8F94D275;
	Thu, 26 Nov 2026 06:31:22 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v13 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Thu, 26 Nov 2026 06:31:16 +0000
Message-Id: <20261126-a9-i2c-v13-0-926e2072cc4f@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIADXSB2sC/3XSzU7DMAwH8FeZeqYQ2/nkxHsgDknqbJVYi9qpG
 pr27iTT6IpajnH8y1+xfKlGHloeq9fdpRp4ase27/IB6GlXxYPv9ly3TS5UKFALB1B7V7cYa5T
 SWEZkbanKzcGPXIfBd/FQ2nPLS2nr+Hwq118Dp/Z8C3r/yOdDO5764fuWO0Gp3hNQ/iZMUIs6W
 N+4IHWS3r7542e/b+Nz7I9VeWTCGYJAnCFmKBVT5ARGhbSGtIRuhpShCSRijEIoojWUD5jlDGW
 GyoN2CCpYdmuolpBmqDK0OmETGzCu2fijXsLHcHQZjvcaDCTUaQOabWgKpIyCouSTXEO7gCBma
 DMEdg1qi8nqsIZuCc0M3X2qFK2Tif0agtiWOV3UROyd5xQZxQaFJbUPWrZHW09sXEqStlLxH1r
 2J0VLUREgsP5Lr9frDzN/CEE3AwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674680; l=4011;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=VG38lz3bQkFtaNsrKv2JR7dmLOKBqQpIx9rJVzY1Afk=;
 b=5sqqu0gv5XNxfbHLSA9rQFtAUzZA9aBqMeEWrU9YM/CmM+PtC2X4g4k0n2X1DRGUVXXTv1DjX
 mk/BHLNpoj9AOe2TPn8aZTGmLn3eEqkGrdungW+oUJ47NjClJ8WhqiT
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
Changes in v13:
- Fix commit message in the dt-bindings patch ("device tree" -> "Devicetree").
- Clear pending IRQ status before configuring and starting a new I2C transfer.
- Link to v12: https://lore.kernel.org/r/20261118-a9-i2c-v12-0-fc83c53121e6@amlogic.com

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
base-commit: 4cd099f240b0b74101fde32b6e3b15ea6e26714c
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



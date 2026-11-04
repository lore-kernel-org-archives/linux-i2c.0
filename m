Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760295;
	b=roCk6JKXH3JP8d9fg7hNMd3HIDSB/4E+NBk5mWVtdjJjD24b4U9jHH4qlUcCU6OxlDIU
	 MLKY9EG0rx3FclCDMkuXoLWI6Ho/F415/W4iCXs7l0Gsi909+t46iCgDy38E7Kh9ukW5o
	 LEQP/dQWDeJYhxej64BZ5NRuKv1F2eHfjuxDULgTZz+DFf7I6FD6iuTPIKKISgJo5jv3T
	 HD/pKcupcP6Rz84fKpBh9Impm0wj7Dukr/H9ZC9dJORCemOacE/BMscCmj9Ff3Sh2JstT
	 f1vXpLlIlhDTy5HpcWSuRmdMkiWweifxiAw4HZnUEVnQSAlfbp2QhuQnDZZShlgv2lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760295;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=KNqyU1i/xpcC/Z4st/z26veCt1UHQ8yGSYEh9gSIV9I=;
	b=wuaWwJgeEL/0QGOlBz0686EV/aUChgB0IbTUzL7Sjq7JE0nayWlo/AvVEjgkwwpaktJk
	 b+uMaXp9zrq/XNJJhAe4QU/8hb6Y/IVE+hVVQhpl4Q06BdCotMvsKtZYdPIz9SABtC/Du
	 RhSXTkdHuwMKtLv+Lwpz9RPcAGrT37HXSKQAITBDQCeYFGxLCASiu9rpuvzp3/XCZcmns
	 TFHtn9jPde1EKGcUlViGtMQw7p3yOHPn60eMgKFKnRdQtPrI2Wc3IGn4xlKLR/cM+gioC
	 +MOaqK8VfbfiX6ZEQSXBQHh+FiOQdzHTfLelNyewfQxenAN5gBSfnZmD7OivFNqOyeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8Epv6v7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D5606A326;
	Wed,  4 Nov 2026 02:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8Epv6v7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760295;
	b=aZNNQP+3B2/H7f2J3LRIqrssvVzZN55y6NbukwSbASpe7Be5zcujM1Yup0NRg68kUr0d
	 3Y/+L00pF3oSCmeLbt0XJRoErFeFwBk0i68Oiv2D2fpTvxQiIY0HwFlZABdOfUfSP5gQA
	 qlob+fQg1gHEl9dfz9lG8xo6rf0In2oToMzW3hhZOprQdX8nGrsNzcXgZ91LminB0k2cR
	 XCiy73bsdrrm5rjUBXWpnV+gNLPy4HEb0PENDKIM56LIvUp+Xzs5gRwS3QnIn9h8bUCfQ
	 mJRX63LEEzL4gAnV7GaWnv0bTtP0fO/g5OlUGqL2mNl5XAyqi0vh4cBg7+Brm6kHBAQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760295;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=KNqyU1i/xpcC/Z4st/z26veCt1UHQ8yGSYEh9gSIV9I=;
	b=jyx13XnzXllXEPnUPOW4jLRZ/7cwsuC9MFSqnnN4CLq0ngeEBIeRx3sLJbjy3u992rTT
	 wk19/y1QKbpEaQNG65tTeR2r+WWTZ0AO036rv/eU4BmvuAGABf+HvzulGtOUtCEwhvZR3
	 UKHZ0mfM2J+UAIVFNTzkuchMwUXmSe9rdosOHUwvPu5aPF6DbMjPlp9KPYTiEuCxo3dKQ
	 CrwF2yDfvU/KFXjmmCkGt0lF3V2Z4o1jWAvw/Pti1ZUg0mLdjWDYPmpEVOAW7eXrU+bYF
	 Z8ennbY6G9rIQGIg6D2DpiYeSkKNXh5kibkmEcmNOEB0kckpRsZGQ+XydZZY5dJN5qg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0D9E21F000C1;
	Wed,  4 Nov 2026 02:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760295;
	bh=KNqyU1i/xpcC/Z4st/z26veCt1UHQ8yGSYEh9gSIV9I=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=f8Epv6v7EJ/bLMWJ34IVR2jPC9O6Ie7KiMb01t4kwPxC/uEifIIHonoeGgtipxBYY
	 Yj3QE2KH8ZU3qNGiX0c0vXpyT61bJ2/ojoHMPNGEZpMM0M+xr2NCmIdW4B7C1QBtA3
	 49uson+6KTSjyi3n+cGRcpSNHbdL6zcxg5vh5uC7YBho/w49kfjXpqrvOD11kN6Y/O
	 1YeZ2NmoUZ493EXqfCDQ5pV9O8XS+TOWlP2LqNoqQev1TmbxNOAFd/ezGRB9cYw1g3
	 lpNdw+xruL72yWH1nSTCmDSGD0+K4Iu84ZNNh6ilwA7gX1YllREQxlWIPJ3bLZ61pk
	 1SFBSLMaj+b7g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 624FC46BED;
	Wed,  4 Nov 2026 02:44:53 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v6 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Wed, 04 Nov 2026 02:44:48 +0000
Message-Id: <20261104-a9-i2c-v6-0-baa6171f26f8@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIACCc6moC/2XPS27DIBQF0K1EjEsLj4+ho+6j6oDPc4zU2BFEV
 qrIey9ELY3q4YV7uOJGCuaEhbwebiTjmkpa5hr004GEyc1HpCnWTICBZpZz6ixNEChIORgEQG0
 EqWXvClKf3RymVq+Vl1ab8Xpp1+eMY7red94/ap5SuSz56z678nb6swDyd2HllFFvXLRe6lE68
 +ZOn8sxheewnEh7ZIUOOQPoECqUCkXAkQ/Kj3soHqHtUFQ4eMFCCIwpIfZQ/sEqO5QVKse1Ba6
 8QbuH6hGKDlWFRo8QQ+SDjf/+uG3bN1o0AKOhAQAA
X-Change-ID: 20260911-a9-i2c-24478e22e683
To: Junyi Zhao <junyi.zhao@amlogic.com>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Xianwei Zhao <xianwei.zhaol@amlogic.com>
Cc: Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760291; l=2328;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=Nm1JWbtaRuSABkoleUS6h/wQySv7sonsy5vVlEVZvCs=;
 b=XeTI+00jgRc76jWdI93jk8kT/tPHJfMO2BBWSKmN3+0z3ZjwvsR5Zh0K/M6/67IQnpdRIvUaC
 rhjvUdMjcy/AxnIeh3XBjezWE9uFPCKtM+as/2yn8p1LD2rtSrpmS58
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



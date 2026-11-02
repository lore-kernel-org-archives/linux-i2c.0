Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793605694;
	b=RtfSaECFt+5hdQLVGqVuQFC9N/o+plCqkCZfypfR1RirmP06w3lm2Udsb594ZXa745Yw
	 BDJJr+Vu9sRZVKWdo8UY0d6GhEftEGF/0WYz0u7BsHZHNwoEP8qSVFTaLxlSlAH2IvlVc
	 xJ+6AB0JArAH1Zc2yfwOG/YaCiEsmHdPBumzLWLNqBcVJjTu/o94EBY2+BXJbasSSRwJt
	 G4yOzVvAvC4sOEvyPcGQmqRd47aunzsFW2GuhEWFtSozDgQuURO0zh6wB2dCH3d7NraVr
	 5NuZN92oAaVkP0MG75iXCO1UhfA12/e8h90MrQYDj0PprI1WUSYQtlevEw1ff/BK8LQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605694;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=C38BuGd0bfYisxrxsIaUK6a3tH1ZGJCB/km1kK1SgKU=;
	b=Dkpe0VV+L+EXXkudAs7KRHGhqo0MVt4Zw3L/LsjvbHzugvqNlxF7x0OMJ9ru2mnesRRy
	 CtAk4Y3IciBZlKrZM6kxMZdUch5uI1qEIUYIj8VxozwgxGPiBIzUXCNnSCkubThfL20aL
	 HIFfmDSm+bx79oFGdGO+HHu+6SM6fta71MgqI5AWGx8YvL0rP4YmGTYwmHBlTz7CH8h8C
	 rWiNgGyY8PMfid4D7/C8yoPylLR/wrRx6LjRytiekyGGlpWbNrpCVgimiQNR18kiMQTTz
	 HswoceXLCpbtqsxopNgs+CXpIYdy1y3BXHLZhKwxZGKy6y2XwFSBWXSXYv94BLQ7w4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqyqxqea;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C85606A32F;
	Mon,  2 Nov 2026 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lqyqxqea
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793605693;
	b=dkHaFGadM+u2VKAqC5nmhpCRPlkk0oH2HAgdpzGT/Qz4dM83peUdCCzL1YTHypAvlNhX
	 ciC5ayp0bufhu3OA4GwO2JDfgVI0dgWZIrNH2Moy8L9ubxrr4geu/aQzy4ysjhDMlSegF
	 F3eviX4UTBEMF9xxPLDR/FftMtd2i4r5kp2YNi0tIR77iwGm/pDdU70C5eTiWZ3JDY+6d
	 UjRc4ucuFe3pIKR8cu1/Zt8gLoa0aVpeAgKksE0lqtQuSTD3YiXcpY2Kk1EbPIgWF6P2w
	 VMoCEcZ+XSLZifn7YGIlewwjrg+EDgzHrMKheQ+KCANtoOhJ1thonmQ2kj9fewwD/1w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793605693;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=C38BuGd0bfYisxrxsIaUK6a3tH1ZGJCB/km1kK1SgKU=;
	b=xkLSqG2by6xjg19fWSvfU2QbcNCW/utnUBWVx7DLqG6AVGSCcoGDaBRjC2h5dboxh5vv
	 bosWOUTK8Zw0J7KM/wh05gMPJ8T+NbWF84AjOx6My5OYtCHoOKrniKLD+X+C3QQIwmUuB
	 BiSGJm//ijeAxJhhrDqJYhqS6efm+dLmucYJCt/98AiB+KjpUjhq26eZyfGbHkP3P0nmv
	 cf0y1NjRFswiAmhsk2kGclwEZD7aMIUG9k/Lwq1bsDQEWtKoCvM9zAKHL33EhryNCMigX
	 TostTfIGhCIVRn6p7QRawyuFgCDT+Su6/VM/ZZfHSLpTwX9LAnZLWLQW/xWOKpQ2H8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7CD911F00A16;
	Mon,  2 Nov 2026 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793605693;
	bh=C38BuGd0bfYisxrxsIaUK6a3tH1ZGJCB/km1kK1SgKU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=lqyqxqeatC2Gy9pLsSPNQXYiGlKuNG4aRQqnNYy5KEGOOKTPsy8c6LYyamc+ea9Vx
	 lyaUjCyAyFlazVV35MQnXO6UwitDs9+2zfvriYqrfPoIO9dafxUfYbf1EirlsokNoo
	 h/F8FjLzsDb8MqqhnbvNI0IDB4XVqkDRuYSwxIE8CX2ov374ztEzhZiCCgIlRjobtv
	 oCuEkMpIFn+vW+cm68pqafTl2RBgB1WVn0mIYrCCF8qK1KUXTBmUNgyd2ha1wae9kJ
	 fSJehkbqNJ4PWdv2bXvMwaSsMZFou2atRzZnbfsghah3eyb2jy+PxUxxb+VdQk0Gbe
	 Tcwz1HeFFbTAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CC5F2463F4;
	Mon,  2 Nov 2026 07:48:11 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v4 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Mon, 02 Nov 2026 07:48:04 +0000
Message-Id: <20261102-a9-i2c-v4-0-5a169215b8e9@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIADRA6GoC/2WNzQ7CIBAGX6XhLAoL/fPkexgPsG4tiW0NNE2N6
 bsLRhuNx2+ZYR4skHcU2D57ME+TC27o49CbjGFr+gtxd46bgYBC1FJyU3MHyEHrsiIAKirFImx
 NIG696bFNeER2CetpHtPzzVPj5lfneIq7dWEc/P2VnWS6vgugP4VJcsFtZc611UWjTXUw3XW4O
 Nzi0LH0yQSrKAXAKkIUdU4KqZFlbpt/UX2L9SqqKJZWCUQUIlfqV1yW5QkIAJg9LwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793605689; l=1910;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=9OQOd2rrl9WlOLjkuFw/sxdkDaySWYrLQRhEJmJuB6s=;
 b=J0LHiuTQFweKm5XAIdH5d58CBCOophPTriobO2pHaW+S2/jX9DKMXBcO3uotTgSOZHrrGM+KC
 f2yTpYhjnkRCXXUXuYQy0NOgCImKNM/Py62w3WGsMQuZMp3V2Vwexdp
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
 drivers/i2c/busses/i2c-amlogic-a9.c                | 431 +++++++++++++++++++++
 5 files changed, 505 insertions(+)
---
base-commit: 4ec2365c08de306f52650d8736aef5862baedb8d
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



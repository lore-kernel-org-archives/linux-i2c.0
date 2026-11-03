Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793674364;
	b=0Qnkw6TGrZEQKGecsv2xLBHUrZLnGYJkCu8LU28WB5sfhQcVT3F6nVDJKOK4b/z7Nylx
	 DxSKf+8kUQVKgMJ7AJn/oohhI9SJJlYjNhmiFaNqP9ZP1Up7jeN6/CHLED5I3mL1iZUuv
	 /EOzPVh+Nlkw6Qc0C5r9X5YRPH513jM1NwcRwRBQk0nqqANMKr9C5/GTdHgm9ifkIT6lF
	 UdTnTN+1/OgFheAszTTzcOx0ie8ZtbMkmYI1QybAOfiX0leXkEMcnZRkzHb4e/g5T1+yn
	 18MtR/BPAQ99tcW1sGo6XVfov0rB7XRcHyK/0LJYKy5icL+qASCASjEZvjCVBXIeffA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674364;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=7lZGGFM47Y+vesCqWyVDCjfCNRXmTtOZ6DpDFv9Q2ho=;
	b=oonR1jDZFMvoPWTHF5lRixmEvFgAt7kWIHCRPyrVlI0naQL/o7v5ZN5X0LFE1mg3p4xw
	 ACW7UgeVea3EFOc3QVVX699sTYS/F1QQf8afzVUVarECMtTMGpgpnzBKwvxGUuLX3KRTD
	 b5yoVL2L2JqGaKwih5FjbresIVjnlF2l400ILN13E4qXSJ8N4ro/vtfIa7NrLDG58tS2X
	 Olfu4IjnBXCX2R8aY0+s0HOBQ8D3E8n9AMXaODHj5netpcpUeYBfIdIDy7pKTzt3Fe6y3
	 cn9U1d3n+QsPYfeGfeT3dO0CEtBt3GT2UYIe+m7aabb28ERAc/EMDFTOuJiXXx9hbFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvhSP70r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD2606A326;
	Tue,  3 Nov 2026 02:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvhSP70r
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793674363;
	b=qSrePLptl6QhAVf+eqA/sz/7wye+Y8yoAbFrW6fks22TWktD73Kmqu8agAjWNvxcwnEl
	 LyOJiqOCPAh64aUuwSOchFIpl8t7tG6W4t8Mb3JiNt52UQ9bNI59TKfcNLNT6d8JIh3MT
	 w9zJlqJzQ3p1RwYsMRZKzWKTRbQVP5n4Doj+uuG3W99+4wAhLyCaoGbFA+Kb+GSrMEOXa
	 BRc29thSy6EZbw6Gpt1IFSmTQHsOTMpLzlABVxFcD11XwgYxhrsZuyGyX5g2GY5dPbrt/
	 vn0BGsfdH2j/M/wBQr3tWcleeTiysW7vRmYwyoKqFrbJsu0t3Yz7NqSWUAJOBFQ889A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793674363;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=7lZGGFM47Y+vesCqWyVDCjfCNRXmTtOZ6DpDFv9Q2ho=;
	b=gBetH/W5427WGpiDDiJprhuSDllcf/tJuiT7LHDPbPQ0XaJUbvHYz6ipTDp6ItVvj7qM
	 sBoF15Kajmn8lqd+eXvXnhvPFiJWQYILtVW7oDwXyimh5cJayJrFVKzfDfK/qioJ1VvAE
	 eD0AgCJlum1QLVgsElQhJgKiK5sr93E6PFtstRMe0O1RigvOruWb8AbUZJ0Q2mtv/NaGr
	 CyM4t3NrS8pef6U1rclQwWAHSVcoVZlMCWeglVmkrAUU+aHJRHK1ailMCGG+Noz6mm2JN
	 t3PpY9RuAR/02nHKNEH17e6GsVc7sXhwc5kqgz+3ZSYHmER6W7BpGuu/+bZUmptMfkw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A8F1E1F000C1;
	Tue,  3 Nov 2026 02:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674363;
	bh=7lZGGFM47Y+vesCqWyVDCjfCNRXmTtOZ6DpDFv9Q2ho=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=LvhSP70rtb+nmlPhywjZdyZfgyVEprXdhilWqpvHV1bViyJgLK2D3PnRM/f/GSyQ8
	 G+HNacYDlpUCoaiLL66H0IRb8UUmikr7y+aoI4SzDLFJ8SVsuBX+OZJw9szn4vn2lw
	 bIEFgcq/YN9UU9HQAlsG5GWwjK5Dmshjs8kzqm0bIcrAi5/eLBDafdcb8FYzdEikGZ
	 fk3ped3BQavbsVjELpzkPFlFhx8PDHPsXlu+8L7l3P+uWz9NAq9Xk1X+Qn5lL+aw1J
	 yVkaQX4NinV48jP3vq3IprxBtVxxTDLvSbK+GNv273EcHAC91pJhgCavZuU2FK4YlL
	 n9x6dm8OMt90w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B5044672E;
	Tue,  3 Nov 2026 02:52:42 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v5 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Tue, 03 Nov 2026 02:52:36 +0000
Message-Id: <20261103-a9-i2c-v5-0-86f2dcd179d8@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIAHRM6WoC/2XNQW7DIBAF0KtErEsLA9jQVe9RZQGTcYzU2BVEV
 qLId+8QtW6rLP/wH/8mKpVMVbzubqLQkmueJw7uaSdwjNORZD5wFqCgU0FrGYPMgBKs7T0BUOe
 N4HKKlWQqccKx1bny0moTXc7t+bPQkC/3nfc95zHX81yu99lFt+v3AtifhUVLJZOPh5BsN9jo3
 +LpYz5mfMb5JNonC2xQK4ANAkPryCANundpeITmLwwbNAz7ZBQiKuWMeYT2F7LcoGXoou4CaJc
 8hf9wXdcvYY7cfmgBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793674360; l=2121;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=7+M64M86zXRcRp+mwvX7/HRiZidre0O5p+ZpTs5Dazo=;
 b=evoz4ROMlBv7BzBePEzTMgLz6aLHhAzwRqQXGqgAFaenx2tn5l1NLmjYiP1hcCK1tIA0RvDPo
 BrKfkqihec7ClBmyafbmm3JTfxsN6lkfa3ba6hSg/m/yD6tVmEIXXik
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
 drivers/i2c/busses/i2c-amlogic-a9.c                | 431 +++++++++++++++++++++
 5 files changed, 505 insertions(+)
---
base-commit: 4ec2365c08de306f52650d8736aef5862baedb8d
change-id: 20260911-a9-i2c-24478e22e683

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



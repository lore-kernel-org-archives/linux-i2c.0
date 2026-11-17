Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794916744;
	b=CMgeIUO/gtuRQx/y7wRZAIxyabCbDjT2ZtxIWiKl/BZ2EfTYEKJmFTMkuChBoUbVOVGA
	 3xFNx4ISDvl7gPF30cgHzfZf/kaiIX8em+lnknlVTouViVjOOjoeUjRV20gO4ilSrf3vB
	 WZ8OrJifMWFWCE2R/BBXbTkDPJgW2J11HjQP9WjZitBncZiFiT9phXyzyiVZ2aA42to2s
	 6RKPLTDPLaHhkekXjz9P3+p9gXcvAn+AN+m16c/UVdz+tPfDIEMnaUfKAB2ICt2Nw2z6C
	 dNeNGC2dokwfu630GnU0KlJ8lK89XWYryPQomx19vIH5nbjy4FENEjY0LUWXOmGCWWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916744;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Zo+p/MUo5NSeHN6m+APY1ECpjqUQAyFEWeMPmWJJiYs=;
	b=uPg8dJe0lk8xcAOLgQzUUz/Qajh/aWkQSNoYzQyz1Ypzymfm6R/CESEElpuEi7J+JYqK
	 ZeFl8Ndr/c8EgY7VkbUMritDW7oOtGpA7oUOM6O16F7Vl5G0EdRQo4mQYOl4mFi/QnHQv
	 +G4fISt2vtNjMITzpl+B4DtZC6vy1FSiXVHmzYzp1BXN4zZBAtmzzAsIPfDe6VbNae9+d
	 yr4L0sC4JVocBJCzPWr0Ffmq80Vlcvv2s5RZu98d/r2490NM4f0+AEvX44PGSvNPQJBxT
	 ouY2p9fNsfhS67mBCUlmAgr0WCe3B9Zt0J2Xh8FLO5Ry9ATPiVKKx4ravABlu2Kpucg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2OVeSKI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152A0606A32C;
	Tue, 17 Nov 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U2OVeSKI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794916743;
	b=ky/JB+Xm08vR9pIHBF5U9OpkqSG/pEM5t06Wd2yhYA1WURmo7qHSchhR8nAnODm5nLVG
	 O22X0TQq+6/cvudo4cQCDPHDmOH686JQ8+zNzLz3aXmrk1aim5s6XW4bRgHXTKLuod2Fm
	 i1YbhYCqdreab0k5RzyWrdrLaXM5dARw4Fn3p0kvHVdrmQ7Ng38inBRXu1u25q/mcPtYI
	 pioxYfE6dMFKDOw7h8Z17LOL5i/R+ur8/HihT4rszq5IO1hMYbs1dkFTx5LPPCTQlR/AC
	 nkxuPNFwrBO+yEiENY6WGcimijbi6cKRGq71lOSEt0/OSlglouHnW1iQSJRgNilYOjA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794916743;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Zo+p/MUo5NSeHN6m+APY1ECpjqUQAyFEWeMPmWJJiYs=;
	b=LEgXz5KTp4LUdY4aQp1Z0vCVuHJUwtdh8bjIK+fBSSEiIIRO/rN9y+/tPZprxXOdJ5Dn
	 0YQwA1DLxyxPU1UTbwEaxFLXFQL6BV0z72Gt7uiMwRYLMCcr2WTCL/l+mcS4LCCOH1Cb4
	 N2WyZMP1WT7X8oMO/41t6OfGR+NFfFya/4ilgF4B5idbmCsQ04NYHM7enwYmoo12i6Zhc
	 NkM9bK23hY8QbJ7pUMD6IBc7C51eJH1k+HilAc2+l+LiPwIGD3kCp8SLMAOsMR2Q1zBxp
	 lG9leold9nuJ8KC2dhJi08XqZQ3LlZOul0CF5glI0d/dySWpt1bMJxNLtwIdBfnOOvA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CACD01F000C4;
	Tue, 17 Nov 2026 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794916743;
	bh=Zo+p/MUo5NSeHN6m+APY1ECpjqUQAyFEWeMPmWJJiYs=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=U2OVeSKIX79GzpUPfnlka1LAR+VYdHp2YXKu16BU8DRnu5c6ikbGxFK+6IsoxVBvj
	 6u+dNkNAGXTdUcAWk6hu5yLkyXyLKyl0w19eJIxhI2EmoSbCZD3Fvg8pvUWDlYta0E
	 TF0C53LR2N7SHehfoS4yneVWWAa7IsRPGJZ0/qjnMFa8Il5hMnbpGybLCbNH0FpDxF
	 pk5K2AqhrehXOcgGaT9T/0PVxx9g9mTGbQO4L7FruySu+DENKqulb/CTIG39CmuY/1
	 PlwbUGZzJxoEDdSuO8oTmlYFNgkeK9rlC3MWxc/UB/Cqtdb0X+Zhx/JVYl1hyYY7ds
	 ZS2MZZIjZ4fvA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2E22B4A949;
	Tue, 17 Nov 2026 11:59:02 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v10 0/2] i2c: Add driver support Amlogic A9 I2C
Date: Tue, 17 Nov 2026 11:58:55 +0000
Message-Id: <20261117-a9-i2c-v10-0-33ea9aefce20@amlogic.com>
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
X-B4-Tracking: v=1; b=H4sIAIBB/GoC/23QTW7DIBAF4KtUrOuWGf676j2qLgAPCVJjV3Zkp
 Ypy90KUElfOkuF9PDFnNtOUaWZvT2c20ZLnPA7lAPz5icW9H3bU5b4MGHLU3AF03nUZY4dSGku
 IpK1gJRz8TF2Y/BD3NV4irzU20OlYr78nSvl0Lfr4LOd9no/j9HPtXaBObw0o/xoW6HgXrO9dk
 DpJb9/94Wvc5fgSxwOrjyzYIHDEBrFAqUhESmBUSFso1tA1KAo0QfAYI+dKiC2Ud1hkg7JA5UE
 7BBUsuS1UaygaVAVanbCPPRjXP/ijXsP7cnRdjvcaDCTU6QE0j6GpUBQUlEg+yS20Kwi8QVsgk
 OtRW0xWhy10a2gadLetimidTOT/w8vl8gvZx5nnhgIAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794916741; l=3217;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=pKrAL+T0Zub2OESC9RtL1tJC+rFDKjL1TpuiSeE9tzY=;
 b=WWrwJsfDZQakxXbLVi5ffb2e3TaxTll09uL7DBWz8huvgNv8C20D+GutAEDc8TmhKkHNIeyjd
 +ReY97cpu/PBYfexaaTZvGyLspf7PNQrgmC/5MRppJv+VWgKvxVDcBN
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
Changes in v10:
- Use guardinlock, drop extra curly braces, and add another auther, according to Markus's suggestions.
- s/Device Tree/device tree in binding msg and cover-letter msg, according to Markus's suggestions.
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



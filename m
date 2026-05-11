Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5573A33F5BA;
	Mon, 11 May 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516045; cv=none; b=s37YfYu+g1RLHd8REN7xZYOIhb9ENINe9K34AvAI9J7Ikn0ibkBoBl+H3Cu2aV+tzrW2MFJ7y6wyxjYcD3CVNywwe2iAVaZlSj+yx+1b1MFUk93jgJgKxiIR2fvtS5mUv9skDULzp2DYACDWEerEUFxl8pvzi9qMRIrla3MUE0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516045; c=relaxed/simple;
	bh=7nt21aNMTJpuJlpguGqIOYAwrloi/bl0w0j5O9gTepA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UFXimIUqIFhZG8XDbgKPNEpHDx5OGuX+LSzqYvCih5aXzBUXILZ8yf0BiGf8F0TMijGU16rOe1dlH7szwZhVaZ6u7pN4kRZgvHJIds2ZvxlSkA9DEQKywuPAezj9bTCXyMCjdOuuoXhVd2nWpB5YagWPF/4RLC19dvHlS98w6Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oRjV4ndS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oRjV4ndS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DC8E44E42BF3;
	Mon, 11 May 2026 16:14:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA38660646;
	Mon, 11 May 2026 16:14:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2558D11AF9D4C;
	Mon, 11 May 2026 18:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778516041; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=T3GOq63elP1UWSpyefvFT2JqWkwwxc+A1uBIRaXMwPQ=;
	b=oRjV4ndSGQ/HwCdfD0+CPHujeQDdEWKpPnrupZXJ/iihIw2YP4Vp509zSDj4rf5AOn++iv
	Vb3gulbtin1ay556GyyB98HqfWhzh+wpfcMvh2jzNZ6bNvYNkk+wED/j7abcYi10qdnE6y
	oXuhk/dseWMwHC7+0NVmvrsQwH+JEPIAVHYju86Vzi5GJNCOb5ZZSsI7ur+IDPny+yEuC2
	xJoM26RI++ioChJm3zWK4DMXOPXXSKr+CTo451A4G0oaotdNZac13cA8NIu5mTiJJG+7BA
	91cb3QHRAc62Y0U/a3t6dvY8e9MFt1FMm/0kvfxcXHPuttLUOp2yCw5FVEnKhQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v7 0/1] lan966x pci device: Add support for SFPs, I2C dependency part
Date: Mon, 11 May 2026 18:13:48 +0200
Message-ID: <20260511161355.35656-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Previously, I sent a big picture series adding support for SFP ports
available on the LAN966x PCI device [0].

In this series patches touch several parts and sub-system in the kernel.
Reviews have be done and it makes sense to split the series and send
parts separately.

This current series is the extraction of a patch related to an I2C build
dependency issues.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Best regards,
Hervé

Changes:

v6 -> v7

  Rebase on top v7.1-rc1

  - Patch 1
    No changes

Older iterations:
  Patches 19 in the big picture series
  https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Herve Codina (1):
  i2c: busses: at91: Add MCHP_LAN966X_PCI dependency

 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.54.0


Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A8423170;
	Mon, 11 May 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515297; cv=none; b=lto9GcChOrP3k7akbIgOQYDfRUET46QBvZU01B9BQdxRTBy7GPonk1Kn4vC6cTJmE7K4cbiFcs1dpVhaUFcfdz6QsYrWd0OAFKbNqa0tLNo+0oaPEqVT0tA4yJXg2UFrgTkEaNwV3CGLGuovxNdCuEEUju3m2wLSPdxar6/eRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515297; c=relaxed/simple;
	bh=ZaR3Okq+2s2Np8wkDtpHrIEgdLLFYTA6sznZ81NREBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KRFkWrO40eYzTw5Z7ZapoJm0TvDLDhNBbVjhdUJd4JQsWcPPgvzwfWyU3EImkOW381i5yOvrfq1cNpwxPz2vQbQC3wAP1L+aBhYvRLIpugwz7F5tbb6JJXDnpAZHZB8XAx2O2DFCvQ3rNNBw3mmO72SWr1r4pybuFD/VKoOxN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RC/YdEmk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RC/YdEmk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A78D2C5E14B;
	Mon, 11 May 2026 16:02:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BB6060646;
	Mon, 11 May 2026 16:01:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C91E11AF9F2F;
	Mon, 11 May 2026 18:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515294; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=8wwnEr4E6ErCNBSatPbGyq4FU6v9HeDDxzhNKNaPjNw=;
	b=RC/YdEmkK8CNUv5180Ed0i9zqHhT+wDZ1L7ccXYbBZLCOOelMMMP4bk5OGta25uEIiIqbm
	fGcQzSRC7Ukdn4v2SNdkUJGWYRs7pw7lxQE9eKRl24Y5i310J6Jh9I330hxrVWxuS17jYa
	Ehm3pEecff4GDDrNbP8QqyGtGK5cCWECaBHPGNWKag+pcNt5iPu/aizNGTJ/LdQtxhA6+9
	Ozw8dLV0sQTrANlJwpWtgakHycj48s6vWNSD2Ixa/m8hklIisfAYeutUmDm/8vw7YBnjSe
	JDSqtImluRey6Jyr8E/7ZygyybvxsKszn2H2QXe/Dq4eR5ohyQCbrMIihauhsQ==
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
Subject: [PATCH v7 0/1] lan966x pci device: Add support for SFPs, clock dependency part
Date: Mon, 11 May 2026 18:01:26 +0200
Message-ID: <20260511160128.34786-1-herve.codina@bootlin.com>
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

This current series is the extraction of a patch related to a clock
build dependency issues.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Best regards,
Hervé

Changes:

v6 -> v7

  Rebase on top v7.1-rc1

  - Patch 1
    No changes

Older iterations:
  Patches 18 in the big picture series
  https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Herve Codina (1):
  clk: lan966x: Add MCHP_LAN966X_PCI dependency

 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.54.0


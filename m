Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800438;
	b=Qijv/nBgYyhy2pe5mA8a6XPKS8hL8UHyemFB4YWwkRm2wR9q2XL2wPo9M61GfW7CTL5A
	 WCM13nhm+dMydJgL/hTA4cK2rLZZPyg9GHzTPc2z2X4g2W69GT0faKYOCi4O1cwklAyK3
	 KOtVMOwJ+jgQoPWkx0YUfyANyg9JmGqiSscG8tz+lZ4qBN1Hha+owTtS87d3rxmnaar8D
	 64nEExqO0GfrJ4sk4TEoZEoAj8DrUeIrOWfLDf8CvYdzmIksFTJvrVrIHBKJPJ+gHKILl
	 lPhp4Uu0w/5plo5B5Z4sY4fkQPn7kha4C+DvoSBcB5qvS+lfsO9H5XkOn1zxMPhXkrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800438;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=kP9j29kM+rCzY1MReOn+pCL5N9M2SphRjgtOq9THpLM=;
	b=lNfJuhP40dHrGvuNy3gcA50Wt+UinIvhsioUU34YrZ3ZV1gQ24+YhCHmwNTIBzGzfkbG
	 6kRsBK/z3rXGQ5XsofWk6qhmgKQxl8inWYuQ/Q11oIVTRbjUAGn/55WCZv9zXGa0pjtyQ
	 2oquALJqapYXO70mZTYJqYlHX0ZS2RHeLcGfvPwQxSlqTQkIyQz59xf6eAN7yl1eeHwQl
	 nC1Y815/Mrm/+d7tBNww6R6e4sjfEmd8YggAik+KJSds0aHoE9HJ01aa6WzjsLqDnoGD1
	 X/LMrYUALomPRCYL8vP975n1be5XY6B9/jlpYqEuTDITLc8wqMJU77plwFU1C1h7wJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TocLECKi;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3905606A330
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 13:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3905606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TocLECKi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 46CDA4E413FD;
	Wed,  4 Nov 2026 13:53:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1948C60770;
	Wed,  4 Nov 2026 13:53:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A700103291D1;
	Wed,  4 Nov 2026 14:53:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793800428; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kP9j29kM+rCzY1MReOn+pCL5N9M2SphRjgtOq9THpLM=;
	b=TocLECKi5w3ZWSsOQZzfb7u86ThtISJ39nM8FrzN4dvs7s9ZIiME/BfDjz+4QKmKMtaejq
	N90VyWYTQFU4nhVD9LpclWt/fap9zHfwwvXORqUoCUNinJVvXqj2YRo4ySfYYgHwbDZrBy
	TVR6OmEiJIHPZXlocTOFCOOB65cj/E5kvHL37UpovJHmA6IcVIQp1UF8yGwh/NS91BZDJb
	UOL4o9fEOUT+IgP4Oz+LPzOhCiUEFbKVl66fX22laZw++NnabPvaBHWmsKVtRA+NI0LggH
	11bLfujlDdfLOG0JRzURLgS1mpIgp0fAzw1miZbYX/0z848FEH0f+2YUo3oxpw==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v9 0/3] lan966x pci device: Add support for SFPs, i2c part
Date: Wed,  4 Nov 2026 14:53:03 +0100
Message-ID: <20261104135324.492692-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
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

This current series is the extraction of patches related to issues in
the I2C subsystem. It has to be seen as a continuation of the big
picture series but related to this specific I2C part.

Those patches are related fw_delink issues specific to I2C muxes and
atrs.

They purpose is to correctly set a link between an adapter supplier and
its consumer. Indeed, an i2c mux/atr adapter's parent is not the i2c
mux/atr supplier but the adapter the i2c mux/atr is connected to. Adding
a new link between the adapter supplier involved when i2c muxes/atrs are
used avoid a freeze observed during device removal.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Compared to the previous iteration, this v9 iteration updates i2c-atr.c
with the same modification done in i2c-mux.c. Indeed, atr and mux are
pretty similar and the exact same modifications for the exact same
reason can be done in both files (reported in v8 by Peter Rosin).

If having both atr and mux modifications in one commits is not
acceptable, let me know and I will split them in different commits.

Worth noting that I tested modifications done in mux but not in atr.
Indeed, I don't have any atr devices on the different board I have to
perform a test.

Best regards,
Hervé

Changes:

v8 -> v9
  v8: https://lore.kernel.org/all/20260630103010.413688-1-herve.codina@bootlin.com/
  Rebase on top of v7.4-rc1

  Patches 2 and 3
  - Add same modifications in i2c-atr.c than the ones done in i2c-mux.c.
  - Update commit logs accordingly.

v7 -> v8
  v7: https://lore.kernel.org/all/20260605083158.28ac874f@bootlin.com/

  Rebase on top of v7.2-rc1
  No other changes

v6 -> v7

  Rebase on top of v7.1-rc1

  - Patch 1, 2 and 3
    No changes

Older iterations:
  Patches 14, 15 and 16in the big picture series
  https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Herve Codina (3):
  i2c: core: Introduce i2c_get_adapter_physdev()
  i2c: {mux,atr}: Set adapter physical device
  i2c: {mux,atr}: Create missing devlink between mux/atr and adapter
    physical device

 drivers/i2c/i2c-atr.c       | 26 ++++++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c | 16 ++++++++++++++++
 drivers/i2c/i2c-mux.c       | 26 ++++++++++++++++++++++++++
 include/linux/i2c.h         |  3 +++
 4 files changed, 71 insertions(+)

-- 
2.56.0


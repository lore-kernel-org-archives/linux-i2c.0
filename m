Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0B3F4DDC
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815419; cv=none; b=pg03n/DrVA9KBmAkktte6D4c0fGQWGIw4A2ZqamxpzYG4DSm5iNn2pYUUxTKpR957YU3NfFeLt+ki1w+0+oeQHiNjG9uaySQHQs6BR4bI485jD9fIEbKutTa/+xpmrb+WIOfeqzOagCniIuOEH0BTwhw3xgPn4ChFyuE6D6URD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815419; c=relaxed/simple;
	bh=j17tz5zzx0lcKqL2EVMtBzWIPISz/TX1FmaRTa6q4FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A50zDdLKOYCu+GI5U3zTZOszvQg+60pQM5zt9+6RFMcW8R/P9Fj3y8DJqSLllQUlVz2QLj80M6rcQlJgjmbOX6cIFWh2fiKGtKLnHW5vwMdYVR6Kj5OtyLyLCuV5NmZ2DDZg8bNsJncA2WnRtmrLJzRkztVkmDXGbrRWYskpZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wjVoJdXs; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wjVoJdXs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AC82EC5CD47;
	Tue, 30 Jun 2026 10:30:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 392926025A;
	Tue, 30 Jun 2026 10:30:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B6E9106F1D67;
	Tue, 30 Jun 2026 12:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782815416; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=odBvXjmVyDnxNyTBT7valtr+fSYPWjjzW6dvgNXKweU=;
	b=wjVoJdXsHUZGajpOeyKW+I5lOX8icoSQEMpdnrQbaZKE4vh2ztN5plIKfgrB41NwHGieiL
	vB96EclQvIyq7mNjlhcIHIpCwOcXSVCXaLuHtN3zSy46W+VcwpAAYGtnVnGrUdiAl6F3KS
	OIRHcD5gC0cwOEbqSazE0RIGBkUX9Tnrs8vZ6r4+n+K63qEi35avU6CRp330Ct3TJ8SXw8
	FGegTTJIdj8Gdvwy/+EvAqmTGisRrwYT59E103jR4lbIsEl31f5bcPRYvVomYLd0eyZ+mq
	avEnNnqpcHcCdU/esAvccSGDeqPtZroHwx+ueoXDDMi3ycnMHu/m74h71bvTSA==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v8 0/3] lan966x pci device: Add support for SFPs, i2c part
Date: Tue, 30 Jun 2026 12:30:05 +0200
Message-ID: <20260630103010.413688-1-herve.codina@bootlin.com>
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

This current series is the extraction of patches related to issues in
the I2C subsystem. It has to be seen as a continuation of the big
picture series but related to this specific I2C part.

Those patches are related fw_delink issues specific to I2C muxes.

They purpose is to correctly set a link between an adapter supplier and
its consumer. Indeed, an i2c mux adapter's parent is not the i2c mux
supplier but the adapter the i2c mux is connected to. Adding a new link
between the adapter supplier involved when i2c muxes are used avoid a
freeze observed during device removal.

[0] https://lore.kernel.org/all/20260325143555.451852-1-herve.codina@bootlin.com/

Best regards,
Hervé

Changes:

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
  i2c: mux: Set adapter physical device
  i2c: mux: Create missing devlink between mux and adapter physical
    device

 drivers/i2c/i2c-core-base.c | 16 ++++++++++++++++
 drivers/i2c/i2c-mux.c       | 26 ++++++++++++++++++++++++++
 include/linux/i2c.h         |  3 +++
 3 files changed, 45 insertions(+)

-- 
2.54.0


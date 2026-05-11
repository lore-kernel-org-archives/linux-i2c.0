Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9654218B7
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515264; cv=none; b=jrR+GzeBQOdP/0ZOz2h7uDVHPvJbgCRRfeERkWTItqO7Igo6Ygj1n4639SaiG9i6NeG3r+tzZRXgl1jYPE1p+nrRh8QzCGeOVZpq37ElOjyK8Hhc69KY+auALy8zBX0YpWas5GTThdCvWx42s85gUV29aB/KVJ6SFq3WidCc7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515264; c=relaxed/simple;
	bh=vwKchaJOLpUSIYPQP5Php/ru16y3qz5lSqYXe0H8VNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FzL058e8obOYxKttw0BdU837kwj3ndm4GvSsAGrummKBf4aZXXg5eo3hLOAPhSCIEiSAlM3znopJrM96WB6dtc3YqE8suEJYrVtXEWuusfgcZp43guobq6dV2TbLKc5dkSrPgRTH8dPnUVoOnOH0qtsijExkAS4czJPMiY+bnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k2NWqkOy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k2NWqkOy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6A95C4E42BF3;
	Mon, 11 May 2026 16:01:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3EE5860646;
	Mon, 11 May 2026 16:01:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2C6C11AF9F27;
	Mon, 11 May 2026 18:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=5vAnkU/dk/z0DRNCeqTmyQePsDtc5wmXL6T7EzS8jrA=;
	b=k2NWqkOy03H+eZRr/QLF3yPNF+DtyG9Fx1ely9vzQHZEJY0igkLLX77G4o4R8qQXeM7zCG
	DLrIf64unTGsrSIHCy3oJrIktDHW6iGK6N+Z2zrIhed5arciMyYrkCxL5/qYDxiZ+MN9r2
	d+ccUBjmVZXngoTaqUuhrMmp7afhvWjE4TK6JyagXIgj4QahSmCyLqyzNc9kXCGVAPbuJ5
	pzhMnFa2TbUwSjmgrbPCMaszvpsiDgDbybwApFM6Kv/5iV/lZ73VsZQkasKJ9x+Hxde55x
	qG6iXzKbjKPZM8RliGYWVckeaNqnPP0KX721SrTMdUBIn4cSzyxFAEgv7hMf7A==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
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
Subject: [PATCH v7 0/3] lan966x pci device: Add support for SFPs, i2c part
Date: Mon, 11 May 2026 18:00:47 +0200
Message-ID: <20260511160051.34700-1-herve.codina@bootlin.com>
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

v6 -> v7

  Rebase on top v7.1-rc1

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


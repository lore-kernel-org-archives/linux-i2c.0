Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009191;
	b=TwrxPPPDEwRs6Y+uUVNhHyzO0Y/gqEI+E+XWlytn4dyFpeoY6R5mGviBmGfwMBciVfT4
	 mM92oZgjAkO2KX++PuYYWzJU1c7q6Y0525MuJ1KpARor1D4RRTlOePEfZ744mgXewT8q9
	 FQR0XxaUP0svRJgERHIdloAh8AeWydPeRgRduXRolnGMSUDVnynfyj0jRCcDet4bM6pji
	 xng01EtsLFC6WhRJMvuc/4/npleJmRCVtzaNb/l8dUcU+0lBseuWR80rPcvULSlrxqygA
	 qdedz8Zl/oGUeV0ez0G5iWCbIzlK2nzDcVHxL9MkCVAg+mrLpjuExQQPRe6TohS5EKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009191;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=n/xNnljAIoTpSIonTUtPSuIAXIf9DvOLWxzsuQnFSHo=;
	b=Ht+YUcPKRdIVm4k+3sp2BO/FUzDGAyybd7ONWlTWpIFrQuVOKKIm8IrVhkSs2MRSFW8u
	 nWiY0Th8gp9pbqNDid12tBc1KA3QSOK1RdmNyaYSv89nsl8iuqKYs5QXtCYISC69Cz4I9
	 eCV2NSonDXnLKOKKF+zVJCxi0tSZmC3zLiBYposTzCK7l0T0Uoec7XHCn51wH9ZjSYzzT
	 wSL0vQ6ug7V0YCfrv5XrtawK9JkZAuvJPtTW6MCngRA2m9dsQ3vmq7YssdNgT7WKg6z/M
	 /T/r43MdlIFnEZxqAxOUMiRnGtJouaR7RbOEi+hQhBdmvqQl5hJJKO1+1esLHYE/hFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YkjZItOj;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E2606A31C
	for <linux-i2c@vger.kernel.org>; Wed, 18 Nov 2026 13:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91E2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YkjZItOj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AF26F1A16D9;
	Wed, 18 Nov 2026 13:39:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7CCD45FE9B;
	Wed, 18 Nov 2026 13:39:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9EBE311BC2086;
	Wed, 18 Nov 2026 14:39:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795009183; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=n/xNnljAIoTpSIonTUtPSuIAXIf9DvOLWxzsuQnFSHo=;
	b=YkjZItOjnKrvUNQqGwfyVQDndORZx7f2ZBPqGS+E23ES7+QUG3XwwROwBKolYxAvgMNi3I
	yAXrUFn91oCVAqdkEKuVcfoo0hRBi0eRPaynPINZgJNHxgcqIR5LHt3lX0ycBFx7r4C+UY
	IGkmqueyDXyO8N8GEB6TFUvhd0KZW1mebwpVOYP5xNtKgraNT4sG37sUZYLTIKUhqZy+eP
	ITDLhrf2bxGY27yx7umEFIkOIBMmaLVjax8tGT0rHzfqgPgpCbXH1WFWlxeze1zBqJd8t+
	7/pMmlWphALzrrRe3rmrwScJ96FnwJh62qp2XvYfZWyLHm5w1LruFdazQfRKzg==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v10 0/6] lan966x pci device: Add support for SFPs, i2c part
Date: Wed, 18 Nov 2026 14:39:09 +0100
Message-ID: <20261118133927.366482-1-herve.codina@bootlin.com>
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

During the previous iteration, Sashiko reported some issues [1]. This
new iteration takes them into account.

Also, previously, modification done on muxes and atrs were done in the
same patch. This new iteration split them in several patches. Even if
modification are similar, commit logs are not. For instance, serializer
and deserializer related to issues reported by Sashiko are present in
atrs but not muxes. With that in mind, having specific commits for muxes
and atr makes sense.

[1] https://sashiko.dev/#/patchset/20261104135324.492692-1-herve.codina%40bootlin.com

Still worth noting that I tested modifications done in mux but not in
atr. Indeed, I don't have any atr devices on the different boards I have
to perform a test.

Best regards,
Hervé

Changes:

v9 -> v10
  v9: https://lore.kernel.org/all/20261104135324.492692-1-herve.codina@bootlin.com/
  Sashiko's review: https://sashiko.dev/#/patchset/20261104135324.492692-1-herve.codina%40bootlin.com

  Patch 1 (new patch in v10)
  - Update rtl2832 driver to pass &client->dev instead of &i2c->dev
    (issue reported by Sashiko).

  Patch 2 (patch 1 in v9)
  No change

  Patch 3 (patch 2 in v9)
  - Split v9 patch 2 (mux part)
  - No specific mux change
  - Keep 'Reviewed-by: Andy' tag

  Patch 4 (patch 3 in v9)
  - Split v9 patch 3 (mux part)
  - Handle issues reported by Shashiko (possible NULL parent_physdev,
    possible parent_physdev == mux->dev)
  - Handle DVB bridges issue reported by Sashiko (client->dev.driver
    NULL pointer dereference). Fix it avoiding the link creation when
    the consumer is an i2c client attached to the same adapter as the
    supplier.

  Patch 5 (patch 2 in v9)
  - Split v9 patch 2 (atr part)
  - Use desc->parent for chan->adap.physdev (serializer/deserializer
    issue reported by Sashiko).

  Patch 6 (patch 3 in v9)
  - Split patch 3 (atr part)
  - Use desc->parent for the devlink consumer (reported by Sashiko)
  - Avoid a dangling pointer in atr->adapter[chan_id] (reported by
    Sashiko)
  - Take into account possible NULL parent_physdev (idem mux)
  - Take into account the parent_physdev == desc->parent case (idem
    mux).
  - Avoid link creation when the consumer is an i2c client attached to
    the same adapter as the supplier (idem mux).

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

Herve Codina (6):
  media: rtl2832: Use I2C client device as mux device
  i2c: core: Introduce i2c_get_adapter_physdev()
  i2c: mux: Set adapter physical device
  i2c: mux: Create missing devlink between mux and adapter physical
    device
  i2c: atr: Set adapter physical device
  i2c: atr: Create missing devlink between ATR and adapter physical
    device

 drivers/i2c/i2c-atr.c                 | 47 +++++++++++++++++++++++++++
 drivers/i2c/i2c-core-base.c           | 16 +++++++++
 drivers/i2c/i2c-mux.c                 | 45 +++++++++++++++++++++++++
 drivers/media/dvb-frontends/rtl2832.c |  2 +-
 include/linux/i2c.h                   |  3 ++
 5 files changed, 112 insertions(+), 1 deletion(-)

-- 
2.56.0


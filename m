Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA043F5BD4
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815425; cv=none; b=E+gzbVu1dBWE+rgGxTYI1QN0RCNcQDwPtS1qUvWbYMPYwXshMsCIntlybPYfJQJEbKARpS7yYNrQzq4Zh2mI+qVWiFeU00ufhrj+O7R6L2kyPbWsGxaALr5U2DJMx/6619q+nDCOTChssHGRLZuS+FYYAqv/u3TQNvGlOehZ+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815425; c=relaxed/simple;
	bh=AWzsAlFki5r8/Nzxjbdv5ewKshsRLiRR79F5oNS5n7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdabMLzRNFVZzMCsOdDEalw876NqMjYFX2L2c1VTKJRgoIR5mtzb/timD+xLXhscth7baLojOE0LTm9n6N1TSQ9LWs0s60ZnggI9Wn1iuh6XUFtGkW3+va+YqvAxv183fXO6M2+xKltkzJmyrZwladwsOL2tSmsZr2Amch/8iRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0kwSD4uz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0kwSD4uz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 03A4CC5CD4B;
	Tue, 30 Jun 2026 10:30:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 852E06025A;
	Tue, 30 Jun 2026 10:30:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 24870106F1D9C;
	Tue, 30 Jun 2026 12:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782815421; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qeSVgRzzcRZSwyW0NgN4yrI69j7Xls5GCIYU5hWpnG0=;
	b=0kwSD4uzaPNCSXNMLCbMkn9EJckUje7Guj75dVfQOzjdBUyhGUpxN3ZbcRTz4UMq478fjj
	sss0tteqnAGwdqv2a4RankC3eTpPVbJYDSuuM3lcU+29uldTlCvoSt/dqgjl09qDrXcCWu
	7LtqpmeOj1PodAaOwZeTuYNah9AQ43uxlA+7iu/57QZ8VKUj6XJheH9apz3+Om6UdTs7tK
	WLj4m6sp8v9jsHzv5wm6Dbcyyi5/g2NAp7vKGs78z94GSqEHfpgiD1enA5EjFsDCnPSE1Q
	LyIn2FCvJtKEMigkLGx4leYIH/+N2Fa9B0oHueackUOcRKWT38XxVRLlwbVJMw==
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
Subject: [PATCH v8 2/3] i2c: mux: Set adapter physical device
Date: Tue, 30 Jun 2026 12:30:07 +0200
Message-ID: <20260630103010.413688-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630103010.413688-1-herve.codina@bootlin.com>
References: <20260630103010.413688-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

For i2c muxes, the parent of the mux adapter device is the adapter
device the mux is connected to.

This parent is not the physical device related to the mux adapter.
Indeed, the physical device of the mux adapter is the mux device itself.

Fill the adap.physdev with the mux device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/i2c-mux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
index 681a201c239b..f4e73e7a0e33 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -315,6 +315,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
+	priv->adap.physdev = muxc->dev;
 	priv->adap.retries = parent->retries;
 	priv->adap.timeout = parent->timeout;
 	priv->adap.quirks = parent->quirks;
-- 
2.54.0


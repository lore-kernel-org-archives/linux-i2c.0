Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009257;
	b=Zhoy35QHLhohlze4y6NDv7EXMbNcV1xdOE2jprHgIfITvgaiMUUjamwZQ6RRB3jC5tPw
	 VYdgaHQ27UkFCeGeDNJxqj4HkN70/tgkaO5Ntlib9euExV9f/mZgveErDpSUWQQiCNceH
	 PoIYWaE1CedZRBOaZ/YTVYRhmtEIfH6kyufwoIVcutgirgtzsQzr9JwxYrhlE62Y8QJ0W
	 BfWjaPzLqRB7pAkRUtZ+3UGfqFP1R1m2kLyNePtmur2feG54RDU8JzAUMinAR4wNO8Mop
	 Tc7RREOov1PfrHxFfbvIRFbaXY3ZqzmgTr2mTgjDLxjEG3iKF/CGAQ9rbDR9xcPfJzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009257;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=pRFhJrtEbA59+P0bhkwyJkntkOBG5jIZd//e6sEb3E8=;
	b=WMfYvsoZXekEQn82sVUNa47v3HE+7gxEpW3ouNTf6WCRXu8XWDKcBuIbs1a2NwOU9n+Y
	 SKD4N7SFCzsOP6BpbQ7d5JYEtm34VNbVFaR2c0ZrwKb8zOY199Hp5iS+W2iosnBpeDCYt
	 fyNCMPPi26hdGFXdDkA31NXFM6WGtc88ka1T+FX+FAi1UTmfv5p4v05sksjqlgRZOaORn
	 NqxZHq2+SOvJ0DrZn4ITGB/edLPEWcwSUPztrfeZeTidm6P3XHAsmnz+VQKYXE5ZqEjU/
	 1r0YSI1nQmRYCL5VnZzka8i2gJ9P7vIXZttu7bsSlTiO3cIJe23ZAoR8Wi847X9sQ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="n2b/RoMi";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC87606A330;
	Wed, 18 Nov 2026 13:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC87606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=n2b/RoMi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BFB05C4CBD9;
	Wed, 18 Nov 2026 13:40:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E9EF95FE9B;
	Wed, 18 Nov 2026 13:40:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4203311BC20A4;
	Wed, 18 Nov 2026 14:40:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795009253; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pRFhJrtEbA59+P0bhkwyJkntkOBG5jIZd//e6sEb3E8=;
	b=n2b/RoMi+zWPV5m4nL+jX1iPgew2lcTUyn0JEzlkKu2L/STPHkUk9FFe03luMk9Sjf5zuS
	O1DTsZU81hqCdCHgsOe6qVFxYKJIW+LGIkDyIeW19frNO8QjJS28WrxlSppuu4hV0+qQoh
	+eEuxMiMMHLzeNehvO2uL1/GJ7qupFWaTMDrZdKwnnY2EjtF5drlNF/s+BEDx+OfDE28CK
	ZuHMNSAGkdIJBEvYOULsYyrxH7MfJRX0DBGrYLj5eSrwFPQ+dKMCINLfAjLmPhW9LjqYhX
	iIOqV/82X4c39SV8vj0MpTP85HVZE/fqTWSbjFrjzsdQJ4SpxmxWRxhKO/VWgw==
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
Subject: [PATCH v10 3/6] i2c: mux: Set adapter physical device
Date: Wed, 18 Nov 2026 14:39:12 +0100
Message-ID: <20261118133927.366482-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118133927.366482-1-herve.codina@bootlin.com>
References: <20261118133927.366482-1-herve.codina@bootlin.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
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
index 53428098ddc7..c1836114ef56 100644
--- a/drivers/i2c/i2c-mux.c
+++ b/drivers/i2c/i2c-mux.c
@@ -361,6 +361,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
 	priv->adap.algo = &priv->algo;
 	priv->adap.algo_data = priv;
 	priv->adap.dev.parent = &parent->dev;
+	priv->adap.physdev = muxc->dev;
 	priv->adap.retries = parent->retries;
 	priv->adap.timeout = parent->timeout;
 	priv->adap.quirks = parent->quirks;
-- 
2.56.0


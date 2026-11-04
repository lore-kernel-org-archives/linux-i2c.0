Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793800450;
	b=SYKXWBXU1bb1DSrC4cYZwEFkBrQHeBGH6xSBF4vCbb8v3wE9AyuVzv4sEUpqJrzltM+H
	 YccGd2Ohl9freS6Lo6rhExvJXVxR26TAGGujlvh/j8OlvsihW3H/2UJekpfZjdVhY5SP4
	 u4DRC9onmvZj2JJKrL+GlaRfEgTXjstVJ7ycObHQGsXI/lnY4Dy7cEvKT+4yKsUHhzIJZ
	 z8NtuL5e8wzJ4sMX4oHLUDACAVchio5cuMvdduVS7hmt1+AahMZ+hYXxUQPj/xaMfqJW4
	 BeLz4oO9MICslnewWhmDCluP4u0Y+1uQypjGDRU/PGZaEIq7CDTfnSECLGr98KQIZLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800450;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=AyfDI+vr08JlAxQNF+LWQauQ7bhDgKsQOWnNTVi2BYQ=;
	b=dM16y1wD00Z1VY+xtuooi2BGeycZ+f2c2i0Xpf5DHcUHMAq2Kdh22EqmHoVxo6WggSm2
	 QJtpgzAP6FniHvl6B3CilltbBlXJF3gj5UP6bcHZSq+Dx3K7UhdfoC/CMGNh5L2DcOelb
	 3iu6kN0Cg5EIQotHjM7rZ1O1XWu9aOoftWmCLeYqTq/20e4MoyaLbAQNvOBa9WwuIysZ7
	 QiUWP1BY2nAvK7jn6y160Id5vKavmX+pBTkyRUM7awjyra9hIw8t1pw54dydLUTdgQojr
	 GSuauKjkpZqw30nCTkkZRjVHhW3CFbhfIyAxeLPb3O8ZUGQL1ABPQ1OgWfdQs1Bhm6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rZfSmJza;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C5606A331;
	Wed,  4 Nov 2026 13:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D49C5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rZfSmJza
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 59AD6C8F46F;
	Wed,  4 Nov 2026 13:55:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A28A60770;
	Wed,  4 Nov 2026 13:54:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C262103291F6;
	Wed,  4 Nov 2026 14:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793800443; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AyfDI+vr08JlAxQNF+LWQauQ7bhDgKsQOWnNTVi2BYQ=;
	b=rZfSmJza+1mzpm0RDYrz/9vmLYC2pipHQT6G1/RCusGC1chP3hkw4yXgLVyYCADOXEbtYV
	FGmBxIe9SOfkfEi2wXWQdSqjqupgTfoChbr7qGx4nkRX5vpsWQQHQUtTN3W73C4RhikM8J
	4b+FwtJ9quhcNZtCuCSKV0iZngmSArvtBSck7/VLvr4zlB65oW4FY+E+w5h5JJtG1PNG9r
	gXx3rHU/SzIW8aqGW55vZcBy1S32nHJ/2H3kK77FUhFiZoBH4P7Q0KP4R9hVl9I2aNzyRz
	Wr25n0H17YkWUStkc62WKjtABMy0cLpyGuxZ8lDGyuepty44+N/8R2lKNMsI4Q==
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
Subject: [PATCH v9 2/3] i2c: {mux,atr}: Set adapter physical device
Date: Wed,  4 Nov 2026 14:53:05 +0100
Message-ID: <20261104135324.492692-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104135324.492692-1-herve.codina@bootlin.com>
References: <20261104135324.492692-1-herve.codina@bootlin.com>
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

For i2c muxes and atrs (address translators), the parent of the mux/atr
adapter device is the adapter device the mux/atr is connected to.

This parent is not the physical device related to the mux/atr adapter.
Indeed, the physical device of the mux/atr adapter is the mux/atr device
itself.

Fill the adap.physdev with the mux/atr device.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/i2c-atr.c | 1 +
 drivers/i2c/i2c-mux.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/i2c/i2c-atr.c b/drivers/i2c/i2c-atr.c
index b98442ffff94..a591d39050e7 100644
--- a/drivers/i2c/i2c-atr.c
+++ b/drivers/i2c/i2c-atr.c
@@ -824,6 +824,7 @@ int i2c_atr_add_adapter(struct i2c_atr *atr, struct i2c_atr_adap_desc *desc)
 	chan->adap.algo = &atr->algo;
 	chan->adap.algo_data = chan;
 	chan->adap.dev.parent = desc->parent;
+	chan->adap.physdev = dev;
 	chan->adap.retries = parent->retries;
 	chan->adap.timeout = parent->timeout;
 	chan->adap.quirks = parent->quirks;
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


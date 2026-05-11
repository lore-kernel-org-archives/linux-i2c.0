Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AA0425CC3
	for <linux-i2c@vger.kernel.org>; Mon, 11 May 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515270; cv=none; b=dh+sYefoH0kxUnzw0eSEB1W5D4AhSVlTuVva+/GtqseWtvi7oYTqnEOXjcMWNQFvhwoIsuFIA+H7GjvhorWZr1v8Imy8yBQgUw8RFkNIi47DPrnCR9+icBYjOqT1FvOCBwemQwipP1uaJ5DjSqaU11az4wm6jr9XQbYXPJejXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515270; c=relaxed/simple;
	bh=AWzsAlFki5r8/Nzxjbdv5ewKshsRLiRR79F5oNS5n7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaGfLsrHYKoY1QXq320N1QxmlUh7cOFb4iOet5sX0RD0C4OknXJg4BNAu0BOx146ztCmFzm4+K8gQpsTV4o1kg8mTVvmrxLgGARBX4EX2e0pFEYj1xvHtCVXJP/u2SF7/0w8SkXiaqY/7r6mj2S0YH8bdba2nMTnrKIA1jOcuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K9wkb9/q; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K9wkb9/q"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 865EE4E42BF4;
	Mon, 11 May 2026 16:01:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5B22060646;
	Mon, 11 May 2026 16:01:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B826211AF9F2C;
	Mon, 11 May 2026 18:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778515266; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qeSVgRzzcRZSwyW0NgN4yrI69j7Xls5GCIYU5hWpnG0=;
	b=K9wkb9/q9fuU2uczvMj+HYG1Pdwj1oVvky70rRYoqwkeSgNBPN51NV5QcjyLeeL8ZZmvfB
	3oN4TauBhir9N7dTS6A/CiGIq/4WqycUj+pRoKICpeuIUFLTqzEVz5VN5n3wpKWi1EcrKg
	Inuoi5B3+Qy8ZWwK9IJcniHNiyahIlobudya4zL+tuzx26ubJmLNaiik65nn/EiNS3gHpG
	b9+drRtF75W1NtZspMvtpwUELzwpQ+jp9kYS4dCpFKEPkiKqcUiWWbDq+Z5Df6ddeDRO45
	292BiMOIUVeq+jJbcJeKbYGB/I+wj6VGnfHJ8rZaeQinyLwwUfXoPI4rAGDbRg==
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
Subject: [PATCH v7 2/3] i2c: mux: Set adapter physical device
Date: Mon, 11 May 2026 18:00:49 +0200
Message-ID: <20260511160051.34700-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511160051.34700-1-herve.codina@bootlin.com>
References: <20260511160051.34700-1-herve.codina@bootlin.com>
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


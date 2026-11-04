Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789372;
	b=OZqp4QkrVtubzfbE/nvRDREXPHxrNtC42IF1cHR6IH3/gEgRYVqS8iBwy8dhesdOJ2Yn
	 B3U9LdQThq1i/8Fu5O3URb0sI7PieExrbVPBfAnG2/k2wetiIMyXNcFox8jk1AmXcMmy8
	 K1YPo2w7Gz0d05CMTqul/OHehRQJJYXAm+BS7XiX+Uf75U5XfdQY1zaFcy0WTyVp38r3h
	 tqqWf5M/hdrlVMl6TEGEU8UprYUGk1ckGk2pHZkXWCllrM6KtzSyjyoPMDRFCzS7X05aq
	 k97Kpa9nAV5o+ucd3x2xW0qvHubG+0ylXnlc3vWPZtdKRIh/6lUB6oQF9ORfqFnx4+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789372;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=vrL/ldQTg7qfwDH+X5xkdD0XYJb0hJYraFfdLjgleJI=;
	b=Xt6yM1MASs/dRH9gxCselDMAizpxboUjrJI0NJ/Q35h3dtowWdUDxU/LAC0XJ4VFbci6
	 QVpJx9ylyn/O2/6nauGW4wIViNax9LEt2P9MkshtO3rSf66u6BubynpzAva6jJAjzAj0g
	 dmGeUh7GKtaa5/EnFB/53R9uXIvxEJwIFicv65NJqyZZtsISWtRuJ5fi6/LjBibI60qKK
	 GZ9q09lfHRw3zAaqg5l0ptjngUgidOhGYfuvS51qaJcDy3yILoxpdA8adaBNzCOE4ElXb
	 o+HPDSaAYWqjaz3TA8FM7+2umgma783Ic3HIBDNN0iaAJnp7i05APPQgwhufQPQvwqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dovD6fkx;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B075606A326
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 10:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B075606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dovD6fkx
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 05B2A4E413FC
	for <linux-i2c@vger.kernel.org>; Wed,  4 Nov 2026 10:49:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C97FA60770;
	Wed,  4 Nov 2026 10:49:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81A1510329171;
	Wed,  4 Nov 2026 11:49:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793789368; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vrL/ldQTg7qfwDH+X5xkdD0XYJb0hJYraFfdLjgleJI=;
	b=dovD6fkx5+4hEfeNxX3AEjbrupWKWyOnpeWxxAOm8J7YWJRUoZPV2h0XT18mmsI99Sirrh
	XfB2B8CIeMVFvt8YZKq1N50IwRRsPwbKhU/fOJdl5jQg+9NCZZeiKGkiS4UqY+3k6QJHRT
	IF731X+dAgj9x2DEEecBTB0msFfxVjF1QVJQQSxOjq8GVJeobBuxl9LiEMZQfyEhn6f3aZ
	DWpLOkHp6ZpNij6yFBjXQ/I1w2neELS1r9zaGV15rw2P67620BauGbqvQlno+LW04MxhdK
	+2QwKNrtXVBE+qxEu7LY9h3akfLPDgfoKHmvSQW2PeTNVRZY91xSNwoshjuqPg==
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: Robert Richter <rric@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Umesh Kumar <ukumar@marvell.com>,
	Shashank Gupta <shashankg@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>,
	Paul Cercueil <paul.cercueil@bootlin.com>
Subject: [PATCH 1/3] i2c: octeon: Add error state recovery
Date: Wed,  4 Nov 2026 11:49:10 +0100
Message-ID: <20261104104912.166301-2-paul.cercueil@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104104912.166301-1-paul.cercueil@bootlin.com>
References: <20261104104912.166301-1-paul.cercueil@bootlin.com>
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

From: Tanmay Jagdale <tanmay@marvell.com>

Whenever a Bus Error state occurs, trigger a software recovery to
attempt to return to a working state.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
Co-developed-by: Paul Cercueil <paul.cercueil@bootlin.com>
Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 93a49e4637ec..9f72ec1feaa0 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -205,6 +205,17 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 	return 0;
 }
 
+static int octeon_i2c_recovery(struct octeon_i2c *i2c)
+{
+	int ret;
+
+	ret = i2c_recover_bus(&i2c->adap);
+	if (ret)
+		/* recover failed, try hardware re-init */
+		ret = octeon_i2c_init_lowlevel(i2c);
+	return ret;
+}
+
 static int octeon_i2c_check_status(struct octeon_i2c *i2c, int final_read)
 {
 	u8 stat;
@@ -265,8 +276,9 @@ static int octeon_i2c_check_status(struct octeon_i2c *i2c, int final_read)
 		return -EOPNOTSUPP;
 
 	case STAT_TXDATA_NAK:
-	case STAT_BUS_ERROR:
 		return -EIO;
+	case STAT_BUS_ERROR:
+		return octeon_i2c_recovery(i2c) ? -EIO : -EAGAIN;
 	case STAT_TXADDR_NAK:
 	case STAT_RXADDR_NAK:
 	case STAT_AD2W_NAK:
@@ -277,24 +289,13 @@ static int octeon_i2c_check_status(struct octeon_i2c *i2c, int final_read)
 		/* Set BUS_MON_RST to reset bus monitor */
 		mode |= BUS_MON_RST_MASK;
 		octeon_i2c_writeq_flush(mode, i2c->twsi_base + OCTEON_REG_MODE(i2c));
-		return -EIO;
+		return octeon_i2c_recovery(i2c) ? -EIO : -EAGAIN;
 	default:
 		dev_err(i2c->dev, "unhandled state: %d\n", stat);
 		return -EIO;
 	}
 }
 
-static int octeon_i2c_recovery(struct octeon_i2c *i2c)
-{
-	int ret;
-
-	ret = i2c_recover_bus(&i2c->adap);
-	if (ret)
-		/* recover failed, try hardware re-init */
-		ret = octeon_i2c_init_lowlevel(i2c);
-	return ret;
-}
-
 /**
  * octeon_i2c_start - send START to the bus
  * @i2c: The struct octeon_i2c
-- 
2.47.3


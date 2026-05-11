Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C51F3FF884;
	Mon, 11 May 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510245; cv=none; b=PXfdFwP8wZ4Dqc2w9pQ+xrFzIQ0aYECBw3MbyY701mSsrgli2Rfgk9WgHmGteCKCdQ5CaqYLejv5kFNlVw2J5Dm60fnzV/2/nG5jwh4xazZm3QBIyGOUk55lWSzk4V0AvP0RDJ5wTorR0/F4QqfWwIt8s3LBQF02GwU7/RFHpOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510245; c=relaxed/simple;
	bh=7Ky3OZfr0RF6XOeZrPt3Y22wFgkR2InbGKSD9DORk+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zx9eLlOptGKiKD2HJmHuoB6FCO8438kW7uOeEwaPgz2XeWd/a4Ya8kGryl5isT5cAEvY22pj9Y478e8uMyXkM+HejQOoGDBHapBBhMSwwHT0wnWFqag81A48ZX/ihJJYOlqnDPeupLfz19TfyRU8PG5UbvPPFH1uy2Gth4qLRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRrVNVre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRrVNVre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E65FC2BCFB;
	Mon, 11 May 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510244;
	bh=7Ky3OZfr0RF6XOeZrPt3Y22wFgkR2InbGKSD9DORk+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GRrVNVrePfjyL/Mlqyn9D74oriW+C8Tot6zVSy2QRwj6/7WD7LEM3nuoHVWtmqfAy
	 GdgDCrLjkJPc6IIivSlZ9nIxD5qh7gJUfPdWnClDP6AWm+6g5kKZILLWiCkrRfMPVY
	 +PKr/NUK248FZ2ZzIs0jIN4/9HWu0XobWr7qaqNV/Hi74KUumJsHlgJH7NxnuF09ar
	 r9w6qOppcZmeaKxj28GH+5O/9KuZdiL1fI3JjlkXkHBhSeTxA+eRRnFenejGfkiBD7
	 m08tSd2ZnVmEaycGb0dnO6sRAgRfAOAvCMhKqRVWVmv8jd9+YU+6tK6aEwVpIXO+om
	 ak2OeTD7Rjs/A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wMRl4-000000033qD-0nht;
	Mon, 11 May 2026 16:37:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH v3 04/10] i2c: core: fix adapter probe deferral loop
Date: Mon, 11 May 2026 16:37:09 +0200
Message-ID: <20260511143715.729714-5-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511143715.729714-1-johan@kernel.org>
References: <20260511143715.729714-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers must not probe defer after having registered devices as that
will trigger a probe loop if the devices bind to a driver (cf. commit
fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).

Move the recovery initialisation, where the GPIO lookup may fail, before
registering the adapter to prevent this.

Fixes: 75820314de26 ("i2c: core: add generic I2C GPIO recovery")
Cc: stable@vger.kernel.org	# 5.9
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index fa9db415e219..1caaa3b3ee10 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1562,6 +1562,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1583,10 +1587,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
-	res = i2c_init_recovery(adap);
-	if (res == -EPROBE_DEFER)
-		goto out_reg;
-
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	/* create pre-declared device nodes */
-- 
2.53.0


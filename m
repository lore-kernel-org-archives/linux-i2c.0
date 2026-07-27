Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D236F8F1
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152112; cv=none; b=pJ19kQmAHxtJ3dS3ipvfUJakZK6ipwxzjDOqoaMKJHT1YiDHQV5aXFsw9gbV4kdGmLfkYxCOz05TI5OpXyz1y+gA9cEQwl5rk+4ZuC6ECjMmnY/ysTR8TBDouMdUTBN3Ht3RNrBAuxmsfTH5Saf7TbmCCz800aUzrd4EqkA7Gc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152112; c=relaxed/simple;
	bh=hdSGShFGJGsT/dc3xbpf7sNgejjVXXGrA2Dn/uCY+VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+26g+ysnwmo8ibgQJuAhCN8R4R9WsjM/FH3vOabZ2Sas/3GtR5uz5e1X1pNAHODI11LpbPBbEC7XFfrwYe39/O0kgfF71Mn2cqopPvLhclzqZbhohgzh5lS5TlF5GYGTmAWXntnxtOJegPQNtSlK1N0+1/kno4YQHZlogMjIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SuHcYSD3; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SuHcYSD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=K7muAPk8j9p8FQyHmYALkCxfCYbzHHEUnk70zJaymgg=; b=SuHcYS
	D3l3CT+6bGaF0SE5dDd3KDeTyuXFLiH3rtBhZ2DfwS/EliGIQSZhrQ1VfJ4bUM7N
	HNthEXvAPWZxWPwKniqW1iJsFZXsUhcdQHrqeus/0CyUayn0SCCdg99im8iYCimF
	6dUE3oVcyNnx2R2Sl9hyUMZzEq5Plf26S7BYvwWUJ30+2dWLRZEq7S1cO8sjadI1
	jQfGFGltaopxUZhhKXuQgrmlV89Aor8kR0PeUmUxRYB6zP6FVd41DjLpZiI5zR1w
	60yIfJ7n4Kw66iKHhFX0c4pTLVWkVB0lOuZ4CxJepG51FtgWhE48ihevcyVfmoeu
	PMgzzesDWUPdL0yQ==
Received: (qmail 589354 invoked from network); 27 Jul 2026 13:35:05 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jul 2026 13:35:05 +0200
X-UD-Smtp-Session: l3s3148p1@7a4cHZZXSM8ujnuy
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org
Subject: [PATCH 2/2] i2c: rcar: add R-Car Gen5 support
Date: Mon, 27 Jul 2026 13:34:43 +0200
Message-ID: <20260727113441.11193-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727113441.11193-4-wsa+renesas@sang-engineering.com>
References: <20260727113441.11193-4-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support the next generation of R-Car SoCs, we need to skip polling
the reset status. SCMI doesn't support it and the firmware must take
care of this anyhow. Other than that, the driver works fine as-is.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 5ce8f8e4856f..46508176712c 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -137,6 +137,7 @@ enum rcar_i2c_type {
 	I2C_RCAR_GEN2,
 	I2C_RCAR_GEN3,
 	I2C_RCAR_GEN4,
+	I2C_RCAR_GEN5,
 };
 
 struct rcar_i2c_priv {
@@ -900,8 +901,12 @@ static int rcar_i2c_do_reset(struct rcar_i2c_priv *priv)
 	if (ret)
 		return ret;
 
-	return read_poll_timeout_atomic(reset_control_status, ret, ret == 0, 1,
-					100, false, priv->rstc);
+	/* SCMI based resets don't need to poll for success */
+	if (priv->devtype < I2C_RCAR_GEN5)
+		return read_poll_timeout_atomic(reset_control_status, ret, ret == 0,
+						1, 100, false, priv->rstc);
+
+	return 0;
 }
 
 static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
@@ -1111,6 +1116,7 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,rcar-gen2-i2c", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,rcar-gen3-i2c", .data = (void *)I2C_RCAR_GEN3 },
 	{ .compatible = "renesas,rcar-gen4-i2c", .data = (void *)I2C_RCAR_GEN4 },
+	{ .compatible = "renesas,rcar-gen5-i2c", .data = (void *)I2C_RCAR_GEN5 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
@@ -1194,9 +1200,15 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 			goto out_pm_put;
 		}
 
-		ret = reset_control_status(priv->rstc);
-		if (ret < 0)
-			goto out_pm_put;
+		/*
+		 * Gen5+ uses SCMI based reset which cannot report status.
+		 * Firmware has to ensure proper reset
+		 */
+		if (priv->devtype < I2C_RCAR_GEN5) {
+			ret = reset_control_status(priv->rstc);
+			if (ret < 0)
+				goto out_pm_put;
+		}
 
 		/* hard reset disturbs HostNotify local target, so disable it */
 		priv->flags &= ~ID_P_HOST_NOTIFY;
-- 
2.47.3


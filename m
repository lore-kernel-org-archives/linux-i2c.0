Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF940098E
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155163; cv=none; b=mTIHH3gaI46W3GhT/ymicEjZZeCYuMpY5emUiaP3nnBMUmxvLOlFXT0+UmEkvQCIJ+rJhDcxcxhCA407qUjHzS2bS+FNaFoOpsbqAEqCxly8PhPe7bK0O2tfnxa2jRFocMagVDQPRG5QF31igQaTPNjr2oVhDJBImIQ7Jzd6Gbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155163; c=relaxed/simple;
	bh=I3qGEWdzYVVNyzDWnBYN7ipvBVem1rcEnr5hf17hn8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgTkatLgxnsdP+aWN9tr5YvSOKL3Sa30LmTtGb4AHz5zYhDcoa0NQDbtAXPr0RiNJJD8u24Km5XEF5FCUII4f+TZ3esGmmzB3g8SzvgbYXO3C1K6bchHASDse554knVWrKV83RHJAa3gO5qg0xmFdKIY1z39qEaY5039I+KsMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=joQ5kxwt; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="joQ5kxwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=9Cksj6VmHhDFvOo9sllAxluuSeqR1KLxI4AkzBIDJpM=; b=joQ5kx
	wtv2MQ0fNdcLCgGmxeqA2WCoG9fzhPGP8PFAWVqQ/xJEcIwk6dkjHS3jaQQCOzzZ
	JKk4QlzZpPy83N4SHVlaG82L10qgD4wRD3eaMNnd6oZeWXKF7P9BSz157qK0CLZe
	z7YDt9pRn8sp4JcEa3EAUXxCIAroZ1VFsPxggBhPdZKV8wIuaR41s9xHp9Mu9aFV
	FE4uXfqgz1BGSEe8KJ5XlJjMEIjpyHsYAR5bbKIyemuaIdAQ6/+fhQAIJ5WksV+K
	tchWFYpmD8zIvgupgmdj/wrlCt/GyLTnXYtCUrAU/TcRnyr8cW6Ojx1IuZMPYzf2
	iIskSDa+qigng4+w==
Received: (qmail 602594 invoked from network); 27 Jul 2026 14:25:59 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jul 2026 14:25:59 +0200
X-UD-Smtp-Session: l3s3148p1@gTQc05ZXLr0ujnuy
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v2 2/2] i2c: rcar: add R-Car Gen5 support
Date: Mon, 27 Jul 2026 14:25:48 +0200
Message-ID: <20260727122546.4232-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
References: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
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
Change since v1: * none

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


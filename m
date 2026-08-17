Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3A3C2B8D
	for <linux-i2c@vger.kernel.org>; Mon, 17 Aug 2026 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786955465; cv=none; b=lnPhDes2EvyiCPW/YjMi4EJ3BL20Yg8tX+7kCHCEpdfw935X3IpfbRob9kz7/nfdoAHcqwoljKm2utgWbugnRV44qe1NXl/86SAKHmy+13JyLQ46NnX044ZIl2ewhsYH6cEPap32FUj9gL+TSCyQqlnDpfv0aQB1sP6WuUrgXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786955465; c=relaxed/simple;
	bh=LbEwa3z7r5tm8VeysrxRioGAFNdFYhPV3TOfC5buAFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXVA/wcl11fBEY2g1HUeiqaA8GmUUAo4LOHnjYO+uTCuhu4v52qqIDu9LA+eI/M5fvfdrmZK80pw/dqTKPaSLopkzaxWuHxceC9epxGdX5FQmXVwCnIVDuJx8SLXnbfFKXzRxgCjPU/6zD11IRyAjtvrh4Pe8pbArrA0I4pYPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hMuxaMJp; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hMuxaMJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=fAcBFOcxc3nHiQ
	rjC9A//y2CuUhmSjMl2E6N4VvLwJY=; b=hMuxaMJpLsZMQuf4fYFM+YG1+/oRr4
	0JxFcIsfHg5I5ntBkIH3IiONUCjlpZiuZslbViQgrWP6/gdpKMtv3W/dl0ML5zwg
	HT977phX/TPQuepgZvKKPyV8VZ7amGGZOFjOT14HEvHKFFFy2Xm0LL0wh44oXLjR
	45ftzwkcagdh192btYbb/98rF2FmgHb75os+IGlExPpYfunH9TYe0NOm7zzioiJi
	iupJGHhJ4fq1Pg/5TAaWVEYWz1P7lHh8iqYNEdKJ/bgm1VuLkPomaeS+Ilc8UdFf
	vD4n2uS15C6g7k5sA2MtIwLD9vcLKTzfIomO6JkDYCQWGT2LSYrlN4aw==
Received: (qmail 3386364 invoked from network); 17 Aug 2026 10:30:59 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Aug 2026 10:30:59 +0200
X-UD-Smtp-Session: l3s3148p1@G1Vl/TlZXLEujnve
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andi Shyti <andi.shyti@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-i2c@vger.kernel.org
Subject: [PATCH] i2c: rcar: fix reset handling for Gen5
Date: Mon, 17 Aug 2026 10:26:45 +0200
Message-ID: <20260817083046.11935-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing reset_control_status() support is not Gen5 specific. It depends
on the firmware used, if any. Refactor the code to handle missing
reset_control_status() more generically.

Fixes: 87e713f20048 ("i2c: rcar: add R-Car Gen5 support")
Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Based on this discussion[1]. Tested on a Ironhide board (R-Car X5H) and
a SparrowHawk (R-Car V4H) for regression testing.

[1] https://lore.kernel.org/r/CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com

 drivers/i2c/busses/i2c-rcar.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 46508176712c..755064804cb2 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -123,12 +123,13 @@
 #define ID_NACK			BIT(4)
 #define ID_EPROTO		BIT(5)
 /* persistent flags */
+#define ID_P_NO_RST_STAT	BIT(26)
 #define ID_P_FMPLUS		BIT(27)
 #define ID_P_NOT_ATOMIC		BIT(28)
 #define ID_P_HOST_NOTIFY	BIT(29)
 #define ID_P_NO_RXDMA		BIT(30) /* HW forbids RXDMA sometimes */
 #define ID_P_PM_BLOCKED		BIT(31)
-#define ID_P_MASK		GENMASK(31, 27)
+#define ID_P_MASK		GENMASK(31, 26)
 
 #define ID_SLAVE_NACK		BIT(0)
 
@@ -901,12 +902,11 @@ static int rcar_i2c_do_reset(struct rcar_i2c_priv *priv)
 	if (ret)
 		return ret;
 
-	/* SCMI based resets don't need to poll for success */
-	if (priv->devtype < I2C_RCAR_GEN5)
-		return read_poll_timeout_atomic(reset_control_status, ret, ret == 0,
-						1, 100, false, priv->rstc);
+	if (priv->flags & ID_P_NO_RST_STAT)
+		return 0;
 
-	return 0;
+	return read_poll_timeout_atomic(reset_control_status, ret, ret == 0,
+					1, 100, false, priv->rstc);
 }
 
 static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
@@ -1200,15 +1200,12 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 			goto out_pm_put;
 		}
 
-		/*
-		 * Gen5+ uses SCMI based reset which cannot report status.
-		 * Firmware has to ensure proper reset
-		 */
-		if (priv->devtype < I2C_RCAR_GEN5) {
-			ret = reset_control_status(priv->rstc);
-			if (ret < 0)
-				goto out_pm_put;
-		}
+		ret = reset_control_status(priv->rstc);
+		/* Some SCMI firmware does not support reading reset status */
+		if (ret == -ENOTSUPP)
+			priv->flags |= ID_P_NO_RST_STAT;
+		else if (ret < 0)
+			goto out_pm_put;
 
 		/* hard reset disturbs HostNotify local target, so disable it */
 		priv->flags &= ~ID_P_HOST_NOTIFY;
-- 
2.47.3


Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385835CB6E;
	Mon, 23 Mar 2026 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774250055; cv=none; b=jWFJHw3pm9uAgntz8oop3tC9OVGzESGLbXaQAde9xH03842+R+NRfsp9gCKTFn2FBjj82A75R/wP2Mo8vcoknHAk9FZgsG06apMgyrXQuLn+PQd6xn+/myPVm9P/HijjOLXweLaVjWTldesHIIj+t2pPLwxgM48Q3+nLI1JVAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774250055; c=relaxed/simple;
	bh=GwaO3Jgs7I+IjOxIFQXKkawzKx2llBDskSmUtS3EUww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntzp0NfzimevEI8Xec5dwyJJRqcUUQkxHTTzbqPzjj5bi8h69RjRLm7tqcu4N4oHs+5l7/zgy9OM0BwpJcpP6Sf7F2/f+Vzl4qX7EkEs4ciyaRJ20N85rTCOGUY2RVHFBnWS/5pqL51qK0wbY1IOG+Ds1E2ec8GNEmQTKsOC4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=LwDS8Obc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="LwDS8Obc"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6927326E75;
	Mon, 23 Mar 2026 08:14:12 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIWg8zhIfRCh; Mon, 23 Mar 2026 08:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774250051; bh=GwaO3Jgs7I+IjOxIFQXKkawzKx2llBDskSmUtS3EUww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LwDS8ObcWoSMcO8nSeoBhxyVKOjuv88eoxyuucqKwom4+CICBgh193qT75znbKCGC
	 r1O5BmNWn3E7+4yyIxmH6WW8Kpav7f0SUYBt7cjYeCCDlCCzWnMg4EpztcSeDHrhSx
	 Jzdva5D+zgnxdE+vm/S5Ql5oJ+SGcKCMu2vEJeFdnuT9QKoQCzIotEFq/NGSi4CDFq
	 vPFzD/ATTZxOqzSdPg9CfToLN8wwxEzPZh2bf4NJ+J4S+5nAdYagpF2UvPees+FsHJ
	 qEp+XXBI8/tFUK7jUMmA6mj5YaQYrhRrsq7wJwKi8OqBEdawRg2zAR+wRW+GV9h38m
	 KZtEY8aIxAYpQ==
From: Rustam Adilov <adilov@disroot.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>
Subject: [PATCH v4 3/8] i2c: rtl9300: introduce F_BUSY to the reg_fields struct
Date: Mon, 23 Mar 2026 12:13:32 +0500
Message-ID: <20260323071337.15410-4-adilov@disroot.org>
In-Reply-To: <20260323071337.15410-1-adilov@disroot.org>
References: <20260323071337.15410-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RTL9607C i2c controller the busy check operation is done on the
separate bit of the command register as opposed to self clearing
command trigger bit on the rtl9300 and rtl9310 i2c controllers.

Introduce a new F_BUSY field to the reg_fields struct for that
and change the regmap read poll function to use F_BUSY
instead of I2C_TRIG.

Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 2cada6038b44..e40b4692a3fa 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -53,6 +53,7 @@ enum rtl9300_i2c_reg_fields {
 	F_SCL_SEL,
 	F_SDA_OUT_SEL,
 	F_SDA_SEL,
+	F_BUSY,
 
 	/* keep last */
 	F_NUM_FIELDS
@@ -262,7 +263,7 @@ static int rtl9300_i2c_do_xfer(struct rtl9300_i2c *i2c, struct rtl9300_i2c_xfer
 	if (ret)
 		return ret;
 
-	ret = regmap_field_read_poll_timeout(i2c->fields[F_I2C_TRIG], val, !val, 100, 100000);
+	ret = regmap_field_read_poll_timeout(i2c->fields[F_BUSY], val, !val, 100, 100000);
 	if (ret)
 		return ret;
 
@@ -505,6 +506,7 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
 		[F_MEM_ADDR_WIDTH]	= MST_REG_FIELD(RTL9300_I2C_MST_CTRL2, 2, 3),
 		[F_SCL_FREQ]		= MST_REG_FIELD(RTL9300_I2C_MST_CTRL2, 0, 1),
 		[F_SDA_SEL]		= GLB_REG_FIELD(RTL9300_I2C_MST_GLB_CTRL, 0, 7),
+		[F_BUSY]		= MST_REG_FIELD(RTL9300_I2C_MST_CTRL1, 0, 0),
 	},
 	.select_scl = rtl9300_i2c_select_scl,
 	.rd_reg = RTL9300_I2C_MST_DATA_WORD0,
@@ -527,6 +529,7 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 		[F_I2C_FAIL]		= MST_REG_FIELD(RTL9310_I2C_MST_CTRL, 1, 1),
 		[F_I2C_TRIG]		= MST_REG_FIELD(RTL9310_I2C_MST_CTRL, 0, 0),
 		[F_MEM_ADDR]		= MST_REG_FIELD(RTL9310_I2C_MST_MEMADDR_CTRL, 0, 23),
+		[F_BUSY]		= MST_REG_FIELD(RTL9310_I2C_MST_CTRL, 0, 0),
 	},
 	.select_scl = rtl9310_i2c_select_scl,
 	.rd_reg = RTL9310_I2C_MST_DATA_CTRL,
-- 
2.53.0


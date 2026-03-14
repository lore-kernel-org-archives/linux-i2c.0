Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7E29D29F;
	Sat, 14 Mar 2026 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773476848; cv=none; b=pz+QwP9OE9HbBs+IOJRYuB+LdX38LVszfg8sZV9bsIKJb/q2sBkIS1bGXHuJ09X7DnVoMO/r/tZShAM4IZQ1IueNoweB6J6+W5ek2PCZGgOBLOa8UVWTyTn/AFM86HPl/KlUm91KVXk91Y+e812glsOZSHvTsbyQDjea2Xl8gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773476848; c=relaxed/simple;
	bh=wObEu7e3pzx2P5ILQgZadH8cxnOg7AQelSJPu3msjb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiTC0vPiIKSgMeUVu89nqZGrmALuNdv+Weai+MEYP4dKG3Cw4zs4GCYEBo2VqauwnMPWBUfghEcxuviqWKcuW4b9aw732BFPtbTJrm/z02SqOg4XAqf3k0KjOknMUBZPgyUK92qLn+s17VtJnQZNdnnWZpv7Lsg/xN39gxoiNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Xg8Uweo2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Xg8Uweo2"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1708C27011;
	Sat, 14 Mar 2026 09:27:26 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bgeJMl2NZ993; Sat, 14 Mar 2026 09:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773476845; bh=wObEu7e3pzx2P5ILQgZadH8cxnOg7AQelSJPu3msjb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xg8Uweo2eMltt7MRalvWBx/ry+rm/OphA2rULKGmT/RKbq2c9yd4DBQ+FJtqQI2v7
	 0c51eBrYoWUMlERYYG5dzpd4jV4fhGQMAnnJJ3EydxDbR/Wevt/wp6ioLquacPES/R
	 sHuXMZIm5p+XHGFY2OBzr0v/7rWhw96z/G6ZjgrGjrq+bbCFOIknKXcGApNUNWTJW9
	 Blg7nxzl4knOPLunvGrpykYHW5CCpr6lH3mXpNj/twB6z1cUcYDx/d8+bJPjNNcUVx
	 meDQ6rjh13Mw3Z/B+IVoPdDl5b49arNPFPaVWI7lulNy+bvSnb7eV5ABJ2dW8yo/sC
	 R5d9wXdxWMfrw==
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
Subject: [PATCH 3/8] i2c: rtl9300: introduce F_BUSY to the reg_fields struct
Date: Sat, 14 Mar 2026 13:26:23 +0500
Message-ID: <20260314082628.25206-4-adilov@disroot.org>
In-Reply-To: <20260314082628.25206-1-adilov@disroot.org>
References: <20260314082628.25206-1-adilov@disroot.org>
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

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 1354c8a7a369..2525b57a9d03 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -47,6 +47,7 @@ enum rtl9300_i2c_reg_fields {
 	F_SCL_SEL,
 	F_SDA_OUT_SEL,
 	F_SDA_SEL,
+	F_BUSY,
 
 	/* keep last */
 	F_NUM_FIELDS
@@ -256,7 +257,7 @@ static int rtl9300_i2c_do_xfer(struct rtl9300_i2c *i2c, struct rtl9300_i2c_xfer
 	if (ret)
 		return ret;
 
-	ret = regmap_field_read_poll_timeout(i2c->fields[F_I2C_TRIG], val, !val, 100, 100000);
+	ret = regmap_field_read_poll_timeout(i2c->fields[F_BUSY], val, !val, 100, 100000);
 	if (ret)
 		return ret;
 
@@ -493,6 +494,7 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
 		[F_MEM_ADDR_WIDTH]	= MST_REG_FIELD(RTL9300_I2C_MST_CTRL2, 2, 3),
 		[F_SCL_FREQ]		= MST_REG_FIELD(RTL9300_I2C_MST_CTRL2, 0, 1),
 		[F_SDA_SEL]		= GLB_REG_FIELD(RTL9300_I2C_MST_GLB_CTRL, 0, 7),
+		[F_BUSY]		= MST_REG_FIELD(RTL9300_I2C_MST_CTRL1, 0, 0),
 	},
 	.select_scl = rtl9300_i2c_select_scl,
 	.rd_reg = RTL9300_I2C_MST_DATA_WORD0,
@@ -515,6 +517,7 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 		[F_I2C_FAIL]		= MST_REG_FIELD(RTL9310_I2C_MST_CTRL, 1, 1),
 		[F_I2C_TRIG]		= MST_REG_FIELD(RTL9310_I2C_MST_CTRL, 0, 0),
 		[F_MEM_ADDR]		= MST_REG_FIELD(RTL9310_I2C_MST_MEMADDR_CTRL, 0, 23),
+		[F_BUSY]		= MST_REG_FIELD(RTL9310_I2C_MST_CTRL, 0, 0),
 	},
 	.select_scl = rtl9310_i2c_select_scl,
 	.rd_reg = RTL9310_I2C_MST_DATA_CTRL,
-- 
2.53.0


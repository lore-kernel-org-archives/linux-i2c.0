Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3390407119;
	Thu, 26 Mar 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538854; cv=none; b=SiVBPd+J2TMJ3xjA+bYkM5pl54P7yPhCeIvNRnhZnlNwyWTHVS7IC0c5Xu4WF2Spiuo7lk8A2/JGUY1ZQ1jJ4hOUZZAGCgp3hDyl3+n7M5Z6ifqm3EBFripRrm3RfySvOc6jvNBHI/zwAiOhA+YEC5gpXnNY2GyF+ves3JTZ5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538854; c=relaxed/simple;
	bh=GwaO3Jgs7I+IjOxIFQXKkawzKx2llBDskSmUtS3EUww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El0SSFEV6Om/5/UWSJhUQfIclWEsLyOQ71hZ4tcmDyk5EvNj1W2TCJKzPgaZ1mEIQ3C06bYNjMSqYtvQDeaSJI4a3pGfk+frQpDbsX3vZQGVApjD/s2axs32R6Ax+lUIvnSs37GP81DzRs6OR9V5bDTU3USWwhn/P/75c/y5hmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ikcZANm7; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ikcZANm7"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 41C5A26452;
	Thu, 26 Mar 2026 16:27:31 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0-J0etiwooBu; Thu, 26 Mar 2026 16:27:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774538850; bh=GwaO3Jgs7I+IjOxIFQXKkawzKx2llBDskSmUtS3EUww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ikcZANm7j49padSBxOPn90xV7sjTFE+IaYcYOi72c1bAIDForJIHv0RjBhwdOTcwM
	 xGF4lO8AsVDIKhLW9QcC7mtgLKkwJYQd4yrQb1Q8C0uXdy/XuhjhHjwXR1gPYMgqqb
	 1qJZat0LlQrCqxongaCOysCbUZYXpLNyBoAhiCBzSUp2+MzhIUN3AFVCw42Mqpp7l/
	 JIkhtlvEXIDckZ3Of71MM9rFK5kE5XMRAu+OSL2ewEFh5UiNrmmozz3MN/i4s1Bki1
	 bgDoyBctISRLSfCdqv1YqnTDCmwPlu3IaC+hEhAfOhvL4i8ii2cQ3+1xR4FSO6ceqa
	 qerbDdtss+U6g==
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
Subject: [PATCH v5 3/8] i2c: rtl9300: introduce F_BUSY to the reg_fields struct
Date: Thu, 26 Mar 2026 20:26:51 +0500
Message-ID: <20260326152656.14030-4-adilov@disroot.org>
In-Reply-To: <20260326152656.14030-1-adilov@disroot.org>
References: <20260326152656.14030-1-adilov@disroot.org>
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


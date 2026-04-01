Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04C2FF657;
	Wed,  1 Apr 2026 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066843; cv=none; b=RncRFwnZ2FVwYxSS/0nScmc9CTRsYTabRjgjHVqzV2QoLCaZz/T8fM5ToqZzT2Nf8z0USPiblHBzEPc944RplobtDpjWk9FnS86fekwvWqJsZvLhTHTYOgCLzMJ1nRsRYPaUhYeKSGBYFOthXrzQhSrePaj6y1NAZR+T1LiDyJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066843; c=relaxed/simple;
	bh=GwaO3Jgs7I+IjOxIFQXKkawzKx2llBDskSmUtS3EUww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy6tdJ3aERCmro83daLxSJ4soiYOrJfMjwC9BgoaSsMHrCAfaz4uq91oKBJVh1Wt1lEIyipOsn895UMAagzCJnDoZod9jyNV82tOLwW7F5/hwRIzJrrNosW52Q96dFdRwL6Kh9zP2AffUFkJurlJvxD5FT5GFjtQ2wEkuuvz3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=e2WbuLd6; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="e2WbuLd6"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 98F1825D5A;
	Wed,  1 Apr 2026 20:07:19 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PnB8oaF5aTri; Wed,  1 Apr 2026 20:07:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775066839; bh=GwaO3Jgs7I+IjOxIFQXKkawzKx2llBDskSmUtS3EUww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e2WbuLd62v/KW+PNwQeg5FXWeJvXBVG2TAI7viShUpEERWjhShMa4/h8UAjnz03Fc
	 1xxCjqomwstCsU8/5aZHRLBvolJryQ1nNWvMccN4pjLZ9LMikiMHYbXtPFqpBIEmmf
	 TQi7kdIwui180//9fXJV0u7x1/5zxyCpF01/uDGUiokZqcGH8kDnNbNk+ofbFtZWEe
	 4mnVQPDunQmOrfU/ltmkB6LBHEzXC2GD/orWY+1Ra9r7gJoH8+neaQUod0YbKosf5R
	 SdAETr7BnuH8vaasDpptws4Q1DqI2kvbWXz++FEzeuY+XIFZG3yf9/sc1E8g2Z7Kk+
	 ZJbB0AUYppqyg==
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
Subject: [PATCH v6 3/8] i2c: rtl9300: introduce F_BUSY to the reg_fields struct
Date: Wed,  1 Apr 2026 23:06:43 +0500
Message-ID: <20260401180648.337834-4-adilov@disroot.org>
In-Reply-To: <20260401180648.337834-1-adilov@disroot.org>
References: <20260401180648.337834-1-adilov@disroot.org>
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


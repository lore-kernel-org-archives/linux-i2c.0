Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414863EE1F8;
	Thu, 19 Mar 2026 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943165; cv=none; b=pG82EWdaTEMRPlDnHp/fLHzFPanxjrihmxwLi+AsVxC2vP/u3SIIKpQGpj0qot9BOd7uVv63qDP51AWVdFv8bkweZq4MoNBRqlZt4sBIHLg0F3Lyf+YF7P8iRfgqv4ct8yXGWE/H7p8kaXMcpp2gf0/vVPOR1qyrU/iLfBcdQV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943165; c=relaxed/simple;
	bh=gLVZnYH8RyztHWedBiBheyvBydAbsVMkC5d77hHYZlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4DUTvo8eOTX4IRKM5YsgKzVQKygQWy85uex583dwgEgdTRFoTsi+wUl47TQJtx1Zaz7I7OvT+Z7paTYsIG2Rzk/C7EZi5hDHp00isnCPC8xIBEuJZ5ru+vNteTe3JkJgz3N3OD4oQ0iDyNyizEGN2qGiP+43vwoyVQzC+cZK+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kgB4FtVh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kgB4FtVh"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 38A3E27312;
	Thu, 19 Mar 2026 18:59:15 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NzVVZRHtfIks; Thu, 19 Mar 2026 18:59:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773943154; bh=gLVZnYH8RyztHWedBiBheyvBydAbsVMkC5d77hHYZlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kgB4FtVh4SrcrA2zRxOF9T2HBlj9bEEH2UQhgBSz5s+QO1J1qkydh064b2zdQmJYY
	 0p33+4gWfiXPZ5KTKr45zkJayZZ3d674zlopP50DTbg4rphDtArKCz8LzDyV5pP8KX
	 KEjyHym3nbdtZlEFD4pW4yVJky3KdV3RnpgGwWIAMEhWOqiMN9WHS3A7lLBQTsSUlm
	 +cYtfHyNDZ4AfrG6IAdUI/Xi65utucnxzEH8BZ+8uNBzsJXg9RrmOUjYtUK2KBFRhk
	 jQQ34JRQqZ2DgWL3L1czoNc5E7HPYHmOYVTbPhIMVoiKSdI8Dh0vlYu5DHVrd4sAaD
	 Zq7rvkVX5IO6A==
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
Subject: [PATCH v2 1/8] i2c: rtl9300: split data_reg into read and write reg
Date: Thu, 19 Mar 2026 22:57:46 +0500
Message-ID: <20260319175753.32338-2-adilov@disroot.org>
In-Reply-To: <20260319175753.32338-1-adilov@disroot.org>
References: <20260319175753.32338-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RTL9607C i2c controller, there are 2 separate registers for reads
and writes as opposed the combined 1 on rtl9300 and rtl9310.

In preparation for RTL9607C support, split it up into rd_reg and wd_reg
properties and change the i2c read and write functions accordingly.

Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 67a5c4228fc9..9bf4c6b08e05 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -61,7 +61,8 @@ enum rtl9300_i2c_reg_fields {
 struct rtl9300_i2c_drv_data {
 	struct rtl9300_i2c_reg_field field_desc[F_NUM_FIELDS];
 	int (*select_scl)(struct rtl9300_i2c *i2c, u8 scl);
-	u32 data_reg;
+	u32 rd_reg;
+	u32 wd_reg;
 	u8 max_nchan;
 };
 
@@ -74,7 +75,8 @@ struct rtl9300_i2c {
 	struct rtl9300_i2c_chan chans[RTL9310_I2C_MUX_NCHAN];
 	struct regmap_field *fields[F_NUM_FIELDS];
 	u32 reg_base;
-	u32 data_reg;
+	u32 rd_reg;
+	u32 wd_reg;
 	u8 scl_num;
 	u8 sda_num;
 	struct mutex lock;
@@ -171,7 +173,7 @@ static int rtl9300_i2c_read(struct rtl9300_i2c *i2c, u8 *buf, u8 len)
 	if (len > 16)
 		return -EIO;
 
-	ret = regmap_bulk_read(i2c->regmap, i2c->data_reg, vals, ARRAY_SIZE(vals));
+	ret = regmap_bulk_read(i2c->regmap, i2c->rd_reg, vals, ARRAY_SIZE(vals));
 	if (ret)
 		return ret;
 
@@ -198,12 +200,12 @@ static int rtl9300_i2c_write(struct rtl9300_i2c *i2c, u8 *buf, u8 len)
 		vals[reg] |= buf[i] << shift;
 	}
 
-	return regmap_bulk_write(i2c->regmap, i2c->data_reg, vals, ARRAY_SIZE(vals));
+	return regmap_bulk_write(i2c->regmap, i2c->wd_reg, vals, ARRAY_SIZE(vals));
 }
 
 static int rtl9300_i2c_writel(struct rtl9300_i2c *i2c, u32 data)
 {
-	return regmap_write(i2c->regmap, i2c->data_reg, data);
+	return regmap_write(i2c->regmap, i2c->wd_reg, data);
 }
 
 static int rtl9300_i2c_prepare_xfer(struct rtl9300_i2c *i2c, struct rtl9300_i2c_xfer *xfer)
@@ -268,14 +270,14 @@ static int rtl9300_i2c_do_xfer(struct rtl9300_i2c *i2c, struct rtl9300_i2c_xfer
 	if (!xfer->write) {
 		switch (xfer->type) {
 		case RTL9300_I2C_XFER_BYTE:
-			ret = regmap_read(i2c->regmap, i2c->data_reg, &val);
+			ret = regmap_read(i2c->regmap, i2c->rd_reg, &val);
 			if (ret)
 				return ret;
 
 			*xfer->data = val & 0xff;
 			break;
 		case RTL9300_I2C_XFER_WORD:
-			ret = regmap_read(i2c->regmap, i2c->data_reg, &val);
+			ret = regmap_read(i2c->regmap, i2c->rd_reg, &val);
 			if (ret)
 				return ret;
 
@@ -408,7 +410,8 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
 	if (device_get_child_node_count(dev) > drv_data->max_nchan)
 		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
 
-	i2c->data_reg = i2c->reg_base + drv_data->data_reg;
+	i2c->rd_reg = i2c->reg_base + drv_data->rd_reg;
+	i2c->wd_reg = i2c->reg_base + drv_data->wd_reg;
 	for (i = 0; i < F_NUM_FIELDS; i++) {
 		fields[i] = drv_data->field_desc[i].field;
 		if (drv_data->field_desc[i].scope == REG_SCOPE_MASTER)
@@ -499,7 +502,8 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
 		[F_SDA_SEL]		= GLB_REG_FIELD(RTL9300_I2C_MST_GLB_CTRL, 0, 7),
 	},
 	.select_scl = rtl9300_i2c_select_scl,
-	.data_reg = RTL9300_I2C_MST_DATA_WORD0,
+	.rd_reg = RTL9300_I2C_MST_DATA_WORD0,
+	.wd_reg = RTL9300_I2C_MST_DATA_WORD0,
 	.max_nchan = RTL9300_I2C_MUX_NCHAN,
 };
 
@@ -519,7 +523,8 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 		[F_MEM_ADDR]		= MST_REG_FIELD(RTL9310_I2C_MST_MEMADDR_CTRL, 0, 23),
 	},
 	.select_scl = rtl9310_i2c_select_scl,
-	.data_reg = RTL9310_I2C_MST_DATA_CTRL,
+	.rd_reg = RTL9310_I2C_MST_DATA_CTRL,
+	.wd_reg = RTL9310_I2C_MST_DATA_CTRL,
 	.max_nchan = RTL9310_I2C_MUX_NCHAN,
 };
 
-- 
2.53.0


Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293AE32D0D8;
	Sat, 14 Mar 2026 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773476845; cv=none; b=PH9waFPi/qygtuzlm4iyumsdHRBqX9QKpBOtbA0cGT3SOBM4gBbPbMGCY9B5kgpvjxjkgTDmpfjuIEoo2NdGRfaQqh/PmtXn157cyjZzEpbRfm4zr+TtcxMDZeHFha5y9iOUBvP3ihLTNFVbkJRuiRLSl4oYMhvP3DcCo/RocGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773476845; c=relaxed/simple;
	bh=XZ1w1KvIa3CV+ZPgZfcPDWPjjJWpcjh6BeKa5wN95YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct+p0NviMSak0GtaUHArtrw0fQuHbzU/unzkn0+sqi3d5BeaFndo0QD7zFAcn95Dv5H86qV13EfVJ30Dc23rnSYiop6oJdEPF2aHoODEyeHJ1nvz8O4LLCTqRbmMEqnTvhGRT5ycaRqvdxhApqKbVad7tvj/RTvWZklXd24cm2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=aE2CtOEQ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="aE2CtOEQ"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DF2A22676F;
	Sat, 14 Mar 2026 09:27:22 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ebb908eLS7qx; Sat, 14 Mar 2026 09:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773476842; bh=XZ1w1KvIa3CV+ZPgZfcPDWPjjJWpcjh6BeKa5wN95YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aE2CtOEQ9Lp9dgGsIz5vWwRDRf8jByZdDLXqvUfRnuYPZsUNeU+LitBKrW5yDsJ3M
	 QpKxXbeUlzm3OCsYQuYgzmtu/r1Z9yKAWdbqngtOy3SRc5+JLkokqeP9IUVD28jiLW
	 HWyOL4j5Zqem07rbHqyujgRPH8JcRJV9Wqj9iyee4j0dExDqSTQqrruZlTaBsZQxHD
	 0/WTkGAMViLYnqMrv3GGk9Asqu2eiuiTsXxHRQFC7zVfa0oOhUcCfhxiJLgAljDhrZ
	 bittLHBzauKX36d/4ynToZtDkFuUXlEC68A92ZXdRQIHHejyPNUmtonHveUVdQTpOt
	 8a1KoGXP1Yefw==
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
Subject: [PATCH 2/8] i2c: rtl9300: introduce max length property to driver data
Date: Sat, 14 Mar 2026 13:26:22 +0500
Message-ID: <20260314082628.25206-3-adilov@disroot.org>
In-Reply-To: <20260314082628.25206-1-adilov@disroot.org>
References: <20260314082628.25206-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RTL9607C i2c controller, theoretical maximum the data length
can be is 4 bytes as opposed to 16 bytes on rtl9300 and rtl9310.

Introduce a new property to the driver data struct for that.
Adjust if statement in prepare_xfer function to follow that new
property instead of the hardcoded value.

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 66390420bd6a..1354c8a7a369 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -58,11 +58,14 @@ struct rtl9300_i2c_drv_data {
 	u32 rd_reg;
 	u32 wd_reg;
 	u8 max_nchan;
+	u8 max_data_len;
 };
 
 #define RTL9300_I2C_MUX_NCHAN	8
 #define RTL9310_I2C_MUX_NCHAN	12
 
+#define RTL9300_I2C_MAX_DATA_LEN	16
+
 struct rtl9300_i2c {
 	struct regmap *regmap;
 	struct device *dev;
@@ -204,9 +207,11 @@ static int rtl9300_i2c_writel(struct rtl9300_i2c *i2c, u32 data)
 
 static int rtl9300_i2c_prepare_xfer(struct rtl9300_i2c *i2c, struct rtl9300_i2c_xfer *xfer)
 {
+	const struct rtl9300_i2c_drv_data *drv_data;
 	int ret;
 
-	if (xfer->data_len < 1 || xfer->data_len > 16)
+	drv_data = device_get_match_data(i2c->dev);
+	if (xfer->data_len < 1 || xfer->data_len > drv_data->max_data_len)
 		return -EINVAL;
 
 	ret = regmap_field_write(i2c->fields[F_DEV_ADDR], xfer->dev_addr);
@@ -493,6 +498,7 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
 	.rd_reg = RTL9300_I2C_MST_DATA_WORD0,
 	.wd_reg = RTL9300_I2C_MST_DATA_WORD0,
 	.max_nchan = RTL9300_I2C_MUX_NCHAN,
+	.max_data_len = RTL9300_I2C_MAX_DATA_LEN,
 };
 
 static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
@@ -514,6 +520,7 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 	.rd_reg = RTL9310_I2C_MST_DATA_CTRL,
 	.wd_reg = RTL9310_I2C_MST_DATA_CTRL,
 	.max_nchan = RTL9310_I2C_MUX_NCHAN,
+	.max_data_len = RTL9300_I2C_MAX_DATA_LEN,
 };
 
 static const struct of_device_id i2c_rtl9300_dt_ids[] = {
-- 
2.53.0


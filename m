Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841640710B;
	Thu, 26 Mar 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538851; cv=none; b=D0fpJqoDdhJuJ0+qr5hhC06UjjSL8UyORPss6OnaJ0WNFOL0juN5bm0Aww7YsSBc2C044BtBOuA80YvDyJm8pM5NuMRo1zPLVrccuw6B0fv1K/Dc7Pwl3iZ2EMOauEx9dWjmMSJzA/NzR6Q8AgXuRXyG9eoM3zWrmJCWfeqkqlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538851; c=relaxed/simple;
	bh=78qH5nIWIELIDV6PJGBxhJTVaTi35H4kfKGiY4tduC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd2UI0JuVjdloFpzsrrTMrCfHxxSQLsDk62x0GUkX4b5DQzlnHnV58X4bdIMU8oL1w7fb6bOhGabAoDJdOHW4arPEsZ+s0sd+W6ggK0QeO8A7wc9xlAlhaAlnCv8T+0GdcsS3Y0wXCs9hjYK2rD7d0xa+MZ47qbsRNv4pN41Dco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iHNJe8Od; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iHNJe8Od"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 56A19264DD;
	Thu, 26 Mar 2026 16:27:28 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0cnvZarManhI; Thu, 26 Mar 2026 16:27:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774538847; bh=78qH5nIWIELIDV6PJGBxhJTVaTi35H4kfKGiY4tduC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHNJe8OdJds1rmXcV0W40zvTX9fCdn+CkGW2y1qYVEC12jBdfpI8TF4mGERREpPUa
	 AQIraAzeYbBhbsJmKLnvN9AS+C4sxYtwBVCGJoTv6YQBRUJrIPTcIR2agDzCzE5uhR
	 jOL+Gg8gqi8XC/+Aw9IrZ1b9dLIqt+PnB1/wRbML1MWHEAsIMlKtBMXZV/T4eJvE/E
	 RhWHYEdNy7fvDOhpp9ZouV1mW2pcMO67ER9t/j9/3X51LscCJscEvccB1qKDLBnouG
	 OYWuzO6mmqfJDldW+IyEg6/R70fdyox5iSaAL44o5EjWQxvSiSxM4481FtBXoNfq9x
	 JHDa/Ww9v+tnQ==
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
Subject: [PATCH v5 2/8] i2c: rtl9300: introduce max length property to driver data
Date: Thu, 26 Mar 2026 20:26:50 +0500
Message-ID: <20260326152656.14030-3-adilov@disroot.org>
In-Reply-To: <20260326152656.14030-1-adilov@disroot.org>
References: <20260326152656.14030-1-adilov@disroot.org>
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

Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 9bf4c6b08e05..2cada6038b44 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -64,11 +64,14 @@ struct rtl9300_i2c_drv_data {
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
@@ -210,9 +213,11 @@ static int rtl9300_i2c_writel(struct rtl9300_i2c *i2c, u32 data)
 
 static int rtl9300_i2c_prepare_xfer(struct rtl9300_i2c *i2c, struct rtl9300_i2c_xfer *xfer)
 {
+	const struct rtl9300_i2c_drv_data *drv_data;
 	int ret;
 
-	if (xfer->data_len < 1 || xfer->data_len > 16)
+	drv_data = device_get_match_data(i2c->dev);
+	if (xfer->data_len < 1 || xfer->data_len > drv_data->max_data_len)
 		return -EINVAL;
 
 	ret = regmap_field_write(i2c->fields[F_DEV_ADDR], xfer->dev_addr);
@@ -505,6 +510,7 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
 	.rd_reg = RTL9300_I2C_MST_DATA_WORD0,
 	.wd_reg = RTL9300_I2C_MST_DATA_WORD0,
 	.max_nchan = RTL9300_I2C_MUX_NCHAN,
+	.max_data_len = RTL9300_I2C_MAX_DATA_LEN,
 };
 
 static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
@@ -526,6 +532,7 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 	.rd_reg = RTL9310_I2C_MST_DATA_CTRL,
 	.wd_reg = RTL9310_I2C_MST_DATA_CTRL,
 	.max_nchan = RTL9310_I2C_MUX_NCHAN,
+	.max_data_len = RTL9300_I2C_MAX_DATA_LEN,
 };
 
 static const struct of_device_id i2c_rtl9300_dt_ids[] = {
-- 
2.53.0


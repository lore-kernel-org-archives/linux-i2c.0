Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149230E83A;
	Wed,  1 Apr 2026 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066845; cv=none; b=oOtqr3r+UqGze5BoRuh0IGAGZymp3ESZCyuf29d6YsT8sPqBdPdEhYiRdx5s0Za0+feRrMjV/cv3DMl1Y27WQRKiU/8eO2MkiOIH7s5M5Pzy5EWUkHsTwSBlTRFBt4JxyWqHeZLevgtYuAcGULBUnT9dcTfJeYbaadgjNRIwiIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066845; c=relaxed/simple;
	bh=78qH5nIWIELIDV6PJGBxhJTVaTi35H4kfKGiY4tduC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpBcAVjsYtTgqG7/8jpFxsVY815j0G2GF3hMgKmyOztNCuPljKn20TdstcWhqrOXuiFMaJEsWBDyY0xyuT8wVMAqN7eQDNHmLRgMvU30xh6oZQBvaIHrBuX03BZbQxM6QTKPgA6+eIoNX4F3VnZDH3vkLWdzzqfHiFB+lO8TZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fDD1/e16; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fDD1/e16"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 186A025D79;
	Wed,  1 Apr 2026 20:07:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h3Il5tcyWnwO; Wed,  1 Apr 2026 20:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775066836; bh=78qH5nIWIELIDV6PJGBxhJTVaTi35H4kfKGiY4tduC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fDD1/e16erxOrH2KgadQJJKaCcQ0WuJmfALmxZCZ2z0HBYagz50+La+mhE8sMQTuq
	 VCsF4bOtf2Ge6KHoqNgDXUYTKeV5meOdfHOTkCOYSmLR8/LoINSIdFHyZh7mZAE9tl
	 AaWFFx3yTKpondtVc+UWArHeEt0la3Ir00yUKzDvxYvLh+5ZFMcz/QU+VLscM6tP7i
	 E3oIM7jbXCv9UGVstP99CDZd74clpC5yplZoGV9XNZyDOwAba9LDgOJNZrkM5YubSD
	 0JoPIb44ybuPoagmgj9Pi8atct8A6oHG+Fmnr5O0jOLl8Sl1jeMeFssVAQR9mbC0Dj
	 fszyFpPoof00A==
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
Subject: [PATCH v6 2/8] i2c: rtl9300: introduce max length property to driver data
Date: Wed,  1 Apr 2026 23:06:42 +0500
Message-ID: <20260401180648.337834-3-adilov@disroot.org>
In-Reply-To: <20260401180648.337834-1-adilov@disroot.org>
References: <20260401180648.337834-1-adilov@disroot.org>
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


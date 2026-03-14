Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573522DCC05;
	Sat, 14 Mar 2026 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773476862; cv=none; b=Qvn+bPjWh67M/hLHBcm3i3hxG1lQyz1OQ7E5Q0ZTYgyR4r8OP2aQ4YbBTgRPix8P+BBvHTMxbZBp8+n9qASbePYcwlx01SRBnH5GooyqC02XnTysufOCu+UXgBq5E1XlZBMO1hNUQdhGOpEiuGpzg1qpQZP5VJyIrbUo6lOKmfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773476862; c=relaxed/simple;
	bh=KLpVO8hnVsxasYM9RKBW/SYpFjxwis+040wASje/CLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5Qvy2/PcBLSBi0+G7UzxceADqkKP90W+WQGmZ5Szm2J1mPSqqjyVafhhZyzHrNfcK4lexbfdiI5DenJqg8lRdmMp7pr2ULPTXZ5S6MaSdAN3FqM8+pJYonjU1sdgRWxY5k4TsMJuZo7TW2Z7oKh1FH9pRrniNnjKZ7JPsyPopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JfgqtbQ3; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JfgqtbQ3"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 14EFC26F8F;
	Sat, 14 Mar 2026 09:27:40 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11275bj0QC-i; Sat, 14 Mar 2026 09:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773476859; bh=KLpVO8hnVsxasYM9RKBW/SYpFjxwis+040wASje/CLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JfgqtbQ36632WyfYwN2yn/3HIDspHgjH6mrsFMyvN5ygLqocqcpjo2QzbV6H2cm2J
	 o17vvYE+eH7mksdL/2c2HgCpNsg3+6A33pnGAExbJfOH572XvP/auVvXHGyZFN3rBg
	 Iel9WdlTubNXUf4TyG1ePDS9HVSgTkxWecLtxgbsASvyi5xTbd5IxkfJgaYlUhLhGK
	 ElSekQd6HmlmNdV0c/jScjzEkU4W/wNqsjGZdA0gBsH0yesz7V5nZb7RZ9VE9IoGA7
	 jkPl9eZ1CMwByHRexz8V81aHnSxdiS+4QYQSTJW0guB22u5725gzFq9UASX0WfY5g2
	 rwOW2gRWZ3Tkw==
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
Subject: [PATCH 8/8] i2c: rtl9300: add RTL9607C i2c controller support
Date: Sat, 14 Mar 2026 13:26:28 +0500
Message-ID: <20260314082628.25206-9-adilov@disroot.org>
In-Reply-To: <20260314082628.25206-1-adilov@disroot.org>
References: <20260314082628.25206-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the internal I2C controllers of RTL9607C series based
SoCs. Add register definitions, chip-specific functions and macros too.

Make use of the clk introduced from the previous patch to get the clk_div
value and use it during the rtl9607c channel configuration.

Introduce a new EXT_SCK_5MS field to the reg fields struct which is going
to be initialized by rtl9607c init function at the end of the probe.

This patch depends on all the previous patches in this patch series.

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 7930f47a37b2..4ea9e0bade19 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -51,6 +51,7 @@ enum rtl9300_i2c_reg_fields {
 	F_SDA_SEL,
 	F_BUSY,
 	F_CLK_DIV,
+	F_EXT_SCK_5MS,
 
 	/* keep last */
 	F_NUM_FIELDS
@@ -71,8 +72,10 @@ struct rtl9300_i2c_drv_data {
 
 #define RTL9300_I2C_MUX_NCHAN	8
 #define RTL9310_I2C_MUX_NCHAN	12
+#define RTL9607_I2C_MUX_NCHAN	1
 
 #define RTL9300_I2C_MAX_DATA_LEN	16
+#define RTL9607_I2C_MAX_DATA_LEN	4
 
 struct rtl9300_i2c {
 	struct regmap *regmap;
@@ -121,6 +124,14 @@ struct rtl9300_i2c_xfer {
 #define RTL9310_I2C_MST_MEMADDR_CTRL			0x4
 #define RTL9310_I2C_MST_DATA_CTRL			0x8
 
+#define RTL9607_I2C_CONFIG				0x22f50
+#define RTL9607_IO_MODE_EN				0x23014
+#define RTL9607_I2C_IND_WD				0x0
+#define RTL9607_I2C_IND_ADR				0x8
+#define RTL9607_I2C_IND_CMD				0x10
+#define RTL9607_I2C_IND_RD				0x18
+#define RTL9607_REG_ADDR_8BIT_LEN			0
+
 static int rtl9300_i2c_reg_addr_set(struct rtl9300_i2c *i2c, u32 reg, u16 len)
 {
 	int ret;
@@ -172,6 +183,27 @@ static int rtl9300_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_c
 	return 0;
 }
 
+static int rtl9607_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_chan *chan)
+{
+	const struct rtl9300_i2c_drv_data *drv_data;
+	int ret;
+
+	if (i2c->sda_num == chan->sda_num)
+		return 0;
+
+	ret = regmap_field_write(i2c->fields[F_CLK_DIV], chan->clk_div);
+	if (ret)
+		return ret;
+
+	drv_data = device_get_match_data(i2c->dev);
+	ret = drv_data->select_scl(i2c, i2c->scl_num);
+	if (ret)
+		return ret;
+
+	i2c->sda_num = chan->sda_num;
+	return 0;
+}
+
 static void rtl9300_i2c_config_clock(u32 clock_freq, struct rtl9300_i2c_chan *chan)
 {
 	struct rtl9300_i2c *i2c = chan->i2c;
@@ -190,6 +222,13 @@ static void rtl9300_i2c_config_clock(u32 clock_freq, struct rtl9300_i2c_chan *ch
 	}
 }
 
+static void rtl9607_i2c_config_clock(u32 clock_freq, struct rtl9300_i2c_chan *chan)
+{
+	struct rtl9300_i2c *i2c = chan->i2c;
+
+	chan->clk_div = clk_get_rate(i2c->clk) / clock_freq - 1;
+}
+
 static int rtl9300_i2c_read(struct rtl9300_i2c *i2c, u8 *buf, u8 len)
 {
 	u32 vals[4] = {};
@@ -410,6 +449,11 @@ static int rtl9300_i2c_init(struct rtl9300_i2c *i2c)
 	return regmap_field_write(i2c->fields[F_RD_MODE], 0);
 }
 
+static int rtl9607_i2c_init(struct rtl9300_i2c *i2c)
+{
+	return regmap_field_write(i2c->fields[F_EXT_SCK_5MS], 1);
+}
+
 static int rtl9300_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -562,6 +606,31 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 	.reg_addr_8bit_len = RTL9300_REG_ADDR_8BIT_LEN,
 };
 
+static const struct rtl9300_i2c_drv_data rtl9607_i2c_drv_data = {
+	.field_desc = {
+		[F_SCL_SEL]		= GLB_REG_FIELD(RTL9607_IO_MODE_EN, 13, 14),
+		[F_EXT_SCK_5MS]		= MST_REG_FIELD(RTL9607_I2C_CONFIG, 26, 26),
+		[F_DEV_ADDR]		= MST_REG_FIELD(RTL9607_I2C_CONFIG, 14, 20),
+		[F_MEM_ADDR_WIDTH]	= MST_REG_FIELD(RTL9607_I2C_CONFIG, 12, 13),
+		[F_DATA_WIDTH]		= MST_REG_FIELD(RTL9607_I2C_CONFIG, 10, 11),
+		[F_CLK_DIV]		= MST_REG_FIELD(RTL9607_I2C_CONFIG, 0, 9),
+		[F_I2C_FAIL]		= MST_REG_FIELD(RTL9607_I2C_IND_CMD, 3, 3),
+		[F_BUSY]		= MST_REG_FIELD(RTL9607_I2C_IND_CMD, 2, 2),
+		[F_RWOP]		= MST_REG_FIELD(RTL9607_I2C_IND_CMD, 1, 1),
+		[F_I2C_TRIG]		= MST_REG_FIELD(RTL9607_I2C_IND_CMD, 0, 0),
+		[F_MEM_ADDR]		= MST_REG_FIELD(RTL9607_I2C_IND_ADR, 0, 31),
+	},
+	.select_scl = rtl9310_i2c_select_scl,
+	.config_chan = rtl9607_i2c_config_chan,
+	.config_clock = rtl9607_i2c_config_clock,
+	.misc_init = rtl9607_i2c_init,
+	.rd_reg = RTL9607_I2C_IND_RD,
+	.wd_reg = RTL9607_I2C_IND_WD,
+	.max_nchan = RTL9607_I2C_MUX_NCHAN,
+	.max_data_len = RTL9607_I2C_MAX_DATA_LEN,
+	.reg_addr_8bit_len = RTL9607_REG_ADDR_8BIT_LEN,
+};
+
 static const struct of_device_id i2c_rtl9300_dt_ids[] = {
 	{ .compatible = "realtek,rtl9301-i2c", .data = (void *) &rtl9300_i2c_drv_data },
 	{ .compatible = "realtek,rtl9302b-i2c", .data = (void *) &rtl9300_i2c_drv_data },
@@ -571,6 +640,7 @@ static const struct of_device_id i2c_rtl9300_dt_ids[] = {
 	{ .compatible = "realtek,rtl9311-i2c", .data = (void *) &rtl9310_i2c_drv_data },
 	{ .compatible = "realtek,rtl9312-i2c", .data = (void *) &rtl9310_i2c_drv_data },
 	{ .compatible = "realtek,rtl9313-i2c", .data = (void *) &rtl9310_i2c_drv_data },
+	{ .compatible = "realtek,rtl9607-i2c", .data = (void *) &rtl9607_i2c_drv_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, i2c_rtl9300_dt_ids);
-- 
2.53.0


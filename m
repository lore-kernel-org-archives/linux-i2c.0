Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7B31B10B;
	Wed,  1 Apr 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775066853; cv=none; b=Ji1RPuutKBNfGN9CPEV1wVFz3QEqxy8PQ2utmBWTgcVTqyBNYBM5NTX8imW3wqBJvyUw0AewrXxVpgrE0ZO1ArTQgjMNiF3EikqdBALIug5/EtAeSJt5EJPwBWaq4DK79UvP9/PSHBNjkFgEQxHWwHcVqtd+jMtvHczEUb1+8OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775066853; c=relaxed/simple;
	bh=ov7gAUZ+HttR2UyoVExn+ZrfViQk6IyIflOA57OqFPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbEzGt/AUD2yrI8OkA3V383rlRXV4+JGV3yiq5v99IDZRhvJfzCDRu2PDI+Wf5IUmegKMQKADr2rp02ylB7sJgIawLI95G1H0WA+luKdO7/5cNa3cT5cKX6vrd02Qds7QI13ki3YIF4sxqqPx1HCRpefFQ9j+Y3/0xk1Qoo/7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=fqTo0jso; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="fqTo0jso"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 46ADF266FA;
	Wed,  1 Apr 2026 20:07:30 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EOm9lDE-4uNI; Wed,  1 Apr 2026 20:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1775066849; bh=ov7gAUZ+HttR2UyoVExn+ZrfViQk6IyIflOA57OqFPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqTo0jsog6Olfp9mYFU8Ix7CnMVWB1IA6R8OLZKO4/Fip+5AEX2s75Hj3czXqldih
	 GMAmCVU1eDeLdGJYjs8eal4RpZ8zz0wsTlF9YK6nCYVxlJn4Btf1aiI36fgjuXuoGx
	 a7A3UgQXg/NO7jd6GMxRcXYqr2q3YTe0FL2/kTR+o0c/adyY3Pyq4Ve5wI6rty2sII
	 /bzzrr4HxvBbGwqejYNgt+XY2GE4Df9xQsZK0+TYy0lU7Huovw7mm4dQTIRJSJ8sUh
	 2pEtTVzTfDn6sSuVUo/h/jtUVd6KcimRGkEW0cMT7p6Zg2UmgKw9b+p1UgX5uPmUkw
	 vWqHIFTqgiVEA==
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
Subject: [PATCH v6 7/8] i2c: rtl9300: introduce new function properties to driver data
Date: Wed,  1 Apr 2026 23:06:47 +0500
Message-ID: <20260401180648.337834-8-adilov@disroot.org>
In-Reply-To: <20260401180648.337834-1-adilov@disroot.org>
References: <20260401180648.337834-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the very nature of differences between RTL9607C i2c controller
and RTL9300 / RTL9310 that are incompatible with each other in some areas
of this driver, for example in clock configuration, channel configuration
and initialization at the end of the probe, introduce new function
properties to the driver data struct to handle those differences.

With these new properties, create configuration functions for RTL9300 and
RTL9310 and assign them to their respective driver data structs.

Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 66 +++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index 16af49ccd1dd..b718b74afe0d 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -65,6 +65,9 @@ enum rtl9300_i2c_reg_fields {
 struct rtl9300_i2c_drv_data {
 	struct rtl9300_i2c_reg_field field_desc[F_NUM_FIELDS];
 	int (*select_scl)(struct rtl9300_i2c *i2c, u8 scl);
+	int (*config_chan)(struct rtl9300_i2c *i2c, struct rtl9300_i2c_chan *chan);
+	void (*config_clock)(u32 clock_freq, struct rtl9300_i2c_chan *chan);
+	int (*misc_init)(struct rtl9300_i2c *i2c);
 	u32 rd_reg;
 	u32 wd_reg;
 	u8 max_nchan;
@@ -175,6 +178,30 @@ static int rtl9300_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_c
 	return 0;
 }
 
+static void rtl9300_i2c_config_clock(u32 clock_freq, struct rtl9300_i2c_chan *chan)
+{
+	struct rtl9300_i2c *i2c = chan->i2c;
+
+	switch (clock_freq) {
+	case I2C_MAX_STANDARD_MODE_FREQ:
+		chan->bus_freq = RTL9300_I2C_STD_FREQ;
+		break;
+	case I2C_MAX_FAST_MODE_FREQ:
+		chan->bus_freq = RTL9300_I2C_FAST_FREQ;
+		break;
+	case RTL9300_I2C_MAX_SUPER_FAST_FREQ:
+		chan->bus_freq = RTL9300_I2C_SUPER_FAST_FREQ;
+		break;
+	case RTL9300_I2C_MAX_SLOW_FREQ:
+		chan->bus_freq = RTL9300_I2C_SLOW_FREQ;
+		break;
+	default:
+		dev_warn(i2c->dev, "SDA%d clock-frequency %d not supported using default\n",
+			 chan->sda_num, clock_freq);
+		break;
+	}
+}
+
 static int rtl9300_i2c_read(struct rtl9300_i2c *i2c, u8 *buf, u8 len)
 {
 	u32 vals[4] = {};
@@ -322,7 +349,7 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
 	guard(rtl9300_i2c)(i2c);
 
 	drv_data = device_get_match_data(i2c->dev);
-	ret = rtl9300_i2c_config_chan(i2c, chan);
+	ret = drv_data->config_chan(i2c, chan);
 	if (ret)
 		return ret;
 
@@ -389,6 +416,12 @@ static struct i2c_adapter_quirks rtl9300_i2c_quirks = {
 	.max_write_len	= 16,
 };
 
+static int rtl9300_i2c_init(struct rtl9300_i2c *i2c)
+{
+	/* only use standard read format */
+	return regmap_field_write(i2c->fields[F_RD_MODE], 0);
+}
+
 static int rtl9300_i2c_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -453,27 +486,11 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
 		if (ret)
 			clock_freq = I2C_MAX_STANDARD_MODE_FREQ;
 
-		switch (clock_freq) {
-		case I2C_MAX_STANDARD_MODE_FREQ:
-			chan->bus_freq = RTL9300_I2C_STD_FREQ;
-			break;
-		case I2C_MAX_FAST_MODE_FREQ:
-			chan->bus_freq = RTL9300_I2C_FAST_FREQ;
-			break;
-		case RTL9300_I2C_MAX_SUPER_FAST_FREQ:
-			chan->bus_freq = RTL9300_I2C_SUPER_FAST_FREQ;
-			break;
-		case RTL9300_I2C_MAX_SLOW_FREQ:
-			chan->bus_freq = RTL9300_I2C_SLOW_FREQ;
-			break;
-		default:
-			dev_warn(i2c->dev, "SDA%d clock-frequency %d not supported using default\n",
-				 sda_num, clock_freq);
-			break;
-		}
-
 		chan->sda_num = sda_num;
 		chan->i2c = i2c;
+
+		drv_data->config_clock(clock_freq, chan);
+
 		adap = &i2c->chans[i].adap;
 		adap->owner = THIS_MODULE;
 		adap->algo = &rtl9300_i2c_algo;
@@ -491,8 +508,7 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
 	}
 	i2c->sda_num = 0xff;
 
-	/* only use standard read format */
-	ret = regmap_field_write(i2c->fields[F_RD_MODE], 0);
+	ret = drv_data->misc_init(i2c);
 	if (ret)
 		return ret;
 
@@ -521,6 +537,9 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
 		[F_BUSY]		= MST_REG_FIELD(RTL9300_I2C_MST_CTRL1, 0, 0),
 	},
 	.select_scl = rtl9300_i2c_select_scl,
+	.config_chan = rtl9300_i2c_config_chan,
+	.config_clock = rtl9300_i2c_config_clock,
+	.misc_init = rtl9300_i2c_init,
 	.rd_reg = RTL9300_I2C_MST_DATA_WORD0,
 	.wd_reg = RTL9300_I2C_MST_DATA_WORD0,
 	.max_nchan = RTL9300_I2C_MUX_NCHAN,
@@ -545,6 +564,9 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 		[F_BUSY]		= MST_REG_FIELD(RTL9310_I2C_MST_CTRL, 0, 0),
 	},
 	.select_scl = rtl9310_i2c_select_scl,
+	.config_chan = rtl9300_i2c_config_chan,
+	.config_clock = rtl9300_i2c_config_clock,
+	.misc_init = rtl9300_i2c_init,
 	.rd_reg = RTL9310_I2C_MST_DATA_CTRL,
 	.wd_reg = RTL9310_I2C_MST_DATA_CTRL,
 	.max_nchan = RTL9310_I2C_MUX_NCHAN,
-- 
2.53.0


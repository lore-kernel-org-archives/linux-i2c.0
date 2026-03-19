Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651233F1655;
	Thu, 19 Mar 2026 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943181; cv=none; b=q4Y1+UT32NECZbHwYSd7ktj6D6+R3lljW5/iytP9H6fKgDqSuLSPTlxATzFC0exjxooaR1ORWQD+Zk4/7D8bdGaQmlQlZEJRicRyfgoy+1YIwUWaAKfUcvJXIG42g2joR8NLm67daB6OH2XVkQ+7wj1g4EjkhB9AcyD0zEyQve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943181; c=relaxed/simple;
	bh=ov7gAUZ+HttR2UyoVExn+ZrfViQk6IyIflOA57OqFPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o23+TWMTNTihDFy90eJ5wW3S5frNUpvF8PDOtny/gmMQF2VLcPSQg+63A3xm9gFDw6JQ3337G7Kruajkbe7/tgns+Fq9dx9va5VUdKaxyKHDZZxNVuNU3oqcoNvlCW+d0pcAZGF7WQjy6/hLUlUXR1i63Aru8yTimf4lzKETQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=E4M62aes; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="E4M62aes"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 34F5F2650C;
	Thu, 19 Mar 2026 18:59:39 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RM0SD9n4uTfm; Thu, 19 Mar 2026 18:59:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1773943178; bh=ov7gAUZ+HttR2UyoVExn+ZrfViQk6IyIflOA57OqFPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E4M62aesSk8Ls+ZRf1Atup4ipOu5CfS112Sx+IgTQcsBLJ0L8EqcubdepzrcOy3YB
	 zYWA+pfLhbj6DeSuoynjzaPcdJBbzfQR0qvfBqsXk/8bHI5yQ6OR3JXR549Fk7wsXY
	 jQZDq6tTGT1Nalv62TuI/na5+bxEfLeL4NkhG+QBT904eufRii+Fhjc4cKSk6/1fbd
	 OdGROha2J6xGSyVzz4hVy5fac0+vgDYyKWj4eUvOykqZufmS/tBYZKRlorqVmXLAJo
	 JjVXVWsPhRTvu+5qn+/HcxM7/S8hpG/I4ACQB4AVINaYHECfIpW3kFswnI0Yt1N5W9
	 zM9XGzNUqOOzw==
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
Subject: [PATCH v2 6/8] i2c: rtl9300: intoduce new function properties to driver data
Date: Thu, 19 Mar 2026 22:57:51 +0500
Message-ID: <20260319175753.32338-7-adilov@disroot.org>
In-Reply-To: <20260319175753.32338-1-adilov@disroot.org>
References: <20260319175753.32338-1-adilov@disroot.org>
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


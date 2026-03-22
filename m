Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CF381B0C;
	Sun, 22 Mar 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774182947; cv=none; b=ncV/+psG7a4+5g4XwBwvYUSJHFgt6tSZ9mQ0+9iXmGfQOvAHGpu1heUnV6UfA5s4AZf4Q9M52XNCWZOLjWG4tZ/yo/9/PK60nu96iqAhrUMToLp/8WgX8vzs+uJj4eBvKCvpcUIOAUD3/hC9osWlx+ccp7rWw7En6XKxMwV55E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774182947; c=relaxed/simple;
	bh=RwJI+wBXjRIWiP98ZF3hF7NJhpb6ggVHouRYyy/KwpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+hd0q3nawdAQ1v79omm0CuJkrNm2yLaVFuihWqf0+FajPLW0leQvRj8EaZhAL8MUdRAGnwufrsPC2xh7icjFk66qUXwkkE8i8VWpE+rKql6W9HuchUjqi+WE5rH9rw8I4daH3AEJ7Rkp56x93oWlircL+YswKgPb8cXfGos07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cgU4wnZb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cgU4wnZb"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4378226849;
	Sun, 22 Mar 2026 13:35:41 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KGa1lKlRf4Us; Sun, 22 Mar 2026 13:35:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1774182940; bh=RwJI+wBXjRIWiP98ZF3hF7NJhpb6ggVHouRYyy/KwpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cgU4wnZbQ5h3yVo5MdSADtHUlcp5MsPQEzBHzE6HSCNAY6HHpXShvmLOAHRXmoMIZ
	 Js7M47hA5c3zbyMsaCLBq7AUJKcZmylMw5YT/xiESWz3iRBQphk5vFgwZ2guTG94df
	 FOKKDitrfaczlpAxn5LeSSNXfMncy67UCDk8Kq7ffNT/5Kgg1wA97+lAIbHXv/usFm
	 wbo+LkwFVAEGYN1n1AFjRSk+uyKUIpYEUP4ox/cZSyiekic7P5goVGOQCVu9N5Uil9
	 P1tv4iuwey9poZNHpEKoGdf/S+BTl61nAvqXmm9WO62wzkKSsbLoQf+LT7ESnhkkJ0
	 dFTBIevNfpq0A==
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
Subject: [PATCH v3 4/8] i2c: rtl9300: introduce a property for 8 bit width reg address
Date: Sun, 22 Mar 2026 17:34:07 +0500
Message-ID: <20260322123411.32102-5-adilov@disroot.org>
In-Reply-To: <20260322123411.32102-1-adilov@disroot.org>
References: <20260322123411.32102-1-adilov@disroot.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RTL9607C i2c controller, in order to indicate that the width of
memory address is 8 bits, 0 is written to MEM_ADDR_WIDTH field as
opposed to 1 for RTL9300 and RTL9310.

Introduce a new property to a driver data to indicate what value
need to written to MEM_ADDR_WIDTH field for this case.

Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Rustam Adilov <adilov@disroot.org>
---
 drivers/i2c/busses/i2c-rtl9300.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
index e40b4692a3fa..ffbc6c52861b 100644
--- a/drivers/i2c/busses/i2c-rtl9300.c
+++ b/drivers/i2c/busses/i2c-rtl9300.c
@@ -66,6 +66,7 @@ struct rtl9300_i2c_drv_data {
 	u32 wd_reg;
 	u8 max_nchan;
 	u8 max_data_len;
+	u8 reg_addr_8bit_len;
 };
 
 #define RTL9300_I2C_MUX_NCHAN	8
@@ -111,6 +112,7 @@ struct rtl9300_i2c_xfer {
 #define RTL9300_I2C_MST_DATA_WORD2			0x10
 #define RTL9300_I2C_MST_DATA_WORD3			0x14
 #define RTL9300_I2C_MST_GLB_CTRL			0x384
+#define RTL9300_REG_ADDR_8BIT_LEN			1
 
 #define RTL9310_I2C_MST_IF_CTRL				0x1004
 #define RTL9310_I2C_MST_IF_SEL				0x1008
@@ -305,6 +307,7 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
 				  union i2c_smbus_data *data)
 {
 	struct rtl9300_i2c_chan *chan = i2c_get_adapdata(adap);
+	const struct rtl9300_i2c_drv_data *drv_data;
 	struct rtl9300_i2c *i2c = chan->i2c;
 	struct rtl9300_i2c_xfer xfer = {0};
 	int ret;
@@ -314,6 +317,7 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
 
 	guard(rtl9300_i2c)(i2c);
 
+	drv_data = device_get_match_data(i2c->dev);
 	ret = rtl9300_i2c_config_chan(i2c, chan);
 	if (ret)
 		return ret;
@@ -321,7 +325,7 @@ static int rtl9300_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned s
 	xfer.dev_addr = addr & 0x7f;
 	xfer.write = (read_write == I2C_SMBUS_WRITE);
 	xfer.reg_addr = command;
-	xfer.reg_addr_len = 1;
+	xfer.reg_addr_len = drv_data->reg_addr_8bit_len;
 
 	switch (size) {
 	case I2C_SMBUS_BYTE:
@@ -513,6 +517,7 @@ static const struct rtl9300_i2c_drv_data rtl9300_i2c_drv_data = {
 	.wd_reg = RTL9300_I2C_MST_DATA_WORD0,
 	.max_nchan = RTL9300_I2C_MUX_NCHAN,
 	.max_data_len = RTL9300_I2C_MAX_DATA_LEN,
+	.reg_addr_8bit_len = RTL9300_REG_ADDR_8BIT_LEN,
 };
 
 static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
@@ -536,6 +541,7 @@ static const struct rtl9300_i2c_drv_data rtl9310_i2c_drv_data = {
 	.wd_reg = RTL9310_I2C_MST_DATA_CTRL,
 	.max_nchan = RTL9310_I2C_MUX_NCHAN,
 	.max_data_len = RTL9300_I2C_MAX_DATA_LEN,
+	.reg_addr_8bit_len = RTL9300_REG_ADDR_8BIT_LEN,
 };
 
 static const struct of_device_id i2c_rtl9300_dt_ids[] = {
-- 
2.53.0


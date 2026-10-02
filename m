Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEA146DFF3
	for <linux-i2c@vger.kernel.org>; Fri,  2 Oct 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939598; cv=none; b=iFP9P2U8q8LIW46aigQMhfYXel89z8D6m69gn5ochu0IGgXRZypZhnb0wCvwlaakCQ1KlQTrqI2XGni6yziX2gp1XWYuI7utvMqUC6jHez8fz7gDMcRpps+pLU9TSzobRVkTL++ZB3r5HXVYJBjL1qO7NO91XKtHaLBYKxsozSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939598; c=relaxed/simple;
	bh=QRQaEclnrtrbKfZYObyRX1HiOJiIyZAXR224kDqzf+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyaGxWy9oEMPa51RMqmUtFQULLmhCQYHRBR1nqffkuUUrGfLbabQpUL/MJPHtN+ejS3PBSZFWUtjGQwn/ZMLR6ZNvLLAHGpORS4bpGRjjBEDpcwVW3PYQnhusLjW2KiRxtBdenYJG7aVmQ5E359CRMfQre9yBuS/WMwFfbEjR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2WWhZB+S; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2WWhZB+S"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C1E981A1086;
	Fri,  2 Oct 2026 11:13:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96BBC603DC;
	Fri,  2 Oct 2026 11:13:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72D13103282D2;
	Fri,  2 Oct 2026 13:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790939591; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Hrek6EE2qb4QiJSEkIbWK+7d1cHlWq/Lia1ubbr/WYQ=;
	b=2WWhZB+SzgFA2flFtRlIdj06xMRYZORV7jbkKX3qkZptush8Tmg3J5Dw0OzYnN+3H26F7m
	Wo/iJ/PfxSCw6f8mmlKpTsJqTXVIzF33cz3q5/4pNG1D0DRpyxHHozggxnBy45FYcVio6J
	hkjJiZNaz4N6Q+yhg7BjdtulXKuthSQroBxN1E8HcTTIofOKFxUZCcON8dxuZWYMwysphK
	kzXG2ZM5jV6iM08Y/xBc7/BYHymGok9Kr6RXOYfW5vP5fklRUoh/QRSWuwNOprk5s97yuP
	JswUOhBR3SIgGpZrIB1oAySk5cu1oqInI1OzjIx8MQXFrmzww/pkYoGA8RBlMg==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 02 Oct 2026 13:12:41 +0200
Subject: [PATCH v4 3/9] i2c: cgbc: Use plateform data to get bus ID and
 adapter name
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-cgbc-i2c-storage-devices-support-v4-3-eb42e0f1df59@bootlin.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Obtain the bus ID (from the BC point of view) and adapter name from
platform data. This allows the specific definitions to be removed, leaving
only a generic adapter definition.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c | 68 ++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 25a74fa51aa0..cc1cd75c4d74 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -12,9 +12,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#define CGBC_I2C_PRIMARY_BUS_ID	0
-#define CGBC_I2C_PM_BUS_ID	4
-
 #define CGBC_I2C_CMD_START	0x40
 #define CGBC_I2C_CMD_STAT	0x48
 #define CGBC_I2C_CMD_DATA	0x50
@@ -60,11 +57,6 @@ enum cgbc_i2c_state {
 	CGBC_I2C_STATE_ERROR,
 };
 
-struct i2c_algo_cgbc_data {
-	u8		bus_id;
-	unsigned long	read_maxtime_us;
-};
-
 struct cgbc_i2c_data {
 	struct device		*dev;
 	struct cgbc_device_data *cgbc;
@@ -73,6 +65,8 @@ struct cgbc_i2c_data {
 	int			nmsgs;
 	int			pos;
 	enum cgbc_i2c_state	state;
+	u8			bus_id;
+	unsigned long		read_maxtime_us;
 };
 
 struct cgbc_i2c_transfer {
@@ -115,10 +109,9 @@ static unsigned int cgbc_i2c_reg_to_freq(u8 reg)
 
 static int cgbc_i2c_get_status(struct i2c_adapter *adap)
 {
-	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
-	u8 cmd = CGBC_I2C_CMD_STAT | algo_data->bus_id;
+	u8 cmd = CGBC_I2C_CMD_STAT | i2c->bus_id;
 	u8 status;
 	int ret;
 
@@ -132,7 +125,6 @@ static int cgbc_i2c_get_status(struct i2c_adapter *adap)
 static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 				  unsigned int bus_frequency)
 {
-	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	u8 cmd[2], data;
@@ -144,7 +136,7 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 		bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
-	cmd[0] = CGBC_I2C_CMD_SPEED | algo_data->bus_id;
+	cmd[0] = CGBC_I2C_CMD_SPEED | i2c->bus_id;
 	cmd[1] = cgbc_i2c_freq_to_reg(bus_frequency);
 
 	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
@@ -170,7 +162,7 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 	 * can be read by a command is CGBC_I2C_READ_MAX_LEN.
 	 * Therefore, calculate the max time to properly size the timeout.
 	 */
-	algo_data->read_maxtime_us = (BITS_PER_BYTE + 1) * CGBC_I2C_READ_MAX_LEN
+	i2c->read_maxtime_us = (BITS_PER_BYTE + 1) * CGBC_I2C_READ_MAX_LEN
 		* USEC_PER_SEC / bus_frequency;
 
 	return 0;
@@ -200,7 +192,6 @@ static unsigned int cgbc_i2c_xfer_to_cmd(struct cgbc_i2c_transfer xfer, u8 *cmd)
 
 static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 {
-	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	struct i2c_msg *msg = i2c->msg;
@@ -210,7 +201,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 	u8 cmd_data;
 
 	struct cgbc_i2c_transfer xfer = {
-		.bus_id = algo_data->bus_id,
+		.bus_id = i2c->bus_id,
 		.addr = i2c_8bit_addr_from_msg(msg),
 	};
 
@@ -268,11 +259,11 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 
 		ret = read_poll_timeout(cgbc_i2c_get_status, ret,
 					ret != CGBC_I2C_STAT_BUSY, 0,
-					2 * algo_data->read_maxtime_us, false, adap);
+					2 * i2c->read_maxtime_us, false, adap);
 		if (ret < 0)
 			goto err;
 
-		cmd_data = CGBC_I2C_CMD_DATA | algo_data->bus_id;
+		cmd_data = CGBC_I2C_CMD_DATA | i2c->bus_id;
 		ret = cgbc_command(cgbc, &cmd_data, sizeof(cmd_data),
 				   msg->buf + i2c->pos, len, NULL);
 		if (ret)
@@ -335,44 +326,35 @@ static const struct i2c_algorithm cgbc_i2c_algorithm = {
 	.functionality = cgbc_i2c_func,
 };
 
-static struct i2c_algo_cgbc_data cgbc_i2c_algo_data[] = {
-	{ .bus_id = CGBC_I2C_PRIMARY_BUS_ID },
-	{ .bus_id = CGBC_I2C_PM_BUS_ID },
-};
-
-static const struct i2c_adapter cgbc_i2c_adapter[] = {
-	{
-		.owner		= THIS_MODULE,
-		.name		= "Congatec General Purpose I2C adapter",
-		.class		= I2C_CLASS_DEPRECATED,
-		.algo		= &cgbc_i2c_algorithm,
-		.algo_data	= &cgbc_i2c_algo_data[0],
-		.nr		= -1,
-	},
-	{
-		.owner		= THIS_MODULE,
-		.name		= "Congatec Power Management I2C adapter",
-		.class		= I2C_CLASS_DEPRECATED,
-		.algo		= &cgbc_i2c_algorithm,
-		.algo_data	= &cgbc_i2c_algo_data[1],
-		.nr		= -1,
-	},
+static const struct i2c_adapter cgbc_i2c_adapter = {
+	.owner		= THIS_MODULE,
+	.class		= I2C_CLASS_DEPRECATED,
+	.algo		= &cgbc_i2c_algorithm,
+	.nr		= -1,
 };
 
 static int cgbc_i2c_probe(struct platform_device *pdev)
 {
-	struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct cgbc_device_data *cgbc = dev_get_drvdata(dev->parent);
+	struct cgbc_i2c_platform_data *pdata;
 	struct cgbc_i2c_data *i2c;
 	int ret;
 
-	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
+	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
+	pdata = dev_get_platdata(dev);
+	if (!pdata)
+		return dev_err_probe(dev, -ENODEV, "missing platform_data\n");
+
 	i2c->cgbc = cgbc;
-	i2c->dev = &pdev->dev;
-	i2c->adap = cgbc_i2c_adapter[pdev->id];
+	i2c->dev = dev;
+	i2c->adap = cgbc_i2c_adapter;
 	i2c->adap.dev.parent = i2c->dev;
+	i2c->bus_id = pdata->cgbc_bus_id;
+	strscpy(i2c->adap.name, pdata->name, sizeof(i2c->adap.name));
 	i2c_set_adapdata(&i2c->adap, i2c);
 	platform_set_drvdata(pdev, i2c);
 

-- 
2.53.0


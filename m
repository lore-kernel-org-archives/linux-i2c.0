Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724574;
	b=CFzhj6ccIDZrg/YIanG7opDIOgiaodfYpnVxtGMEVsbjezViWSihRwFKG2Gsb2earpfV
	 o0jF/T78jNS86QPqQTW1wihHzR6jcoXhE4se+HdtU2Znsf4r2xjUKjvpD2vi/YLrXwID9
	 0pdPRRDHkba6mL6EUAXVyB7MDsobhTE6GMyptkwNeLRuVL1UTB0CosIEQbGZxtRQorIh6
	 Q8j4xTpK5H/K8oxk7RGMTYJDRA8uUi8WafoA7TyEkQyzhGLMZSoBZMhF5XDgUW7xJ1d1K
	 xubkhtXCH2gqRhYN+JwYKfbDkR7KvFW25bPGm+eVDGYEOHND3StSZIkp3HFMDA3r3RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724574;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=F9Kxz+/GPijvT1oPKNCsfGJFCGBSXMQozR90QHZWN/Q=;
	b=G5visd7h/oHTBRjVj4YTgeD8nIRNJM8CXAf2vqoK93ujyTQdYNjemlMkQdIPPOjruVzO
	 ZMHUd4O2ng3wRlykDy1BKG5pj7Uf0M744yeG4jN2h1YdVcqd/btro1Ibdcz0EO1aiyVlR
	 syModM/G8j2dMXN6fpxrGj6WlF7ztQrx4fJLmEUm2UYLoOwqFjzZd9cyHooKOGVMi2zBO
	 Ju31P1JDi4KW7ipuU4DLCfTUeBjlv5lugApVpO/9JbgkjTQ7KJO7jY4WOyHBFN54fXGD3
	 axHv4j/UG//6b+8RQEUyfaoeJ89krVwOvTmaVL0tV3Z+C9dWAhyKQ+EperpYznFhaNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YIUeZjvs;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A2606D82E
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 16:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240A2606D82E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YIUeZjvs
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 95B2A1A1436
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 16:49:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64EDD6046C;
	Tue,  3 Nov 2026 16:49:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 85873103291F6;
	Tue,  3 Nov 2026 17:49:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724571; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F9Kxz+/GPijvT1oPKNCsfGJFCGBSXMQozR90QHZWN/Q=;
	b=YIUeZjvsdYsTCboKAFdzerJkjjxeoy1tus5NsxuYChAJas4k7q7OYUioqy8NIEAeO/0M3U
	YQEx70cK44mEbxvb5iN4V3PbZmO4tcJo5l6iDKY4fsmX7fLYczb7pfbHptC6tC4qYdvRdL
	oLOV9v2Zn9djhS3jBCAI5Zy4ZXDaHhTM7A34ulOp8Q5J8Iq4M474+PkmRe0lL6og3V4R7N
	WiDYtWApD4Z5plkWOoYhia+SzAzbwrYZi0+Gx40699iTM1D1Ojk75Y63iIWlB1JZxkM6+J
	XYo/xZnLYspsj6bT4A9LbtX2SbiLrATO/a5n9gMfGihYbXk7kgU7nMEph2BjEQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:12 +0100
Subject: [PATCH v5 4/9] i2c: cgbc: Use plateform data to get bus ID and
 adapter name
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-4-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
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
index ac23435b731b..40ffab4fd0bc 100644
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
 	u8 cmd_data, data_len;
 
 	struct cgbc_i2c_transfer xfer = {
-		.bus_id = algo_data->bus_id,
+		.bus_id = i2c->bus_id,
 		.addr = i2c_8bit_addr_from_msg(msg),
 	};
 
@@ -268,7 +259,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 
 		ret = read_poll_timeout(cgbc_i2c_get_status, status,
 					status != CGBC_I2C_STAT_BUSY, 0,
-					2 * algo_data->read_maxtime_us, false, adap);
+					2 * i2c->read_maxtime_us, false, adap);
 		if (ret)
 			goto err;
 
@@ -282,7 +273,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 			goto err;
 		}
 
-		cmd_data = CGBC_I2C_CMD_DATA | algo_data->bus_id;
+		cmd_data = CGBC_I2C_CMD_DATA | i2c->bus_id;
 		ret = cgbc_command(cgbc, &cmd_data, sizeof(cmd_data),
 				   msg->buf + i2c->pos, len, &data_len);
 		if (ret)
@@ -350,44 +341,35 @@ static const struct i2c_algorithm cgbc_i2c_algorithm = {
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
-		.name		= "cgbc-i2c0",
-		.class		= I2C_CLASS_DEPRECATED,
-		.algo		= &cgbc_i2c_algorithm,
-		.algo_data	= &cgbc_i2c_algo_data[0],
-		.nr		= -1,
-	},
-	{
-		.owner		= THIS_MODULE,
-		.name		= "cgbc-ddc0",
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


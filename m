Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484433F23C0
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 18:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152543; cv=none; b=p3s8HaDB93VI4Wfrp5pxwPqeBXIhDtspTBVjAuXqTQXvQmYO44yCxo7UAqUYRvj0CtGUPFskEOyWhqxTBQVewP7uOLuLvvFpE8R354pB9hgSIcosYlpAJYKcNSIBs8006Tuv4qiQEOFs0XfG+stE2S3u4w9FQbKy5q1JHPA/djY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152543; c=relaxed/simple;
	bh=6uasUWW1Pv1/xpJBGur7yYwGOxREfBAI108G7qkQuAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gn8kT/qILDsQkmqqME4d3PbckijKLTJYtxvuzB5zhtZEo/N9vbLb75eqtfC7SdkmK5JXdN1mZIp7dQ/64Dt/G8/UAkSNDhpByxAuRtlKSab3m9vshnk9MwWBQzXAUidOvXE50SqLbwVwvnC0eu+lZvVrNn9vqyTHcVKbwcDsBe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iMYHrUoJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iMYHrUoJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8C35E1A0238;
	Fri, 11 Sep 2026 18:48:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 59B4E606CC;
	Fri, 11 Sep 2026 18:48:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D00DB11C7AF95;
	Fri, 11 Sep 2026 20:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789152537; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bNkNZ5mloq/4pMyL1jbXsxWjswvGDcsH+OiZ0h0Oy3Y=;
	b=iMYHrUoJVpblkuwm11R+0W8/WiGQn6f6llQp8P5oNlVTGvTWlGvY9ubjDSLVLE8SxjRD//
	45lPNrXhMMRPRKOO3eHc2khHhzvOYPE6VjyiXz2+BzHCujvjEGILQc1FcZwVd5fBm2a8BV
	AwxbwP3UKqwtRoLs58cO5tYoMwKYACWYYTaM7xDNyoyG3cNehv4I8rLY6C+G0hxhm1/m61
	uVSbYz2PvVGNbEnfMQfVYG+bHddIuzMo8lTUMjqXnBiAaVLU5HgzZP1WeLNd+bDMnhldZ9
	xznJil4mLNTgAQ49XdWIDOrPVrTfZjT/D4j6OKEtfKk5NgTHSbfTeneBcuQoJQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 11 Sep 2026 20:48:05 +0200
Subject: [PATCH v3 3/9] i2c: cgbc: Use plateform data to get bus ID and
 adapter name
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-cgbc-i2c-storage-devices-support-v3-3-594b53fbc5ea@bootlin.com>
References: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
In-Reply-To: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
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
 drivers/i2c/busses/i2c-cgbc.c | 69 ++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 25a74fa51aa0..d388e07aad84 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -10,11 +10,9 @@
 #include <linux/iopoll.h>
 #include <linux/mfd/cgbc.h>
 #include <linux/module.h>
+#include <linux/platform_data/i2c-cgbc.h>
 #include <linux/platform_device.h>
 
-#define CGBC_I2C_PRIMARY_BUS_ID	0
-#define CGBC_I2C_PM_BUS_ID	4
-
 #define CGBC_I2C_CMD_START	0x40
 #define CGBC_I2C_CMD_STAT	0x48
 #define CGBC_I2C_CMD_DATA	0x50
@@ -60,11 +58,6 @@ enum cgbc_i2c_state {
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
@@ -73,6 +66,8 @@ struct cgbc_i2c_data {
 	int			nmsgs;
 	int			pos;
 	enum cgbc_i2c_state	state;
+	u8			bus_id;
+	unsigned long		read_maxtime_us;
 };
 
 struct cgbc_i2c_transfer {
@@ -115,10 +110,9 @@ static unsigned int cgbc_i2c_reg_to_freq(u8 reg)
 
 static int cgbc_i2c_get_status(struct i2c_adapter *adap)
 {
-	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
-	u8 cmd = CGBC_I2C_CMD_STAT | algo_data->bus_id;
+	u8 cmd = CGBC_I2C_CMD_STAT | i2c->bus_id;
 	u8 status;
 	int ret;
 
@@ -132,7 +126,6 @@ static int cgbc_i2c_get_status(struct i2c_adapter *adap)
 static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 				  unsigned int bus_frequency)
 {
-	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	u8 cmd[2], data;
@@ -144,7 +137,7 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 		bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
 	}
 
-	cmd[0] = CGBC_I2C_CMD_SPEED | algo_data->bus_id;
+	cmd[0] = CGBC_I2C_CMD_SPEED | i2c->bus_id;
 	cmd[1] = cgbc_i2c_freq_to_reg(bus_frequency);
 
 	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
@@ -170,7 +163,7 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 	 * can be read by a command is CGBC_I2C_READ_MAX_LEN.
 	 * Therefore, calculate the max time to properly size the timeout.
 	 */
-	algo_data->read_maxtime_us = (BITS_PER_BYTE + 1) * CGBC_I2C_READ_MAX_LEN
+	i2c->read_maxtime_us = (BITS_PER_BYTE + 1) * CGBC_I2C_READ_MAX_LEN
 		* USEC_PER_SEC / bus_frequency;
 
 	return 0;
@@ -200,7 +193,6 @@ static unsigned int cgbc_i2c_xfer_to_cmd(struct cgbc_i2c_transfer xfer, u8 *cmd)
 
 static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 {
-	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	struct i2c_msg *msg = i2c->msg;
@@ -210,7 +202,7 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 	u8 cmd_data;
 
 	struct cgbc_i2c_transfer xfer = {
-		.bus_id = algo_data->bus_id,
+		.bus_id = i2c->bus_id,
 		.addr = i2c_8bit_addr_from_msg(msg),
 	};
 
@@ -268,11 +260,11 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 
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
@@ -335,44 +327,35 @@ static const struct i2c_algorithm cgbc_i2c_algorithm = {
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


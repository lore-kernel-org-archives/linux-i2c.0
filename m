Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908881;
	b=lidQWMBkXrfOJpqyScSZ0r4YVagsMfvAYaIXUjvrbxNkJNrkxhn9DfF2Xzne38vZHm9W
	 s1S6B0Cd3bGDkYjmV2EEjpkD7W4voPqJsCmKxNahwHdf5AUY/E88fgYmvgaG9d6GQ4bMV
	 6bA9PqfKYtrWTscEd48E/oCt8Fhu6VrMoiEDLVxeROsIy/gdOtYF0k/f7f+NN10DJS0ID
	 3Zme+08DXopWz0Zl2WQGuBi1kA1AXvhK5fMvXfSKLgzAxFKZBE2uHbZk56AqH13MOoi15
	 85WdGcOGcKGNfHHgYB044/sufm9lskMwAyVEFhYZCLWdGVZtO6YyFtvBUmFOfeHyn2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908881;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=n5uv/PXdXh3MTK+O8CMlRVhg7sEyPpcJ0VyqXAlR2Lw=;
	b=GzkvRtEyD8ukZhYQmyJ66T7bUnn2rhStJ4ethm460805tev/wgHEZg8PeB6YFruQfRs6
	 mjl26ZmYzEAxZ2B78BLgycS2LkZJIFxDUTtStRrEXCLbaK/UYwQkpA8Bci1g5eRIyNcYm
	 KD+GSH5tcHz+B+fsS4a9WqRSUb75Ojqf3ncCakPuSejeo2ZFU9Y6bs5aaQGB9m8ExHULl
	 3c2tyEYbaVRIcUuUutCuPLD84vVwXmcCgJChAkfYp07LmyWE/sm6uhVcmO66ML5GlEuFv
	 PpAaCZKvucQRxlXG6Eum9DLRWY3oE+G8dTFUSIrRMs6BAMBCvELQvvQeuOl2YHMK7MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zYNa4tU6;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CA60A2604;
	Tue, 17 Nov 2026 09:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 373CA60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zYNa4tU6
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EE2274E414C3;
	Tue, 17 Nov 2026 09:47:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4CA35FC81;
	Tue, 17 Nov 2026 09:47:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E175D11BC09A1;
	Tue, 17 Nov 2026 10:47:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794908877; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n5uv/PXdXh3MTK+O8CMlRVhg7sEyPpcJ0VyqXAlR2Lw=;
	b=zYNa4tU68+BpvLBBmIIQCO8cQGlYAggicTHRXcsOVhXGRa2CjVqcLOqABzVqlzgyazrlR1
	jV5FNPuH+/UFywDSREamHWQ+7FbmV0/zs7xbqX+Rfnhpm3hnmFQ3odl59GzG+370m4d305
	WoF8tfwvkLdzadBF+5iU9aCTmzbeeoPZOBXsp6MmGKbLen4uLPqPRjrEMMq5GkOLjZiDKC
	844yKHf1SIz6dFGkR7x8fO6xYZrfkDuL5D9W+weDiti6VBaIGWYyUZpI4SuPXYzu/VS6wI
	PJL/P8kuSP3ew1URAtmAM4zYIm3VcJy/DNwNTlsN+gOhT7QW9bCVrPbCdSvxdg==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 17 Nov 2026 10:47:45 +0100
Subject: [PATCH v6 05/10] i2c: cgbc: Use plateform data to get bus ID and
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
Message-Id: <20261117-cgbc-i2c-storage-devices-support-v6-5-bb070ad3e9aa@bootlin.com>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
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
index baf02bfe090c..50483bdc6730 100644
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
 
-	i2c = devm_kzalloc_obj(&pdev->dev, *i2c);
+	i2c = devm_kzalloc_obj(dev, *i2c);
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


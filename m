Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802317;
	b=R7vKywoeQGR37lOc+wWZu00779D3UnioGQV7ZTGsIIRuX/pHKhE1uFCji+xpWfSUZwl8
	 XQ6i97VujFqb/BHopyLxZ/62ZOmH4sLqY+7p6fzJJ8rVLgfAIeEWOsGcikFFnKanVvAlF
	 LMOS44pB/9hCc7qlUZsbcAgr+FyoiwgBZzbfIvE++HI/YnFroGvexAyiDO357VtzyDq5v
	 QNwuyAQ6wgO2eZKKot6KVvzQdYRtAfnTa4t374Ozh8KgRCeARyYTICtI4RVoyMeFO8wOs
	 GjA55dhv6whdjLvaDHGWIriKKTn+HumNJAn5v8XTmLw2NG2BiUF1pPPAFZQyzUGFHqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802317;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=KUcfyyvRjt6f6+XIUtGpur5XSwIQA21KPfNG4y+9nvg=;
	b=YY62yJU89UE9YmfUy2XdTjb2hI+Fip5DGO07Olnc9icGhGErZN18dTrWz5smVnhFWqmm
	 LzNGDJYbWscYP9hmcF4JGM603cOalgAXpCYDcfCMp37E+dTJ6oWSQ4Z37fahLcJYZgl0L
	 qoq0cpcCa84C+WVUepIzfe9aA04z0aAg25pXLsl22X8HJ4DqXEBRLc0GiwHY27SAF2oA0
	 axM/2kS/LT74DpemHoDAzV153EEUH/KSmevIY2vqUd5nclKlzuBSUbAy66quoxUtLjlO4
	 y0lonninFdNBbStPPVFGpO0dqh4bt5TxpF61i1X/6GZaET3l66EQ+QmyaMd32QytCFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="OTpcG/Ks";
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C9606A31C
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 17:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C5C9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OTpcG/Ks
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 01CDBC2AC4F
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 17:58:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 266046049C;
	Fri, 27 Nov 2026 17:58:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D14B0104395A3;
	Fri, 27 Nov 2026 18:58:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KUcfyyvRjt6f6+XIUtGpur5XSwIQA21KPfNG4y+9nvg=;
	b=OTpcG/Kscj+VVDcsJEmrAhiAUEwesgA+Cnwmq71XP+On6NJSiDtZpA75GkpCWQ9DV/PW+c
	DdAj/Ebkp6iGfFi0+hT/s/yFnRWdm9hNk6mzkCqO+UxqGZ+fPNXfXbcHNxG8UG8dJXGGVC
	ThI8Q9FbEZSwnZjFl5qkBD7X7lyODdbkZ5f3M1edyW8Ooyd8NgOvld7GMKR1pdkuWYCaKq
	f++pOYYiGQcDEovI2JMBDBSwklVOCf3U0TCQKrEXQvM97NW3Gu0f//XDiCkskFuHim7iFG
	DCaYbn0Fn/oL949Ou7Zl24Cyc701xTsldc/U1d7RKzhAmMDslQsntH0IWM5VmQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 27 Nov 2026 18:57:51 +0100
Subject: [PATCH v7 07/11] i2c: cgbc: Add support for fixed frequency buses
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
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-7-d0e70fc57879@bootlin.com>
References: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
In-Reply-To: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Some I2C buses run at a fixed frequency. Add a fixed_freq flag to struct
cgbc_i2c_platform_data to identify them. But the frequency is still needed
to compute read_maxtime_us, so split cgbc_i2c_set_frequency() into two
functions:
- cgbc_i2c_set_frequency(): sets the bus frequency (skipped for
  fixed-frequency buses).
- cgbc_i2c_get_frequency(): reads the bus frequency and computes
  read_maxtime_us.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c | 38 +++++++++++++++++++++++++++-----------
 include/linux/mfd/cgbc.h      |  2 ++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 50483bdc6730..85cbe709bcde 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -128,7 +128,6 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	u8 cmd[2], data;
-	int ret;
 
 	if (bus_frequency > CGBC_I2C_FREQ_MAX_HZ ||
 	    bus_frequency < CGBC_I2C_FREQ_MIN_HZ) {
@@ -139,18 +138,29 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 	cmd[0] = CGBC_I2C_CMD_SPEED | i2c->bus_id;
 	cmd[1] = cgbc_i2c_freq_to_reg(bus_frequency);
 
-	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
-	if (ret)
-		return dev_err_probe(i2c->dev, ret,
-				     "Failed to initialize I2C bus %s",
-				     adap->name);
+	return cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
+}
 
-	cmd[1] = 0x00;
+static int cgbc_i2c_get_frequency(struct i2c_adapter *adap)
+{
+	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
+	struct cgbc_device_data *cgbc = i2c->cgbc;
+	u8 cmd[2] = { CGBC_I2C_CMD_SPEED | i2c->bus_id };
+	unsigned int bus_frequency;
+	u8 data = 0;
+	int ret;
 
 	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
 	if (ret)
-		return dev_err_probe(i2c->dev, ret,
-				     "Failed to get I2C bus frequency");
+		return ret;
+
+	/*
+	 * The BC should never return a zero value; if it does, the resulting bus
+	 * frequency is 0 Hz, causing a division by zero when computing
+	 * read_maxtime_us.
+	 */
+	if (!data)
+		return -EIO;
 
 	bus_frequency = cgbc_i2c_reg_to_freq(data);
 
@@ -373,9 +383,15 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
 	i2c_set_adapdata(&i2c->adap, i2c);
 	platform_set_drvdata(pdev, i2c);
 
-	ret = cgbc_i2c_set_frequency(&i2c->adap, I2C_MAX_STANDARD_MODE_FREQ);
+	if (!pdata->fixed_freq) {
+		ret = cgbc_i2c_set_frequency(&i2c->adap, I2C_MAX_STANDARD_MODE_FREQ);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to set I2C bus frequency");
+	}
+
+	ret = cgbc_i2c_get_frequency(&i2c->adap);
 	if (ret)
-		return ret;
+		return dev_err_probe(i2c->dev, ret, "Failed to get I2C bus frequency");
 
 	return i2c_add_numbered_adapter(&i2c->adap);
 }
diff --git a/include/linux/mfd/cgbc.h b/include/linux/mfd/cgbc.h
index 4b6e41b9ca4a..63fdf16fec95 100644
--- a/include/linux/mfd/cgbc.h
+++ b/include/linux/mfd/cgbc.h
@@ -45,10 +45,12 @@ int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size
  * struct cgbc_i2c_platform_data - Platform data of the CGBC I2C driver
  * @name:		I2C adapter name
  * @cgbc_bus_id:	I2C bus ID (from Board Controller point of view)
+ * @fixed_freq:		I2C bus has a fixed frequency
  */
 struct cgbc_i2c_platform_data {
 	const char *name;
 	int cgbc_bus_id;
+	bool fixed_freq;
 };
 
 #endif /*_LINUX_MFD_CGBC_H_*/

-- 
2.53.0


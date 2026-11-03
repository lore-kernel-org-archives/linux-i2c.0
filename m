Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724576;
	b=QNOnTA761pLnd34l5ElVY2npNQQFJj2+LlNN0gLxsHEXoUKuIZA4mHQ2RVmvgAMwqjdy
	 bGBPsQY+UQfguF/g9LSr0kt5uR6JNUwN6Xm1P0fBJEDG3hIjMn+JxRhkke/GXEnW4wB2t
	 Gx0AO4h7FW84sY2XZ8k7kj+N9Lub2s1Gdb9aHcBX4CD8Zd5M/msr+53AiBorUcFprWGK4
	 2IAnh5LMO01t9zDw0sdhMOT2WwMCFZqRg4pNQakae+bHWWeTGAnBgMz0TYwiFB1ovIJ+G
	 D58MybsZkw7pLdlx1kZTq+GCVAFLQX/xE3Mmz4tpO5PUwNOF/xsesY26z70IHcQkzqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724576;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=sXXXhM2EDu3ROCdH3F3m73DJX0EM4Yoi8JjSeuI9o0o=;
	b=c5dUB/Y7pblQ0ywBSaflLGvcktixGvQLaSOH/wHA50IOm4ZrmmQGy1a63gv8BlX4+41O
	 xv5LNItyXdfa+OOpIQ0HXl7OCkPR1ciJDdembs4Fy9h/yLug5KdQtPEhDcqj85k2Iau1B
	 NoqnB2O8yCMdLkwgAn+V6jd8w6WSdn2Ua7J/S4GG34pMBeoXDdPpaMVPQnL5J+Ffezn/l
	 SmNMQPsaaQaaFk0Xcpab1uFRykNsbqfpHbe0G4ha5tnYAMoMt2Dj2HjHjYxnodVRwK3In
	 Erkr+AWvv2vNZeMMC/jpprRYp0r/arnsrEHN9yk0aCiMmagvdvXTabijxDyfks2ONfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=24abW0uw;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAF606EE94;
	Tue,  3 Nov 2026 16:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BAF606EE94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=24abW0uw
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 383641A143B;
	Tue,  3 Nov 2026 16:49:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 063E26046C;
	Tue,  3 Nov 2026 16:49:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B678010329123;
	Tue,  3 Nov 2026 17:49:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sXXXhM2EDu3ROCdH3F3m73DJX0EM4Yoi8JjSeuI9o0o=;
	b=24abW0uwGAt/GUNqQN9K7Az4wWphNaIDpoewyGbbT3QZ/4crC22Skoc427CgbRKeoevdr1
	vrcnyetszcTDWX8FrIcEkX9tW0kJtcBYZVZrsvHAHswV2m05WYz2rgq1zcQeS6ODjYroEC
	ya0s3iOYLnOBAX+FfxL+N4GvivqMyWxLfj7IWMstndcXPVJiC/4rQgpfGnuT6ohRjkMw8n
	w5OmML7jWKTi409rc03AUwUapqUqSCa2qNBQmy7PMRifwAUCd36QzDScUV/pXIil8QhINp
	3xbWoIwu1Ho10yzIBuxwAmTcR/4cG6szORXNov/RtjECoLpTKHiex6coPJJ91w==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:14 +0100
Subject: [PATCH v5 6/9] i2c: cgbc: Add support for fixed frequency buses
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
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-6-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
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
 drivers/i2c/busses/i2c-cgbc.c | 30 +++++++++++++++++++-----------
 include/linux/mfd/cgbc.h      |  2 ++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 40ffab4fd0bc..8623a5d03636 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -128,7 +128,6 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	u8 cmd[2], data;
-	int ret;
 
 	if (bus_frequency > CGBC_I2C_FREQ_MAX_HZ ||
 	    bus_frequency < CGBC_I2C_FREQ_MIN_HZ) {
@@ -139,18 +138,21 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
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
+	u8 data;
+	int ret;
 
 	ret = cgbc_command(cgbc, &cmd, sizeof(cmd), &data, 1, NULL);
 	if (ret)
-		return dev_err_probe(i2c->dev, ret,
-				     "Failed to get I2C bus frequency");
+		return ret;
 
 	bus_frequency = cgbc_i2c_reg_to_freq(data);
 
@@ -373,9 +375,15 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908882;
	b=wT/Bokbv+I7lNoKOtwMGDE1oSWxenN0CbHzxSf0pyBdyvyrwtrhbuBDyvVh67tUtfh5w
	 qbFPiIn/1AyOMWxEdenXdpSrZtvlSygrSMjgkuDhPBaUjWoYvSK3iXxm3SVcsAGSAgg3b
	 tWjHlgf035fTEx2gQOFnQtXMGSpQ3FITv2HPj5TUG8AXZ5VzDlp4yCyXuXDjrRb07GOj5
	 A6ouQukxvH2gCzTwgRBm81KqqVNwv6Kh4+MrYNaPuc7F75+uPm6wR5xrc76IvOnJnsupz
	 T1jZxFuxPPnrywdapSkttPPilhOHCLZ4OYcY2RRctdlpCSG8RKSBr/Y0EpRm60NIg3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908882;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=OdfwGfdRiW9VRqR5z5OVzgocF0tcJqdCFQK081QGkic=;
	b=ilqG3pgitfH2JrapIktYz0B4Apy5FLi58sUUwqOL1C6xaflbyiZt0gBrECjkIARyokno
	 CmDyUrzhuk/jPGHupkJiPi0RlPK2+lqS5/WuTu6BrQ1SGPiqdLxOBCUNzd/eM38H2CYdE
	 615oQu/oQzhWpy53o9kxP1vT/eJLtX79VKhggBJxYh28k2hbO919X5jKV0t6oJ59T5VRR
	 WuzRGpy/4Ahe8zL/MjzU75BeOdkEKk/E+FvYLhIvFRJljXO6Y9ps7P08EW7ZkBL5dkWy2
	 PcSGyxCZhgLyoeTnJPzek4WOzrV7XYhOk6ioHsw02guXBIK6GcHJl2Q5LfFX05C06zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=o5lCG7u8;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E260A263C
	for <linux-i2c@vger.kernel.org>; Tue, 17 Nov 2026 09:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B0E260A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=o5lCG7u8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3884C4E414D9;
	Tue, 17 Nov 2026 09:48:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0931C5FC81;
	Tue, 17 Nov 2026 09:48:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DB2211BC1143;
	Tue, 17 Nov 2026 10:47:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794908880; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OdfwGfdRiW9VRqR5z5OVzgocF0tcJqdCFQK081QGkic=;
	b=o5lCG7u8e7FZ+rLAA6fPl1g1ZofyfySNIaOXKGz34aaoFy72rvS23RFSGJmj2scuYJSuZ7
	xpf7VvZvMvJ3E5XUsBnyfvA89UGOW3NG+Q+c28tD/vlJjkI4bRgLX/9gPV/PU7ujbCUEGK
	UIlPkazWZDSv2IGhX76VGSqb2YrZphmxc3PQK7A7LoaYnQaOPUTNUAcnewv8KVly9UW+Ne
	piYIdBesIh2KmIp9TEIUMQ9Y3WXkD9yAoGdnULWeP7MckWQ6jVfW1iS5yWagwgQiMnO7PV
	OPwmLUInjSMwY84y4yOksEUuqf8FaZj8dPpCdvmkHhjbOzzBUIjLlteHvjQRPA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 17 Nov 2026 10:47:47 +0100
Subject: [PATCH v6 07/10] i2c: cgbc: Add support for fixed frequency buses
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
Message-Id: <20261117-cgbc-i2c-storage-devices-support-v6-7-bb070ad3e9aa@bootlin.com>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
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
index 50483bdc6730..c523ffdc22f2 100644
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


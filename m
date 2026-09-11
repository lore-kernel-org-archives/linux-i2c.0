Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F63F7884
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152545; cv=none; b=rdnPSeQP0JSkjry/yOjwlcIVxLfrIwBby0CGe71ChFsj39H97AKmAVktpIxOtvDdRl5BLgCZtNL308mKT5EaedeSzyXkKFEMVgEzOEj7m+uksM2KgwGQ2fqe3LxgWd/X2GN1G/smVEdk8bW1w7t/ymxwmqCD/eNj5w6pylMLJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152545; c=relaxed/simple;
	bh=MLXlkWvAz2reCSNezaXmeowtTnYNrr3l0Mg0DQtTtKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTyl3yaQhajg4j9nzP/sZ5bUygT287/u954nmyLMIznxOpr/YMCOxfef313xpYtlZrdCZUAu1ssNYo5uUtZrRciDj7tnIUvPwcl3ViKS+Uru6O950eI8zHyx7M44RFvyPkSxwBk9UB7jOU+RVyAmH2HYKzJzZPoab8pDY5ntTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BDKaNuqZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BDKaNuqZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 770671A022A;
	Fri, 11 Sep 2026 18:49:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A7B5606E3;
	Fri, 11 Sep 2026 18:49:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09A3111C7AFB3;
	Fri, 11 Sep 2026 20:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789152540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qb0jmvppUUTsrwnBOJ07ToDzPzb3JhdaJ8as8Vej6mY=;
	b=BDKaNuqZsRe2nd5FatX4ifvigzPmM0GWscsZa7I2+E4EU1R7L1azLxsJwzTclu2k8dyq1J
	UkF85YotvMUYg0215TKev7p1mSz6g99uSk32jciuWm88oAgZ9RcXvlxiR1yI1RytqMJU28
	XcM/bJYUrhrznEhh2cSZXja+sAbwDpKNJb3aQ4D0sTLYiuWiMcwCwoX5jm6YEdMmAUbBy3
	lBYBwgcfS5VQ7/oR4j8BQ6ZGtim3r5nSkjlvkvUDvKoR6j/qMBJBtOK5hH8B9lkC0CAX5k
	V6UCvJJRbo9EIECrOHAD0nBV2H+rCSJnRxq+NwUsxzL4sNSN86E5uAVfi2+i4w==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 11 Sep 2026 20:48:08 +0200
Subject: [PATCH v3 6/9] i2c: cgbc: Add support for fixed frequency buses
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-cgbc-i2c-storage-devices-support-v3-6-594b53fbc5ea@bootlin.com>
References: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
In-Reply-To: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
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
  fixed-frequency busses).
- cgbc_i2c_get_frequency(): reads the bus frequency and computes
  read_maxtime_us.

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c          | 30 +++++++++++++++++++-----------
 include/linux/platform_data/i2c-cgbc.h |  2 ++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index d388e07aad84..cb0435b3cc5f 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -129,7 +129,6 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
 	struct cgbc_i2c_data *i2c = i2c_get_adapdata(adap);
 	struct cgbc_device_data *cgbc = i2c->cgbc;
 	u8 cmd[2], data;
-	int ret;
 
 	if (bus_frequency > CGBC_I2C_FREQ_MAX_HZ ||
 	    bus_frequency < CGBC_I2C_FREQ_MIN_HZ) {
@@ -140,18 +139,21 @@ static int cgbc_i2c_set_frequency(struct i2c_adapter *adap,
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
 
@@ -359,9 +361,15 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
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
diff --git a/include/linux/platform_data/i2c-cgbc.h b/include/linux/platform_data/i2c-cgbc.h
index 4465e8a7b40e..224926c12070 100644
--- a/include/linux/platform_data/i2c-cgbc.h
+++ b/include/linux/platform_data/i2c-cgbc.h
@@ -13,10 +13,12 @@
  * struct cgbc_platform_data - Platform data of the CGBC I2C driver
  * @name:		I2C adapter name
  * @cgbc_bus_id:	I2C bus ID (from Board Controller point of view)
+ * @fixed_freq:		I2C bus has a fixed frequency
  */
 struct cgbc_i2c_platform_data {
 	const char *name;
 	int cgbc_bus_id;
+	bool fixed_freq;
 };
 
 #endif /* _LINUX_I2C_CGBC_H */

-- 
2.53.0


Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6C4218E91;
	Fri,  2 Oct 2026 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939609; cv=none; b=ebuBMS4zL3mpAlPxna5nuCQWDY/03ly9ds2G6BCiunyj4TkeBKM9bBNw23woFzTCxdEYLf8SwTrJFDMPn9IZ8LrBtaTQRyZAltEPhjoIiH7xH/NjK2HxoqeRZeY+BpeRf7j3w6RSTx91dXwIpaiJE3Xsf7+CyPFIATCS7Vvw+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939609; c=relaxed/simple;
	bh=Ql9vJIaBMiiicb2u62QoIlpz6tAya18EGhMtKaj8gf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOlDu6NWvsCN/iP/GDQ3Va9mA9CfKYa47PIsuXTLxlLawv/K2hxhBEjK7PrDnL6aROkjT1NHM13gqXOu6IDaA4wcmt7RvRc4ytAa+onQKaufGWNMSwaqREsZGtdUfNdN2yNgmi+UndjxPQqqgSd8tGEVEJZm+Zsxn4N6tcLrpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uONirvL5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uONirvL5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E3BF31A10C9;
	Fri,  2 Oct 2026 11:13:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B7E59603DC;
	Fri,  2 Oct 2026 11:13:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B248103284C7;
	Fri,  2 Oct 2026 13:13:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790939606; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=URvRR5Wk6WmvD9WKBJmjTywNs53F0e/bxib1TicQIbc=;
	b=uONirvL5K0ZriOKE5ol+NIp1dqIeW/O/IYkDecQB1Hv0jPtWyig6zP8wC8FiIY/9giLvI3
	L8oesfwuXk7HHPQMkWX7l2pkN84GyoUnXTqmQTKlfciz8HEwXzTEpk9nWrQ9vEQ2pFPMh9
	1nEIzJDw6Ty0ZqFpHIf2dV0QonfOYL0zr2kqIb/PoeXHWDCxl/Q7VWWAh2c5CBl4a/WsTG
	1FBZil2Hc7C+AVPcbtCUPHdjfi6OrI+eSTbsrBPgPnrtMHxeLHwsunod33mBzhf/+Opd9c
	jb4AefFkYZl687CqNHNwbMsh9Lse79kkv4+w8Rd3d7muk8VwoEhLSYvw1arwaA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 02 Oct 2026 13:12:44 +0200
Subject: [PATCH v4 6/9] i2c: cgbc: Add support for fixed frequency buses
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-cgbc-i2c-storage-devices-support-v4-6-eb42e0f1df59@bootlin.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
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
index cc1cd75c4d74..f7ddeca1d701 100644
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
 
@@ -358,9 +360,15 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
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


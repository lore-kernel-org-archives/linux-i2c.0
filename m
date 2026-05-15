Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062103B9D91
	for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862470; cv=none; b=M/JKmV8pYtD5ShLEWI3AHoskBT3TAv1DVn+xo3otFYR9mERbfr/xM998BrPdP9D+6yRSSKlLB8PUky5KuJqq5sgaMPeHR9m1k2Nw2nl1WD8iXQEfSwhr5B3IrMV0OkxDat0Y7B+RxTZ790WS8+7h+XtWt3xE9AVUewXxtFtZ3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862470; c=relaxed/simple;
	bh=l3adOaOidU1zC/6p6+v88w+3M2j0OhlsT1pM3yKkLDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K1Cmm9cpdTxb/CGTjm3loaC5UX3wGYEB/eQ71tY/Ejc17zLIOi0yC0ZNtOLEyDsr6ZoM/Gl/LJojxI4H156ewPzk0ppDlbpUenyX4tk8grrpXn6EdUaA1S3YPBKderPiqLMXZfXRrUX5ijYSVFhLy0rsA8VF6sCueHvXIxcrcsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=tnck66hg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="tnck66hg"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44c350a5b87so5771446f8f.3
        for <linux-i2c@vger.kernel.org>; Fri, 15 May 2026 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778862465; x=1779467265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2GCR/oRqFsoYnz3oBRWzmTawr2cqVXu3wUZyo8zRQ4=;
        b=tnck66hgowzRwiK6Mv+OtEuveIqKvICbXQhPjoB/5HrhGUtNn5rfUrvmceAwf8OupP
         EGRi5T8eHillDKJUr0MPua3ZPuRj54ArbgJJKyPpDsq8ZegkALv5Knx7tWmmpXUgI9ve
         9WNcB6tn8SSrs8xzUiFolvwChJRE8WYJbWrS2SrQIiETa5bP3K0D10cC3yFnbX8yD0F/
         S8ZR/AlGkl/zVrB1NG3Ctibos9OtLJNp9YIi4M0h5tJ+e+wuI7UjvHukczLs0HG4fz9M
         9zX7RxFecsqVaSvGZ1h0ip3xCsvC09eHTgeX/uiNcgMRGT4A0fY2PMa33/GHjHkY5TgB
         6wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778862465; x=1779467265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2GCR/oRqFsoYnz3oBRWzmTawr2cqVXu3wUZyo8zRQ4=;
        b=UQNFNWMVThSVH3P+v09sUmUAuLABOhTWrv7G8GokRv2hNqf7vTkLgCgrejF3K0yp4+
         vHLWBYMoK2/YxvtjiZJZo0090ImTCnZ646kj4FvyaXeQbXKkU1MB/sW50Z7qnQPJM/z/
         QL9ji45MQ1xg3qnfVDQfPInsOc11gyx7POWNjQl8XWS/DGZ0GjbDoALOPimrWVWDPKDh
         21i5cJ5Not6wYjcTtRU04lm9oB4nE6ek1E/x8oA0KS/pXxDXBZH9W/gbKKfp5O2hUYMh
         mxuufqIQ3ZoRjVXZgSgxLdWXtiUwx+dH8EBvTbw1+7uUi93uc94FgKP58g82euU0qqOv
         Q8aQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t+nNuojY3SPKLWaL1s2mBTtzCm9O3QT254OwmSXbMlltVV/lOn551W+2KXQYaWYSg6Z3fl3wIC2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNViFBWyCuTABPgl9chxFt6L2HePz1qnE90YVSK62YuJDEfTU
	ZhonPkeI0GZbaBVlcS14WURSxwbK7EnTuhjYCOkurUUPLpWM15GvsxDRTC0JqusgdTg=
X-Gm-Gg: Acq92OG6v0rjXWR4/VBeSNVLcknRbvFn/GttLdzRccDxfCltUYEztBiBbFWf+J2XsO0
	sTcl2ClgkYgKnxqFgDJP3+TMo/vQqzXH0KCdGao7ZErfe6fBKze3M+lskIDhISHtzYPBi1PR/cT
	upGrMmW9bSrHTViAFVYWko4o90eYZ7GNxoNEcrXHWQQhRFpSNhccWwtXpzglQqzUHyRMbjrKpys
	0Ye9CF3rIajXcUQib1BUUSt1mEQPjS7OOMaoE5PTGtmHgyajaoqmwLSc/MmQdKXW6DEh554jCbu
	/fOSJbL/Msf+tuwLFSeVqJT3UwOJK9Q0QoyxT/xNXM0uWLgRVLyCH427pxYgABQCY5m7KjhLV59
	9BEazwm4QXd1neZwnKKP+ki0pjVxJtDSd/akDjpFJ9Mioa9viSHJCDTw55FTAUaoQM5VXFnIGCI
	f9lfAC/cnopH4BKv3rMBrbnHvrP+mmePOpWYQ2O9Y6ivUgxz1hPV4vC7MSjFrcqeGr4gyNt1Up9
	j8w9QCL1x1wxcvBle5ygsrYKw==
X-Received: by 2002:a05:6000:2984:20b0:451:1143:7df5 with SMTP id ffacd0b85a97d-45e5c5f8d95mr4861089f8f.41.1778862465302;
        Fri, 15 May 2026 09:27:45 -0700 (PDT)
Received: from localhost (p200300f65f47db047ce9331f6697a627.dip0.t-ipconnect.de. [2003:f6:5f47:db04:7ce9:331f:6697:a627])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a17ec2sm14384415f8f.24.2026.05.15.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:27:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Eric Piel <eric.piel@tremplin-utc.net>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Akshay Gupta <Akshay.Gupta@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: [PATCH v1] misc: Use named initializers for arrays of i2c_device_data
Date: Fri, 15 May 2026 18:27:33 +0200
Message-ID: <20260515162734.469327-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=21012; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=l3adOaOidU1zC/6p6+v88w+3M2j0OhlsT1pM3yKkLDc=; b=kA0DAAoBj4D7WH0S/k4ByyZiAGoHSXahdeiftITf4tcdKrD7civn4HDjGC5hPuzAS7yFpDzke IkBMwQAAQoAHRYhBD+BrGk6eh5Zia3+04+A+1h9Ev5OBQJqB0l2AAoJEI+A+1h9Ev5OCKcH/3zI qF8xXCzcy4A1nmXxePlKZUBa9FhgXEWrpMpzbaOLaohebOa9Xv9v9ZfMK63V6q88cS8Klo+YbiR OyP3M0plV8Pc2RlMIxTu+2RiWPCt+G4YyxASgE8Rw1IUUWLsHl2MCI8BERKPRiqcTxlLvTF7LAm yt62G0GQimAmhATtmx3sbvxRaQdhsrZO9u4IKlv5wRbglxnjSB7yJxfYcEEfBU9o5NXr2El7DYC lHMpeGhFeeZwazXWiwC6CxKyUbmEUSHYLuurqR/+eCo5rDahhlpIlkuLmFSmcLPpxkunV8KKQfZ mlbEl8MlKD7+tYAFPC9uBS6X3kB1nvIJYk8OVt4=
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching all these arrays, unify usage of whitespace and commas.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to i2c_device_id is the following:

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {
	
	 struct i2c_device_id {
	 	char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;     /* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };
	
	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

	diff --git a/drivers/misc/eeprom/m24lr.c b/drivers/misc/eeprom/m24lr.c
	index bf2194d7cdbd..e0d7d8739e67 100644
	--- a/drivers/misc/eeprom/m24lr.c
	+++ b/drivers/misc/eeprom/m24lr.c
	@@ -104,9 +104,9 @@ static const struct m24lr_chip m24lr64e_r_chip = {
	 };
	 
	 static const struct i2c_device_id m24lr_ids[] = {
	-	{ .name = "m24lr04e-r", .driver_data = (kernel_ulong_t)&m24lr04e_r_chip },
	-	{ .name = "m24lr16e-r", .driver_data = (kernel_ulong_t)&m24lr16e_r_chip },
	-	{ .name = "m24lr64e-r", .driver_data = (kernel_ulong_t)&m24lr64e_r_chip },
	+	{ .name = "m24lr04e-r", .driver_data_ptr = &m24lr04e_r_chip },
	+	{ .name = "m24lr16e-r", .driver_data_ptr = &m24lr16e_r_chip },
	+	{ .name = "m24lr64e-r", .driver_data_ptr = &m24lr64e_r_chip },
		{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, m24lr_ids);
	@@ -478,7 +478,7 @@ static const struct m24lr_chip *m24lr_get_chip(struct device *dev)
		if (dev->of_node && of_match_device(m24lr_of_match, dev))
			ret = of_device_get_match_data(dev);
		else if (id)
	-		ret = (void *)id->driver_data;
	+		ret = id->driver_data;
		else
			ret = acpi_device_get_match_data(dev);
 
that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that.

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

 drivers/misc/ad525x_dpot-i2c.c         |  52 ++++++------
 drivers/misc/amd-sbi/rmi-i2c.c         |   4 +-
 drivers/misc/apds9802als.c             |   2 +-
 drivers/misc/apds990x.c                |   4 +-
 drivers/misc/bh1770glc.c               |   6 +-
 drivers/misc/ds1682.c                  |   2 +-
 drivers/misc/eeprom/at24.c             |  62 +++++++-------
 drivers/misc/eeprom/ee1004.c           |   2 +-
 drivers/misc/eeprom/idt_89hpesx.c      | 108 ++++++++++++-------------
 drivers/misc/eeprom/m24lr.c            |   6 +-
 drivers/misc/eeprom/max6875.c          |   2 +-
 drivers/misc/hmc6352.c                 |   2 +-
 drivers/misc/ics932s401.c              |   2 +-
 drivers/misc/isl29003.c                |   4 +-
 drivers/misc/isl29020.c                |   2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c |   6 +-
 drivers/misc/tsl2550.c                 |   2 +-
 17 files changed, 134 insertions(+), 134 deletions(-)

diff --git a/drivers/misc/ad525x_dpot-i2c.c b/drivers/misc/ad525x_dpot-i2c.c
index 469478f7a1d3..e02be9098b3b 100644
--- a/drivers/misc/ad525x_dpot-i2c.c
+++ b/drivers/misc/ad525x_dpot-i2c.c
@@ -73,32 +73,32 @@ static void ad_dpot_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ad_dpot_id[] = {
-	{"ad5258", AD5258_ID},
-	{"ad5259", AD5259_ID},
-	{"ad5251", AD5251_ID},
-	{"ad5252", AD5252_ID},
-	{"ad5253", AD5253_ID},
-	{"ad5254", AD5254_ID},
-	{"ad5255", AD5255_ID},
-	{"ad5241", AD5241_ID},
-	{"ad5242", AD5242_ID},
-	{"ad5243", AD5243_ID},
-	{"ad5245", AD5245_ID},
-	{"ad5246", AD5246_ID},
-	{"ad5247", AD5247_ID},
-	{"ad5248", AD5248_ID},
-	{"ad5280", AD5280_ID},
-	{"ad5282", AD5282_ID},
-	{"adn2860", ADN2860_ID},
-	{"ad5273", AD5273_ID},
-	{"ad5161", AD5161_ID},
-	{"ad5171", AD5171_ID},
-	{"ad5170", AD5170_ID},
-	{"ad5172", AD5172_ID},
-	{"ad5173", AD5173_ID},
-	{"ad5272", AD5272_ID},
-	{"ad5274", AD5274_ID},
-	{}
+	{ .name = "ad5258", .driver_data = AD5258_ID },
+	{ .name = "ad5259", .driver_data = AD5259_ID },
+	{ .name = "ad5251", .driver_data = AD5251_ID },
+	{ .name = "ad5252", .driver_data = AD5252_ID },
+	{ .name = "ad5253", .driver_data = AD5253_ID },
+	{ .name = "ad5254", .driver_data = AD5254_ID },
+	{ .name = "ad5255", .driver_data = AD5255_ID },
+	{ .name = "ad5241", .driver_data = AD5241_ID },
+	{ .name = "ad5242", .driver_data = AD5242_ID },
+	{ .name = "ad5243", .driver_data = AD5243_ID },
+	{ .name = "ad5245", .driver_data = AD5245_ID },
+	{ .name = "ad5246", .driver_data = AD5246_ID },
+	{ .name = "ad5247", .driver_data = AD5247_ID },
+	{ .name = "ad5248", .driver_data = AD5248_ID },
+	{ .name = "ad5280", .driver_data = AD5280_ID },
+	{ .name = "ad5282", .driver_data = AD5282_ID },
+	{ .name = "adn2860", .driver_data = ADN2860_ID },
+	{ .name = "ad5273", .driver_data = AD5273_ID },
+	{ .name = "ad5161", .driver_data = AD5161_ID },
+	{ .name = "ad5171", .driver_data = AD5171_ID },
+	{ .name = "ad5170", .driver_data = AD5170_ID },
+	{ .name = "ad5172", .driver_data = AD5172_ID },
+	{ .name = "ad5173", .driver_data = AD5173_ID },
+	{ .name = "ad5272", .driver_data = AD5272_ID },
+	{ .name = "ad5274", .driver_data = AD5274_ID },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad_dpot_id);
 
diff --git a/drivers/misc/amd-sbi/rmi-i2c.c b/drivers/misc/amd-sbi/rmi-i2c.c
index 37e5ea83bf97..bbc0d14d1cfc 100644
--- a/drivers/misc/amd-sbi/rmi-i2c.c
+++ b/drivers/misc/amd-sbi/rmi-i2c.c
@@ -141,8 +141,8 @@ static void sbrmi_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sbrmi_id[] = {
-	{"sbrmi-i2c"},
-	{}
+	{ .name = "sbrmi-i2c" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sbrmi_id);
 
diff --git a/drivers/misc/apds9802als.c b/drivers/misc/apds9802als.c
index fc504bd8d916..1488e28819b7 100644
--- a/drivers/misc/apds9802als.c
+++ b/drivers/misc/apds9802als.c
@@ -285,7 +285,7 @@ static UNIVERSAL_DEV_PM_OPS(apds9802als_pm_ops, apds9802als_suspend,
 #endif	/* CONFIG_PM */
 
 static const struct i2c_device_id apds9802als_id[] = {
-	{ DRIVER_NAME },
+	{ .name = DRIVER_NAME },
 	{ }
 };
 
diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index b69c3a1c94d1..f5011111450f 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1254,8 +1254,8 @@ static int apds990x_runtime_resume(struct device *dev)
 #endif
 
 static const struct i2c_device_id apds990x_id[] = {
-	{ "apds990x" },
-	{}
+	{ .name = "apds990x" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, apds990x_id);
diff --git a/drivers/misc/bh1770glc.c b/drivers/misc/bh1770glc.c
index 45f8fc69a711..98fc5970b2bb 100644
--- a/drivers/misc/bh1770glc.c
+++ b/drivers/misc/bh1770glc.c
@@ -1363,9 +1363,9 @@ static int bh1770_runtime_resume(struct device *dev)
 #endif
 
 static const struct i2c_device_id bh1770_id[] = {
-	{ "bh1770glc" },
-	{ "sfh7770" },
-	{}
+	{ .name = "bh1770glc" },
+	{ .name = "sfh7770" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, bh1770_id);
diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
index cb09e056531a..f073a5067fc8 100644
--- a/drivers/misc/ds1682.c
+++ b/drivers/misc/ds1682.c
@@ -271,7 +271,7 @@ static void ds1682_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ds1682_id[] = {
-	{ "ds1682" },
+	{ .name = "ds1682" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds1682_id);
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0200288d3a7a..5d5f357a1996 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -215,37 +215,37 @@ AT24_CHIP_DATA(at24_data_24c2048, 2097152 / 8, AT24_FLAG_ADDR16);
 AT24_CHIP_DATA(at24_data_INT3499, 8192 / 8, 0);
 
 static const struct i2c_device_id at24_ids[] = {
-	{ "24c00",	(kernel_ulong_t)&at24_data_24c00 },
-	{ "24c01",	(kernel_ulong_t)&at24_data_24c01 },
-	{ "24cs01",	(kernel_ulong_t)&at24_data_24cs01 },
-	{ "24c02",	(kernel_ulong_t)&at24_data_24c02 },
-	{ "24cs02",	(kernel_ulong_t)&at24_data_24cs02 },
-	{ "24mac402",	(kernel_ulong_t)&at24_data_24mac402 },
-	{ "24mac602",	(kernel_ulong_t)&at24_data_24mac602 },
-	{ "24aa025e48",	(kernel_ulong_t)&at24_data_24aa025e48 },
-	{ "24aa025e64",	(kernel_ulong_t)&at24_data_24aa025e64 },
-	{ "spd",	(kernel_ulong_t)&at24_data_spd },
-	{ "24c02-vaio",	(kernel_ulong_t)&at24_data_24c02_vaio },
-	{ "24c04",	(kernel_ulong_t)&at24_data_24c04 },
-	{ "24cs04",	(kernel_ulong_t)&at24_data_24cs04 },
-	{ "24c08",	(kernel_ulong_t)&at24_data_24c08 },
-	{ "24cs08",	(kernel_ulong_t)&at24_data_24cs08 },
-	{ "24c16",	(kernel_ulong_t)&at24_data_24c16 },
-	{ "24cs16",	(kernel_ulong_t)&at24_data_24cs16 },
-	{ "24c32",	(kernel_ulong_t)&at24_data_24c32 },
-	{ "24c32d-wl",	(kernel_ulong_t)&at24_data_24c32d_wlp },
-	{ "24cs32",	(kernel_ulong_t)&at24_data_24cs32 },
-	{ "24c64",	(kernel_ulong_t)&at24_data_24c64 },
-	{ "24c64-wl",	(kernel_ulong_t)&at24_data_24c64d_wlp },
-	{ "24cs64",	(kernel_ulong_t)&at24_data_24cs64 },
-	{ "24c128",	(kernel_ulong_t)&at24_data_24c128 },
-	{ "24c256",	(kernel_ulong_t)&at24_data_24c256 },
-	{ "24256e-wl",	(kernel_ulong_t)&at24_data_24256e_wlp },
-	{ "24c512",	(kernel_ulong_t)&at24_data_24c512 },
-	{ "24c1024",	(kernel_ulong_t)&at24_data_24c1024 },
-	{ "24c1025",	(kernel_ulong_t)&at24_data_24c1025 },
-	{ "24c2048",    (kernel_ulong_t)&at24_data_24c2048 },
-	{ "at24",	0 },
+	{ .name = "24c00",	.driver_data = (kernel_ulong_t)&at24_data_24c00 },
+	{ .name = "24c01",	.driver_data = (kernel_ulong_t)&at24_data_24c01 },
+	{ .name = "24cs01",	.driver_data = (kernel_ulong_t)&at24_data_24cs01 },
+	{ .name = "24c02",	.driver_data = (kernel_ulong_t)&at24_data_24c02 },
+	{ .name = "24cs02",	.driver_data = (kernel_ulong_t)&at24_data_24cs02 },
+	{ .name = "24mac402",	.driver_data = (kernel_ulong_t)&at24_data_24mac402 },
+	{ .name = "24mac602",	.driver_data = (kernel_ulong_t)&at24_data_24mac602 },
+	{ .name = "24aa025e48",	.driver_data = (kernel_ulong_t)&at24_data_24aa025e48 },
+	{ .name = "24aa025e64",	.driver_data = (kernel_ulong_t)&at24_data_24aa025e64 },
+	{ .name = "spd",	.driver_data = (kernel_ulong_t)&at24_data_spd },
+	{ .name = "24c02-vaio",	.driver_data = (kernel_ulong_t)&at24_data_24c02_vaio },
+	{ .name = "24c04",	.driver_data = (kernel_ulong_t)&at24_data_24c04 },
+	{ .name = "24cs04",	.driver_data = (kernel_ulong_t)&at24_data_24cs04 },
+	{ .name = "24c08",	.driver_data = (kernel_ulong_t)&at24_data_24c08 },
+	{ .name = "24cs08",	.driver_data = (kernel_ulong_t)&at24_data_24cs08 },
+	{ .name = "24c16",	.driver_data = (kernel_ulong_t)&at24_data_24c16 },
+	{ .name = "24cs16",	.driver_data = (kernel_ulong_t)&at24_data_24cs16 },
+	{ .name = "24c32",	.driver_data = (kernel_ulong_t)&at24_data_24c32 },
+	{ .name = "24c32d-wl",	.driver_data = (kernel_ulong_t)&at24_data_24c32d_wlp },
+	{ .name = "24cs32",	.driver_data = (kernel_ulong_t)&at24_data_24cs32 },
+	{ .name = "24c64",	.driver_data = (kernel_ulong_t)&at24_data_24c64 },
+	{ .name = "24c64-wl",	.driver_data = (kernel_ulong_t)&at24_data_24c64d_wlp },
+	{ .name = "24cs64",	.driver_data = (kernel_ulong_t)&at24_data_24cs64 },
+	{ .name = "24c128",	.driver_data = (kernel_ulong_t)&at24_data_24c128 },
+	{ .name = "24c256",	.driver_data = (kernel_ulong_t)&at24_data_24c256 },
+	{ .name = "24256e-wl",	.driver_data = (kernel_ulong_t)&at24_data_24256e_wlp },
+	{ .name = "24c512",	.driver_data = (kernel_ulong_t)&at24_data_24c512 },
+	{ .name = "24c1024",	.driver_data = (kernel_ulong_t)&at24_data_24c1024 },
+	{ .name = "24c1025",	.driver_data = (kernel_ulong_t)&at24_data_24c1025 },
+	{ .name = "24c2048",	.driver_data = (kernel_ulong_t)&at24_data_24c2048 },
+	{ .name = "at24",	.driver_data = 0 },
 	{ /* END OF LIST */ }
 };
 MODULE_DEVICE_TABLE(i2c, at24_ids);
diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index e13f9fdd9d7b..e3f0119cd968 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -54,7 +54,7 @@ static struct ee1004_bus_data {
 } ee1004_bus_data[EE1004_MAX_BUSSES];
 
 static const struct i2c_device_id ee1004_ids[] = {
-	{ "ee1004" },
+	{ .name = "ee1004" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ee1004_ids);
diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 60c42170d147..35fdf1da4d93 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -1376,12 +1376,12 @@ static void idt_remove(struct i2c_client *client)
  * ee_ids - array of supported EEPROMs
  */
 static const struct i2c_device_id ee_ids[] = {
-	{ "24c32",  4096},
-	{ "24c64",  8192},
-	{ "24c128", 16384},
-	{ "24c256", 32768},
-	{ "24c512", 65536},
-	{}
+	{ .name = "24c32",	.driver_data = 4096 },
+	{ .name = "24c64",	.driver_data = 8192 },
+	{ .name = "24c128",	.driver_data = 16384 },
+	{ .name = "24c256",	.driver_data = 32768 },
+	{ .name = "24c512",	.driver_data = 65536 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ee_ids);
 
@@ -1389,58 +1389,58 @@ MODULE_DEVICE_TABLE(i2c, ee_ids);
  * idt_ids - supported IDT 89HPESx devices
  */
 static const struct i2c_device_id idt_ids[] = {
-	{ "89hpes8nt2" },
-	{ "89hpes12nt3" },
+	{ .name = "89hpes8nt2" },
+	{ .name = "89hpes12nt3" },
 
-	{ "89hpes24nt6ag2" },
-	{ "89hpes32nt8ag2" },
-	{ "89hpes32nt8bg2" },
-	{ "89hpes12nt12g2" },
-	{ "89hpes16nt16g2" },
-	{ "89hpes24nt24g2" },
-	{ "89hpes32nt24ag2" },
-	{ "89hpes32nt24bg2" },
+	{ .name = "89hpes24nt6ag2" },
+	{ .name = "89hpes32nt8ag2" },
+	{ .name = "89hpes32nt8bg2" },
+	{ .name = "89hpes12nt12g2" },
+	{ .name = "89hpes16nt16g2" },
+	{ .name = "89hpes24nt24g2" },
+	{ .name = "89hpes32nt24ag2" },
+	{ .name = "89hpes32nt24bg2" },
 
-	{ "89hpes12n3" },
-	{ "89hpes12n3a" },
-	{ "89hpes24n3" },
-	{ "89hpes24n3a" },
+	{ .name = "89hpes12n3" },
+	{ .name = "89hpes12n3a" },
+	{ .name = "89hpes24n3" },
+	{ .name = "89hpes24n3a" },
 
-	{ "89hpes32h8" },
-	{ "89hpes32h8g2" },
-	{ "89hpes48h12" },
-	{ "89hpes48h12g2" },
-	{ "89hpes48h12ag2" },
-	{ "89hpes16h16" },
-	{ "89hpes22h16" },
-	{ "89hpes22h16g2" },
-	{ "89hpes34h16" },
-	{ "89hpes34h16g2" },
-	{ "89hpes64h16" },
-	{ "89hpes64h16g2" },
-	{ "89hpes64h16ag2" },
+	{ .name = "89hpes32h8" },
+	{ .name = "89hpes32h8g2" },
+	{ .name = "89hpes48h12" },
+	{ .name = "89hpes48h12g2" },
+	{ .name = "89hpes48h12ag2" },
+	{ .name = "89hpes16h16" },
+	{ .name = "89hpes22h16" },
+	{ .name = "89hpes22h16g2" },
+	{ .name = "89hpes34h16" },
+	{ .name = "89hpes34h16g2" },
+	{ .name = "89hpes64h16" },
+	{ .name = "89hpes64h16g2" },
+	{ .name = "89hpes64h16ag2" },
 
-	/* { "89hpes3t3" }, // No SMBus-slave iface */
-	{ "89hpes12t3g2" },
-	{ "89hpes24t3g2" },
-	/* { "89hpes4t4" }, // No SMBus-slave iface */
-	{ "89hpes16t4" },
-	{ "89hpes4t4g2" },
-	{ "89hpes10t4g2" },
-	{ "89hpes16t4g2" },
-	{ "89hpes16t4ag2" },
-	{ "89hpes5t5" },
-	{ "89hpes6t5" },
-	{ "89hpes8t5" },
-	{ "89hpes8t5a" },
-	{ "89hpes24t6" },
-	{ "89hpes6t6g2" },
-	{ "89hpes24t6g2" },
-	{ "89hpes16t7" },
-	{ "89hpes32t8" },
-	{ "89hpes32t8g2" },
-	{ "89hpes48t12" },
-	{ "89hpes48t12g2" },
+	/* { .name = "89hpes3t3" }, // No SMBus-slave iface */
+	{ .name = "89hpes12t3g2" },
+	{ .name = "89hpes24t3g2" },
+	/* { .name = { "89hpes4t4" }, // No SMBus-slave iface */
+	{ .name = "89hpes16t4" },
+	{ .name = "89hpes4t4g2" },
+	{ .name = "89hpes10t4g2" },
+	{ .name = "89hpes16t4g2" },
+	{ .name = "89hpes16t4ag2" },
+	{ .name = "89hpes5t5" },
+	{ .name = "89hpes6t5" },
+	{ .name = "89hpes8t5" },
+	{ .name = "89hpes8t5a" },
+	{ .name = "89hpes24t6" },
+	{ .name = "89hpes6t6g2" },
+	{ .name = "89hpes24t6g2" },
+	{ .name = "89hpes16t7" },
+	{ .name = "89hpes32t8" },
+	{ .name = "89hpes32t8g2" },
+	{ .name = "89hpes48t12" },
+	{ .name = "89hpes48t12g2" },
 	{ /* END OF LIST */ }
 };
 MODULE_DEVICE_TABLE(i2c, idt_ids);
diff --git a/drivers/misc/eeprom/m24lr.c b/drivers/misc/eeprom/m24lr.c
index 7a9fd45a8e46..bf2194d7cdbd 100644
--- a/drivers/misc/eeprom/m24lr.c
+++ b/drivers/misc/eeprom/m24lr.c
@@ -104,9 +104,9 @@ static const struct m24lr_chip m24lr64e_r_chip = {
 };
 
 static const struct i2c_device_id m24lr_ids[] = {
-	{ "m24lr04e-r", (kernel_ulong_t)&m24lr04e_r_chip},
-	{ "m24lr16e-r", (kernel_ulong_t)&m24lr16e_r_chip},
-	{ "m24lr64e-r", (kernel_ulong_t)&m24lr64e_r_chip},
+	{ .name = "m24lr04e-r", .driver_data = (kernel_ulong_t)&m24lr04e_r_chip },
+	{ .name = "m24lr16e-r", .driver_data = (kernel_ulong_t)&m24lr16e_r_chip },
+	{ .name = "m24lr64e-r", .driver_data = (kernel_ulong_t)&m24lr64e_r_chip },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, m24lr_ids);
diff --git a/drivers/misc/eeprom/max6875.c b/drivers/misc/eeprom/max6875.c
index 5731d2dc8a57..be5e6d19be10 100644
--- a/drivers/misc/eeprom/max6875.c
+++ b/drivers/misc/eeprom/max6875.c
@@ -183,7 +183,7 @@ static void max6875_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max6875_id[] = {
-	{ "max6875" },
+	{ .name = "max6875" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max6875_id);
diff --git a/drivers/misc/hmc6352.c b/drivers/misc/hmc6352.c
index ff92c6edff6b..275dc054ca04 100644
--- a/drivers/misc/hmc6352.c
+++ b/drivers/misc/hmc6352.c
@@ -121,7 +121,7 @@ static void hmc6352_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id hmc6352_id[] = {
-	{ "hmc6352" },
+	{ .name = "hmc6352" },
 	{ }
 };
 
diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
index 015710762a65..e8bcf0df2da8 100644
--- a/drivers/misc/ics932s401.c
+++ b/drivers/misc/ics932s401.c
@@ -95,7 +95,7 @@ static int ics932s401_detect(struct i2c_client *client,
 static void ics932s401_remove(struct i2c_client *client);
 
 static const struct i2c_device_id ics932s401_id[] = {
-	{ "ics932s401" },
+	{ .name = "ics932s401" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ics932s401_id);
diff --git a/drivers/misc/isl29003.c b/drivers/misc/isl29003.c
index 95480e16ae5f..c9b526a212d0 100644
--- a/drivers/misc/isl29003.c
+++ b/drivers/misc/isl29003.c
@@ -449,8 +449,8 @@ static SIMPLE_DEV_PM_OPS(isl29003_pm_ops, isl29003_suspend, isl29003_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct i2c_device_id isl29003_id[] = {
-	{ "isl29003" },
-	{}
+	{ .name = "isl29003" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, isl29003_id);
 
diff --git a/drivers/misc/isl29020.c b/drivers/misc/isl29020.c
index c288aeec16c0..dd966db28ec4 100644
--- a/drivers/misc/isl29020.c
+++ b/drivers/misc/isl29020.c
@@ -177,7 +177,7 @@ static void isl29020_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id isl29020_id[] = {
-	{ "isl29020" },
+	{ .name = "isl29020" },
 	{ }
 };
 
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index 15119584473c..36032fc125f3 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -247,9 +247,9 @@ static int lis3_i2c_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct i2c_device_id lis3lv02d_id[] = {
-	{"lis3lv02d", LIS3LV02D},
-	{"lis331dlh", LIS331DLH},
-	{}
+	{ .name = "lis3lv02d", .driver_data = LIS3LV02D },
+	{ .name = "lis331dlh", .driver_data = LIS331DLH },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, lis3lv02d_id);
diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 03f19eda641e..c871ea860bb5 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -420,7 +420,7 @@ static SIMPLE_DEV_PM_OPS(tsl2550_pm_ops, tsl2550_suspend, tsl2550_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct i2c_device_id tsl2550_id[] = {
-	{ "tsl2550" },
+	{ .name = "tsl2550" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tsl2550_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


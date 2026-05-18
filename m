Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6535DA56
	for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122722; cv=none; b=d0kfvHK03QBbPd9muSOCOVxN2T4Q81//TnfQPQ5mNbS9wGDst+VMyhLls2Zuqs0fF+ysDw9KnlD7cxhBx4AqhSH5OQMzEN2eX7uVQLjITnwQN2TUOoU6GWvYdlJY/9ap9r23Gb0Ah5mfxRWitSrRdKT3/7PWDk9PO/klUqAS+pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122722; c=relaxed/simple;
	bh=lCH/RQ3ab4WHRokQ/M9DUnB00sh46GAiobF+8oiI4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aC66PSQdcvKXNiTJpciwgNkFeiAIcnC9RMI5YWnQ0K6xqxg9rR4NCLejc/OPcf+hil0fH5riEWw/0RlUZZT+IEKw0KIVtISISV+IdFP/03AzqRI9Jb+TpDM//cQp51bsmw+U9Mg2rE9E32NoKNJj4zfzj+7cBjmay7JMMLAD+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Waw7m/Gn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Waw7m/Gn"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b150559bso19804385e9.1
        for <linux-i2c@vger.kernel.org>; Mon, 18 May 2026 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779122718; x=1779727518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e4uoJqOZQPI2cVHQzOQoRk6wrV7n9yA1ivdWcQg27mc=;
        b=Waw7m/GnMONd5p2mErNWBYQyHzIuR1amS9drXSQGgPbtodgZEyfMGI4GCY3b4G7KYO
         kaHm5lU0EZLA6rDHlUIyfj6bkWOh9aAaiN2b9fw0sBGLik4de9lUnvuUEMZ2TCB5DE2W
         xMa0WMU1qC0VB2iH3qWuWZSUO+iAUwgyFLLG7xKKNwcF2geuowW4zdaztHzQhJLyvj1v
         rBXub16ptGB3h0VeLdnhSn+lpiK+Q/ltOl477huDY3I3SDTuC6Jsdhi/Y+fM01p2zdTg
         y98Xzy2btIHBUGATCywU1ReBUZEF2B8apzGCyY14vj8HfJ3TsU9DE8oOScj7h4Eq8U+k
         pCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122718; x=1779727518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4uoJqOZQPI2cVHQzOQoRk6wrV7n9yA1ivdWcQg27mc=;
        b=oaxz7Wtk1yuZ8zWFPs5LCRFU9H0A1d6Vmbw9dGZT9DWMjyelX57t/1GpoKt9vy2Bj2
         VBE0dF3JSFCCJZmzX+vg56TH1AaZZAODqQn0J0WWgMkUcYqeyG7oJ0biNd7QMXewYRqj
         +Wb7OWf+aNTMJjojLDJ5uq1GZg0p3K96dSYv+AByqVzkXpgaxb8K1z3Y+qLLMLChDSNa
         AzeiGZKdw/C+8WcW5OiIHsAf5ddTneG+lWi2pS51fLdqfxO5nAYk4eivsUm/5wj5ZJ/p
         MlOmdN4a5EU8izfjg3UCihp4gWPU0m2WUR0bUZwKaRcqhpAIoAnb6AugBRKXZK1Z0opz
         9VXA==
X-Forwarded-Encrypted: i=1; AFNElJ8UN2gRFSKRXjltNsIDTw/598vwlPXQeAQdprcCGOHrMm0S0LalQouV1AVtqKCnbJinpPqi+y2jT10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+aJIrt2misB4ztthYTfz4FtyXwOG9oO0jt4/QhOKiZCrDHXN
	gWr0h588rXko+aOUdGclbXZg9/Pl16WcMeQiN+GzQKZpZsEeFw1i+lzx4kr9kMMH/mM2j7AQOBq
	wugbMDRo=
X-Gm-Gg: Acq92OFhdwveuoaZjA1a96FYtpHnz8TS0PCPjnwsw587ZwShCAQxgW5pLCuBRXvxeYD
	VFP6t+rW5cGYeASdzV+rrJ5S+ncDHwJer1eqT0UGeCDi/pjHi5UsJfKuLrQGNnvKfr29sBoOJCG
	OQsoFYAMV4T5+6QEajM7KjUTZudz740VxvLRGGkaUKd2Ix29+GuOhUhD+1K5poebzGYY1gVL+zW
	BFaJnhKbhwW5dPp0raZJ+FykufMb5Ze1ijiAdY2PzSLVo5Nq3dr83lBbal21q73aLA7yZFbFrI0
	UCanQ1cJaHmuxsMemc8NKTp/6rtC04WQQxQXZhXFx7S9KkOv/6jeicW+EtJindDKB/DAT254mXr
	UQF5XMWRfRX3okxYwCaY2QJXL9+sSqnN1gVJzC8Gve1b/xDGOWytkIqu7Oc0dT3mW2pxEXtSUzP
	mxBHwtKJATluLjuEkfcxLhNE1QbUP5j0OygizBaMYppvcLiCfv2j1uqopQvwYJlcB0oVfpxiukc
	tTMLgntm+hxjR4lhg4oxoJE
X-Received: by 2002:a05:600c:181b:b0:48f:e230:2a1d with SMTP id 5b1f17b1804b1-48fec369d0fmr142735965e9.32.1779122717763;
        Mon, 18 May 2026 09:45:17 -0700 (PDT)
Received: from localhost (p200300f65f47db041bee4d0e08e9609b.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1bee:4d0e:8e9:609b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe5ab3977sm290714205e9.9.2026.05.18.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:45:17 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] i2c: Use named initializers for arrays of i2c_device_data
Date: Mon, 18 May 2026 18:45:09 +0200
Message-ID: <20260518164510.805502-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10046; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=lCH/RQ3ab4WHRokQ/M9DUnB00sh46GAiobF+8oiI4Vc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqC0IWKD1anbKMQT5x3rIuO8tRTfVyYIG6F45vD vXmFuLqvm6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagtCFgAKCRCPgPtYfRL+ TgPRB/4tYpmhpRNIIafzwyzih7JRor42G48nsBsAJm0vqj1u8+T3mLpTscaBJtP4AT76+dhv3HS 8i+j5qVenK9XBR+h9xLo5xiqS4GTvwvy22X6UtC/JtiHVL07TcR5R3ERjJ0gMutxU40tKzGMBEc NTqRgYAuALE8G6Txzvwlh2wIMP8Tz0mrG0fuqxxX1cZa+C+rH1IovVj9WJvviDQ40sGNqMKquez CnJO+Nn73HIyjVizZmh9uJzaCVSDzf4wPr9pWJizWZMkP9ZtN9sz1ppOGnwDBvjqM/thAn5uaar uO7K84h7dNyNy9PnMZB0W1q67JCKnc2bjttCbew/9b5LnBZo
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching all these arrays, unify usage of whitespace in the list
terminator.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
Forwarded: id:20260518134035.644762-2-u.kleine-koenig@baylibre.com
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
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
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

	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
	index 0123ca8157a8..dfb0b07500a7 100644
	--- a/drivers/regulator/ad5398.c
	+++ b/drivers/regulator/ad5398.c
	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};

	 static const struct i2c_device_id ad5398_id[] = {
	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
	 	{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
	 	struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
	 	struct regulator_config config = { };
	 	struct ad5398_chip_info *chip;
	-	const struct ad5398_current_data_format *df =
	-	                (struct ad5398_current_data_format *)id->driver_data;
	+	const struct ad5398_current_data_format *df = id->driver_data;

	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
	 	if (!chip)

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find an i2c driver that benefits, so this
is "only" a regulator driver example.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/

 drivers/i2c/i2c-core-base.c         |  4 ++--
 drivers/i2c/i2c-slave-eeprom.c      | 16 ++++++-------
 drivers/i2c/i2c-slave-testunit.c    |  2 +-
 drivers/i2c/i2c-smbus.c             |  2 +-
 drivers/i2c/muxes/i2c-mux-ltc4306.c |  4 ++--
 drivers/i2c/muxes/i2c-mux-pca9541.c |  4 ++--
 drivers/i2c/muxes/i2c-mux-pca954x.c | 36 ++++++++++++++---------------
 7 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9c46147e3506..7e4b7adffd6e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1107,8 +1107,8 @@ EXPORT_SYMBOL(i2c_find_device_by_fwnode);
 
 
 static const struct i2c_device_id dummy_id[] = {
-	{ "dummy", },
-	{ "smbus_host_notify", },
+	{ .name = "dummy" },
+	{ .name = "smbus_host_notify" },
 	{ }
 };
 
diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 6bc2ef650a74..226d722af662 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -191,14 +191,14 @@ static void i2c_slave_eeprom_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id i2c_slave_eeprom_id[] = {
-	{ "slave-24c02", I2C_SLAVE_DEVICE_MAGIC(2048 / 8,  0) },
-	{ "slave-24c02ro", I2C_SLAVE_DEVICE_MAGIC(2048 / 8,  I2C_SLAVE_FLAG_RO) },
-	{ "slave-24c32", I2C_SLAVE_DEVICE_MAGIC(32768 / 8, I2C_SLAVE_FLAG_ADDR16) },
-	{ "slave-24c32ro", I2C_SLAVE_DEVICE_MAGIC(32768 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
-	{ "slave-24c64", I2C_SLAVE_DEVICE_MAGIC(65536 / 8, I2C_SLAVE_FLAG_ADDR16) },
-	{ "slave-24c64ro", I2C_SLAVE_DEVICE_MAGIC(65536 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
-	{ "slave-24c512", I2C_SLAVE_DEVICE_MAGIC(524288 / 8, I2C_SLAVE_FLAG_ADDR16) },
-	{ "slave-24c512ro", I2C_SLAVE_DEVICE_MAGIC(524288 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
+	{ .name = "slave-24c02", .driver_data = I2C_SLAVE_DEVICE_MAGIC(2048 / 8,  0) },
+	{ .name = "slave-24c02ro", .driver_data = I2C_SLAVE_DEVICE_MAGIC(2048 / 8,  I2C_SLAVE_FLAG_RO) },
+	{ .name = "slave-24c32", .driver_data = I2C_SLAVE_DEVICE_MAGIC(32768 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ .name = "slave-24c32ro", .driver_data = I2C_SLAVE_DEVICE_MAGIC(32768 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
+	{ .name = "slave-24c64", .driver_data = I2C_SLAVE_DEVICE_MAGIC(65536 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ .name = "slave-24c64ro", .driver_data = I2C_SLAVE_DEVICE_MAGIC(65536 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
+	{ .name = "slave-24c512", .driver_data = I2C_SLAVE_DEVICE_MAGIC(524288 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ .name = "slave-24c512ro", .driver_data = I2C_SLAVE_DEVICE_MAGIC(524288 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, i2c_slave_eeprom_id);
diff --git a/drivers/i2c/i2c-slave-testunit.c b/drivers/i2c/i2c-slave-testunit.c
index 6de4307050dd..68a07d957113 100644
--- a/drivers/i2c/i2c-slave-testunit.c
+++ b/drivers/i2c/i2c-slave-testunit.c
@@ -270,7 +270,7 @@ static void i2c_slave_testunit_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id i2c_slave_testunit_id[] = {
-	{ "slave-testunit" },
+	{ .name = "slave-testunit" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, i2c_slave_testunit_id);
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index bc7bd55e6370..069f08f68bc1 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -220,7 +220,7 @@ static void smbalert_remove(struct i2c_client *ara)
 }
 
 static const struct i2c_device_id smbalert_ids[] = {
-	{ "smbus_alert" },
+	{ .name = "smbus_alert" },
 	{ /* LIST END */ }
 };
 MODULE_DEVICE_TABLE(i2c, smbalert_ids);
diff --git a/drivers/i2c/muxes/i2c-mux-ltc4306.c b/drivers/i2c/muxes/i2c-mux-ltc4306.c
index 50fbc0d06e62..18228f5b80e8 100644
--- a/drivers/i2c/muxes/i2c-mux-ltc4306.c
+++ b/drivers/i2c/muxes/i2c-mux-ltc4306.c
@@ -191,8 +191,8 @@ static int ltc4306_deselect_mux(struct i2c_mux_core *muxc, u32 chan)
 }
 
 static const struct i2c_device_id ltc4306_id[] = {
-	{ "ltc4305", ltc_4305 },
-	{ "ltc4306", ltc_4306 },
+	{ .name = "ltc4305", .driver_data = ltc_4305 },
+	{ .name = "ltc4306", .driver_data = ltc_4306 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc4306_id);
diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 3d8002caf703..9a59129bc50f 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -74,8 +74,8 @@ struct pca9541 {
 };
 
 static const struct i2c_device_id pca9541_id[] = {
-	{ "pca9541" },
-	{}
+	{ .name = "pca9541" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, pca9541_id);
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index b9f370c9f018..8fca709ed279 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -250,24 +250,24 @@ static const struct chip_desc chips[] = {
 };
 
 static const struct i2c_device_id pca954x_id[] = {
-	{ "max7356", max_7356 },
-	{ "max7357", max_7357 },
-	{ "max7358", max_7358 },
-	{ "max7367", max_7367 },
-	{ "max7368", max_7368 },
-	{ "max7369", max_7369 },
-	{ "pca9540", pca_9540 },
-	{ "pca9542", pca_9542 },
-	{ "pca9543", pca_9543 },
-	{ "pca9544", pca_9544 },
-	{ "pca9545", pca_9545 },
-	{ "pca9546", pca_9546 },
-	{ "pca9547", pca_9547 },
-	{ "pca9548", pca_9548 },
-	{ "pca9846", pca_9846 },
-	{ "pca9847", pca_9847 },
-	{ "pca9848", pca_9848 },
-	{ "pca9849", pca_9849 },
+	{ .name = "max7356", .driver_data = max_7356 },
+	{ .name = "max7357", .driver_data = max_7357 },
+	{ .name = "max7358", .driver_data = max_7358 },
+	{ .name = "max7367", .driver_data = max_7367 },
+	{ .name = "max7368", .driver_data = max_7368 },
+	{ .name = "max7369", .driver_data = max_7369 },
+	{ .name = "pca9540", .driver_data = pca_9540 },
+	{ .name = "pca9542", .driver_data = pca_9542 },
+	{ .name = "pca9543", .driver_data = pca_9543 },
+	{ .name = "pca9544", .driver_data = pca_9544 },
+	{ .name = "pca9545", .driver_data = pca_9545 },
+	{ .name = "pca9546", .driver_data = pca_9546 },
+	{ .name = "pca9547", .driver_data = pca_9547 },
+	{ .name = "pca9548", .driver_data = pca_9548 },
+	{ .name = "pca9846", .driver_data = pca_9846 },
+	{ .name = "pca9847", .driver_data = pca_9847 },
+	{ .name = "pca9848", .driver_data = pca_9848 },
+	{ .name = "pca9849", .driver_data = pca_9849 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pca954x_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


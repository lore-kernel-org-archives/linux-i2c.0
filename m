Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838A35893;
	Sat,  4 Apr 2026 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775269236; cv=none; b=oiayYXfHcMw/b3EIIIAlcIvou41hMfXJwvlJjgbZxGfZeWGChTXqaINuTH3+fcQCQssfg7sNIrraRBut/VEqYlDZqlLud0fZomlquODKOM4+w2v/oxOqum/RW43G73rn3S3vIB4QKLLO+QFwyoDtzyZjEV8atocFpqfMsNLG8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775269236; c=relaxed/simple;
	bh=NF8qIpmHVsbcu3sHqesh1NPyNm6zE60AqBXWscwLYRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O3rNiOUV5XJVXY07xydfWsCaXWkx7CiQXBkN2ukeDtRsKwWq2gXB4xg6m+A3lhl5rYoNE80foqQf0odpEfWCg/MV5kGeC39q0FXilRojUl82pptoJFYjXHbOki8sEHP9OZQ1gPrGyDb5ZASswHYiibyR3oiYWlGetyb+eX+NQOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=T/rGlW71; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="T/rGlW71"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10769; q=dns/txt;
  s=iport01; t=1775269234; x=1776478834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SFLadLAyF1PhMfay+CG6tg8s4lYpQFfVhza6etmNhns=;
  b=T/rGlW712Ejc3x+PiVTl3j3+y5RddMFO8zE3UoJEfgoXyMKy6B8VUNv/
   dpEzup2DzXQL0rj+DydFD7xpQ3gl8zLv/QljTqCibDxX2Jn30+o2nIgYs
   u9AayU9XjYIUwFF88brJajY+U/Jyz2V8XC4w5hjBy4aItatWaW2/kW4xW
   7DBdY3AfUiJs5QMCEcgem+ITuHub164H7dCUfjuatvZZnLajIYbKpzptq
   a64ch9kXHFXkykkMIv84qVhRWysBr9Q4XrWjynIzvlq32LfalkTV5EAgG
   01zD6J6lOiApkoQl1qhakg/OekhzhYTgMNvhDkNe8EFWs1BqkW5D4DmcQ
   g==;
X-CSE-ConnectionGUID: 2AYD/fHITjm82Jm7/s0c5w==
X-CSE-MsgGUID: 8VNhtYT4Rh682qZK8nw3DQ==
X-IPAS-Result: =?us-ascii?q?A0ACAAA6dNBp/4r/Ja1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQGBfAQBAQEBAQsBglaBUEJJjHOJWIEWnQeBfw8BAQEPU?=
 =?us-ascii?q?QQBAYUHjSwCJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFg?=
 =?us-ascii?q?Q4ThlyGXSsLAUaBDDsJgwKCdAIBtSqBeTOBAd4+gWQBCxWBOAGNWXSEeicVB?=
 =?us-ascii?q?oFJRIEVgnJ2gVqCMIZ9BIMcFIQZBoJlgzIBhh9IgR4DWSwBVRMNCgsHBYFmA?=
 =?us-ascii?q?zUSKhUyPDIdgSM+F4EMGwcFgUuHGnRtgRODfGYDCxgNSBEsNxQbBD5uB4tRK?=
 =?us-ascii?q?IE8CFIgexOBJ4E2DD2SYAkBkjyBNYpKlQ+EJqFYGjOEBJQVklEBLodlkHOjX?=
 =?us-ascii?q?H2EaDaBMjyBWTMaCBsVgyJSGQ+OKgMWyQojNT4BBwIHDgKBc5AAgX0BAQ?=
IronPort-Data: A9a23:6NIcp6s3/taarh863Whdxho3fefnVE5fMUV32f8akzHdYApBsoF/q
 tZmKWmEOarZNmfwKI9+O4i09h9U7ZDcyoVnGws/r3wxEn5HgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav666yEgiclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuFYzdJ5xYuajhKs/7b80s11BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIwoM9GLSZA1
 d0kKjVdNDKG2KWtmLnmVbw57igjBJGD0II3oHpsy3TdSP0hW52GG/yM7t5D1zB2jcdLdRrcT
 5NGMnw0M1KaPkAJYwxHYH49tL/Aan3XdTxDs1uQvaMf6GnIxws327/oWDbQUoPSFJkFzx7B+
 goq+UypPDcaKO2jlQCFrCL2n93szSXkA64rQejQGvlCxQf7KnYoIBQMU1eTqOO/hkT4V983A
 0YO9S4Gp6c++VLtVt2VdxKirXGHvjYYWtxNA+M99QeBw7bV5ADfAXILJhZFado7pIo3HzcCy
 FCEhZXqCCZpvbnTTmiSnp+QrDWvKW0WIHUEaCssUwQI+Z/grZs1gxaJScxseJNZlfXvEj32h
 jTPpy8kivBL1IgA1r6w+hbMhDfESoX1czPZLz7/BgqNhj6Vrqb+D2B0wTA3Ncp9Ebs=
IronPort-HdrOrdr: A9a23:WxPP662nMioDX86uv0d/KQqjBLkkLtp133Aq2lEZdPWaSKOlfq
 eV7ZEmPHDP6Qr5NEtMpTniAtjjfZqjz/5ICOAqVN/INjUO01HHEGgN1+ffKkXbak7DHio379
 YGT0C4Y+eAaWRHsQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AKShmKWgOtghcS924HkTbAf7U8jJuKFTs4DDeA26?=
 =?us-ascii?q?EC2M5Ep+QFhiLoKg5jJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AzaYkQg/f+wTON1sQQIGPvHOQf5dWxaSyOXxRq5V?=
 =?us-ascii?q?Y65OdBw8gPSjGoA3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,158,1770595200"; 
   d="scan'208";a="709489014"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 04 Apr 2026 02:19:24 +0000
Received: from sjc-ads-2636.cisco.com (sjc-ads-2636.cisco.com [171.70.32.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTPS id A9350180001C5;
	Sat,  4 Apr 2026 02:19:24 +0000 (GMT)
Received: by sjc-ads-2636.cisco.com (Postfix, from userid 470863)
	id 3B440CBEF83; Fri,  3 Apr 2026 19:19:24 -0700 (PDT)
From: Nishanth Sampath Kumar <nissampa@cisco.com>
To: brgl@bgdev.pl
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Nishanth Sampath Kumar <nissampa@cisco.com>
Subject: [PATCH] at24: add SMBus fallback for adapters lacking I2C_FUNC_I2C
Date: Fri,  3 Apr 2026 19:19:20 -0700
Message-Id: <20260404021920.359902-1-nissampa@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 171.70.32.71, sjc-ads-2636.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com

AMD PIIX4 SMBus adapters, present on AMD SP5/EPYC-based platforms
(including Cisco 8000 series routers), support SMBUS_BYTE_DATA and
SMBUS_WORD_DATA but lack I2C_FUNC_I2C and I2C_FUNC_SMBUS_I2C_BLOCK.
This causes two distinct failures:

1. AT24_FLAG_ADDR16 EEPROMs (e.g. 24c64 syseeprom):
   regmap_get_i2c_bus() returns -ENOTSUPP (-524) for reg_bits=16
   because neither I2C_FUNC_I2C nor I2C_FUNC_SMBUS_I2C_BLOCK is set.
   The driver probe fails entirely with:
     at24 3-0055: probe with driver at24 failed with error -524

2. 8-bit addressed EEPROMs (e.g. 24c02 fan EEPROMs) behind a pca9548
   mux on a PIIX4 child adapter: regmap selects regmap_i2c_smbus_i2c_block
   which fails at runtime even though SMBUS_BYTE_DATA is available.

Add two SMBus-primitive fallback paths, selected after chip flags are
fully resolved (i.e. after flags = cdata->flags and DT address-width
overrides):

  smbus_addr16_fallback (AT24_FLAG_ADDR16 set):
    READ:  i2c_smbus_write_byte_data(client, addr_hi, addr_lo) sets
           the 16-bit address pointer; repeated i2c_smbus_read_byte()
           fetches bytes sequentially (EEPROM auto-increments pointer).
    WRITE: i2c_smbus_write_word_data() encodes address + data byte
           in one SMBus WORD transaction.

  smbus_addr8_fallback (AT24_FLAG_ADDR16 not set):
    READ:  i2c_smbus_read_byte_data(client, (u8)offset) per byte.
    WRITE: i2c_smbus_write_byte_data(client, (u8)offset, data) per byte.

Both paths bypass regmap for I/O. A regmap init retry with reg_bits=8
is added so that probe succeeds on adapters that reject the initial
regmap configuration.

The fallback is only activated when i2c_check_functionality() confirms
both SMBUS_BYTE_DATA and SMBUS_WORD_DATA are present, ensuring no
regression on adapters that support full I2C transfers.

Signed-off-by: Nishanth Sampath Kumar <nissampa@cisco.com>
---
 drivers/misc/eeprom/at24.c | 183 +++++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 1 deletion(-)

--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -88,6 +88,11 @@
 	struct regulator *vcc_reg;
 	void (*read_post)(unsigned int off, char *buf, size_t count);
 
+	/* SMBus-only fallback for EEPROMs on PIIX4 adapters */
+	bool smbus_addr16_fallback;
+	bool smbus_addr8_fallback;
+	struct i2c_client *smbus_client;
+
 	/*
 	 * Some chips tie up multiple I2C addresses; dummy devices reserve
 	 * them for us.
@@ -343,6 +348,139 @@
 	return count;
 }
 
+/* forward declaration needed by at24_smbus_write below */
+static size_t at24_adjust_write_count(struct at24_data *at24,
+				      unsigned int offset, size_t count);
+
+/*
+ * SMBus primitive fallback for 16-bit addressed EEPROMs.
+ *
+ * PIIX4 SMBus supports BYTE_DATA and WORD_DATA but NOT I2C_FUNC_I2C or
+ * I2C_FUNC_SMBUS_I2C_BLOCK, so regmap_get_i2c_bus() returns -ENOTSUPP
+ * for reg_bits=16.  We bypass regmap entirely for the I/O path:
+ *
+ *  READ : write_byte_data(addr_hi, addr_lo) sets the 16-bit EEPROM
+ *         address pointer, then read_byte() fetches bytes one-by-one
+ *         (EEPROM auto-increments the pointer after each read).
+ *
+ *  WRITE: write_word_data(addr_hi, cpu_to_le16((data<<8)|addr_lo))
+ *         encodes the address and data byte in one SMBus word write.
+ */
+static ssize_t at24_smbus_read(struct at24_data *at24, char *buf,
+			       unsigned int offset, size_t count)
+{
+	struct i2c_client *client = at24->smbus_client;
+	unsigned long timeout, read_time;
+	u8 addr_hi = (offset >> 8) & 0xff;
+	u8 addr_lo = offset & 0xff;
+	ssize_t ret;
+	size_t i;
+
+	count = at24_adjust_read_count(at24, offset, count);
+
+	timeout = jiffies + msecs_to_jiffies(at24_write_timeout);
+	do {
+		read_time = jiffies;
+
+		/* Set 16-bit address pointer: command=addr_hi, value=addr_lo */
+		ret = i2c_smbus_write_byte_data(client, addr_hi, addr_lo);
+		if (ret < 0)
+			goto retry;
+
+		/* Read bytes sequentially -- EEPROM auto-increments pointer */
+		for (i = 0; i < count; i++) {
+			ret = i2c_smbus_read_byte(client);
+			if (ret < 0)
+				goto retry;
+			buf[i] = (u8)ret;
+		}
+		dev_dbg(&client->dev, "smbus read %zu@%u --> ok\n", count, offset);
+		return count;
+retry:
+		usleep_range(1000, 1500);
+	} while (time_before(read_time, timeout));
+
+	return -ETIMEDOUT;
+}
+
+static ssize_t at24_smbus_write(struct at24_data *at24, const char *buf,
+				unsigned int offset, size_t count)
+{
+	struct i2c_client *client = at24->smbus_client;
+	unsigned long timeout, write_time;
+	size_t i;
+	int ret;
+
+	/* Write one byte at a time (page writes need raw I2C transfers) */
+	count = at24_adjust_write_count(at24, offset, count);
+
+	for (i = 0; i < count; i++, offset++) {
+		timeout = jiffies + msecs_to_jiffies(at24_write_timeout);
+		do {
+			write_time = jiffies;
+			/*
+			 * command  = addr[15:8]
+			 * word LSB = addr[7:0]
+			 * word MSB = data byte
+			 * EEPROM: set 16-bit address then write one data byte.
+			 */
+			ret = i2c_smbus_write_word_data(client,
+					(offset >> 8) & 0xff,
+					cpu_to_le16(((u16)(u8)buf[i] << 8) |
+						    (offset & 0xff)));
+			if (!ret) {
+				dev_dbg(&client->dev, "smbus write 1@%u --> ok\n",
+					offset);
+				break;
+			}
+			usleep_range(1000, 1500);
+		} while (time_before(write_time, timeout));
+
+		if (ret)
+			return (i > 0) ? (ssize_t)i : -ETIMEDOUT;
+	}
+
+	return count;
+}
+
+static ssize_t at24_smbus8_read(struct at24_data *at24, char *buf,
+				unsigned int offset, size_t count)
+{
+	struct i2c_client *client = at24->smbus_client;
+	size_t i;
+	int ret;
+
+	count = at24_adjust_read_count(at24, offset, count);
+
+	for (i = 0; i < count; i++) {
+		ret = i2c_smbus_read_byte_data(client, (u8)(offset + i));
+		if (ret < 0)
+			return ret;
+		buf[i] = (u8)ret;
+	}
+	dev_dbg(&client->dev, "smbus8 read %zu@%u --> ok\n", count, offset);
+	return count;
+}
+
+static ssize_t at24_smbus8_write(struct at24_data *at24, const char *buf,
+				 unsigned int offset, size_t count)
+{
+	struct i2c_client *client = at24->smbus_client;
+	size_t i;
+	int ret;
+
+	count = at24_adjust_write_count(at24, offset, count);
+
+	for (i = 0; i < count; i++) {
+		ret = i2c_smbus_write_byte_data(client, (u8)(offset + i),
+						(u8)buf[i]);
+		if (ret < 0)
+			return (i > 0) ? (ssize_t)i : ret;
+	}
+	dev_dbg(&client->dev, "smbus8 write %zu@%u --> ok\n", count, offset);
+	return count;
+}
+
 static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
 				unsigned int offset, size_t count)
 {
@@ -353,6 +491,12 @@
 	regmap = at24_translate_offset(at24, &offset);
 	count = at24_adjust_read_count(at24, offset, count);
 
+	if (at24->smbus_addr16_fallback)
+		return at24_smbus_read(at24, buf, offset, count);
+
+	if (at24->smbus_addr8_fallback)
+		return at24_smbus8_read(at24, buf, offset, count);
+
 	/* adjust offset for mac and serial read ops */
 	offset += at24->offset_adj;
 
@@ -411,6 +555,13 @@
 
 	regmap = at24_translate_offset(at24, &offset);
 	count = at24_adjust_write_count(at24, offset, count);
+
+	if (at24->smbus_addr16_fallback)
+		return at24_smbus_write(at24, buf, offset, count);
+
+	if (at24->smbus_addr8_fallback)
+		return at24_smbus8_write(at24, buf, offset, count);
+
 	timeout = jiffies + msecs_to_jiffies(at24_write_timeout);
 
 	do {
@@ -601,6 +752,8 @@
 	bool i2c_fn_i2c, i2c_fn_block;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
+	bool smbus_addr16_fallback;
+	bool smbus_addr8_fallback;
 	bool full_power;
 	struct regmap *regmap;
 	bool writable;
@@ -611,6 +764,18 @@
 	i2c_fn_block = i2c_check_functionality(client->adapter,
 					       I2C_FUNC_SMBUS_WRITE_I2C_BLOCK);
 
+	/*
+	 * Detect SMBus-only adapters (e.g. AMD PIIX4) that lack true I2C
+	 * transfer capability.  Two cases:
+	 *
+	 * 1. No I2C_FUNC_I2C and no I2C_FUNC_SMBUS_I2C_BLOCK:
+	 *    For 16-bit addressed EEPROMs (AT24_FLAG_ADDR16), bypass regmap
+	 *    and use SMBus BYTE_DATA/WORD_DATA helpers.
+	 *
+	 * 2. No I2C_FUNC_I2C but I2C_FUNC_SMBUS_READ_I2C_BLOCK advertised
+	 *    (PIIX4 mux children): regmap picks the block-read path which
+	 *    fails at runtime.  For 8-bit addressed EEPROMs use BYTE_DATA.
+	 */
 	cdata = i2c_get_match_data(client);
 	if (!cdata)
 		return -ENODEV;
@@ -648,6 +813,33 @@
 		}
 	}
 
+	/*
+	 * Detect SMBus-only adapters (e.g. AMD PIIX4) that lack true I2C
+	 * capability.  Detection is done here, after flags has been resolved
+	 * from cdata and any device-tree overrides.
+	 */
+	smbus_addr16_fallback = false;
+	smbus_addr8_fallback = false;
+	if (!i2c_fn_i2c) {
+		bool has_byte = i2c_check_functionality(client->adapter,
+						I2C_FUNC_SMBUS_BYTE_DATA);
+		bool has_word = i2c_check_functionality(client->adapter,
+						I2C_FUNC_SMBUS_WORD_DATA);
+		if (has_byte && has_word) {
+			/*
+			 * SMBus-only adapter (e.g. AMD PIIX4): no true I2C transfers.
+			 * Choose fallback based on EEPROM address width.
+			 */
+			if (flags & AT24_FLAG_ADDR16) {
+				smbus_addr16_fallback = true;
+				dev_dbg(dev, "SMBus-only adapter: enabling 16-bit addr SMBus fallback\n");
+			} else {
+				smbus_addr8_fallback = true;
+				dev_dbg(dev, "SMBus-only adapter: enabling 8-bit addr SMBus fallback\n");
+			}
+		}
+	}
+
 	err = device_property_read_u32(dev, "size", &byte_len);
 	if (err)
 		byte_len = cdata->byte_len;
@@ -681,10 +873,31 @@
 	regmap_config.val_bits = 8;
 	regmap_config.reg_bits = (flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
+	/*
+	 * Force reg_bits=8 when the SMBus fallback path is active so that
+	 * regmap_get_i2c_bus() can pick regmap_smbus_byte and succeed on PIIX4.
+	 * The actual 16-bit address I/O is done entirely by our helpers.
+	 */
+	if (smbus_addr16_fallback && (flags & AT24_FLAG_ADDR16))
+		regmap_config.reg_bits = 8;
 
 	regmap = devm_regmap_init_i2c(client, &regmap_config);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	if (IS_ERR(regmap)) {
+		/*
+		 * For SMBus fallback paths the regmap is never used for I/O.
+		 * If regmap init fails (e.g. adapter lacks I2C_FUNC_SMBUS_I2C_BLOCK
+		 * at probe time), retry with a minimal byte config so probe succeeds.
+		 */
+		if (smbus_addr16_fallback || smbus_addr8_fallback) {
+			struct regmap_config smbus_config = regmap_config;
+
+			smbus_config.reg_bits = 8;
+			smbus_config.val_bits = 8;
+			regmap = devm_regmap_init_i2c(client, &smbus_config);
+		}
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+	}
 
 	at24 = devm_kzalloc(dev, struct_size(at24, client_regmaps, num_addresses),
 			    GFP_KERNEL);
@@ -700,6 +913,9 @@
 	at24->num_addresses = num_addresses;
 	at24->offset_adj = at24_get_offset_adj(flags, byte_len);
 	at24->client_regmaps[0] = regmap;
+	at24->smbus_addr16_fallback = smbus_addr16_fallback;
+	at24->smbus_addr8_fallback = smbus_addr8_fallback;
+	at24->smbus_client = client;
 
 	at24->vcc_reg = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(at24->vcc_reg))

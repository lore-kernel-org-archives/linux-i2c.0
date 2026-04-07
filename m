Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569333F394;
	Tue,  7 Apr 2026 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605245; cv=none; b=qpCnB3cZZTzA322eIJPdB0ogjCUGPi4jKDrg6oQbeDHjZDv+Y8Nkk7ffwnAgstMdXSpc3sSou/67qU206EdKVNV8FoZPYpWIpGghwZQfGEhEBNmwpQrNsSf2H9QXKndlLtbtWjW6e7NTehsWkLL6ry+Hj5UcI/idBjetDHz05DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605245; c=relaxed/simple;
	bh=4Zxzv9bU3lk0ATs2+10/KKxB+S6qASBhD0OYMLyGryc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NaQ0s3kCB65adu8G9GVACKFYwTX8sO7khJA/AWBAaw80N988y6NAT5mUXOdirIURgDjO5vNYfNKNXKR1K4GQDfquyLyk5vNv4B8SMhdTI39VmhaSdI6olKgEpQQtcGV7QhZ2YrSYamxgI90dgX+GJCeIwV4+XTSjEhVDuY8qkqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=gohyotHw; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="gohyotHw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4154; q=dns/txt;
  s=iport01; t=1775605243; x=1776814843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nufn5pIW58IKxrRWnt8EV/auxiPJjdzFzrAlDceL2Ak=;
  b=gohyotHwXzPaI0Ac5qLeJl2XGsc4SYuYh8eAaybhZGhxlgy7vsIvEk6x
   omm2dkSyBnoUUTD+Hb69+1m78XPHGeRD7FGVcWGHgtM7xGVVtaw72qEdC
   67Uv2E01PusDXPrEEQo4WGSWppezyAv9uI2ZMntLEYUJnT8yHMhr1we5r
   ++YnwXA6aJ9G1QkPlzj9sL8n3LFF53sD6f+F8M0CeN7Bs09Car/003Qlz
   gIWLnQzmVYUunHQoAo2op/TSVlkeSH9IjtuJAzQUNlSMh6cJi6qoY3BQN
   S84+Xc0ot28BY4Ta/sRUcZ2vF3P6KF8x2PAtxZk6I3MSQfPOpUkTB6eKY
   A==;
X-CSE-ConnectionGUID: bxwX4TF3QcW4IUbG6PGbEQ==
X-CSE-MsgGUID: qx6haSvjSx+jO/GN4IUaLQ==
X-IPAS-Result: =?us-ascii?q?A0BFAgASldVp/5L/Ja1aHgEBCxIMgWsQDwuCU4FQQkmWS?=
 =?us-ascii?q?4EWnQeBfw8BAQEPUQQBAYUHAo0qAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBCgEBBQEBAQIBBwWBDhOGXIZbAgEDJwsBRhBRKysZgwKCdAIBsl+BeTOBA?=
 =?us-ascii?q?bgggWQBCxWBOI1adIR6JxUGgUlEgRWCcnaLBwSDMINaBoJlgzEBhilIgR4DW?=
 =?us-ascii?q?SwBVRMNCgsHBYFmAzUSKhVuMh2BIz4XgQwbBwWBS4Y0dG2BE4N3cwMLGA1IE?=
 =?us-ascii?q?Sw3FBsEPm4HiyMngUVSIAEsThOCLwEBDh4MPZJgkkaBNZ9ZhCahWBozhASUF?=
 =?us-ascii?q?ZJSLodlkHOkWYRogWg8gVkzGggbFYMiUhkPjioDFhzKAiM1PgEHAgcOAoFzk?=
 =?us-ascii?q?X0BAQ?=
IronPort-Data: A9a23:NcuH4q7p5UsXZXWeq9i28gxRtAzGchMFZxGqfqrLsTDasY5as4F+v
 mIZXGiFM/uMZTD3Ko1xb4Ti8UkBvcLXmNMwTVFkpCxmZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa+1H1dOSx8xGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wo+KUzBHf/g2Qqaj5MtPrfwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoZWk
 M6akdlVVkuAl/scIovNfoTTKyXmcZaOVeS6sUe6boD56vR0SoPe5Y5gXBYUQR8/ZzxkBLmdw
 v0V3XC7YV9B0qEhBI3xXjEAexySM5Gq95fNMWeP7fC9lHTNTCfN/v9BUnkZN6Ahr7Mf7WFmr
 ZT0KRgXZRyFwubzy7WhR6w014IoLdLgO8UUvXQIITPxVKl9B8ucBf+XuJkBgGlYasNmRZ4yY
 +IfaCF0ZRHYajVEO0wcD9Q1m+LAanzXLGcI9QvN//tri4TV5BVhjrjkC8TXQczJR+ISsWDEh
 1/P212sV3n2M/Tak1Jp6EmEj/XJkQvyQoQeHvu0+5ZCikecwkQZBxEbSx2jpZGRgFS5XNReJ
 mQX9zAooKx081akJvHnVhOxrXqsvRMGXddUVeog52mlxbDZ7AWZLmwFSCNRZts7ssM/WT0t0
 BmOhdyBLThutqCFDHPH/Z+Koj6ofysYN2kPYWkDVwRty93ippwjyxHCVNBuFIargdDvXzL92
 TaHqG45nbp7sCIQ/7+w8VaCh3enoYLEC1ZkoA7WRWmiqAh+YeZJerCV1LQS1t4YRK7xc7VLl
 CFsdxS2hAzWMaywqQ==
IronPort-HdrOrdr: A9a23:MK6tXa264n8z6TH3yIF2GQqjBJAkLtp133Aq2lEZdPWaSKOlfq
 eV7ZMmPHDP6Qr5NEtMpTnEAtjjfZq+z+8Q3WBuB9eftWDd0QPCRr2Kr7GSpgEIcBeRygcy78
 tdmtBFeb7NJGk/q9rm6w+lFNtl6tyG/Ke0wdr69R5WPGdXg2UK1XYANu5deXcGPTV7OQ==
X-Talos-CUID: =?us-ascii?q?9a23=3APr13SGjZNBSo7FmJpRqEg9fAkTJueG3C/CvsDRS?=
 =?us-ascii?q?BAlk1aYCfZgGo16lJqp87?=
X-Talos-MUID: 9a23:7ptt9gYvbMh00OBTri+yhDhZKsVT8+esLwcit8knhsCgDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,166,1770595200"; 
   d="scan'208";a="728510294"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Apr 2026 23:39:34 +0000
Received: from sjc-ads-2636.cisco.com (sjc-ads-2636.cisco.com [171.70.32.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id 80FA8180004A8;
	Tue,  7 Apr 2026 23:39:34 +0000 (GMT)
Received: by sjc-ads-2636.cisco.com (Postfix, from userid 470863)
	id 27872CBEF83; Tue,  7 Apr 2026 16:39:34 -0700 (PDT)
From: Nishanth Sampath Kumar <nissampa@cisco.com>
To: broonie@kernel.org
Cc: brgl@bgdev.pl,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	arnd@arndb.de,
	Nishanth Sampath Kumar <nissampa@cisco.com>
Subject: [PATCH v2] regmap-i2c: add SMBus byte/word reg16 bus for adapters lacking I2C_FUNC_I2C
Date: Tue,  7 Apr 2026 16:39:27 -0700
Message-Id: <20260407233927.498932-1-nissampa@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20260404021920.359902-1-nissampa@cisco.com>
References: <20260404021920.359902-1-nissampa@cisco.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;sjc-ads-2636.cisco.com [171.70.32.71];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 171.70.32.71, sjc-ads-2636.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com

AMD PIIX4 SMBus adapters, present on AMD SP5/EPYC-based platforms
(including Cisco 8000 series routers), support SMBUS_BYTE_DATA and
SMBUS_WORD_DATA but lack I2C_FUNC_I2C and I2C_FUNC_SMBUS_I2C_BLOCK.

When at24 (or any driver) requests a regmap with reg_bits=16 and
val_bits=8 on such an adapter, regmap_get_i2c_bus() finds no matching
bus and returns -ENOTSUPP.  The existing regmap_i2c_smbus_i2c_block_reg16
bus type already implements 16-bit addressed reads using only
write_byte_data() + read_byte() primitives, but its selection is gated
on I2C_FUNC_SMBUS_I2C_BLOCK which these adapters lack.

Add a new regmap_smbus_byte_word_reg16 bus that:

  READ:  reuses regmap_i2c_smbus_i2c_read_reg16() -- sets the 16-bit
         address via write_byte_data(addr_lo, addr_hi), then reads
         bytes sequentially via read_byte() (EEPROM auto-increments).
         Requires only SMBUS_BYTE_DATA.

  WRITE: uses write_word_data(addr_hi, (data << 8) | addr_lo) to
         encode one data byte per SMBus WORD transaction.
         Requires only SMBUS_WORD_DATA.  Single-byte writes only.

The new bus is selected in regmap_get_i2c_bus() when reg_bits=16,
val_bits=8, and the adapter has SMBUS_BYTE_DATA | SMBUS_WORD_DATA but
not I2C_FUNC_I2C or SMBUS_I2C_BLOCK.  The branch is placed after the
existing I2C_BLOCK_reg16 check so adapters with full block support
continue to use the faster path.

This fixes at24 EEPROM probe failures on PIIX4:
  at24 3-0055: probe with driver at24 failed with error -524

No driver changes are required -- at24 already passes reg_bits=16 to
devm_regmap_init_i2c(), which now succeeds.

Signed-off-by: Nishanth Sampath Kumar <nissampa@cisco.com>
---
v1 -> v2: Moved fix from at24 driver into regmap-i2c core per review
          feedback from Bartosz Golaszewski and Mark Brown.

 drivers/base/regmap/regmap-i2c.c | 49 ++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -303,6 +303,50 @@
 	.max_raw_write = I2C_SMBUS_BLOCK_MAX - 2,
 };
 
+/*
+ * SMBus byte/word reg16 support for adapters that have SMBUS_BYTE_DATA
+ * and SMBUS_WORD_DATA but lack I2C_FUNC_I2C and I2C_FUNC_SMBUS_I2C_BLOCK,
+ * such as the AMD PIIX4.
+ *
+ * READ:  set 16-bit EEPROM address via write_byte_data(addr_lo, addr_hi),
+ *        then sequentially read bytes via read_byte() (EEPROM auto-
+ *        increments the address pointer).  Same as the I2C-block reg16
+ *        read path above.
+ *
+ * WRITE: encode the low address byte and data into a word transaction:
+ *        write_word_data(addr_hi, (data_byte << 8) | addr_lo).
+ *        Only single-byte writes are supported (one value per transaction).
+ */
+static int regmap_smbus_word_write_reg16(void *context, const void *data,
+					 size_t count)
+{
+	struct device *dev = context;
+	struct i2c_client *i2c = to_i2c_client(dev);
+	u8 addr_hi, addr_lo, val;
+
+	/*
+	 * data layout: [addr_hi, addr_lo, val0, val1, ...].
+	 * Only single-byte value writes are supported; multi-byte would
+	 * require raw I2C (or repeated word writes with incrementing address).
+	 */
+	if (count != 3)
+		return -EINVAL;
+
+	addr_hi = ((u8 *)data)[0];
+	addr_lo = ((u8 *)data)[1];
+	val = ((u8 *)data)[2];
+
+	return i2c_smbus_write_word_data(i2c, addr_hi,
+					 cpu_to_le16(((u16)val << 8) | addr_lo));
+}
+
+static const struct regmap_bus regmap_smbus_byte_word_reg16 = {
+	.write = regmap_smbus_word_write_reg16,
+	.read = regmap_i2c_smbus_i2c_read_reg16,
+	.max_raw_read = I2C_SMBUS_BLOCK_MAX - 2,
+	.max_raw_write = 1,
+};
+
 static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 					const struct regmap_config *config)
 {
@@ -321,6 +365,11 @@
 		i2c_check_functionality(i2c->adapter,
 					I2C_FUNC_SMBUS_I2C_BLOCK))
 		bus = &regmap_i2c_smbus_i2c_block_reg16;
+	else if (config->val_bits == 8 && config->reg_bits == 16 &&
+		 i2c_check_functionality(i2c->adapter,
+					I2C_FUNC_SMBUS_BYTE_DATA |
+					I2C_FUNC_SMBUS_WORD_DATA))
+		bus = &regmap_smbus_byte_word_reg16;
 	else if (config->val_bits == 16 && config->reg_bits == 8 &&
 		 i2c_check_functionality(i2c->adapter,
 					 I2C_FUNC_SMBUS_WORD_DATA))

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724581;
	b=OomWv6P0MPUu+rcFPQTtvNtcU30aQToOzzoc2HDNczEpuCJkxbMyuEA7/ewDlL63oS/f
	 OfIzEbJ+lrh6Jdd0tRUb9dcLg8Oj5y8I/ob/AqPwiu9mlnRw6HJ8/dErUUjdYE3rFYt6e
	 Z6I2afnKJllBKhtb7BGUHXS1txIWRYcTmebBeOqefpJ6xwmkiCyB08MpL3shYGz/8cSv6
	 Gm6KkDy6Vt2mdgnMI6nSaAViCnGLi4pLI7L5FNIOksoe37RA7DpYJKbpgp+vQkdNhM3Sc
	 3V9VrPe5SvniuySimCyFuhBHf5G0FSC/vtfpWAo6hw3+7/RR183nU/EUs2KRgB75o+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724581;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=8lwJOdCb7MDJg26e+UvINZEG/5lYfgdDkUR6Uxlpvj8=;
	b=jHeHxLSRFZKUxe1ybwGUQOsI9lSILnJZmr1zNbGFDfg/Dw4rnSJ+3NpMycCF8mIVGySR
	 L5XMkK4AyP3Qk9ClyCO6HzsGCyF5XarNDblmlXolN+6YCvpu6lAsW4FAV8+mg30xak0qq
	 FkhdXXIc2cAKs5ZYmBRZGPJJ+cuvj5eMoim08vZ+PySTpxW1jOSSDufAcW+W62KUi2USp
	 lFjDIS9lcqZomrH0lz3fENuuRSlAQQjuZ7Qpi2bnZqqwfrw3RRLGxxZZ8U6qs9ik3g+sK
	 JiaI1vbZfiYc4yH+brMjdUUoUMYzRSeaZLkeV1TCyA0F9akcGoQg/SIc0RmBYv2vRuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OasqhL83;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C5606D80F
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 16:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 364C5606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OasqhL83
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DEB9F1A1435;
	Tue,  3 Nov 2026 16:49:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AE25C6046C;
	Tue,  3 Nov 2026 16:49:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56825103291EA;
	Tue,  3 Nov 2026 17:49:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724575; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8lwJOdCb7MDJg26e+UvINZEG/5lYfgdDkUR6Uxlpvj8=;
	b=OasqhL83bsUkn+GFLKmud/Uv97o7ICVyWoYFVOlJjjCAxj79d3g1bKib0FtYtgDUeDG3ql
	NeQzx3zf2Qe21zxpKDprt3wWMeq3pggGTvQIh9DVDyW5jBBG9mBpbMbUk7xbW7NSfQm1/u
	0VgnyxUj+74jrdWNl6SzF/0/8uSUeCnwYimuOJQCQkO71Z4ihPw2X86Jkv2AO67rS3g9no
	XCx4Hw0fuHCOy8ZXGCpoqrlz4fMRQMMVXh73+DRRSo/CcZmvbhZUxHpuwakzS+N3XNblLY
	VQcNcKHw0itn0HvOY3O2nbWPwdA5Y88zDu9UCiMDoYHnLNcXIOu64N5wDpc48g==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:16 +0100
Subject: [PATCH v5 8/9] mfd: cgbc: Add virtual storage devices on the
 virtual I2C bus
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
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-8-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Add support for virtual storage devices exposed by the Board Controller
on its virtual I2C bus. There are two device types: EEPROM for persistent
storage and RAM for non-persistent storage:
- Secure Data EEPROM  (64 bytes, RO): static and dynamic board info
- BIOS EEPROM         (32 bytes, RW): reserved for BIOS applications
- BC EEPROM           (32 bytes, RO): Board Controller operational params
- User EEPROM         (32 bytes, RW): user applications
- BIOS RAM            (32 bytes, RW): reserved for BIOS applications
- BC RAM               (8 bytes, RO): Board Controller operational params
- User RAM            (16 bytes, RW): user applications

Use the at24 driver with the 24c01 entry (the most generic one) for all
virtual storage devices, customizing parameters via software_node
properties (size, pagesize, read-only flag, label).

Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c  | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/cgbc.h |   4 ++
 2 files changed, 133 insertions(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index e0d9939d8c0d..1be437bb4775 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -13,10 +13,12 @@
 
 #include <linux/dmi.h>
 #include <linux/iopoll.h>
+#include <linux/i2c.h>
 #include <linux/mfd/cgbc.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/sysfs.h>
 
 #define CGBC_IO_SESSION_BASE	0x0E20
@@ -55,6 +57,131 @@
 
 static struct platform_device *cgbc_pdev;
 
+static const struct property_entry cgbc_secure_data_eeprom_props[] = {
+	PROPERTY_ENTRY_U32("size", 64),
+	PROPERTY_ENTRY_U32("pagesize", 1),
+	PROPERTY_ENTRY_BOOL("read-only"),
+	PROPERTY_ENTRY_STRING("label", "cgbc-secure-data-eeprom"),
+	{ }
+};
+
+static const struct software_node cgbc_secure_data_eeprom_node = {
+	.properties = cgbc_secure_data_eeprom_props,
+};
+
+static const struct property_entry cgbc_bc_eeprom_props[] = {
+	PROPERTY_ENTRY_U32("size", 32),
+	PROPERTY_ENTRY_U32("pagesize", 1),
+	PROPERTY_ENTRY_BOOL("read-only"),
+	PROPERTY_ENTRY_STRING("label", "cgbc-bc-eeprom"),
+	{ }
+};
+
+static const struct software_node cgbc_bc_eeprom_node = {
+	.properties = cgbc_bc_eeprom_props,
+};
+
+static const struct property_entry cgbc_user_eeprom_props[] = {
+	PROPERTY_ENTRY_U32("size", 32),
+	PROPERTY_ENTRY_U32("pagesize", 1),
+	PROPERTY_ENTRY_STRING("label", "cgbc-user-eeprom"),
+	{ }
+};
+
+static const struct software_node cgbc_user_eeprom_node = {
+	.properties = cgbc_user_eeprom_props,
+};
+
+static const struct property_entry cgbc_bios_eeprom_props[] = {
+	PROPERTY_ENTRY_U32("size", 32),
+	PROPERTY_ENTRY_U32("pagesize", 1),
+	PROPERTY_ENTRY_STRING("label", "cgbc-bios-eeprom"),
+	{ }
+};
+
+static const struct software_node cgbc_bios_eeprom_node = {
+	.properties = cgbc_bios_eeprom_props,
+};
+
+static const struct property_entry cgbc_bc_ram_props[] = {
+	PROPERTY_ENTRY_U32("size", 8),
+	PROPERTY_ENTRY_U32("pagesize", 1),
+	PROPERTY_ENTRY_BOOL("read-only"),
+	PROPERTY_ENTRY_STRING("label", "cgbc-bc-ram"),
+	{ }
+};
+
+static const struct software_node cgbc_bc_ram_node = {
+	.properties = cgbc_bc_ram_props,
+};
+
+static const struct property_entry cgbc_user_ram_props[] = {
+	PROPERTY_ENTRY_U32("size", 16),
+	PROPERTY_ENTRY_U32("pagesize", 1),
+	PROPERTY_ENTRY_STRING("label", "cgbc-user-ram"),
+	{ }
+};
+
+static const struct software_node cgbc_user_ram_node = {
+	.properties = cgbc_user_ram_props,
+};
+
+static const struct property_entry cgbc_bios_ram_props[] = {
+	PROPERTY_ENTRY_U32("size", 32),
+	PROPERTY_ENTRY_U32("pagesize", 1),
+	PROPERTY_ENTRY_STRING("label", "cgbc-bios-ram"),
+	{ }
+};
+
+static const struct software_node cgbc_bios_ram_node = {
+	.properties = cgbc_bios_ram_props,
+};
+
+static const struct i2c_board_info cgbc_i2c_i2cv_board_info[] = {
+	{
+		.type = "24c01",
+		.addr = 0x40,
+		.dev_name = "cgbc-secure-data-eeprom",
+		.swnode = &cgbc_secure_data_eeprom_node,
+	},
+	{
+		.type = "24c01",
+		.addr = 0x48,
+		.dev_name = "cgbc-bc-eeprom",
+		.swnode = &cgbc_bc_eeprom_node,
+	},
+	{
+		.type = "24c01",
+		.addr = 0x50,
+		.dev_name = "cgbc-user-eeprom",
+		.swnode = &cgbc_user_eeprom_node,
+	},
+	{
+		.type = "24c01",
+		.addr = 0x58,
+		.dev_name = "cgbc-bios-eeprom",
+		.swnode = &cgbc_bios_eeprom_node,
+	},
+	{
+		.type = "24c01",
+		.addr = 0x60,
+		.dev_name = "cgbc-bc-ram",
+		.swnode = &cgbc_bc_ram_node,
+	},
+	{
+		.type = "24c01",
+		.addr = 0x68,
+		.dev_name = "cgbc-user-ram",
+		.swnode = &cgbc_user_ram_node,
+	},
+	{
+		.type = "24c01",
+		.addr = 0x70,
+		.dev_name = "cgbc-bios-ram",
+		.swnode = &cgbc_bios_ram_node,
+	}
+};
+
 static const struct cgbc_i2c_platform_data cgbc_i2c_i2c0_pdata = {
 	.name = "cgbc-i2c0",
 	.cgbc_bus_id = 0,
@@ -69,6 +196,8 @@ static const struct cgbc_i2c_platform_data cgbc_i2c_i2cv_pdata = {
 	.name  = "cgbc-i2cv",
 	.cgbc_bus_id = 3,
 	.fixed_freq = true,
+	.devices = cgbc_i2c_i2cv_board_info,
+	.nb_devices = ARRAY_SIZE(cgbc_i2c_i2cv_board_info),
 };
 
 static const struct mfd_cell cgbc_devs[] = {
diff --git a/include/linux/mfd/cgbc.h b/include/linux/mfd/cgbc.h
index 63fdf16fec95..46e8b583bdb8 100644
--- a/include/linux/mfd/cgbc.h
+++ b/include/linux/mfd/cgbc.h
@@ -46,11 +46,15 @@ int cgbc_command(struct cgbc_device_data *cgbc, void *cmd, unsigned int cmd_size
  * @name:		I2C adapter name
  * @cgbc_bus_id:	I2C bus ID (from Board Controller point of view)
  * @fixed_freq:		I2C bus has a fixed frequency
+ * @nb_devices:		number of devices to add when the driver is probed
+ * @devices:		devices to add
  */
 struct cgbc_i2c_platform_data {
 	const char *name;
 	int cgbc_bus_id;
 	bool fixed_freq;
+	int nb_devices;
+	struct i2c_board_info const *devices;
 };
 
 #endif /*_LINUX_MFD_CGBC_H_*/

-- 
2.53.0


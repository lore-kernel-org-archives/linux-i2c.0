Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802319;
	b=S3kaKlQZ9Sjos0hO7dXM4Lb9w+eIF1+yynG636wRlQzW3ncdsp0M2qRgBr+0FM9LAr4e
	 nGqHRTaUzVuNAhCgpnSAcofiBBwpK/RB5QwWl/VpiDx3u+ZmalHyRh8iOe74b1c3xx9jV
	 Bp0igUgddjSuJzseulQpeoFM1d5rTISHFQAAhWn4wpcR4k5vgH81o+6wnl3oIBLTkcpjZ
	 8YheHxUafWnH0+sRm5Ms46Ddr3h3orHey1JJ1s54PkLrFSv5yflM3i1M9P311e3niVvSd
	 oGOkfrggM9ZuRSC9aSTQXY1gk5CxZ64PamrUI834dWlrMNCtFx7wpeNdtUAhp4JUx/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802319;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=QvMpBNnKTFpdOZUFpRu8p1F4ZLzqRGE8LkYnPnuvhRw=;
	b=A5ffIWExEuY+mm7MIf8bwru201CZbCpIX4Uqs/LCCFKzJYGLc8249P2BZ+4u/HfU39pN
	 2l6fttoJZlm2kkqMEpJAl8j47/7e1KjcuZT92JaUwpyb1AaYMBMzesp/ocIhL0CuThsGE
	 oaxkvyRXlnBbuhpnXhtMRIVWUQ+jg7c8ogGmV1jO04iWi4obMeU04VCF6e2+AH3slmTsd
	 xEeX8vLz3wgl3ucm5yaZQkrdHZGNG+CoZ08ugMsI6YEqGSKCHnmVblPWQUmEiFfj3eNEZ
	 X+4jKYrMWK6f7sIzXjgfxMjo2DhrrooX8Cwg3cDpcmBaWB4adND4MWxQ1+0mmNE1aJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rVsj1LNH;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68251606A33A
	for <linux-i2c@vger.kernel.org>; Fri, 27 Nov 2026 17:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68251606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rVsj1LNH
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 23AB51A1842;
	Fri, 27 Nov 2026 17:58:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E5E646049C;
	Fri, 27 Nov 2026 17:58:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D77C104395A2;
	Fri, 27 Nov 2026 18:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802316; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QvMpBNnKTFpdOZUFpRu8p1F4ZLzqRGE8LkYnPnuvhRw=;
	b=rVsj1LNHfVgAAUKS64ELq57t+KBGEk7zI4iHT1Kaw/SwRntpMtJWFRCNsXC2X49sKrRoyY
	qDRlsWHwW6YkFgncD3yw3tGioraJBq6fS0h5d7FTG17qTCnlwbAq9YZCP3Eg1GxQ2jDV8h
	nz7rfXctdej02pRk40NysyqD62pCXXk0+WLQV/qtFj+sFyDiueq4DxmOoDq5oXxMsUthKn
	2wiHBFO3/1YY6AGhuQHvKRUxVLqpjAKJZXZkYTJKSvRj1tstZDmtrsMYbjNannsX0woKox
	iGMwaGlPE1p32w2zEF9Da5rcEnoIbBH0VYftxrKxQOQCDkHSizNTzJRLH9/Z1A==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 27 Nov 2026 18:57:53 +0100
Subject: [PATCH v7 09/11] mfd: cgbc: Add virtual storage devices on the
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
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-9-d0e70fc57879@bootlin.com>
References: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
In-Reply-To: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
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
index db22674affbd..ce90d7315007 100644
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908884;
	b=rE79SMsDol4Rl5IXlo80AsowomKq7fAuRJs0pgvHXHmNJajchyDMGOLQP2YkBZ5qlfpz
	 ym1O06WxXGZ79rGsQ6yEjbYLIQNnFc1ZjCyv4GSb8X9l9Au09wLazwAdG3V4E7vlcrUFb
	 Q1eqEXG4YZZGmsggjPE39jsImYtKGErkziENOnLxkv/KOkPBU4dY0lFhs24oMjt+5fZgq
	 CtyU3HkW0Zzk4rwXPPLM46NxpiP9qrHIXAZAI/vJUh3KBPxAheVn6RneDZjtJlKesiavu
	 lR2vAeyvMvr2XSc3bBegrzRQ3Ie8VWljm/QYrMBZErwGC68gi489QnEEkCvNYhzh6zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908884;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=QvMpBNnKTFpdOZUFpRu8p1F4ZLzqRGE8LkYnPnuvhRw=;
	b=xi4nAghC0PQY9B7xktyf5Vh+1VoLLOqg1Rk3aURS+36JSm8bol2wiYDZuOVnKM8pAxvf
	 CUHlDHoXQU8JWEOnwpBM6NZKx3Tq6J8CM+a+C9i/dWPeKzh/c5Ry1JGXDGPh0Cz8BDGmL
	 N+WUJrri/z/oUmg3As0GkBbXaPDdkRF+nDttTXJCo/WLRNPfntxbyc1c3DU0b6ylWqxR2
	 ByvrY260hvc1TXlkh9bQIlUSDHLmXCU2N18kpFXCOAeucmE6bR7JvSvlpFGthVODqvTOS
	 HsFqwMe3i+INcG/tltUUfIncj9BehkHdj1mZePlQaND4XUaXonBdeU90xAVZloUp5jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NW2uRaon;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB560A3831;
	Tue, 17 Nov 2026 09:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11EB560A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NW2uRaon
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 3F8A8C4EDB9;
	Tue, 17 Nov 2026 09:48:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3E2A5FC81;
	Tue, 17 Nov 2026 09:48:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7EDD211BC02EE;
	Tue, 17 Nov 2026 10:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794908882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QvMpBNnKTFpdOZUFpRu8p1F4ZLzqRGE8LkYnPnuvhRw=;
	b=NW2uRaonUtTGzipExQx/iUpAGUhXJoaV0WjD6Km2B4xMYhkNvXDhMFi5cghbLzoPjoZ2rI
	ka/KIJ1Rwn5dfkYpuXikisEBT33IjCR2fsCrj7w1uEXMEVDNNG2F23bTAmhnf5cBlRdxta
	gsCU0JwmCwQE4tHqEfa8LD/vHcxa32ENbo2sSYG+Hjb3dvKYjpDWu9+AagHh2gxxgNzzNo
	5AMIg/hSe6CIvZnohOJKG+5Un2q8rtIHRlmCH5TZOwB4UN5zlkgis2dOX4bGqUUADKVJ6C
	UAWR6Yya/r+/Cz3/lCQX2Wj0qw1zKTJlTiF6ma1b6pGgoRTqUQFB21se8xxXjw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 17 Nov 2026 10:47:49 +0100
Subject: [PATCH v6 09/10] mfd: cgbc: Add virtual storage devices on the
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
Message-Id: <20261117-cgbc-i2c-storage-devices-support-v6-9-bb070ad3e9aa@bootlin.com>
References: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
In-Reply-To: <20261117-cgbc-i2c-storage-devices-support-v6-0-bb070ad3e9aa@bootlin.com>
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


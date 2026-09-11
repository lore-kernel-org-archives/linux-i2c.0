Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA883EDAAE;
	Fri, 11 Sep 2026 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152551; cv=none; b=tjk8IEsLhhIboLoYvWaMwid8PXftFQSc+RLl3O6P+mw5yv9IUj9IagUpUL0Gqb8H1gYlEbfjNinUkibMtyjUnZ60A1B6xxZtxfq3Ei7utAGLELH8GH7J0seCaiF/XfEx/7HR6xnksjadaQONrhbrQcz2RRP2w2VYnwnO+8VBa7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152551; c=relaxed/simple;
	bh=GNNzSTLbgpHykj/Jyzbjs1Z5IOBldeOKxShjDx3id9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpmYeDsV5Jmf+PDlK2jXI+/v4BRSKKtBo6Rq0dgOjhWljb7JMSXUSvbJymxzyB5TuHdUXHrqQIzZaGR4yfvP4rhgIRiVToy1T1hNMMu0hq74+0EPxk5/HMZikQcLqg+E7uxQPZ42wf9NoENQclKH2UyGT8M7ps5ihAOJMn0DARU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aoWfWH9p; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aoWfWH9p"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EAE2CC63442;
	Fri, 11 Sep 2026 18:49:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEC7060737;
	Fri, 11 Sep 2026 18:49:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C3FD11C7AFAD;
	Fri, 11 Sep 2026 20:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789152542; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FtWqilX0/XJZ8szdotwy1h9xODOL04sHT1uvbcJkTbc=;
	b=aoWfWH9p/yAMQ04WVnv0gSjfaGEpfXyrRWq1me6fmM9g+f0lTvpH1S7zFRf8F65nHEzXzZ
	yMRlr198ROXQ12VCeMBx93HR4QeZaVDYLb/+JzMvz1P96LUfI5hS++w5v/oKWM62doJEEH
	sAKjEI1ETYw1ja98I6Omee2TdqIZ/6uYsgtpOfu29dYJ5XA/ZnTkcoR8HzmKA5JLqy0jnG
	sClxgNHvioedRl9xmCx11UF/3PX/ocQK6tVBe4yekmB0NCQw/hzd+NWEbBiEEgVeP9a0z6
	gv/Ac2CX5lQPtuhkNYwVSBYvSFJ/K9/FQs+L4ysOprMnATShSSxUbD3fqjYuqA==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 11 Sep 2026 20:48:10 +0200
Subject: [PATCH v3 8/9] mfd: cgbc: Add virtual storage devices on the
 virtual I2C bus
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-cgbc-i2c-storage-devices-support-v3-8-594b53fbc5ea@bootlin.com>
References: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
In-Reply-To: <20260911-cgbc-i2c-storage-devices-support-v3-0-594b53fbc5ea@bootlin.com>
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
 drivers/mfd/cgbc-core.c                | 129 +++++++++++++++++++++++++++++++++
 include/linux/platform_data/i2c-cgbc.h |   4 +
 2 files changed, 133 insertions(+)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 90fa0e657385..097b7309a400 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -13,11 +13,13 @@
 
 #include <linux/dmi.h>
 #include <linux/iopoll.h>
+#include <linux/i2c.h>
 #include <linux/mfd/cgbc.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/platform_data/i2c-cgbc.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/sysfs.h>
 
 #define CGBC_IO_SESSION_BASE	0x0E20
@@ -56,6 +58,131 @@
 
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
@@ -70,6 +197,8 @@ static const struct cgbc_i2c_platform_data cgbc_i2c_i2cv_pdata = {
 	.name  = "cgbc-i2cv",
 	.cgbc_bus_id = 3,
 	.fixed_freq = true,
+	.devices = cgbc_i2c_i2cv_board_info,
+	.nb_devices = ARRAY_SIZE(cgbc_i2c_i2cv_board_info),
 };
 
 static const struct mfd_cell cgbc_devs[] = {
diff --git a/include/linux/platform_data/i2c-cgbc.h b/include/linux/platform_data/i2c-cgbc.h
index 224926c12070..5f20503ce858 100644
--- a/include/linux/platform_data/i2c-cgbc.h
+++ b/include/linux/platform_data/i2c-cgbc.h
@@ -14,11 +14,15 @@
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
 
 #endif /* _LINUX_I2C_CGBC_H */

-- 
2.53.0


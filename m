Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048846C854;
	Tue,  4 Aug 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855392; cv=none; b=Mu1pi15Zxa32QVHYUzYXfYjaAKkJiULmMePEVfgFiggz17SkvmXJ8XMIdbxJ/8k+24YDu8gR82u+TEtQdQMZU9oNMsSSk0jQuvHQ+lwWX3v96gJgRyKOid2S4VBHRHsQ5KbUgjnRjOfv4Jz1BfZkmQapC8G5NVALBO/cYwMGFSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855392; c=relaxed/simple;
	bh=H4oJJslLxt5OjocU4A+qH3WKHoxfVmuuo+ec3TiWAbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekf+c7iZFvga6U7XrPkBhGCfTdv4twvBMIFeTtsR5GrQqFBeV1NGpUfXMUnMNbA9/t/RPbgMv2u5+d6mhHCRYNzSlm6AHJjrWAudETVPi7bqAXkMxUhGZrlN9H+vSQZXDiZXxWlvE/8PV9Iz1v+nk9bzLjyvuQPTUab2IZarPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=15AN4IX2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="15AN4IX2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2D6F91A140A;
	Tue,  4 Aug 2026 14:56:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F28916029E;
	Tue,  4 Aug 2026 14:56:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF9E111C32F37;
	Tue,  4 Aug 2026 16:56:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785855384; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pgeyWE5OZKQl6M8USoJy7AhlzXJd3GEZj40nBZ0djFU=;
	b=15AN4IX2hkCILgxcYPjslfZ2p+BCNhmLPpYCyIszvqzUSEYLH4Aonw8nVt/NPLScjor5+n
	93ebLtKeM6fJsIw9LRK5QMH7pQUtv+QPGyzxEiNaXxo974Ia+CIeiL9574XkPMIUWZ/5FC
	wvgZ9GiC01f0AurmiGAFCI4v2yR8tGzeQAd2wtpFoNdDcLgp4nu2SiZIk1VMERCMChxcKn
	XPCa2+HAN8mBi6TGni0LqwcnoEh4K3lpuf/eDPQnZZSZV73mzgkhwFETeQZlsPGG7XhlL1
	l3XyLTZ9JppB6F7meIjOP1XDZSIi78d9wibEU8iNl4bE0qzBU6Z4/D0onnkNog==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 04 Aug 2026 16:55:54 +0200
Subject: [PATCH 4/4] i2c: cgbc: Add virtual storage devices on the virtual
 I2C bus
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-cgbc-i2c-storage-devices-support-v1-4-fed38510671c@bootlin.com>
References: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
In-Reply-To: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.15.2
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
 drivers/i2c/busses/i2c-cgbc.c | 151 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index c3f1c83b105a..418de90e11bb 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -372,6 +372,149 @@ static const struct i2c_adapter cgbc_i2c_adapter[] = {
 	},
 };
 
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
+	PROPERTY_ENTRY_STRING("label", "cgbc-bios-eprom"),
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
+static const struct i2c_board_info cgbc_i2c_board_info[] = {
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
+static void cgbc_i2c_instantiate_devices(struct i2c_adapter *adap)
+{
+	struct i2c_algo_cgbc_data *algo_data = adap->algo_data;
+	struct i2c_client *client;
+	int i;
+
+	/* We only instantiate devices on Virtual bus */
+	if (algo_data->bus_id != CGBC_I2C_VIRTUAL_BUS_ID)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(cgbc_i2c_board_info); i++) {
+		client  = i2c_new_client_device(adap, &cgbc_i2c_board_info[i]);
+		if (IS_ERR(client))
+			dev_err(&adap->dev, "Failed to register %s\n",
+				cgbc_i2c_board_info[i].dev_name);
+	}
+}
+
 static int cgbc_i2c_probe(struct platform_device *pdev)
 {
 	struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
@@ -393,7 +536,13 @@ static int cgbc_i2c_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return i2c_add_numbered_adapter(&i2c->adap);
+	ret = i2c_add_numbered_adapter(&i2c->adap);
+	if (ret)
+		return ret;
+
+	cgbc_i2c_instantiate_devices(&i2c->adap);
+
+	return ret;
 }
 
 static void cgbc_i2c_remove(struct platform_device *pdev)

-- 
2.53.0


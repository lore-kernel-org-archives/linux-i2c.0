Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794288896;
	b=wiS8Sn14soauYIYUsYV7lMhiqS/Z19/hawWGN0A6ZKmcC3g09z9rzZoaHefdh7aGBRyW
	 TDPjX1RDMO7kB37JZ2Sup1/u8cb2l70h0ZVKORSZ7rzEsGgoP//wBEzaERIz+5mpKN61Q
	 tn+9soiP4KhANmrUjWKTdqDNYFQYhpixAydELECYZ1OALh8bEodRQPgt12dhc8XixVMCV
	 zn9ANxythkAJ9O6B2oeIOj6fbHCWJ12FWmEj+DRO3m7HuDgBDFcon/QTe18UbbRQAHwg3
	 +Gh1D5BtRVvN2T0N2N1wU4P9p/442lb+odlP8hew4lkJpHOz3FSmb9TH93K4TmDz1WQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288896;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QdNqftHxSoFRAtv7eupcCOSsohFa/GUGlnPv7gkgdzw=;
	b=YbhJ1+lYB2vhIj8+NafaGy9UpdAtb3JzFZfGuP/mG+6u3L3xpYGP3cxGub8PEGbsTKTh
	 jC2RvXJCHeWO1zdoI6sDDddtD/EXkh6O1JxFMbzSnccz6q5bxe9+RlGlJzcYP8Z6/OXpB
	 +wzdFdWl7FP0pj4rdT67qpAaIylAMpn/1j4m8uC/sVT10X/bDNQV2hsNs2xLzOAqLaPIf
	 zf15xgu7XiiNJ7oatgfP/oN65IvIHiUrElkCHVngviE7NUoQA5PLg1dW0S4vMEqNa5YuI
	 f1ECtIIiDWm7SdubYzoxmttm7YevVJ8W9H6jsFClq9rcpIKwFyk0UoNCyd04Zhikb1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jgsF0/Kn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E70606A330;
	Tue, 10 Nov 2026 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jgsF0/Kn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794288896;
	b=PYj6/9FCQc5CeGu4Wl7YDAN2zN2vGYLdjB2qB5zpTC2KY6agYSV4VRG+Fj2jrtDUTJ/s
	 J5kVFN0DNR2SVksewzsQuJAMnMU7IGCQ3RJTeYM2v42J2CG3x9zpvqPHQ051MfV0V4FKO
	 VnA1lW5e4dUYyJIm4d64z4y7aXEF0DeGP4wDmdC5itOj0TkdR9l1ZTPtcJc8EENyeKJ3f
	 SLVBwTI10iysgPhRbj6PZsZHjhTxAeMjIuujKezQO+NZEeuW/Rb2uBV/kn/2nhaFbHyJ3
	 KppyLOeVzqgeZTabSPn/L3Aan9HoLOyCAkfse1ckJzEdVwAbLME8Fca7YEOqE6CPehw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794288896;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QdNqftHxSoFRAtv7eupcCOSsohFa/GUGlnPv7gkgdzw=;
	b=pq1V/GeE22eamELxb2+fIm+D+FSa5lW6lDzSoGcUi4+CBiuZM31KR2SpcXguF55sA0sY
	 iHxtDJvg2pnqz56Tp6fIRET0XbFbJUcFvlBMY2n1/t8mTqEajcjxnAL+wgRpQJiFGcy1A
	 mqNvsUEKdDGAWRDw8OYNT2zsYXmA2IKbv9TTegdTofhYmPAPd7jaqOIf5TkT/tdFgMp5H
	 rLxJIeDmTEXZanK9Yn06VQAumgqvn47UuRhY1e3zVfy+uwrR1lr6RJ0E/T4BNbOhTnRZ0
	 jnHtVBwVfzAtCtaHRPxIkMVsk6IIaK7FP0027Dn9pUcGR4aoHPUDq2gekqdlitlgr7Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 91AF81F0089F;
	Tue, 10 Nov 2026 05:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794288896;
	bh=QdNqftHxSoFRAtv7eupcCOSsohFa/GUGlnPv7gkgdzw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jgsF0/KnAk8CSf+3gMUMbMdOhz272rvf5MPuBas0aLXbpimyGAXAEYDZ9bbq4iBwQ
	 VjFpX5Ch7HSIwwYaPzpXjyMn9xTDhQOMu+SBmGgs18TSGgox3YLTyqHWGvFrr+Je2b
	 Cql+++exTJH2Gbr/we316cHvOcMse1FKZrcRORV7idRxGtJOPmeSuH6Uv5nmpb7x54
	 dISzg11NQ1Eq2iM4AZwjxaw+gkRTS22yFIUR8dyxZBRTFqREr5caghiiq6hYu/fIsM
	 89gH1XlkFqUXFT/2uIEFqpOMw2nkgjBDC7JSna4Ej10a99y4/b2L8WZoeVVf0L6c8e
	 QleNKOHY7pgmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 218F348879;
	Tue, 10 Nov 2026 05:34:55 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 05:34:54 +0000
Subject: [PATCH] i2c: slave-eeprom: Add an OF match table for module
 autoload
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
Message-Id: <20261110-i2c-slave-eeprom-of-match-v1-1-8f762bf06205@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQpGC1VyldTOJER6qRjEpBv
 HvTdvkW/x+gnIUV7tUBmXdRSXOBvVQQBpp7RumKwRlXW2sNiguoL9oZmZecJkwRJ1rDgJ7a2Pn
 6Rs3VQOmXzFHev/fj+bdufuSwfodwnh9v7hfcfQAAAA==
X-Change-ID: 20261110-i2c-slave-eeprom-of-match-ba9fdb67a830
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794288894; l=3226;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=+qcDKxFvuppZ5+abhrsTQv7e2tAroi0xdMF1879SZxg=;
 b=pm0iwkmNmpUWmwlTZ2MwsyckhAzbSKCamcj+JRKNzWGeYPeOuzMQeknDip50mM8/cPhSwpjFf
 F1boVCkr0loBcJXeYnO7ZXwzWxuwcLjPuUWC0b3/HCppgjejGqz5R+x
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

A backend instantiated from the device tree (compatible "slave-24c02",
reg = <(0x64 | I2C_OWN_SLAVE_ADDRESS)>) gets an i2c client, but the
uevent of a client with an of_node carries an of: modalias
(of:N...Cslave-24c02). The module only declares i2c: aliases, so udev
never loads it and the client stays unbound: there is no slave-eeprom
file and no target is registered, with nothing in the log. Only the
sysfs new_device path (i2c: modalias) or a manual modprobe works.

Declare the same names as an OF table and export it, so the module
autoloads for DT and overlay clients. Matching and probe are unchanged:
the client name is the compatible without a vendor prefix, so
i2c_client_get_device_id() still finds the size and flags.

Tested on an Orange Pi Zero2 (H616) with a slave-24c02 node under TWI3
from a DT overlay, using a local target-mode patch for i2c-mv64xxx:
without this change the client stays unbound after boot; with it the
module autoloads, binds to 3-1064 and creates the 256-byte slave-eeprom
file.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
The slave backends have no DT binding (they are debug devices, as
Documentation/i2c/slave-testunit-backend.rst says), so checkpatch reports
the compatibles as undocumented.

This patch was developed with Claude (Anthropic) as a coding assistant:
it investigated the problem, wrote the code and the commit message. I
reviewed it, and it was tested on an Orange Pi Zero2 (H616) as described
above.
---
 drivers/i2c/i2c-slave-eeprom.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 226d722af662..a08abd895412 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -20,6 +20,7 @@
 #include <linux/firmware.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/slab.h>
@@ -203,9 +204,28 @@ static const struct i2c_device_id i2c_slave_eeprom_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, i2c_slave_eeprom_id);
 
+/*
+ * A backend instantiated from the device tree, with the I2C id as
+ * compatible and I2C_OWN_SLAVE_ADDRESS in reg, announces an of: modalias.
+ * List the same names here so that the module autoloads for it.
+ */
+static const struct of_device_id i2c_slave_eeprom_of_match[] = {
+	{ .compatible = "slave-24c02" },
+	{ .compatible = "slave-24c02ro" },
+	{ .compatible = "slave-24c32" },
+	{ .compatible = "slave-24c32ro" },
+	{ .compatible = "slave-24c64" },
+	{ .compatible = "slave-24c64ro" },
+	{ .compatible = "slave-24c512" },
+	{ .compatible = "slave-24c512ro" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, i2c_slave_eeprom_of_match);
+
 static struct i2c_driver i2c_slave_eeprom_driver = {
 	.driver = {
 		.name = "i2c-slave-eeprom",
+		.of_match_table = i2c_slave_eeprom_of_match,
 	},
 	.probe = i2c_slave_eeprom_probe,
 	.remove = i2c_slave_eeprom_remove,

---
base-commit: 00fb8097ca5a4fcf0e0cc1550075aa7313bbd32a
change-id: 20261110-i2c-slave-eeprom-of-match-ba9fdb67a830

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>



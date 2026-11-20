Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795149138;
	b=oMf98Z/BEInaB0PyAbRq9icJRnxwraytIbHdMbSEBxKBRqDikoQ83MKcywz/ikpqWjHZ
	 ysiJYKHqwbU5HZUohuPAsgZfcU/2qQhbHmYtDN0b7dON0+wNpqxjPt/S9+94SoYTX2X3f
	 IZ9Q44MdBV2suYL7eFOdMkXkkyhk9WioaJqgFsfSjOtAszqognooGC6ey2iLKr6/L880A
	 6CYPfJyMePxoFKQrNt8MIsSUh/F6j8K0rH++NeXj/TPzEqd5QUVL9Fut5D1iMQ67KOgGX
	 b8Gs+QhaPnOE86TamNwQSReuZSupymzM0Hqc6x1dBoRbn03kp3g4qYAmFkcTa9Qu/kQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149138;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e2dD4PjXTrEKcc+eI2Y6CdOUG4wqrpk1gxcTZgnq1aQ=;
	b=rFxc4NhU/8kaL9EZLAYHaz7/TpyhwMO03GiZ0/RgYq9tYw4V+qXnWdiCwaBi+QFfAvWo
	 06zaCfe9OH7cOt4sOuxK2dMPLcHvTlvR/dy6NRShdRxvSuusDxOp2fBd4/RO/+smdegna
	 quRWv/i1/oD5CyMUEVMUZ83fKHkdHIZhCz9LVw9o+OxcMk9Fh8ncxnEdPflQv/l/hp5nj
	 kY8AC8t428NA7C7WHvRGs5/opXNq/1xcHk14eOffKaVqWnKWSTLCGrcoyYxiXp2ozi3tA
	 CnxywFzfQV0jCGdttXv4jJklXP2ticodcr9GaRSSemY9eWabFYHYCMlH1DTVc1x8jdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAIalofq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399D606A320;
	Fri, 20 Nov 2026 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SAIalofq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795149138;
	b=T2alzBWEsq7BECbrTwt7ro5IA1Ma9aEQvxBhsDYA43+x+r3RdRYtij5hoeOQRCm5sw+l
	 fE5cbrlmEan5PUd33iuBVjC5PBoxTG7Kcpr8wybJzz9lcOmmJizxj4RtHHJqBu8MJ9ZXf
	 MU5Hyd/2gOrFSYbqy4yjPEOLvpp6N7gcRreZBSimOaQMzsR/XIVdcwXOc3aqqyF8S5Hj2
	 2eTgo1+/6Ep5DZRyvbpi5WHshuIi8rreF9rzcTSM/B1Q8AC4mh3HcY7PzNaeFjkhVzM8W
	 5WTPRlC48+ZWvR9kgvkX3GFntO1/V5E3GrW5oJaYduZ4DfDAy9VRijPSR4SUkFNViPg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795149138;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e2dD4PjXTrEKcc+eI2Y6CdOUG4wqrpk1gxcTZgnq1aQ=;
	b=ZQUCOhABYHv7YfkEsAvVzbFm7wFZ/gjp+mqjzud2VAOH9h9Em0+CZcfsLWU/jx1PxgU6
	 NCMrOv85Y3B/LEJfiYUjvQwspP9AMWmbMh4ES7LhB24HqmYlsLXGE04fOIRyrQoTkMr22
	 q8k9SpMEpxEluxj0G+thpkbdaSpmkClAc/7JnfvJdftbKHSJ7ToK/fcR4RTS4l52QBImV
	 AJ6hvylvxuJhMfN5FEnrD1utqSx/JUep7mBw4o6oT8daE4ybC0HRmEO7nRSfL6DBGe9GE
	 4Y8N2nkhRz5xswbivkNGmYrYk3UX0g6Bgk6DRog7gK98d8Bh2yjqVIJRMnNSaVLFBFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C23041F000C4;
	Fri, 20 Nov 2026 04:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795149138;
	bh=e2dD4PjXTrEKcc+eI2Y6CdOUG4wqrpk1gxcTZgnq1aQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=SAIalofq2nNSkw5Cmkphfky7gEdzjRYRa6MaS1n0QPdFGLEhXg9KQPBa5ItRtUyzp
	 hRrBkzILab2BJMY9xP/RgyhxEW5obqm0/pShKag5RDvzNoji2bXasInsCegsMStZUu
	 7R7n8PMHDPeGAKuqxnQk8cB0NMGvIGg/ambf7HDRpjQ9FGI3dHnnkyBAu0IjH5UiQt
	 K9PzYEldYCz7g6q4apoxA3TSr3pR12rkjVGNPRv1WiXo2P7NzpJSk7wZAISRt67zeu
	 13zj56AyZyQ2IIkwkHDN9v0N7+9ZtJSzq8n2favyXhTMrjTnBPFqSLHSrXp+OKuCMO
	 sNbMa8ycXtlQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5396A495B1;
	Fri, 20 Nov 2026 04:32:17 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 20 Nov 2026 04:32:18 +0000
Subject: [PATCH v2 2/2] i2c: slave-eeprom: Add an OF match table for module
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
Message-Id: <20261120-i2c-slave-eeprom-of-match-v2-2-0444790a0b76@gmail.com>
References: <20261120-i2c-slave-eeprom-of-match-v2-0-0444790a0b76@gmail.com>
In-Reply-To: <20261120-i2c-slave-eeprom-of-match-v2-0-0444790a0b76@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 =?utf-8?q?Bj=C3=B6rn_Ard=C3=B6?= <bjorn.ardo@axis.com>, 
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795149136; l=4307;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Se4Y5/Hb6KkKeH5RRkJ9D6hSoA/188hlVHGVfP3TXZg=;
 b=xKLt9GktKon1JdAU1l70VysZheaZGo5Q9wOfV4/3zzoFViAoUhMHDsjHLYnfdPF0Ri0kootOb
 mLjfPuzcFf1AUvQRyVTvflC4zDPxtLypRwVWLRLdor4iytva2dNFUEa
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
autoloads for DT and overlay clients. Nodes that bind today keep binding
with the same size and flags.

With an OF table the driver also matches a node that lists one of these
names as a fallback compatible. Such a client is named after its first
compatible and has no i2c id, so give the OF entries the same data as
the i2c ids and read it with i2c_get_match_data().

Tested on an Orange Pi Zero2 (H616) with a local target-mode patch for
i2c-mv64xxx: a slave-24c02 overlay node autoloads the module and binds
with a 256-byte file; a node with slave-24c02 as fallback compatible
binds too (v1 oopsed there); new_device slave-24c32 still gives 4096
bytes.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/i2c/i2c-slave-eeprom.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index 226d722af662..0af48a9085b4 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -142,11 +142,11 @@ static int i2c_slave_init_eeprom_data(struct eeprom_data *eeprom, struct i2c_cli
 
 static int i2c_slave_eeprom_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	unsigned long data = (unsigned long)i2c_get_match_data(client);
 	struct eeprom_data *eeprom;
 	int ret;
-	unsigned int size = FIELD_GET(I2C_SLAVE_BYTELEN, id->driver_data) + 1;
-	unsigned int flag_addr16 = FIELD_GET(I2C_SLAVE_FLAG_ADDR16, id->driver_data);
+	unsigned int size = FIELD_GET(I2C_SLAVE_BYTELEN, data) + 1;
+	unsigned int flag_addr16 = FIELD_GET(I2C_SLAVE_FLAG_ADDR16, data);
 
 	eeprom = devm_kzalloc(&client->dev, sizeof(struct eeprom_data) + size, GFP_KERNEL);
 	if (!eeprom)
@@ -154,7 +154,7 @@ static int i2c_slave_eeprom_probe(struct i2c_client *client)
 
 	eeprom->num_address_bytes = flag_addr16 ? 2 : 1;
 	eeprom->address_mask = size - 1;
-	eeprom->read_only = FIELD_GET(I2C_SLAVE_FLAG_RO, id->driver_data);
+	eeprom->read_only = FIELD_GET(I2C_SLAVE_FLAG_RO, data);
 	spin_lock_init(&eeprom->buffer_lock);
 	i2c_set_clientdata(client, eeprom);
 
@@ -203,9 +203,35 @@ static const struct i2c_device_id i2c_slave_eeprom_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, i2c_slave_eeprom_id);
 
+/* Same data as the I2C ids, for clients matched by a fallback compatible */
+#define I2C_SLAVE_OF_DATA(_len, _flags) \
+	((void *)(unsigned long)I2C_SLAVE_DEVICE_MAGIC(_len, _flags))
+
+static const struct of_device_id i2c_slave_eeprom_of_match[] = {
+	{ .compatible = "slave-24c02",
+	  .data = I2C_SLAVE_OF_DATA(2048 / 8, 0) },
+	{ .compatible = "slave-24c02ro",
+	  .data = I2C_SLAVE_OF_DATA(2048 / 8, I2C_SLAVE_FLAG_RO) },
+	{ .compatible = "slave-24c32",
+	  .data = I2C_SLAVE_OF_DATA(32768 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ .compatible = "slave-24c32ro",
+	  .data = I2C_SLAVE_OF_DATA(32768 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
+	{ .compatible = "slave-24c64",
+	  .data = I2C_SLAVE_OF_DATA(65536 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ .compatible = "slave-24c64ro",
+	  .data = I2C_SLAVE_OF_DATA(65536 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
+	{ .compatible = "slave-24c512",
+	  .data = I2C_SLAVE_OF_DATA(524288 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ .compatible = "slave-24c512ro",
+	  .data = I2C_SLAVE_OF_DATA(524288 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
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

-- 
2.55.0



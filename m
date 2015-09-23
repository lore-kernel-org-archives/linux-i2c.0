From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] i2c-core: allow either old or of_matching of devices
Date: Wed, 23 Sep 2015 15:41:15 +0100
Message-ID: <1443019275-12753-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:44356 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978AbbIWOlW (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 23 Sep 2015 10:41:22 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

If an i2c-driver does not have an Linux specific id_table, but does
have an of_match_table available then allow that to be probed by
the i2c core code.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/i2c/i2c-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5f89f1e..073c130 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -455,6 +455,9 @@ static inline int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
 static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
+	if (!id)
+		return NULL;
+
 	while (id->name[0]) {
 		if (strcmp(client->name, id->name) == 0)
 			return id;
@@ -662,7 +665,7 @@ static int i2c_device_probe(struct device *dev)
 	}
 
 	driver = to_i2c_driver(dev->driver);
-	if (!driver->probe || !driver->id_table)
+	if (!driver->probe || !(driver->id_table || dev->driver->of_match_table))
 		return -ENODEV;
 
 	if (client->flags & I2C_CLIENT_WAKE) {
-- 
2.5.1

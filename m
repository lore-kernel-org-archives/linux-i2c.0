From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] i2c: core: don't try to OF populate DDC i2c buses
Date: Wed, 30 Nov 2016 12:50:05 +0100
Message-ID: <20161130115005.11508-1-l.stach@pengutronix.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51087 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751038AbcK3LuI (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Nov 2016 06:50:08 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de

DDC buses are manually managed by their consumers to communicate
with the display. There is no need to try to populate OF childs.

This gets rid of the device create failed warning caused by the
core trying to populate a DDC bus below a OF device, which has
other childs nodes, that aren't i2c devices.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/i2c/i2c-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 5ab67219f71e..fbf7aade2ca7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1686,6 +1686,10 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 	if (!adap->dev.of_node)
 		return;
 
+	/* DDC buses have no OF populated childs */
+	if (adap->class == I2C_CLASS_DDC)
+		return;
+
 	dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
 
 	bus = of_get_child_by_name(adap->dev.of_node, "i2c-bus");
-- 
2.10.2

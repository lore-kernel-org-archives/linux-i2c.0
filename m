From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: algo-bit: add support for I2C_M_STOP
Date: Sat, 17 Jun 2017 19:12:38 +0200
Message-ID: <20170617171238.19638-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46253 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751957AbdFQRMr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 17 Jun 2017 13:12:47 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

Support for enforced STOPs will allow us to use SCCB compatible devices.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Notes: I don't actually have any SCCB compatible sensor but verified with a
logic analyzer that repeated starts got replaced with a stop + start sequence.
However, we have members in our team who might need this feature soon. I'll
likely wait for their Tested-by unless something unforseen happens.

 drivers/i2c/algos/i2c-algo-bit.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index a8e89df665b904..4758058352959d 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -549,12 +549,17 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 	bit_dbg(3, &i2c_adap->dev, "emitting start condition\n");
 	i2c_start(adap);
 	for (i = 0; i < num; i++) {
+		bool did_stop = false;
+
 		pmsg = &msgs[i];
 		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK;
 		if (!(pmsg->flags & I2C_M_NOSTART)) {
-			if (i) {
-				bit_dbg(3, &i2c_adap->dev, "emitting "
-					"repeated start condition\n");
+			if (did_stop) {
+				bit_dbg(3, &i2c_adap->dev, "emitting start condition\n");
+				i2c_start(adap);
+				did_stop = false;
+			} else if (i) {
+				bit_dbg(3, &i2c_adap->dev, "emitting repeated start condition\n");
 				i2c_repstart(adap);
 			}
 			ret = bit_doAddress(i2c_adap, pmsg);
@@ -588,6 +593,12 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 				goto bailout;
 			}
 		}
+
+		if (pmsg->flags & I2C_M_STOP && i != num - 1) {
+			bit_dbg(3, &i2c_adap->dev, "emitting enforced stop condition\n");
+			i2c_stop(adap);
+			did_stop = true;
+		}
 	}
 	ret = i;
 
-- 
2.11.0

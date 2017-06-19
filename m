From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] i2c: rcar: document HW incapabilities
Date: Mon, 19 Jun 2017 23:41:46 +0200
Message-ID: <20170619214146.4784-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Add recent findings (IGNORE_NAK) and document in a bit more detail why
the feature is not possible.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 048deee674955c..93c1a54981df08 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -783,7 +783,12 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 static u32 rcar_i2c_func(struct i2c_adapter *adap)
 {
-	/* This HW can't do SMBUS_QUICK and NOSTART */
+	/*
+	 * This HW can't do:
+	 * I2C_SMBUS_QUICK (setting FSB during START didn't work)
+	 * I2C_M_NOSTART (automatically sends address after START)
+	 * I2C_M_IGNORE_NAK (automatically sends STOP after NAK)
+	 */
 	return I2C_FUNC_I2C | I2C_FUNC_SLAVE |
 		(I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
 }
-- 
2.10.2

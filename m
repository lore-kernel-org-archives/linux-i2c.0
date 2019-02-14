From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v7 5/5] i2c: ocores: checkpatch fixes
Date: Thu, 14 Feb 2019 09:51:34 +0100
Message-ID: <20190214085134.12900-6-federico.vaga@cern.ch>
References: <20190214085134.12900-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214085134.12900-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@cern.ch>
List-Id: linux-i2c@vger.kernel.org

Miscellaneous style fixes from checkpatch

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 78085a8..b32d67c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -179,8 +179,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
 			goto out;
 		}
-	} else
+	} else {
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
+	}
 
 	/* end of msg? */
 	if (i2c->pos == msg->len) {
@@ -197,11 +198,11 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 				i2c->state = STATE_START;
 
 				oc_setreg(i2c, OCI2C_DATA, addr);
-				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
+				oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_START);
 				goto out;
-			} else
-				i2c->state = (msg->flags & I2C_M_RD)
-					? STATE_READ : STATE_WRITE;
+			}
+			i2c->state = (msg->flags & I2C_M_RD)
+				? STATE_READ : STATE_WRITE;
 		} else {
 			i2c->state = STATE_DONE;
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
@@ -461,13 +462,16 @@ static const struct of_device_id ocores_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, ocores_i2c_match);
 
 #ifdef CONFIG_OF
-/* Read and write functions for the GRLIB port of the controller. Registers are
+/*
+ * Read and write functions for the GRLIB port of the controller. Registers are
  * 32-bit big endian and the PRELOW and PREHIGH registers are merged into one
- * register. The subsequent registers has their offset decreased accordingly. */
+ * register. The subsequent registers have their offsets decreased accordingly.
+ */
 static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
 {
 	u32 rd;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
@@ -481,6 +485,7 @@ static void oc_setreg_grlib(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	u32 curr, wr;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
@@ -569,7 +574,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 	return 0;
 }
 #else
-#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
+#define ocores_i2c_of_probe(pdev, i2c) -ENODEV
 #endif
 
 static int ocores_i2c_probe(struct platform_device *pdev)
@@ -686,10 +691,11 @@ err_clk:
 static int ocores_i2c_remove(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c = platform_get_drvdata(pdev);
+	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* disable i2c logic */
-	oc_setreg(i2c, OCI2C_CONTROL, oc_getreg(i2c, OCI2C_CONTROL)
-		  & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	/* remove adapter & data */
 	i2c_del_adapter(&i2c->adap);
@@ -707,7 +713,8 @@ static int ocores_i2c_suspend(struct device *dev)
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	if (!IS_ERR(i2c->clk))
 		clk_disable_unprepare(i2c->clk);
-- 
2.15.0

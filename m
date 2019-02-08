From: Federico Vaga <federico.vaga@cern.ch>
Subject: [PATCH v3 5/5] i2c:ocores: checkpatch fixes
Date: Fri, 8 Feb 2019 17:12:01 +0100
Message-ID: <20190208161201.7860-6-federico.vaga@cern.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208161201.7860-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga <federico.vaga@cern.ch>
List-Id: linux-i2c@vger.kernel.org

Miscellaneous style fixes from checkpatch

Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
---
 drivers/i2c/busses/i2c-ocores.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 5b80190..ba35d2a 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -182,8 +182,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 			oc_setreg(i2c, OCI2C_CMD, OCI2C_CMD_STOP);
 			goto out;
 		}
-	} else
+	} else {
 		msg->buf[i2c->pos++] = oc_getreg(i2c, OCI2C_DATA);
+	}
 
 	/* end of msg? */
 	if (i2c->pos == msg->len) {
@@ -202,9 +203,9 @@ static void ocores_process(struct ocores_i2c *i2c, u8 stat)
 				oc_setreg(i2c, OCI2C_DATA, addr);
 				oc_setreg(i2c, OCI2C_CMD,  OCI2C_CMD_START);
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
@@ -405,7 +406,8 @@ static int ocores_init(struct device *dev, struct ocores_i2c *i2c)
 	u8 ctrl = oc_getreg(i2c, OCI2C_CONTROL);
 
 	/* make sure the device is disabled */
-	oc_setreg(i2c, OCI2C_CONTROL, ctrl & ~(OCI2C_CTRL_EN|OCI2C_CTRL_IEN));
+	ctrl &= ~(OCI2C_CTRL_EN | OCI2C_CTRL_IEN);
+	oc_setreg(i2c, OCI2C_CONTROL, ctrl);
 
 	prescale = (i2c->ip_clock_khz / (5 * i2c->bus_clock_khz)) - 1;
 	prescale = clamp(prescale, 0, 0xffff);
@@ -462,11 +464,13 @@ MODULE_DEVICE_TABLE(of, ocores_i2c_match);
 #ifdef CONFIG_OF
 /* Read and write functions for the GRLIB port of the controller. Registers are
  * 32-bit big endian and the PRELOW and PREHIGH registers are merged into one
- * register. The subsequent registers has their offset decreased accordingly. */
+ * register. The subsequent registers has their offset decreased accordingly.
+ */
 static u8 oc_getreg_grlib(struct ocores_i2c *i2c, int reg)
 {
 	u32 rd;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	rd = ioread32be(i2c->base + (rreg << i2c->reg_shift));
@@ -480,6 +484,7 @@ static void oc_setreg_grlib(struct ocores_i2c *i2c, int reg, u8 value)
 {
 	u32 curr, wr;
 	int rreg = reg;
+
 	if (reg != OCI2C_PRELOW)
 		rreg--;
 	if (reg == OCI2C_PRELOW || reg == OCI2C_PREHIGH) {
@@ -568,7 +573,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 	return 0;
 }
 #else
-#define ocores_i2c_of_probe(pdev,i2c) -ENODEV
+#define ocores_i2c_of_probe(pdev, i2c) -ENODEV
 #endif
 
 static int ocores_i2c_probe(struct platform_device *pdev)
-- 
2.15.0

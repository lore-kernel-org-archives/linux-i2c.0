From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/4] i2c: sh_mobile: eliminate an open-coded "goto" loop
Date: Thu, 17 Jan 2013 10:45:56 +0100
Message-ID: <1358415957-8371-4-git-send-email-g.liakhovetski@gmx.de>
References: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

Eliminate an open-coded "goto" loop by introducing a function.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/i2c/busses/i2c-sh_mobile.c |   60 ++++++++++++++++++++---------------
 1 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 69a1fbe..5cf2367 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -495,6 +495,37 @@ static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg)
 	return 0;
 }
 
+static int poll_busy(struct sh_mobile_i2c_data *pd)
+{
+	int i;
+
+	for (i = 1000; i; i--) {
+		u_int8_t val = iic_rd(pd, ICSR);
+
+		dev_dbg(pd->dev, "val 0x%02x pd->sr 0x%02x\n", val, pd->sr);
+
+		/* the interrupt handler may wake us up before the
+		 * transfer is finished, so poll the hardware
+		 * until we're done.
+		 */
+		if (!(val & ICSR_BUSY)) {
+			/* handle missing acknowledge and arbitration lost */
+			if ((val | pd->sr) & (ICSR_TACK | ICSR_AL))
+				return -EIO;
+			break;
+		}
+
+		udelay(10);
+	}
+
+	if (!i) {
+		dev_err(pd->dev, "Polling timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 			      struct i2c_msg *msgs,
 			      int num)
@@ -502,8 +533,7 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 	struct sh_mobile_i2c_data *pd = i2c_get_adapdata(adapter);
 	struct i2c_msg	*msg;
 	int err = 0;
-	u_int8_t val;
-	int i, k, retry_count;
+	int i, k;
 
 	activate_ch(pd);
 
@@ -527,31 +557,9 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 			break;
 		}
 
-		retry_count = 1000;
-again:
-		val = iic_rd(pd, ICSR);
-
-		dev_dbg(pd->dev, "val 0x%02x pd->sr 0x%02x\n", val, pd->sr);
-
-		/* the interrupt handler may wake us up before the
-		 * transfer is finished, so poll the hardware
-		 * until we're done.
-		 */
-		if (val & ICSR_BUSY) {
-			udelay(10);
-			if (retry_count--)
-				goto again;
-
-			err = -EIO;
-			dev_err(pd->dev, "Polling timed out\n");
+		err = poll_busy(pd);
+		if (err < 0)
 			break;
-		}
-
-		/* handle missing acknowledge and arbitration lost */
-		if ((val | pd->sr) & (ICSR_TACK | ICSR_AL)) {
-			err = -EIO;
-			break;
-		}
 	}
 
 	deactivate_ch(pd);
-- 
1.7.2.5


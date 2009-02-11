From: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Subject: [patch 1/2] i2c: incremental i2c-mpc driver fix for multi-master i2c busses
Date: Wed, 11 Feb 2009 13:21:36 -0800
Message-ID: <200902112121.n1BLLa1q023498@imap1.linux-foundation.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>

Retry on arbitration lost until xfer is successful, a non-arbitration-lost
error is triggered or the 1s timeout is hit.

Tested with a freescale MPC8349E host cpu.

Signed-off-by: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
---

 drivers/i2c/busses/i2c-mpc.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff -puN drivers/i2c/busses/i2c-mpc.c~i2c-incremental-i2c-mpc-driver-fix-for-multi-master-i2c-busses drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c~i2c-incremental-i2c-mpc-driver-fix-for-multi-master-i2c-busses
+++ a/drivers/i2c/busses/i2c-mpc.c
@@ -106,7 +106,7 @@ static int i2c_wait(struct mpc_i2c *i2c,
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
 				pr_debug("I2C: timeout\n");
-				writeccr(i2c, 0);
+				writeccr(i2c, CCR_MEN);
 				result = -EIO;
 				break;
 			}
@@ -120,10 +120,10 @@ static int i2c_wait(struct mpc_i2c *i2c,
 
 		if (unlikely(result < 0)) {
 			pr_debug("I2C: wait interrupted\n");
-			writeccr(i2c, 0);
+			writeccr(i2c, CCR_MEN);
 		} else if (unlikely(!(i2c->interrupt & CSR_MIF))) {
 			pr_debug("I2C: wait timeout\n");
-			writeccr(i2c, 0);
+			writeccr(i2c, CCR_MEN);
 			result = -ETIMEDOUT;
 		}
 
@@ -268,7 +268,7 @@ static int mpc_xfer(struct i2c_adapter *
 	while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
 		if (signal_pending(current)) {
 			pr_debug("I2C: Interrupted\n");
-			writeccr(i2c, 0);
+			writeccr(i2c, CCR_MEN);
 			return -EINTR;
 		}
 		if (time_after(jiffies, orig_jiffies + HZ)) {
@@ -364,6 +364,15 @@ static int __devinit fsl_i2c_probe(struc
 	}
 	of_register_i2c_devices(&i2c->adap, op->node);
 
+	/* Make sure the adapter is already in master mode some time before
+	 * the first xfer to make sure arbitration control had enough time
+	 * to monitor the bus. The CCR_MEN flag should never be cleared without
+	 * makeing sure there is some delay between setting it again and
+	 * starting the first transfer..
+	 */
+	writeccr(i2c, CCR_MEN);
+	udelay(100);
+
 	return result;
 
  fail_add:
_

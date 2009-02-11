From: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Subject: [patch 2/2] i2c: fix i2c-mpc driver for multi-master i2c busses
Date: Wed, 11 Feb 2009 13:21:37 -0800
Message-ID: <200902112121.n1BLLcJb023501@imap1.linux-foundation.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>

Simply retry on arbitration lost until xfer is successfull, a
non-arbitration-lost error is triggered or the 1s timeout is hit.

Tested with a freescale MPC8349E host cpu.

Signed-off-by: Clifford Wolf <clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
---

 drivers/i2c/busses/i2c-mpc.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff -puN drivers/i2c/busses/i2c-mpc.c~i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses drivers/i2c/busses/i2c-mpc.c
--- a/drivers/i2c/busses/i2c-mpc.c~i2c-fix-i2c-mpc-driver-for-multi-master-i2c-busses
+++ a/drivers/i2c/busses/i2c-mpc.c
@@ -134,13 +134,13 @@ static int i2c_wait(struct mpc_i2c *i2c,
 	if (result < 0)
 		return result;
 
-	if (!(x & CSR_MCF)) {
-		pr_debug("I2C: unfinished\n");
-		return -EIO;
-	}
-
 	if (x & CSR_MAL) {
 		pr_debug("I2C: MAL\n");
+		return -EAGAIN;
+	}
+
+	if (!(x & CSR_MCF)) {
+		pr_debug("I2C: unfinished\n");
 		return -EIO;
 	}
 
@@ -257,11 +257,11 @@ static int mpc_read(struct mpc_i2c *i2c,
 static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 {
 	struct i2c_msg *pmsg;
-	int i;
-	int ret = 0;
+	int i, ret;
 	unsigned long orig_jiffies = jiffies;
 	struct mpc_i2c *i2c = i2c_get_adapdata(adap);
 
+restart:
 	mpc_i2c_start(i2c);
 
 	/* Allow bus up to 1s to become not busy */
@@ -281,7 +281,7 @@ static int mpc_xfer(struct i2c_adapter *
 		schedule();
 	}
 
-	for (i = 0; ret >= 0 && i < num; i++) {
+	for (i = 0, ret = 0; ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 		pr_debug("Doing %s %d bytes to 0x%02x - %d of %d messages\n",
 			 pmsg->flags & I2C_M_RD ? "read" : "write",
@@ -292,7 +292,13 @@ static int mpc_xfer(struct i2c_adapter *
 		else
 			ret =
 			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+		if (ret == -EAGAIN) {
+			pr_debug("Lost i2c arbitration -> retry.\n");
+			mpc_i2c_stop(i2c);
+			goto restart;
+		}
 	}
+
 	mpc_i2c_stop(i2c);
 	return (ret < 0) ? ret : num;
 }
_

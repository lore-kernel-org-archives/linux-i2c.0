From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] i2c: davinci: fixup wait_for_completion_timeout handling
Date: Tue, 17 Mar 2015 03:51:13 -0400
Message-ID: <1426578673-10692-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

wait_for_completion_timeout return 0 (timeout) or >=1 (completion) so the check
for >= 0 is always true and can be dropped implying that r==-EREMOTEIO and thus
the return of -EREMOTEIO can be done in the   if (dev->buf_len)  branch.
As wait_for_completion_timeout returns unsigned long not int, and   int r   is
exclusively used for wait_for_completion_timeout it is renamed and the type
changed to unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

Patch was compile tested with davinci_all_defconfig (implies CONFIG_I2C_DAVINCI=y)

Patch is against 4.0-rc4 (localversion-next is -next-20150317)

 drivers/i2c/busses/i2c-davinci.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 6dc7ff5..120a4ef 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -304,7 +304,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	struct davinci_i2c_platform_data *pdata = dev->pdata;
 	u32 flag;
 	u16 w;
-	int r;
+	unsigned long time_left;
 
 	/* Introduce a delay, required for some boards (e.g Davinci EVM) */
 	if (pdata->bus_delay)
@@ -368,8 +368,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		flag |= DAVINCI_I2C_MDR_STP;
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
 
-	r = wait_for_completion_timeout(&dev->cmd_complete, dev->adapter.timeout);
-	if (r == 0) {
+	time_left = wait_for_completion_timeout(&dev->cmd_complete,
+						dev->adapter.timeout);
+	if (!time_left) {
 		dev_err(dev->dev, "controller timed out\n");
 		davinci_i2c_recover_bus(dev);
 		i2c_davinci_init(dev);
@@ -380,17 +381,13 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		/* This should be 0 if all bytes were transferred
 		 * or dev->cmd_err denotes an error.
 		 */
-		if (r >= 0) {
-			dev_err(dev->dev, "abnormal termination buf_len=%i\n",
-				dev->buf_len);
-			r = -EREMOTEIO;
-		}
+		dev_err(dev->dev, "abnormal termination buf_len=%i\n",
+			dev->buf_len);
 		dev->terminate = 1;
 		wmb();
 		dev->buf_len = 0;
+		return -EREMOTEIO;
 	}
-	if (r < 0)
-		return r;
 
 	/* no error */
 	if (likely(!dev->cmd_err))
-- 
1.7.10.4

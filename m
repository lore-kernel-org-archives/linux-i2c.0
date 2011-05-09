From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 07/13] i2c/i2c-nomadik: print abort cause only on abort tag
Date: Mon,  9 May 2011 23:37:37 +0200
Message-ID: <1304977057-31621-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Modify the code to:
1)Print the cause of i2c failure only if the status is set to ABORT.
2)Print slave address on send/receive fail, will help in which slave
failed.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   27 +++++++++++++++++++--------
 1 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 28389c2..c8bf81a 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -442,7 +442,8 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 
 	if (timeout == 0) {
 		/* controller has timedout, re-init the h/w */
-		dev_err(&dev->pdev->dev, "controller timed out, re-init h/w\n");
+		dev_err(&dev->pdev->dev, "read from slave 0x%x timed out\n",
+				dev->cli.slave_adr);
 		(void) init_hw(dev);
 		status = -ETIMEDOUT;
 	}
@@ -506,7 +507,8 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 
 	if (timeout == 0) {
 		/* controller has timedout, re-init the h/w */
-		dev_err(&dev->pdev->dev, "controller timed out, re-init h/w\n");
+		dev_err(&dev->pdev->dev, "write to slave 0x%x timed out\n",
+				dev->cli.slave_adr);
 		(void) init_hw(dev);
 		status = -ETIMEDOUT;
 	}
@@ -568,6 +570,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	u32 cause;
 	struct nmk_i2c_dev *dev = i2c_get_adapdata(i2c_adap);
+	u32 i2c_sr;
 
 	dev->busy = true;
 
@@ -607,14 +610,22 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 			status = write_i2c(dev);
 		}
 		if (status || (dev->result)) {
-			/* get the abort cause */
-			cause =	(readl(dev->virtbase + I2C_SR) >> 4) & 0x7;
-			dev_err(&dev->pdev->dev, "%s\n",
-				cause >= ARRAY_SIZE(abort_causes)
-				? "unknown reason" : abort_causes[cause]);
+			i2c_sr = readl(dev->virtbase + I2C_SR);
+			/*
+			 * Check if the controller I2C operation status is set
+			 * to ABORT(11b).
+			 */
+			if (((i2c_sr >> 2) & 0x3) == 0x3) {
+				/* get the abort cause */
+				cause =	(i2c_sr >> 4)
+					& 0x7;
+				dev_err(&dev->pdev->dev, "%s\n", cause >=
+						ARRAY_SIZE(abort_causes) ?
+						"unknown reason" :
+						abort_causes[cause]);
+			}
 
 			status = status ? status : dev->result;
-
 			goto out;
 		}
 		udelay(I2C_DELAY);
-- 
1.7.5.1

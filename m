From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-davinci: Fix timeout handling
Date: Mon, 23 Feb 2009 15:05:54 +0100
Message-ID: <20090223150554.203437b3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>, Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Properly set the adapter timeout value in jiffies, and then use that
value in the driver, rather than a hard-coded constant.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: Kevin Hilman <khilman-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
---
Troy, Kevin, can either of you please review, build test and run test
this patch? Thanks.

 drivers/i2c/busses/i2c-davinci.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.29-rc6.orig/drivers/i2c/busses/i2c-davinci.c	2009-02-23 08:50:47.000000000 +0100
+++ linux-2.6.29-rc6/drivers/i2c/busses/i2c-davinci.c	2009-02-23 14:56:17.000000000 +0100
@@ -216,7 +216,7 @@ static int i2c_davinci_wait_bus_not_busy
 {
 	unsigned long timeout;
 
-	timeout = jiffies + DAVINCI_I2C_TIMEOUT;
+	timeout = jiffies + dev->adapter.timeout;
 	while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
 	       & DAVINCI_I2C_STR_BB) {
 		if (time_after(jiffies, timeout)) {
@@ -289,7 +289,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
 
 	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
-						      DAVINCI_I2C_TIMEOUT);
+						      dev->adapter.timeout);
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		i2c_davinci_init(dev);
@@ -546,9 +546,7 @@ static int davinci_i2c_probe(struct plat
 	strlcpy(adap->name, "DaVinci I2C adapter", sizeof(adap->name));
 	adap->algo = &i2c_davinci_algo;
 	adap->dev.parent = &pdev->dev;
-
-	/* FIXME */
-	adap->timeout = 1;
+	adap->timeout = DAVINCI_I2C_TIMEOUT;
 
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);

-- 
Jean Delvare

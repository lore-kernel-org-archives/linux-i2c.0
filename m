From: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: [PATCH v4] i2c: davinci: Fix race when setting up for TX
Date: Tue, 21 Sep 2010 13:13:28 +0900
Message-ID: <1285042408-13200-1-git-send-email-jon.povey@racelogic.co.uk>
References: <4C97CEC9.8060602@boundarydevices.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C97CEC9.8060602-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>, Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>, Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When setting up to transmit, a race exists between the ISR and
i2c_davinci_xfer_msg() trying to load the first byte and adjust counters.
This is mostly visible for transmits > 1 byte long.

The hardware starts sending immediately that MDR.STT is set. IMR trickery
doesn't work because if we start sending, finish the first byte and an
XRDY event occurs before we load IMR to unmask it, we never get an
interrupt, and we timeout.

Sudhakar Rajashekhara explains that at least OMAP-L138 requires MDR mode
settings before DXR for correct behaviour, so load MDR first with
STT cleared and later load again with STT set.

Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985

Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
CC: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
CC: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
---
Reworked after comments by Troy and Sudhakar.

Looking at the datasheet it seemed like setting STP without STT early
might cause a stray STOP to be generated, so I moved it into the second
MDR load.

This passes a quick smoke test but I can't do much more testing right at
the moment. Sudhakar, your comments would be welcomed.

 drivers/i2c/busses/i2c-davinci.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2222c87..5795c83 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -331,21 +331,16 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	INIT_COMPLETION(dev->cmd_complete);
 	dev->cmd_err = 0;
 
-	/* Take I2C out of reset, configure it as master and set the
-	 * start bit */
-	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST | DAVINCI_I2C_MDR_STT;
+	/* Take I2C out of reset and configure it as master */
+	flag = DAVINCI_I2C_MDR_IRS | DAVINCI_I2C_MDR_MST;
 
 	/* if the slave address is ten bit address, enable XA bit */
 	if (msg->flags & I2C_M_TEN)
 		flag |= DAVINCI_I2C_MDR_XA;
 	if (!(msg->flags & I2C_M_RD))
 		flag |= DAVINCI_I2C_MDR_TRX;
-	if (stop)
-		flag |= DAVINCI_I2C_MDR_STP;
-	if (msg->len == 0) {
+	if (msg->len == 0)
 		flag |= DAVINCI_I2C_MDR_RM;
-		flag &= ~DAVINCI_I2C_MDR_STP;
-	}
 
 	/* Enable receive or transmit interrupts */
 	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
@@ -357,7 +352,11 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 
 	dev->terminate = 0;
 
-	/* write the data into mode register */
+	/*
+	 * Write mode register first as needed for correct behaviour
+	 * on OMAP-L138, but don't set STT yet to avoid a race with XRDY
+	 * occuring before we have loaded DXR
+	 */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
 
 	/*
@@ -365,12 +364,19 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	 * because transmit-data-ready interrupt can come before
 	 * NACK-interrupt during sending of previous message and
 	 * ICDXR may have wrong data
+	 * It also saves us one interrupt, slightly faster
 	 */
 	if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
 		davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
 		dev->buf_len--;
 	}
 
+	/* Set STT to begin transmit now DXR is loaded */
+	flag |= DAVINCI_I2C_MDR_STT;
+	if (stop && msg->len != 0)
+		flag |= DAVINCI_I2C_MDR_STP;
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
+
 	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
 						      dev->adapter.timeout);
 	if (r == 0) {
-- 
1.6.3.3

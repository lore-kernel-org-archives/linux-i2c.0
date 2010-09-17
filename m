From: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: [PATCH v2] i2c: davinci: Fix race when setting up for TX
Date: Fri, 17 Sep 2010 11:46:47 +0900
Message-ID: <1284691607-9697-1-git-send-email-jon.povey@racelogic.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When setting up to transmit, a race exists between the ISR and
i2c_davinci_xfer_msg() trying to load the first byte and adjust counters.
This is mostly visible for transmits > 1 byte long.

The hardware starts sending immediately that MDR is loaded. IMR trickery
doesn't work because if we start sending, finish the first byte and an
XRDY event occurs before we load IMR to unmask it, we never get an
interrupt, and we timeout.

Move the MDR load after DXR,IMR loads to avoid this race without locking.

Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985

Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
---
Troy, thanks for the input. I tried reordering the IMR load before but got
occasional timeouts. Went back to the logic analyser today and worked out
why, see above comment in the commit message.

Moving the MDR load seems to fix things without locking, much neater and
tiny patch.

As I understand it we can be confident inside i2c_davinci_xfer_msg() that
the peripheral is not busy sending or receiving something else, I had a
look at the other interrupt sources in the datasheet and this seems safe
enough.

I'm not sure what the correct thing to do for followup message IDs here..
My original email? Troy's? Clues welcome for next time.

 drivers/i2c/busses/i2c-davinci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 72df4af..baa5209 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -349,9 +349,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 
 	dev->terminate = 0;
 
-	/* write the data into mode register */
-	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
-
 	/*
 	 * First byte should be set here, not after interrupt,
 	 * because transmit-data-ready interrupt can come before
@@ -371,6 +368,9 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		w |= DAVINCI_I2C_IMR_XRDY;
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
 
+	/* write the data into mode register; start transmitting */
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
+
 	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
 						      dev->adapter.timeout);
 	if (r == 0) {
-- 
1.6.3.3

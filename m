From: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: [PATCH] i2c: davinci: Fix race when setting up for TX
Date: Thu, 16 Sep 2010 19:21:20 +0900
Message-ID: <1284632480-24035-1-git-send-email-jon.povey@racelogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

When setting up to transmit, a race exists between the ISR and
i2c_davinci_xfer_msg() trying to load the first byte and adjust counters.
This is mostly visible for transmits > 1 byte long.

The ISR may run at any time after the mode register has been set.
While we are setting up and loading the first byte, protect this critical
section from the ISR with a spinlock.

The RX path or zero-length transmits do not need this locking.

Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985

Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
---
I suspect this hasn't shown up for others using single-byte transmits as the
interrupt tends to either run entirely before or entirely after this block
in i2c_davinci_xfer_msg():

	/*
	 * First byte should be set here, not after interrupt,
	 * because transmit-data-ready interrupt can come before
	 * NACK-interrupt during sending of previous message and
	 * ICDXR may have wrong data
	 */
	if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
 		davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
 		dev->buf_len--;
 	}

Often the entire message would be sent before that test was executed
(observed with LED wiggling and a logic analyser), so dev->buf_len would
be untrue and things merrily went on their way. That seems to be counter
to the intent in the comment.

I tried some fiddling around reordering the register loads but couldn't
get things reliable so stuck in a spinlock. Better solutions welcome.

P.S.: Having run into the the bus reset code a lot during testing, I
am pretty sure that that generic_i2c_clock_pulse() does NOTHING due to
pinmuxing, at least on DM355, it is misleading and may be better
replaced with a comment saying "It would be great to toggle SCL here".

 drivers/i2c/busses/i2c-davinci.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2222c87..43aa55d 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -107,6 +107,7 @@ struct davinci_i2c_dev {
 	u8			*buf;
 	size_t			buf_len;
 	int			irq;
+	spinlock_t		lock;
 	int			stop;
 	u8			terminate;
 	struct i2c_adapter	adapter;
@@ -312,6 +313,8 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	u32 flag;
 	u16 w;
 	int r;
+	unsigned long flags;
+	int preload = 0;
 
 	if (!pdata)
 		pdata = &davinci_i2c_platform_data_default;
@@ -347,6 +350,15 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		flag &= ~DAVINCI_I2C_MDR_STP;
 	}
 
+	/*
+	 * When transmitting, lock ISR out to avoid it racing on the buffer and
+	 * DXR register before we are done
+	 */
+	if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
+		preload = 1;
+		spin_lock_irqsave(&dev->lock, flags);
+	}
+
 	/* Enable receive or transmit interrupts */
 	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
 	if (msg->flags & I2C_M_RD)
@@ -366,13 +378,15 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 	 * NACK-interrupt during sending of previous message and
 	 * ICDXR may have wrong data
 	 */
-	if ((!(msg->flags & I2C_M_RD)) && dev->buf_len) {
+	if (preload) {
 		davinci_i2c_write_reg(dev, DAVINCI_I2C_DXR_REG, *dev->buf++);
 		dev->buf_len--;
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 
 	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
 						      dev->adapter.timeout);
+
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		i2c_recover_bus(dev);
@@ -490,6 +504,8 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 	int count = 0;
 	u16 w;
 
+	spin_lock(&dev->lock);
+
 	while ((stat = davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG))) {
 		dev_dbg(dev->dev, "%s: stat=0x%x\n", __func__, stat);
 		if (count++ == 100) {
@@ -579,6 +595,8 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
 		}
 	}
 
+	spin_unlock(&dev->lock);
+
 	return count ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -662,6 +680,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
+	spin_lock_init(&dev->lock);
 	init_completion(&dev->cmd_complete);
 #ifdef CONFIG_CPU_FREQ
 	init_completion(&dev->xfr_complete);
-- 
1.6.3.3

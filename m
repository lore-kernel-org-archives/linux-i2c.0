From: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
Subject: [PATCH] i2c: davinci: Fix race when setting up for TX
Date: Tue, 22 Jun 2010 16:31:03 +0900
Message-ID: <1277191864-5024-1-git-send-email-jon.povey@racelogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Move the interrupt enable after the first byte load for TX, as it
was racing with the interrupt handler and corrupting dev->buf_len
for messages > 1 byte.

Tested on DM355.

Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
---
The race seems to have been introduced by 869e6692d527983958216f13c3c8e095791909df

This fixes the problem for me, but someone from TI might want to comment
on the validity of starting the transfer before enabling the RDY interrupts.
Any possibility of losing interrupts?

Considered a spinlock but if this reordering is OK then it's neater.

I'm guessing not many people have been sending multi-byte messages..

 drivers/i2c/busses/i2c-davinci.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 2222c87..72df4af 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -347,14 +347,6 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		flag &= ~DAVINCI_I2C_MDR_STP;
 	}
 
-	/* Enable receive or transmit interrupts */
-	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
-	if (msg->flags & I2C_M_RD)
-		w |= DAVINCI_I2C_IMR_RRDY;
-	else
-		w |= DAVINCI_I2C_IMR_XRDY;
-	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
-
 	dev->terminate = 0;
 
 	/* write the data into mode register */
@@ -371,6 +363,14 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 		dev->buf_len--;
 	}
 
+	/* Enable receive or transmit interrupts */
+	w = davinci_i2c_read_reg(dev, DAVINCI_I2C_IMR_REG);
+	if (msg->flags & I2C_M_RD)
+		w |= DAVINCI_I2C_IMR_RRDY;
+	else
+		w |= DAVINCI_I2C_IMR_XRDY;
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_IMR_REG, w);
+
 	r = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
 						      dev->adapter.timeout);
 	if (r == 0) {
-- 
1.6.3.3

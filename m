From: "Voss, Nikolaus" <N.Voss@weinmann.de>
Subject: RE: [PATCH] i2c-at91: fix data-loss issue
Date: Mon, 23 Apr 2012 07:39:55 +0200
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905DB4657@wm021.weinmann.com>
References: <20120413103937.GH7154@arwen.pp.htv.fi>
 <1334317476-10044-1-git-send-email-h.feurstein@gmail.com>
 <EF2E73589CA71846A15D0B2CDF79505D0905D5A1AA@wm021.weinmann.com>
 <20120418143920.GA19802@pengutronix.de> <4F930B77.8070909@ayanes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F930B77.8070909@ayanes.com>
Content-Language: de-DE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "'devel@ayanes.com'" <devel@ayanes.com>, 'Wolfram Sang' <w.sang@pengutronix.de>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux-i2c@vger.kernel.org'" <linux-i2c@vger.kernel.org>
Cc: 'Hubert Feurstein' <h.feurstein@gmail.com>, "'ben-linux@fluff.org'" <ben-linux@fluff.org>, "'nicolas.ferre@atmel.com'" <nicolas.ferre@atmel.com>, "'rmallon@gmail.com'" <rmallon@gmail.com>, "'balbi@ti.com'" <balbi@ti.com>
List-Id: linux-i2c@vger.kernel.org

Adrian Yanes wrote on 2012-04-21:
> On the other hand we found that the Underrun Error (UNRE) is not handled
> in the driver. When we send data up > 2-4 bytes (quite random to say
> when it really fails) and we add some dev_dbg() to print
> dev->transfer_status we get 141 (==UNRE). According with the datasheet,
> after the first UNRE received "this action automatically generated a
> STOP bit in Master Mode. Reset by read in TWI_SR when TXCOMP is set."
> 
> We thought that one possibility for this was that the board was too slow
> to process the requests or that other interrupts were interfering.
> Disabling the interrupts inside of the twi interrupt handler did not
> help either.
> 
> The datasheet does not mention any method to implement some mechanism to
> avoid the UNRE telling the hardware to wait a bit longer for the next
> byte. Thus, one way will be to restart the transfer with the remaining
> bytes (maybe only applicable to at91rm9200) or just to return some
> error/message to userland informing that could not send all the data.

The latter is probably the easiest and most transparent solution.
There is no UNRE on G45, it just pauses the clock on an underrun
condition.

So in case UNRE is set, EIO should be returned similar to the already
handled OVRE:

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index a6f9e73..a84e19b 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -238,6 +238,11 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
 		dev_err(dev->dev, "overrun while reading\n");
 		return -EIO;
 	}
+	if (dev->transfer_status & AT91_TWI_UNRE && dev->is_rm9200) {
+		dev_err(dev->dev, "underrun while writing\n");
+		return -EIO;
+	}
+
 	dev_dbg(dev->dev, "transfer complete\n");
 
 	return 0;

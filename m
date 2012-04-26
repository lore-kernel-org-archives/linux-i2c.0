From: Nikolaus Voss <n.voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH v10 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Thu, 26 Apr 2012 13:01:18 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1204261035060.16439@gatekeeper.vosshq.de>
References: <D99582E5322435468A77E74BB0039E7B1D22784CF0@SRV02.hamburg.garz-fricke.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D99582E5322435468A77E74BB0039E7B1D22784CF0-6hi2BFpdtA3X4XV0xjfKZxOngtiEHj0sqGK+G5UkneY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Carsten Behling <carsten.behling-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org>
Cc: Marc-Oliver Westerburg <Westerburg-0M7HhAU3Y85FsXB23wyQUg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, h.feurstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Carsten,

On Wed, 25 Apr 2012, Carsten Behling wrote:
> I cannot find the fix for the RXRDY overrun bug in this patch:

The fix refers to the bug when RXRDY flag was masked out by TXCOMP,
reported by Hubert. I hope this is fixed with v10.

[...]
> here you only report the status flags after a complete transfer, but 
> an overrun can happen after every byte. After reading the status 
> register after an overrun for the next byte this info will be lost !

Right, I didn't consider this. Would you mind to test if the attached 
patch on top of v10 fixes your problem?

Thanks,
Niko

P.S. Are you using a RM9200? Seems that this SOC has some problems...

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 97f4365..df0f6ed 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -186,9 +186,11 @@ static irqreturn_t atmel_twi_interrupt(int irq, void *dev_id)
  	else if (irqstatus & AT91_TWI_TXRDY)
  		at91_twi_write_next_byte(dev);

+	/* catch error flags */
+	dev->transfer_status |= status;
+
  	if (irqstatus & AT91_TWI_TXCOMP) {
  		at91_disable_twi_interrupts(dev);
-		dev->transfer_status = status;
  		complete(&dev->cmd_complete);
  	}

@@ -203,6 +205,7 @@ static int at91_do_twi_transfer(struct at91_twi_dev *dev)
  		(dev->msg->flags & I2C_M_RD) ? "read" : "write", dev->buf_len);

  	INIT_COMPLETION(dev->cmd_complete);
+	dev->transfer_status = 0;
  	if (dev->msg->flags & I2C_M_RD) {
  		unsigned start_flags = AT91_TWI_START;

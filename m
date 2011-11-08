From: "Voss, Nikolaus" <N.Voss-+umVssTZoCsb1SvskN2V4Q@public.gmane.org>
Subject: RE: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
Date: Tue, 8 Nov 2011 16:49:07 +0100
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D087B38B8B5@wm021.weinmann.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <EF2E73589CA71846A15D0B2CDF79505D087B38B899@wm021.weinmann.com>
 <20111108154004.GK20728@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111108154004.GK20728-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Content-Language: de-DE
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "'balbi-l0cyMroinI0@public.gmane.org'" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "'linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org'" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "'khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org'" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "'nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org'" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, "'rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org'" <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> > > > +#include <mach/at91_twi.h>
> > > > +#include <mach/board.h>
> > > > +#include <mach/cpu.h>
> > >
> > > avoid including <mach/*> on drivers.
> >
> > Should I move at91_twi.h to include/linux (omap does it like this,
> > other use the mach-include)?
> 
> maybe, is at91_twi.h some sort of platform_data ? there's
> <linux/platform_data/...> for that.

It contains hardware register definitions, not really platform data.
So linux/i2c-at91.h (like linux/i2c-{omap,pxe,...}) would be the right place?


> 
> > > > +	if (irqstatus & AT91_TWI_TXCOMP) {
> > > > +		at91_disable_twi_interrupts(dev);
> > > > +		dev->transfer_status = status;
> > > > +		complete(&dev->cmd_complete);
> > > > +	}
> > > > +	else if (irqstatus & AT91_TWI_RXRDY) {
> > > > +		at91_twi_read_next_byte(dev);
> > > > +	}
> > > > +	else if (irqstatus & AT91_TWI_TXRDY) {
> > > > +		at91_twi_write_next_byte(dev);
> > > > +	}
> > > > +	else {
> > > > +		return IRQ_NONE;
> > >
> > > coding style is wrong. Also, are those IRQ events really mutually
> exclusive ??
> >
> > These are indeed mutually exclusive (semantically).
> 
> so you couldn't have AT91_TWI_TXCOMP and AT91_TWI_RXRDY set when you read
> irqstatus ?

Yes, I do have this, but in this constellation only TXCOMP is relevant and
all other flags can be ignored (because the transfer is finished).

Niko

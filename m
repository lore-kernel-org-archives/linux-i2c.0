From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates,
 part 2
Date: Mon, 31 Mar 2008 20:41:56 +0200
Message-ID: <20080331204156.1bcda7b9@hyperion.delvare>
References: <1205585237-21492-1-git-send-email-me@felipebalbi.com>
	<1205585237-21492-2-git-send-email-me@felipebalbi.com>
	<1205585237-21492-3-git-send-email-me@felipebalbi.com>
	<1205585237-21492-4-git-send-email-me@felipebalbi.com>
	<20080315124918.GA21547@kedavra.cpe.vivax.com.br>
	<20080315125458.GB21547@kedavra.cpe.vivax.com.br>
	<20080315131309.GA24990@kedavra.cpe.vivax.com.br>
	<20080316105617.GA4503@kedavra.cpe.vivax.com.br>
	<20080331173749.GA10234@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080331173749.GA10234-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Mon, 31 Mar 2008 18:37:49 +0100, Ben Dooks wrote:
> On Sun, Mar 16, 2008 at 12:56:18PM +0200, Felipe Balbi wrote:
> > This patch uses set_irq_type as suggested by Dave.
> > 
> > ============= CUT HERE =========
> > 
> > >From 293a73277794a1ca0f2307e7fe9d5ecd76d3ad06 Mon Sep 17 00:00:00 2001
> > From: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
> > Date: Tue, 1 Jan 2008 23:00:18 -0500
> > Subject: [PATCH] I2C: ISP1301_OMAP: New-style i2c driver updates, part 2
> > 
> > Based on David Brownell's patch for tps65010, this patch
> > finish conversting isp1301_omap.c to new-style i2c driver.
> > 
> > Signed-off-by: Felipe Balbi <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>
> > ---
> >  arch/arm/mach-omap1/board-h2.c   |    4 +
> >  arch/arm/mach-omap1/board-h3.c   |    8 ++
> >  arch/arm/mach-omap2/board-h4.c   |   14 ++++
> >  drivers/i2c/chips/isp1301_omap.c |  134 ++++++++++---------------------------
> >  4 files changed, 62 insertions(+), 98 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
> > index 5079877..fd9567c 100644
> > --- a/arch/arm/mach-omap1/board-h2.c
> > +++ b/arch/arm/mach-omap1/board-h2.c
> > @@ -22,6 +22,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/delay.h>
> > +#include <linux/irq.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/i2c.h>
> >  #include <linux/mtd/mtd.h>
> >  #include <linux/mtd/nand.h>
> > @@ -366,6 +368,8 @@ static void __init h2_init_irq(void)
> >  	omap_init_irq();
> >  	omap_gpio_init();
> >  	h2_init_smc91x();
> > +	set_irq_type(OMAP_GPIO_IRQ(2),
> > +			IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_FALLING);
> 
> Calling set_irq_type directly is not the recommended way of doing
> this. Use the correct trigger flags to request_irq().

Why that? set_irq_type() can be called from platform code, while
request_irq() is called from device drivers. When different platforms
use the same driver and need different IRQ trigger flags, using
set_irq_type() saves the need to carry the information from each
platform to the device driver. What's wrong with this approach?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

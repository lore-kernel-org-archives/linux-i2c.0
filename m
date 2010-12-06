From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] EG20T: Update PCH_I2C driver to 2.6.36
Date: Mon, 6 Dec 2010 08:53:04 +0100
Message-ID: <20101206085304.094d1078@endymion.delvare>
References: <4CD8CD32.5000909@dsn.okisemi.com>
	<4CFC6622.1050006@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CFC6622.1050006-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 06 Dec 2010 04:27:14 +0000, Ben Dooks wrote:
> On 09/11/10 04:25, Tomoya MORINAGA wrote:
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> > index c3ef492..e55e051 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -60,6 +60,7 @@ obj-$(CONFIG_I2C_STU300)	+= i2c-stu300.o
> >  obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
> >  obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
> >  obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
> > +obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
> 
> Jean, do you want these alphabetically sorted?

I prefer them sorted alphabetically, yes. For several reasons:
* Makes it easier to find out a specific entry.
* Makes it easier to spot duplicate drivers or drivers for very similar
  devices which could be merged.
* Limits the risks of reject when two new drivers are added in parallel.

Thanks,
-- 
Jean Delvare

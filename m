From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v6 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller
 for Aspeed
Date: Wed, 29 Mar 2017 07:50:16 +1100
Message-ID: <1490734216.3177.140.camel@kernel.crashing.org>
References: <20170328051226.21677-1-brendanhiggins@google.com>
         <20170328051226.21677-3-brendanhiggins@google.com>
         <49a13bbc-aec3-a349-4323-3c8d2728c62f@arm.com>
         <1490692375.3177.119.camel@kernel.crashing.org>
         <91936f1a-0a0d-4091-b981-976503a6f7cd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <91936f1a-0a0d-4091-b981-976503a6f7cd-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2017-03-28 at 10:40 +0100, Marc Zyngier wrote:
> On 28/03/17 10:12, Benjamin Herrenschmidt wrote:
> > On Tue, 2017-03-28 at 09:32 +0100, Marc Zyngier wrote:
> > > I'm a bit concerned by this. It means that you can't even mask an
> > > interrupt. Is that really what you intend to do? Or all that the HW can
> > > do? If you cannot mask an interrupt, you're at the mercy of a screaming
> > > device...
> > 
> > This is not really an interrupt controller. It's a "summary" register
> > that reflects the state of the 14 i2c controller interrupts.
> > 
> > This approach does have the advantage of providing separate counters in
> > /proc/interrupts which is rather nice, but it does have overhead. On
> > those shittly little ARMv9 400Mhz cores it can be significant.
> 
> <pedantic>
> s/ARMv9/ARM9/, as we're still on variations of the ARMv8 architecture ;-)
> </pedantic>

It was a typo, I meant ARM9/ARMv5 :-)

The 2 SOC families we are talking about (Aspeed 24xx and 25xx) are
based on a ARM926EJ at 400Mhz and an ARM1176JZFS at 800Mhz
respectively, so cycles do count :-)
 
> A 400MHz ARM9 (which is either ARMv4 or ARMv5) is not too bad (hey, we
> still have a couple of Versatile-ABs here...). Caches are pretty small
> though.

16K/16K, no L2 :) 

> > I would personally have some kind of trick to register a single
> > interrupt handler that calls directly the handlers of the respective
> > i2c busses via a simple indirection for speed, maybe adding my custom
> > sysfs or debugfs statistics. But that's just me trying to suck the last
> > cycle out of the bloody thing ;-)
> 
> I'd hope the irqdomain itself to be pretty light (the revmap should help
> here), but of course you're going to do more work. Counters also come at
> a cost. It'd be interesting to see if Brendan has any overhead data
> about this.

Thankfully, the HW supports buffered sends/receive or even DMA. The
current patch doesn't yet support these but they would be a good way to
alleviate the cost of the interrupts if it becomes a problem.

Cheers,
Ben.

> Cheers,
> 
> 	M.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

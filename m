From: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 2/5] irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed
Date: Wed, 29 Mar 2017 02:59:53 -0700
Message-ID: <CAFd5g46TAGHWtH7p1o=AJqy8_SygpJZ4RJkJpUwDD3nKxpB5YQ@mail.gmail.com>
References: <20170328051226.21677-1-brendanhiggins@google.com>
 <20170328051226.21677-3-brendanhiggins@google.com> <49a13bbc-aec3-a349-4323-3c8d2728c62f@arm.com>
 <1490692375.3177.119.camel@kernel.crashing.org> <91936f1a-0a0d-4091-b981-976503a6f7cd@arm.com>
 <1490734216.3177.140.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490734216.3177.140.camel-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Kachalov Anton <mouse-Pma6HLj0uuo@public.gmane.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg-Bxea+6Xhats@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The main reason I took this approach is just because I thought it was
cleaner from the perspective of the busses which are totally
independent (except for the fact that they share a single hardware
interrupt).

I did not make any measurements, so I doubt that I have anything to
add that you don't already know. I saw other usages of chained
interrupts that do the same thing (scan a "status" register and use
them to make software interrupts) and I thought that is basically what
the dummy irq chip code is for. The only thing I thought I was doing
that was novel was actually breaking out the dummy irqchip into its
own driver; it is not my idea, but I do think makes it a lot cleaner.
Nevertheless, it should be cheap in terms of number of instructions;
the most expensive part looks like looking up the mapping. In any
case, I think the low hanging fruit here is supporting buffering or
DMA, like Ben suggested.

To address the comment on being over engineered: outside of the init
function (which would exist regardless of how we do this, if not here
then in the I2C driver); the code is actually pretty small and
generic.

All that being said, it would not be very hard to do this without
using the dummy irqchip code and it would definitely be smaller in
terms of indirection and space used, but I think the code would
actually be more complicated to read. We would be going back to having
an I2C controller along with the I2C busses; where all the I2C
controller does is read the IRQ register and then call the appropriate
bus irq handler, which looks a lot like a dummy irqchip.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

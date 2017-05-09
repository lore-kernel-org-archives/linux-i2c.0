From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v7 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Tue, 09 May 2017 09:15:07 +0200
Message-ID: <1494314107.25766.442.camel@kernel.crashing.org>
References: <20170424181818.2754-1-brendanhiggins@google.com>
         <20170424181818.2754-5-brendanhiggins@google.com>
         <CAFd5g47VGa=wqeyg5tFjB5xD=YsTuP27hLN3-ZM62MJD8dCP_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFd5g47VGa=wqeyg5tFjB5xD=YsTuP27hLN3-ZM62MJD8dCP_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>, Kachalov Anton <mouse-Pma6HLj0uuo@public.gmane.org>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg-Bxea+6Xhats@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, OpenBMC Maillist <openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Ryan Chen <ryan_chen-SAlXDmAnmOAqDJ6do+/SaQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 2017-05-08 at 16:28 -0700, Brendan Higgins wrote:
> 
> I am curious what everyone thinks about this. It seemed that, earlier
> on, people did not like me disabling multi-master mode, but I think
> that it would make bus recovery not work as well. Given that, I think
> it makes the most sense to provide a device tree option either to
> enable multi-master support or disable it. Thoughts?

I think we probably want to keep it enabled yes. Another reason is that
SMBus notifications are in effect a type of multi-master (well slave
really), and we should really add support for them even when the slave
is not enabled.

We are hitting some PMbus devices that apparently can't be prevented
from sending those and that's causing issues.

Cheers,
Ben.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

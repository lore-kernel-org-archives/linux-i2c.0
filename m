From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Sat, 19 Feb 2011 10:54:57 +0100
Message-ID: <AANLkTim2TfG-18XN3r9m3Rq68ZD6QHUY7X82E4-XWH83@mail.gmail.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
	<20110218202744.GA19427@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110218202744.GA19427-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, khilman-l0cyMroinI0@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2011/2/18 Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>:

> Do we have any pressing need to convert AMBA stuff? =A0I haven't hear=
d any
> reason yet to convert them to runtime PM - they don't even make any
> runtime PM calls.
>
> Maybe Linus can comment on the PM stuff as he has SoCs with these in.
> As my boards don't have any sensible PM support, I don't have any
> visibility of what PM facilities would be required.

Sure, basically I ACK Rabins patch and his reasoning for it. (BTW
Rabin spends most of his days working on the Ux500 SoCs too.)

The runtime PM we need for Ux500 is to switch off silicon core
voltage first and foremost. The call I've added to switch of a core
voltage regulator will need to be called when the silicon is idle.

In spi/amba-pl022.c I take the most brutal approach with a recent
patch: hammer off this core switch (and clock) whenever the hardware
is not used. This is simple in this driver since it has no state to pre=
serve
across transfers, it is written such that the core is loaded with the
appropriate state for each message.

Continuing this approach we run into two problems with this
and other drivers:

-  Hammering off/on the clock+voltage is causing delays in HW
   so what you want is some hysteresis (usually, wait a few us/ms
   then switch off) - sort of a takeoff/landing effect.

-  Modelling voltage domains as regulators is nice, but require
   us to switch on/off from process context, so we cannot do this
   from interrupt handlers.

Both of these problems are solved by elegance if we use runtime
PM, since it will provide a hysteresis timeout that can be triggered
from interrupt context and call the idling hooks in process context.

Yours,
Linus Walleij

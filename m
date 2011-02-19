From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Sat, 19 Feb 2011 11:16:17 +0100
Message-ID: <AANLkTinz55AAYA7Ltgcs_z+ysedxtavW2xsdw4=4qP0_@mail.gmail.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
	<20110218202744.GA19427@n2100.arm.linux.org.uk>
	<AANLkTim2TfG-18XN3r9m3Rq68ZD6QHUY7X82E4-XWH83@mail.gmail.com>
	<20110219100017.GA29493@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110219100017.GA29493-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, khilman-l0cyMroinI0@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2011/2/19 Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>:
> [Me]
>> Both of these problems are solved by elegance if we use runtime
>> PM, since it will provide a hysteresis timeout that can be triggered
>> from interrupt context and call the idling hooks in process context.
>
> So what's the interdependence with the platform bus that was being talked
> about earlier in this thread?

That's about consistency of runtime PM semantics across
different buses as I understand it.

We have both platform bus and AMBA bus devices in the system,
so it is desireable if the semantics of their runtime PM are identical.

If I understand it, the difference is that the platform bus will call
runtime_suspend() on the device even if it was already in suspended
state, so the question is about whether the AMBA runtime PM
should do this too since it is similar to the platform bus, or if it should
go for the more intutive approach of not suspending suspended
hardware.

I think the current patch from Rabin as it stands does the latter, and
is good as it stands. It's the other buses and their drivers that
need patching.

Yours,
Linus Walleij

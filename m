From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/nomadik: runtime PM support
Date: Fri, 21 Oct 2011 13:19:02 +0200
Message-ID: <CACRpkdZmifrV3o59JrWx2Z6DAqHO80W4d=7NJ6OipAOrbazgXg@mail.gmail.com>
References: <1319127798-13395-1-git-send-email-linus.walleij@stericsson.com>
	<CANqRtoSxHHKxLaKd-qPjCDomp5o-iiij8hqLCs7GNhs4xCV-jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqRtoSxHHKxLaKd-qPjCDomp5o-iiij8hqLCs7GNhs4xCV-jg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 20, 2011 at 6:44 PM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:
> On Fri, Oct 21, 2011 at 1:23 AM, Linus Walleij
> <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
>> From: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
=2E..
>> +static int nmk_i2c_runtime_suspend(struct device *dev)
>> +{
>> + =A0 =A0 =A0 clk_disable(nmk_i2c->clk);
(...)
>> +}
>> +
>> +static int nmk_i2c_runtime_resume(struct device *dev)
>> +{
(...)
>> + =A0 =A0 =A0 clk_enable(nmk_i2c->clk);
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>
> Hm, on SH-Mobile ARM we never control any clocks from the driver
> runtime pm callbacks.

OK so you're using pm_clk_add_notifier() and the standard
implementation from drivers/base/power/clock_ops.c?

> (...) In our case the runtime suspend callbacks are only invoked
> when all the devices in the power domain happen to have a zero runtim=
e
> pm use count. So if you control your clocks from those callbacks then
> they will be mostly left on which may not be what you want.

We have power domains implemented as well, but currently these
handle power domain regulators and pin control only,
not clocking.

They are registered to the platform and amba bus using
bus_register_notifier() rather than pm_*() notifiers though,
but we listen to the same events
BUS_NOTIFY_[BIND|UNBOUND]_DRIVER

So your suggestion is to move clock control for all
platform devices to the overarching platform code where
we also handle the power domain regulators and pin
control?

Currently we have something similar for the AMBA
bus here, since it actually has code in place to grab
the block clock on probe() and its own runtime PM
callbacks. Since the bus driver holds the actual reference
to the clock, we have to call down into the bus callbacks
from the platform runtime PM implementation since our
implementation takes precedence. I guess this is expected
way of doing it?

I see three possible paradigms here:

(A) dev_power_domain implementation in
  platform/board code handle silicon clocks and regulators.

(B) Bus (as AMBA) driver handle silicon clocks and
  regulators

(C) Devices handle clocks and regulators in their runtime
  PM callbacks themselves

So now ARM SHmobile does (A), PrimeCell drivers do
(B) and this patch attempted to do (C).

And our way of handling AMBA is a mixture calling
the bus callbacks from the platform like (A)+(B)

I guess (A) and (C) won't mix very well since both
handle platform devices and things will screw up if
say our platform and SHmobile would use the same
driver.

Yours,
Linus Walleij

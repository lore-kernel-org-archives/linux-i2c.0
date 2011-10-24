From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c/nomadik: runtime PM support
Date: Mon, 24 Oct 2011 23:32:39 +0900
Message-ID: <CANqRtoRw5+1yrEuphdYT+wq2ooHTojj00i5yGLPMWomUBPSP1Q@mail.gmail.com>
References: <1319127798-13395-1-git-send-email-linus.walleij@stericsson.com>
	<CANqRtoSxHHKxLaKd-qPjCDomp5o-iiij8hqLCs7GNhs4xCV-jg@mail.gmail.com>
	<CACRpkdZmifrV3o59JrWx2Z6DAqHO80W4d=7NJ6OipAOrbazgXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZmifrV3o59JrWx2Z6DAqHO80W4d=7NJ6OipAOrbazgXg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 21, 2011 at 8:19 PM, Linus Walleij <linus.walleij-QSEj5FYQhm5QFI55V6+gNQ@public.gmane.org=
g> wrote:
> On Thu, Oct 20, 2011 at 6:44 PM, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>> On Fri, Oct 21, 2011 at 1:23 AM, Linus Walleij
>> <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:
>>> From: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> ...
>>> +static int nmk_i2c_runtime_suspend(struct device *dev)
>>> +{
>>> + =A0 =A0 =A0 clk_disable(nmk_i2c->clk);
> (...)
>>> +}
>>> +
>>> +static int nmk_i2c_runtime_resume(struct device *dev)
>>> +{
> (...)
>>> + =A0 =A0 =A0 clk_enable(nmk_i2c->clk);
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>
>> Hm, on SH-Mobile ARM we never control any clocks from the driver
>> runtime pm callbacks.
>
> OK so you're using pm_clk_add_notifier() and the standard
> implementation from drivers/base/power/clock_ops.c?

We are using the standard implementation together with
pm_clk_add_notifier() to point out our platform_bus_notifier in
arch/arm/mach-shmobile/pm_runtime.c. My intention with the comment
above was not to so focused on the notifier, more that soc-specific
code can use pm_clk_add() to add multiple clocks to a certain struct
device.

>> (...) In our case the runtime suspend callbacks are only invoked
>> when all the devices in the power domain happen to have a zero runti=
me
>> pm use count. So if you control your clocks from those callbacks the=
n
>> they will be mostly left on which may not be what you want.
>
> We have power domains implemented as well, but currently these
> handle power domain regulators and pin control only,
> not clocking.
>
> They are registered to the platform and amba bus using
> bus_register_notifier() rather than pm_*() notifiers though,
> but we listen to the same events
> BUS_NOTIFY_[BIND|UNBOUND]_DRIVER

I probably mentioned this earlier, but on SH-Mobile ARM drivers we
control both clocks and power domains using the same
pm_runtime_get()/put() functions. The clocks are turned off
immediately, but the power domains will only be turned off when all
included devices are idle according to Runtime PM. At this
all-devices-in-one-power-domain-are-idle time we actually invoke the
->runtime_suspend() callbacks. This is handled by generic code and can
easily be used by anyone.

> So your suggestion is to move clock control for all
> platform devices to the overarching platform code where
> we also handle the power domain regulators and pin
> control?

No, I wouldn't go that far to suggest that. =3D) I'm just saying that
using Runtime PM for clock and power domain control on a per-device
granularity in the driver is working well for us. Especially since we
can let the soc-code associate multiple clocks to each struct device
with pm_clk_add().

I'm soon going to hack on trying to tie in voltage control in the
soc-specific Runtime PM code. Right now the voltage is static but we
gate off various parts of the SoC. After prototyping with the voltage
control code then perhaps it would be easier for me to recommend you
something. =3D)

The reason why I replied to the email initially was to point out that
your way of using Runtime PM seems quite different from our way. It
looked like this driver wanted to have the ->runtime_suspend()
callback executed as soon as possible to control the clock. So if you
intend to execute the ->runtime_suspend() callbacks directly then it
may become difficult for you to use the common pm domain code base
that Rafael has been working on.

> Currently we have something similar for the AMBA
> bus here, since it actually has code in place to grab
> the block clock on probe() and its own runtime PM
> callbacks. Since the bus driver holds the actual reference
> to the clock, we have to call down into the bus callbacks
> from the platform runtime PM implementation since our
> implementation takes precedence. I guess this is expected
> way of doing it?

I'm not sure actually. We should sit down together and discuss this
over an afternoon - hopefully together with Rafael. I could probably
find time during next week in Orlando if you're around.

> I see three possible paradigms here:
>
> (A) dev_power_domain implementation in
> =A0platform/board code handle silicon clocks and regulators.
>
> (B) Bus (as AMBA) driver handle silicon clocks and
> =A0regulators
>
> (C) Devices handle clocks and regulators in their runtime
> =A0PM callbacks themselves
>
> So now ARM SHmobile does (A), PrimeCell drivers do
> (B) and this patch attempted to do (C).
>
> And our way of handling AMBA is a mixture calling
> the bus callbacks from the platform like (A)+(B)
>
> I guess (A) and (C) won't mix very well since both
> handle platform devices and things will screw up if
> say our platform and SHmobile would use the same
> driver.

Exactly my point.

Thanks,

/ magnus

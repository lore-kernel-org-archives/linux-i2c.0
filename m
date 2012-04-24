From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V3 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Tue, 24 Apr 2012 10:38:12 -0600
Message-ID: <4F96D6F4.4010406@wwwdotorg.org>
References: <cover.1330669025.git.viresh.kumar@st.com>	<3d25a5406975dbab9d21bfe406e5f779480da17f.1330669025.git.viresh.kumar@st.com>	<20120423125630.GG19192@pengutronix.de>	<CAOh2x==SfyVVvoK83c4fBO5HVkLtJhd3CDcDfULXTNcZzfZ4Dg@mail.gmail.com> <CACRpkdboocdbmx-cFR_ApYX=B4e=CDMzWn+oZMWrn7vxTpnvvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdboocdbmx-cFR_ApYX=B4e=CDMzWn+oZMWrn7vxTpnvvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 04/24/2012 06:08 AM, Linus Walleij wrote:
> On Mon, Apr 23, 2012 at 3:55 PM, viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Mon, Apr 23, 2012 at 6:26 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> 
>>>> + * @set_scl: controller specific scl configuration routine. Only required if
>>>> + *   is_gpio_recovery == false
>>>> + * @get_sda: controller specific sda read routine. Only required if
>>>> + *   is_gpio_recovery == false and skip_sda_polling == false.
>>>> + * @get_gpio: called before recover_bus() to get padmux configured for scl line.
>>>> + *   as gpio. Only required if is_gpio_recovery == true.
>>>> + * @put_gpio: called after recover_bus() to get padmux configured for scl line
>>>> + *   as scl. Only required if is_gpio_recovery == true.
>>>
>>> Can't we use the pinmux/pinctrl subsystem here? Not knowing too much
>>> about it, CCing Linus.
>>
>> Can be. But probably true only for architectures where pinctrl is
>> defined. Linus?
> 
> We *could* do it by defining a standard state for the pinctrl handle
> in <linux/pinctrl/pinctrl-state.h> (pending in linux-next) like:
> 
> #define PINCTRL_STATE_GPIO "gpio"
> 
> Or so, then have the core grab that using the struct device * of this
> pin controller, returing it to PINCTRL_STATE_DEFAULT afterwards.
> 
> It seems a bit scary to do that in core code though, because we
> don't know which state we should return to, should it really
> be default state?
> 
> And what if we're using GPIO bit-banging, then we grab the pins
> into some state they're already in.
> 
> So to me it seems better to do this at driver level using these
> hooks so the driver is in full control of the pinctrl states.
> 
> Stephen, do you agree?

Yes: I don't think pinctrl alone is the correct way here.

The reason here is there's no guarantee that pinctrl is able to interact
with GPIOs in any way.

On some systems, there may be dedicated pins for (at least some) GPIOs,
so there may be no pinctrl driver that affects them (that'd cover the
I2C-over-GPIO-bit-banging case).

We've defined that gpio_direction_input/output() must set up any pinmux
as required to enable usage of those pins as GPIOs. However, we have not
defined that the pinctrl driver must expose a (pinctrl, not C) function
that allows configuring a pin/group as GPIOs. Hence, again, there may be
no way for pinctrl to switch pins into GPIO mode even when they could be
used as GPIOs.

In particular, on Tegra, GPIO vs. pinctrl is controlled by the GPIO HW
and driver, not the pinctrl HW or driver, and so the Tegra pinctrl
driver doesn't expose any GPIO function. Rather, the GPIO driver
programs the relevant HW bits inside gpio_direction_input/output(), and
simply notifies the pinctrl core that it has, rather than having the
pinctrl driver program any HW.

That said, other HW might have multiple GPIOs that can be routed to a
single pin, and might allow configuration of which via pinctrl.

I guess what we need to do is have I2C drivers provide the following
information to the I2C core:

a) GPIO ID for SCL and SDA
b) Optional pinctrl state for GPIO-based recovery, and the pinctrl state
to return to afterwards

The I2C core would have to do something like:

if (state_bitbang)
    pinctrl_select_state(state_bitbang)
gpio_request(gpio_scl)
gpio_request(gpio_sda)
// do recovery
gpio_free(gpio_sda)
gpio_free(gpio_scl)
if (state_bitbang_done)
    pinctrl_select_state(state_bitbang_done)

Noting that perhaps state_bitbang_done could be changed dynamically by
the driver for internal reasons, and hence shouldn't be cached by the
I2C core, but rather read from the I2C driver struct each time it's used.

> But:
> 
> Many platforms I've seen actually have the ability to mux their
> I2C pins into GPIO and bitbang them, sometimes this seems
> to be used to work around broken silicon for example. And
> it seems what is done here is simply some instance of
> bitbanging (am I right?).

Finally, in order to cover any other special cases, I guess I2C drivers
need to have a top-level entry-point to perform bus recovery, so they
can do any HW programming of the I2C controller they need, then call
into the I2C core recovery utility code I outlined above. That should
allow complete flexibility.

> I wonder if it would make sense to model this in the core,
> so any I2C driver can specify that it also supports bit-banging
> using GPIO pins A,B and then this can be used for anything,
> not just for this recovery.
> 
> So the above hooks should be possible to use to switch the
> entire driver over to bitbang mode.

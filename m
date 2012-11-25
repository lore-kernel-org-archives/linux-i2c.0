From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Sun, 25 Nov 2012 09:34:46 +0530
Message-ID: <CAKohpokLD60N087_ae8-JY-4b4Opn+OrTErt0MwFsTgnSwFb0w@mail.gmail.com>
References: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
	<20121124205931.GB3210@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121124205931.GB3210-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thanks for sharing your opinion.

On 25 November 2012 02:29, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Oct 04, 2012 at 04:34:53PM +0530, Viresh Kumar wrote:

>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c

>> +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
>> +{
>> +     struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
>> +     struct device *dev = &adap->dev;
>> +     int ret = 0;
>> +
>> +     if (bri->get_gpio) {
>> +             ret = bri->get_gpio(bri->scl_gpio);
>> +             if (ret) {
>> +                     dev_warn(dev, "scl get_gpio: %d\n", bri->scl_gpio);
>
> This warning is probably not very helpful to a user.

This is what i thought about it: This is a platform specific routine and
most probably it will fail the first time this code is ever hit and so a
warning would be very helpful for them.

But, now i think platforms should have these prints in their get_gpio
implementations. And we can make it have return type void.

>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     ret = gpio_request_one(bri->scl_gpio, bri->scl_gpio_flags, "i2c-scl");
>> +     if (ret) {
>> +             dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
>> +             goto scl_put_gpio;
>> +     }
>> +
>> +     if (!bri->skip_sda_polling) {
>> +             if (bri->get_gpio)
>> +                     ret = bri->get_gpio(bri->sda_gpio);
>> +
>> +             if (unlikely(ret ||
>
> Since the unlikely() are not in hot-paths, you probably better skip
> them.

It will be removed as get_gpio() would have return type void.

>> +                     gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda"))) {
>> +                     /* work without sda polling */
>> +                     dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
>> +                                     bri->sda_gpio);
>> +                     bri->skip_sda_polling = true;
>> +                     if (!ret && bri->put_gpio)
>> +                             bri->put_gpio(bri->sda_gpio);
>> +
>> +                     ret = 0;
>> +             }
>> +     }
>> +static int i2c_recover_bus(struct i2c_adapter *adap)
>> +{
>> +     struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
>> +     unsigned long delay = 1000000;
>
> What is this magic value?

10 ^ 6 For time conversion to ns. clock duration is given by:
1/ (1000 * KHz) sec = 10^6 /(10^6 * 1000 * KHz) sec = 10^6/KHz nsec

>> +/**
>> + * struct i2c_bus_recovery_info - I2c bus recovery information
>> + * @recover_bus: Recover routine. Either pass driver's recover_bus() routine, or
>> + *   pass it NULL to use generic ones, i.e. gpio or scl based.
>
> What about having those options?
>
> NULL or custom_pointer or i2c_generic_scl_recovery or i2c_generic_gpio_recovery

Looks good. But NULL should be an error then ?

> where i2c_generic_gpio_recovery is probably:
>
>         get_gpios_for_recovery
>         i2c_generic_scl_recovery
>         put_gpios_for_recovery

Ok.

> and i2c_generic_scl_recovery is basically your current
> i2c_generic_recovery. That makes it easier to add other generic routines
> if that should ever become necessary.

yes, that a good point.

>> + * @skip_sda_polling: if true, bus recovery will not poll sda line to check if
>> + *   it became high or not. Only required if recover_bus == NULL.
>
> Does a user really need to set this?

This was done for platforms and i2c controllers which don't have configuration
to control scl line. So i still feel we need it.

>> + * @is_gpio_recovery: true, select gpio type else scl type. Only required if
>> + *   recover_bus == NULL.
>
> This could be dropped in favor of i2c_generic_*_recovery in recover_bus

Yes.

>> + * @clock_rate_khz: clock rate of dummy clock in khz. Required for both gpio and
>> + *   scl type recovery.
>
> Does a user really need this? We could probably use something close to
> 100kHz always?

Not sure. Doesn't it depend on the current clk rate of controller ?
If not then yes it can be 100 KHz

>> + * @clock_cnt: count of max clocks to be generated. Required for both gpio and
>> + *   scl type recovery.
>
> Don't think this should be something else than 9. If so, it should be
> increased generally in the core and not inside some platform data.

I don't remember well, but somebody pointed it out in earlier version as
they require more of these. But will drop it for now and make it 9.

>> + * @set_scl: controller specific routine, if is_gpio_recovery == false.
>> + *       set_scl_gpio_value otherwise
>> + * @get_sda: controller specific routine, if is_gpio_recovery == false.
>> + *       get_sda_gpio_value otherwise
>
> Basically OK, documentation should be more user-centric not
> implementation centric :)

Yes, i realize it now.

>> + * @get_gpio: called before recover_bus() to get padmux configured for scl line.
>> + *   as gpio. Only required if is_gpio_recovery == true. Return 0 on success.
>> + * @put_gpio: called after recover_bus() to get padmux configured for scl line
>> + *   as scl. Only required if is_gpio_recovery == true.
>
> I wonder if it makes sense to have those more generic like
> prepare_recovery and unprepare_recovery?

Yes.

>> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. If passed as 0,
>> + *      (GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH) is used instead. Otherwise, it
>> + *      is ORRED with GPIOF_OUT_INIT_HIGH.
>
> Is this needed? I'd say we drop it until somebody with a need can add
> something like this.

Ok.

>> +     /* Pass valid pointer if recovery infrastructure is required */
>
> This comment can be left out.

Ok.

I will float another version as soon as we close open points here. I really
want to get this in 3.8 :)

--
viresh

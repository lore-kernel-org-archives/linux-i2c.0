From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 4 Oct 2012 14:11:34 +0530
Message-ID: <CAKohpok-4PUz=1OMdJ7-TyWPi+f46k8NgFNUx0Z0La5aN-r5Hw@mail.gmail.com>
References: <viresh.kumar@linaro.org>
	<d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar@linaro.org>
	<20121004080051.GG598@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121004080051.GG598-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4 October 2012 13:30, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Fri, Sep 28, 2012 at 04:58:43PM +0530, Viresh Kumar wrote:

>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c

>> +static inline void set_scl_value(struct i2c_adapter *adap, int val)
>> +{
>> +     struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
>> +
>> +     if (bri->is_gpio_recovery)
>> +             gpio_set_value(bri->scl_gpio, val);
>> +     else
>> +             bri->set_scl(adap, val);
> I would have done this in a different way (with function pointers
> instead of an if for each bang). Well, I don't care much.

That would be better. Will be fixed :)

>> +static int i2c_recover_bus(struct i2c_adapter *adap)
>> +{
>> +     struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
>> +     unsigned long delay =3D 1000000;
>> +     int i, ret, val =3D 1;
>> +
>> +     if (bri->is_gpio_recovery) {
>> +             ret =3D i2c_get_gpios_for_recovery(adap);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     delay =3D DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);
>> +
>> +     for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
>> +             set_scl_value(adap, val);
>> +             ndelay(delay);
>> +
>> +             /* break if sda got high, check only when scl line is =
high */
>> +             if (!bri->skip_sda_polling && val)
>> +                     if (unlikely(get_sda_value(adap)))
>> +                             break;
>> +     }
> With clock_cnt usually being 9 (and skipping sda polling) assume a
> device pulls down SDA because it was just addressed but the last cloc=
k
> pulse to release SDA didn't occur:
>
>         SDAout =AF\_/=AF=AF=AF\___/=AF=AF=AF\___________________/=AF=AF=
=AF=AF=AF=AF
>         SCL    =AF=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF=
\_/=AF=AF=AF=AF=AF
>                 S   1   2   3   4   5   6   7   8   9
>
> This adresses an eeprom with address 0x50. When SCL is released for t=
he
> 9th clock the eeprom pulls down SDA to ack being addressed. After tha=
t
> the eeprom expects the master to write a byte.
>
> Now you do write 0xff:
>
>          i      0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
>         SDAin  ___/=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=
=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF\______
>         SCL    =AF=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF=AF\__/=AF=AF\__/=AF=
=AF\__/=AF=AF\______/
>                 9   1   2   3   4    5     6     7     8
>
> (assuming the SCL line goes up some time later to its idle state).
> That is you leave the bus in exactly the same state as before: The 9t=
h
> clock isn't complete and the eeprom asserts SDA low to ack the byte j=
ust
> written. So the bus is still stalled. The problem is BTW the exact sa=
me
> one I introduced first in my bus clear routine (for barebox though).
> Even though you count to 2*9 you only do 8 real clock pulses because =
you
> have a half cycle at both the start and the end.

=46antastic explanation!!
So, we actually need to do "Low-High" 9 times instead of "High-Low".
So, initializing val to 0 should fix it?

>> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implie=
s
>> + *   GPIOF_OUT_INIT_LOW.
>> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implie=
s
>> + *   GPIOF_OUT_INIT_LOW.

> Didn't you want to change this to GPIOF_OUT_INIT_HIGH |
> GPIOF_OPEN_DRAIN? Hmm, I just wonder how to distinguish
> GPIOF_OUT_INIT_LOW from unset. Hmm, maybe assume unset because _LOW i=
s
> wrong?

Hmmm.... Hmmmm... Hmmm... :)
Two things:
- Why should we default it to GPIOF_OPEN_DRAIN? Open drain would mean,
gpio_set_value() will not write one for it, but would put it in input m=
ode.
I don't think that would be correct, as an generic case.
- Obviously _LOW seems to be incorrect. So we can actually do something=
 as
simple as: pass (sda_gpio_flags | GPIOF_OUT_INIT_HIGH). That will work
in both cases, user passed a value or not.

--
viresh

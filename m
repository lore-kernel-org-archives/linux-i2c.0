From: viresh kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 28 Sep 2012 09:11:34 +0530
Message-ID: <CAOh2x=nm+iiw3pcKtRcWjBnnjc0+p1kQ7zcqjHHyX9351cZDHQ@mail.gmail.com>
References: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar@linaro.org>
	<20120927142825.GB16606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120927142825.GB16606-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46inally somebody had a look at this poor fellow :)

On Thu, Sep 27, 2012 at 7:58 PM, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Mon, Aug 27, 2012 at 10:41:26AM +0530, Viresh Kumar wrote:
>> From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
>>
>> Add i2c bus recovery infrastructure to i2c adapters as specified in =
the i2c
>> protocol Rev. 03 section 3.16 titled "Bus clear".
> It's 3.1.16, not 3.16.

Thanks for pointing out.

>> http://www.nxp.com/documents/user_manual/UM10204.pdf
>>
>> Sometimes during operation i2c bus hangs and we need to give dummy c=
locks to
>> slave device to start the transfer again. Now we may have capability=
 in the bus
>> controller to generate these clocks or platform may have gpio pins w=
hich can be
>> toggled to generate dummy clocks. This patch supports both.
>>
>> This patch also adds in generic bus recovery routines gpio or scl li=
ne based
>> which can be used by bus controller. In addition controller driver m=
ay provide
>> its own version of the bus recovery routine.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
>> ---
>>  drivers/i2c/i2c-core.c | 125 ++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>  include/linux/i2c.h    |  52 ++++++++++++++++++++
>>  2 files changed, 177 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index 96ef3d8..7ede75d 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -27,7 +27,9 @@
>>
>>  #include <linux/module.h>
>>  #include <linux/kernel.h>
>> +#include <linux/delay.h>
>>  #include <linux/errno.h>
>> +#include <linux/gpio.h>
>>  #include <linux/slab.h>
>>  #include <linux/i2c.h>
>>  #include <linux/init.h>
>> @@ -104,6 +106,88 @@ static int i2c_device_uevent(struct device *dev=
, struct kobj_uevent_env *env)
>>  #define i2c_device_uevent    NULL
>>  #endif       /* CONFIG_HOTPLUG */
>>
>> +/* i2c bus recovery routines */
>> +static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
>> +{
>> +     struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
>> +     unsigned long delay =3D 1000000;
>> +     int i, ret, val =3D 1;
>> +
>> +     if (bri->get_gpio)
>> +             bri->get_gpio(bri->scl_gpio);
> get_gpio returns an int. That should be checked.

Yes.

>> +
>> +             ret =3D gpio_request_one(bri->sda_gpio, bri->sda_gpio_=
flags,
>> +                             "i2c-sda");
>> +             if (ret < 0) {
>> +                     /* work without sda polling */
>> +                     dev_warn(&adap->dev,
>> +                             "sda_gpio request fail: %d. Skip sda p=
olling\n",
>> +                             bri->scl_gpio);
>> +                     bri->skip_sda_polling =3D true;
>> +                     if (bri->put_gpio)
>> +                             bri->put_gpio(bri->sda_gpio);
>> +             }
>> +     }
>> +
>> +     delay /=3D bri->clock_rate_khz * 2;
> For maximal correctness you should use DIV_ROUND_UP here.

Good point.

>> +     for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
> When do you want clock_cnt !=3D 9?

I don't remember well, but this is result of discussions on the
earlier patchsets.
So, its just an option that somebody may use.

>> +             ndelay(delay);
>> +             gpio_set_value(bri->scl_gpio, val);
>> +
>> +             /* break if sda got high, check only when scl line is =
high */
>> +             if (!bri->skip_sda_polling && val)
>> +                     if (gpio_get_value(bri->sda_gpio))
>> +                             break;
> I'm not sure it's worth to conditionally shortcut here. Either always=
 or
> never shortcut.

This was done, because few platforms may not have configuration bits to=
 read
status of sda line.. For them skip_sda_polling was required.

Whereas, others would need this to see if we can return early.

> In a document by Atmel describing on of their at24 eeproms they sugge=
st
> to send an start and stop after the nine clocks. Yesterday I consider=
ed
> that sensible but today I don't remember why.
>
> Also it might be worth pointing out that this procedure isn't
> multi-master save because it does neither clock synchronization (3.1.=
7)
> nor arbitration (3.1.8). I'm not sure how relevant multi-master is, b=
ut
> if you don't consider it maybe still make it explicit.

Not considering it for this basic version, will mention that.

>> +     }
>> +
>> +     gpio_free(bri->scl_gpio);
>> +
>> +     if (bri->put_gpio)
>> +             bri->put_gpio(bri->scl_gpio);
>> +
>> +     if (!bri->skip_sda_polling) {
>> +             gpio_free(bri->sda_gpio);
>> +
>> +             if (bri->put_gpio)
>> +                     bri->put_gpio(bri->sda_gpio);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int i2c_scl_recover_bus(struct i2c_adapter *adap)
>> +{
>> +     struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
>> +     int i, val =3D 0;
>> +     unsigned long delay =3D 1000000;
>> +
>> +     delay /=3D bri->clock_rate_khz * 2;
>> +
>> +     for (i =3D 0; i < bri->clock_cnt * 2; i++,
>> +                     val =3D !val) {
>> +             bri->set_scl(adap, val);
> again for multi-master set_scl can fail and so if this scenario is
> considered worth to be supported it should return an error indication
> that needs handling.

ditto.

>> +             ndelay(delay);
>> +
>> +             /* break if sda got high, check only when scl line is =
high */
>> +             if (!bri->skip_sda_polling && val)
>> +                     if (bri->get_sda(adap))
>> +                             break;
>> +     }
>> +
>> +     return 0;
>> +}
> i2c_scl_recover_bus and i2c_gpio_recover_bus have a common pattern. B=
oth
> bitbang SCL and SDA. Is it worth to factor out the common stuff?

Will surely have a look at it again, before sending another version.

>>  static int i2c_device_probe(struct device *dev)
>>  {
>>       struct i2c_client       *client =3D i2c_verify_client(dev);
>> @@ -879,6 +963,47 @@ static int i2c_register_adapter(struct i2c_adap=
ter *adap)
>>                        "Failed to create compatibility class link\n"=
);
>>  #endif
>>
>> +     /* bus recovery specific initialization */
>> +     if (adap->bus_recovery_info) {
>> +             struct i2c_bus_recovery_info *bri =3D adap->bus_recove=
ry_info;
>> +
>> +             if (bri->recover_bus) {
>> +                     dev_info(&adap->dev,
>> +                             "registered for non-generic bus recove=
ry\n");
>> +             } else {
>> +                     /* Use generic recovery routines */
>> +                     if (!bri->clock_rate_khz) {
>> +                             dev_warn(&adap->dev,
>> +                                     "doesn't have valid recovery c=
lock rate\n");
>> +                             goto exit_recovery;
>> +                     }
>> +
>> +                     /* Most controller need 9 clocks at max */
>> +                     if (!bri->clock_cnt)
>> +                             bri->clock_cnt =3D 9;
>> +
>> +                     if (bri->is_gpio_recovery) {
>> +                             bri->recover_bus =3D i2c_gpio_recover_=
bus;
>> +                             dev_info(&adap->dev,
>> +                                     "registered for gpio bus recov=
ery\n");
>> +                     } else if (bri->set_scl) {
>> +                             if (!bri->skip_sda_polling && !bri->ge=
t_sda) {
>> +                                     dev_warn(&adap->dev,
>> +                                             "!get_sda. skip sda po=
lling\n");
>> +                                     bri->skip_sda_polling =3D true=
;
>> +                             }
>> +
>> +                             bri->recover_bus =3D i2c_scl_recover_b=
us;
>> +                             dev_info(&adap->dev,
>> +                                     "registered for scl bus recove=
ry\n");
>> +                     } else {
>> +                             dev_warn(&adap->dev,
>> +                                     "doesn't have valid recovery t=
ype\n");
>> +                     }
>> +             }
>> +     }
>> +
>> +exit_recovery:
>>       /* create pre-declared device nodes */
>>       if (adap->nr < __i2c_first_dynamic_bus_num)
>>               i2c_scan_static_board_info(adap);
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index 5970266..9e0a14a 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -370,6 +370,55 @@ struct i2c_algorithm {
>>       u32 (*functionality) (struct i2c_adapter *);
>>  };
>>
>> +/**
>> + * struct i2c_bus_recovery_info - I2c bus recovery information
>> + * @recover_bus: Recover routine. Either pass driver's recover_bus(=
) routine, or
>> + *   pass it NULL to use generic ones, i.e. gpio or scl based.
>> + * @skip_sda_polling: if true, bus recovery will not poll sda line =
to check if
>> + *   it became high or not. Only required if recover_bus =3D=3D NUL=
L.
>> + * @is_gpio_recovery: true, select gpio type else scl type. Only re=
quired if
>> + *   recover_bus =3D=3D NULL.
>> + * @clock_rate_khz: clock rate of dummy clock in khz. Required for =
both gpio and
>> + *   scl type recovery.
>> + * @clock_cnt: count of max clocks to be generated. Required for bo=
th gpio and
>> + *   scl type recovery.
>> + * @set_scl: controller specific scl configuration routine. Only re=
quired if
>> + *   is_gpio_recovery =3D=3D false
>> + * @get_sda: controller specific sda read routine. Only required if
>> + *   is_gpio_recovery =3D=3D false and skip_sda_polling =3D=3D fals=
e.
>> + * @get_gpio: called before recover_bus() to get padmux configured =
for scl line.
>> + *   as gpio. Only required if is_gpio_recovery =3D=3D true.
> This is used for both, scl and sda. I don't know if there is a more
> modern approach available using the pinmux framework? (Added Linus
> Walleij to Cc.)
>
>> + * @put_gpio: called after recover_bus() to get padmux configured f=
or scl line
>> + *   as scl. Only required if is_gpio_recovery =3D=3D true.
>> + * @scl_gpio: gpio number of the scl line. Only required if is_gpio=
_recovery =3D=3D
>> + *   true.
>> + * @sda_gpio: gpio number of the sda line. Only required if is_gpio=
_recovery =3D=3D
>> + *   true and skip_sda_polling =3D=3D false.
>> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implie=
s
>> + *   GPIOF_OUT_INIT_LOW.
> IMHO you should not make this configurable but use
>
>         GPIOF_OUT_INIT_HIGH | GPIOF_OPEN_DRAIN

Discussed here:
http://www.spinics.net/lists/linux-i2c/msg07325.html

>> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implie=
s
>> + *   GPIOF_OUT_INIT_LOW.
>> + */
>> +struct i2c_bus_recovery_info {
>> +     int (*recover_bus)(struct i2c_adapter *);
>> +     bool skip_sda_polling;
>> +     bool is_gpio_recovery;
>> +     u32 clock_rate_khz;
>> +     u8 clock_cnt;
>> +
>> +     /* scl/sda recovery */
>> +     void (*set_scl)(struct i2c_adapter *, int val);
>> +     int (*get_sda)(struct i2c_adapter *);
>> +
>> +     /* gpio recovery */
>> +     int (*get_gpio)(unsigned gpio);
>> +     int (*put_gpio)(unsigned gpio);
>> +     u32 scl_gpio;
>> +     u32 sda_gpio;
>> +     u32 scl_gpio_flags;
>> +     u32 sda_gpio_flags;
> These are not the right types. gpio_request_one expects gpio to be
> unsigned and flags to be unsigned long.

Will fix it.

> As scl/sda recovery and gpio recovery are mutually exclusive you coul=
d
> use a union here. But maybe it's not worth the added complexity?

Hmm.

Thanks for your valuable comments Uwe.

But before i send another version of this patchset, need some inputs fr=
om
Wolfram.

@Wolfram and other maintainers: I understand that you have been very
busy all the time, but this patchset is worth having some feedback. Isn=
't it?

Please share your comments about it, whatever they are...

Many platforms want to use this infrastructure but they are just not
able to do it,
because it hasn't got your acceptance till now.

--
viresh

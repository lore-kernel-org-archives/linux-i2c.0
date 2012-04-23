From: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 23 Apr 2012 19:25:15 +0530
Message-ID: <CAOh2x==SfyVVvoK83c4fBO5HVkLtJhd3CDcDfULXTNcZzfZ4Dg@mail.gmail.com>
References: <cover.1330669025.git.viresh.kumar@st.com>
	<3d25a5406975dbab9d21bfe406e5f779480da17f.1330669025.git.viresh.kumar@st.com>
	<20120423125630.GG19192@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120423125630.GG19192-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 23, 2012 at 6:26 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> w=
rote:
> On Fri, Mar 02, 2012 at 11:53:42AM +0530, Viresh Kumar wrote:
> Finally, a review \o/

:)

>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> +/* i2c bus recovery routines */
>> +static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
>> +{
>> + =A0 =A0 struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_i=
nfo;
>
> I think something alike 'recov_info' is more readable than 'bri'.

Sure.

>> + =A0 =A0 unsigned long delay =3D 1000000;
>
> udelay?

No. It's ndelay. Will rename it.

>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int i2c_scl_recover_bus(struct i2c_adapter *adap)
>> +{
>> + =A0 =A0 struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_i=
nfo;
>> + =A0 =A0 int i, val =3D 0;
>> + =A0 =A0 unsigned long delay =3D 1000000;
>> +
>> + =A0 =A0 delay /=3D bri->clock_rate_khz * 2;
>> +
>> + =A0 =A0 for (i =3D 0; i < bri->clock_cnt * 2; i++,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D !val) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 bri->set_scl(adap, val);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ndelay(delay);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* break if sda got high, check only when =
scl line is high */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!bri->skip_sda_polling && val)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bri->get_sda(adap))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>
> We have two recover bus functions here. I think it would be better to
> have only one. set_scl and get_sda can be mapped to helper functions
> doing needed gpio-calls during init. Something like this pseudo-code:
>
> =A0 =A0 =A0 =A0if (!bri->set_scl && we_have_a_scl_gpio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_scl =3D i2c_set_scl_via_gpio()

gpio calls can't be done at init. As we have to request and free them
again and again. So would be required to keep two calls.

Not sure, if i understand your point here.

>> =A0static int i2c_device_probe(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 struct i2c_client =A0 =A0 =A0 *client =3D i2c_verify_cli=
ent(dev);
>> @@ -861,6 +945,47 @@ static int i2c_register_adapter(struct i2c_adap=
ter *adap)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Failed to create com=
patibility class link\n");
>> =A0#endif
>>
>> + =A0 =A0 /* bus recovery specific initialization */
>> + =A0 =A0 if (adap->bus_recovery_info) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_bus_recovery_info *bri =3D adap=
->bus_recovery_info;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bri->recover_bus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&adap->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "registere=
d for non-generic bus recovery\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Use generic recovery ro=
utines */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bri->clock_rate_khz) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&=
adap->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "doesn't have valid recovery clock rate\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_=
recovery;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Most controller need 9 =
clocks at max */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bri->clock_cnt)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bri->clock=
_cnt =3D 9;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bri->is_gpio_recovery)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bri->recov=
er_bus =3D i2c_gpio_recover_bus;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&=
adap->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "registered for gpio bus recovery\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (bri->set_scl) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bri->=
skip_sda_polling && !bri->get_sda) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_warn(&adap->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "!get_sda. skip sda polling\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bri->skip_sda_polling =3D true;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bri->recov=
er_bus =3D i2c_scl_recover_bus;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&=
adap->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "registered for scl bus recovery\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&=
adap->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "doesn't have valid recovery type\n");
>
> Printouts here should probably be dev_dbg (if not left out), most use=
rs
> won't care.

Hmm. Actually this is a error case. User wanted to have recovery infra,
but didn't mention the method of recovery: via gpio or sda/scl. Don't
know if we could make it dev_err() instead.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> +exit_recovery:
>> =A0 =A0 =A0 /* create pre-declared device nodes */
>> =A0 =A0 =A0 if (adap->nr < __i2c_first_dynamic_bus_num)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_scan_static_board_info(adap);
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index 8e25a91..1310d1a 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -365,6 +365,55 @@ struct i2c_algorithm {
>> =A0 =A0 =A0 u32 (*functionality) (struct i2c_adapter *);
>> =A0};
>>
>
> The description of the members is a good start. To be complete, I'd t=
hink
> we need some higher level description in Documentation/i2c, too, with=
 an
> example how to set up.

Sure.

>> +/**
>> + * struct i2c_bus_recovery_info - I2c bus recovery information
>> + * @recover_bus: Recover routine. Either pass driver's recover_bus(=
) routine, or
>> + * =A0 pass it NULL to use generic ones, i.e. gpio or scl based.
>> + * @skip_sda_polling: if true, bus recovery will not poll sda line =
to check if
>> + * =A0 it became high or not. Only required if recover_bus =3D=3D N=
ULL.
>
> Assume this when there is no get_sda() and/or SDA GPIO =A0defined?

Can be done with get_sda(), but have doubt for GPIO. How to check if sd=
a polling
is required in GPIO case. Obviously by checking its value. Zero is a
valid value.
And -1 doesn't look good.

>> + * @is_gpio_recovery: true, select gpio type else scl type. Only re=
quired if
>> + * =A0 recover_bus =3D=3D NULL.
>
> Assume this when there is no GPIO defined (and no recover_bus)?

Can be done based on value of set_scl, but not on GPIO because of earli=
er
mentioned reasons.

>> + * @clock_cnt: count of max clocks to be generated. Required for bo=
th gpio and
>> + * =A0 scl type recovery.
>
> Why should that be different from 9 (as said in the docs)?

Don't know. Somebody, probably Tegra guys, asked for it during earlier
versions of this
patch. IIRC, they needed 10.

>> + * @set_scl: controller specific scl configuration routine. Only re=
quired if
>> + * =A0 is_gpio_recovery =3D=3D false
>> + * @get_sda: controller specific sda read routine. Only required if
>> + * =A0 is_gpio_recovery =3D=3D false and skip_sda_polling =3D=3D fa=
lse.
>> + * @get_gpio: called before recover_bus() to get padmux configured =
for scl line.
>> + * =A0 as gpio. Only required if is_gpio_recovery =3D=3D true.
>> + * @put_gpio: called after recover_bus() to get padmux configured f=
or scl line
>> + * =A0 as scl. Only required if is_gpio_recovery =3D=3D true.
>
> Can't we use the pinmux/pinctrl subsystem here? Not knowing too much
> about it, CCing Linus.

Can be. But probably true only for architectures where pinctrl is
defined. Linus?

>> + * @scl_gpio: gpio number of the scl line. Only required if is_gpio=
_recovery =3D=3D
>> + * =A0 true.
>> + * @sda_gpio: gpio number of the sda line. Only required if is_gpio=
_recovery =3D=3D
>> + * =A0 true and skip_sda_polling =3D=3D false.
>> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implie=
s
>> + * =A0 GPIOF_OUT_INIT_LOW.
>> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implie=
s
>> + * =A0 GPIOF_OUT_INIT_LOW.
>
> For the last 4, I'd suggest to pass a struct gpio scl_sda_gpio_array[=
2]
> or something.

Ok.

>> + */
>> +struct i2c_bus_recovery_info {
>> + =A0 =A0 int (*recover_bus)(struct i2c_adapter *);
>> + =A0 =A0 bool skip_sda_polling;
>> + =A0 =A0 bool is_gpio_recovery;
>> + =A0 =A0 u32 clock_rate_khz;
>> + =A0 =A0 u8 clock_cnt;
>> +
>> + =A0 =A0 /* scl/sda recovery */
>> + =A0 =A0 void (*set_scl)(struct i2c_adapter *, int val);
>> + =A0 =A0 int (*get_sda)(struct i2c_adapter *);
>> +
>> + =A0 =A0 /* gpio recovery */
>> + =A0 =A0 int (*get_gpio)(unsigned gpio);
>> + =A0 =A0 int (*put_gpio)(unsigned gpio);
>> + =A0 =A0 u32 scl_gpio;
>> + =A0 =A0 u32 sda_gpio;
>> + =A0 =A0 u32 scl_gpio_flags;
>> + =A0 =A0 u32 sda_gpio_flags;
>> +};
>> +
>> =A0/*
>> =A0 * i2c_adapter is the structure used to identify a physical i2c b=
us along
>> =A0 * with the access algorithms necessary to access it.
>> @@ -388,6 +437,9 @@ struct i2c_adapter {
>>
>> =A0 =A0 =A0 struct mutex userspace_clients_lock;
>> =A0 =A0 =A0 struct list_head userspace_clients;
>> +
>> + =A0 =A0 /* Pass valid pointer if recovery infrastructure is requir=
ed */
>> + =A0 =A0 struct i2c_bus_recovery_info *bus_recovery_info;
>> =A0};
>> =A0#define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev=
)
>>
>
> I'd also think calling the recover function should be in the core and
> not in all the drivers.

Sounds good. Based on, if timeout is returned by controller or not.

--
Viresh

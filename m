From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V5 Resend 1/2] i2c/adapter: Add bus recovery
 infrastructure
Date: Thu, 4 Oct 2012 10:00:51 +0200
Message-ID: <20121004080051.GG598@pengutronix.de>
References: <viresh.kumar@linaro.org>
 <d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Viresh,

On Fri, Sep 28, 2012 at 04:58:43PM +0530, Viresh Kumar wrote:
> Add i2c bus recovery infrastructure to i2c adapters as specified in t=
he i2c
> protocol Rev. 03 section 3.1.16 titled "Bus clear".
>=20
> http://www.nxp.com/documents/user_manual/UM10204.pdf
>=20
> Sometimes during operation i2c bus hangs and we need to give dummy cl=
ocks to
> slave device to start the transfer again. Now we may have capability =
in the bus
> controller to generate these clocks or platform may have gpio pins wh=
ich can be
> toggled to generate dummy clocks. This patch supports both.
>=20
> This patch also adds in generic bus recovery routines gpio or scl lin=
e based
> which can be used by bus controller. In addition controller driver ma=
y provide
> its own version of the bus recovery routine.
>=20
> This doesn't support multi-master recovery for now.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> V5 Resend:
> - Fixed my email-id, removed st.com and added linaro.org
> V4->V5:
> - section name corrected to 3.1.16
> - merged gpio and non-gpio recovery routines to remove code redundanc=
y
> - Changed types of gpio and gpio-flags to unsigned and unsigned long
> - Checking return value of get_gpio() now
> - using DIV_ROUND_UP for calculating delay, to get more correct value
>=20
>  drivers/i2c/i2c-core.c | 153 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/i2c.h    |  52 +++++++++++++++++
>  2 files changed, 205 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a7edf98..bdc249a 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -27,7 +27,9 @@
> =20
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/delay.h>
>  #include <linux/errno.h>
> +#include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
> @@ -104,6 +106,116 @@ static int i2c_device_uevent(struct device *dev=
, struct kobj_uevent_env *env)
>  #define i2c_device_uevent	NULL
>  #endif	/* CONFIG_HOTPLUG */
> =20
> +/* i2c bus recovery routines */
> +static inline void set_scl_value(struct i2c_adapter *adap, int val)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +
> +	if (bri->is_gpio_recovery)
> +		gpio_set_value(bri->scl_gpio, val);
> +	else
> +		bri->set_scl(adap, val);
I would have done this in a different way (with function pointers
instead of an if for each bang). Well, I don't care much.

> +}
> +
> +static inline int get_sda_value(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +
> +	if (bri->is_gpio_recovery)
> +		return gpio_get_value(bri->sda_gpio);
> +	else
> +		return bri->get_sda(adap);
> +}
> +
> +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +	struct device *dev =3D &adap->dev;
> +	int ret =3D 0;
> +
> +	if (bri->get_gpio) {
> +		ret =3D bri->get_gpio(bri->scl_gpio);
> +		if (ret) {
> +			dev_warn(dev, "scl get_gpio: %d\n", bri->scl_gpio);
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D gpio_request_one(bri->scl_gpio, bri->scl_gpio_flags, "i2c-s=
cl");
> +	if (ret) {
> +		dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
> +		goto scl_put_gpio;
> +	}
> +
> +	if (!bri->skip_sda_polling) {
> +		if (bri->get_gpio)
> +			ret =3D bri->get_gpio(bri->sda_gpio);
> +
> +		if (unlikely(ret ||
> +			gpio_request_one(bri->sda_gpio, bri->sda_gpio_flags,
> +				"i2c-sda"))) {
> +			/* work without sda polling */
> +			dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
> +					bri->sda_gpio);
> +			bri->skip_sda_polling =3D true;
> +			if (!ret && bri->put_gpio)
> +				bri->put_gpio(bri->sda_gpio);
> +
> +			ret =3D 0;
> +		}
> +	}
> +
> +scl_put_gpio:
> +	if (bri->put_gpio)
> +		bri->put_gpio(bri->scl_gpio);
> +
> +	return ret;
> +}
> +
> +static void i2c_put_gpios_for_recovery(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +
> +	gpio_free(bri->scl_gpio);
> +
> +	if (!bri->skip_sda_polling) {
> +		gpio_free(bri->sda_gpio);
> +
> +		if (bri->put_gpio)
> +			bri->put_gpio(bri->sda_gpio);
> +	}
> +}
> +
> +static int i2c_recover_bus(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +	unsigned long delay =3D 1000000;
> +	int i, ret, val =3D 1;
> +
> +	if (bri->is_gpio_recovery) {
> +		ret =3D i2c_get_gpios_for_recovery(adap);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	delay =3D DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);
> +
> +	for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
> +		set_scl_value(adap, val);
> +		ndelay(delay);
> +
> +		/* break if sda got high, check only when scl line is high */
> +		if (!bri->skip_sda_polling && val)
> +			if (unlikely(get_sda_value(adap)))
> +				break;
> +	}
With clock_cnt usually being 9 (and skipping sda polling) assume a
device pulls down SDA because it was just addressed but the last clock
pulse to release SDA didn't occur:

	SDAout =AF\_/=AF=AF=AF\___/=AF=AF=AF\___________________/=AF=AF=AF=AF=AF=
=AF
        SCL    =AF=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_=
/=AF=AF=AF=AF=AF
	        S   1   2   3   4   5   6   7   8   9

This adresses an eeprom with address 0x50. When SCL is released for the
9th clock the eeprom pulls down SDA to ack being addressed. After that
the eeprom expects the master to write a byte.

Now you do write 0xff:

	 i      0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
	SDAin  ___/=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=
=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF\______
	SCL    =AF=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF=AF\__/=AF=AF\__/=AF=AF\__/=
=AF=AF\______/
	        9   1   2   3   4    5     6     7     8

(assuming the SCL line goes up some time later to its idle state).
That is you leave the bus in exactly the same state as before: The 9th
clock isn't complete and the eeprom asserts SDA low to ack the byte jus=
t
written. So the bus is still stalled. The problem is BTW the exact same
one I introduced first in my bus clear routine (for barebox though).
Even though you count to 2*9 you only do 8 real clock pulses because yo=
u
have a half cycle at both the start and the end.

> +
> +	if (bri->is_gpio_recovery)
> +		i2c_put_gpios_for_recovery(adap);
> +
> +	return 0;
> +}
> +
>  static int i2c_device_probe(struct device *dev)
>  {
>  	struct i2c_client	*client =3D i2c_verify_client(dev);
> @@ -896,6 +1008,47 @@ static int i2c_register_adapter(struct i2c_adap=
ter *adap)
>  			 "Failed to create compatibility class link\n");
>  #endif
> =20
> +	/* bus recovery specific initialization */
> +	if (adap->bus_recovery_info) {
> +		struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +
> +		if (bri->recover_bus) {
> +			dev_info(&adap->dev,
> +				"registered for non-generic bus recovery\n");
> +		} else {
> +			/* Use generic recovery routines */
> +			if (!bri->clock_rate_khz) {
> +				dev_warn(&adap->dev,
> +					"doesn't have valid recovery clock rate\n");
> +				goto exit_recovery;
> +			}
> +
> +			/* Most controller need 9 clocks at max */
> +			if (!bri->clock_cnt)
> +				bri->clock_cnt =3D 9;
> +
> +			bri->recover_bus =3D i2c_recover_bus;
> +
> +			if (bri->is_gpio_recovery) {
> +				dev_info(&adap->dev,
> +					"registered for gpio bus recovery\n");
> +			} else if (bri->set_scl) {
> +				if (!bri->skip_sda_polling && !bri->get_sda) {
> +					dev_warn(&adap->dev,
> +						"!get_sda. skip sda polling\n");
> +					bri->skip_sda_polling =3D true;
> +				}
> +
> +				dev_info(&adap->dev,
> +					"registered for scl bus recovery\n");
> +			} else {
> +				dev_warn(&adap->dev,
> +					"doesn't have valid recovery type\n");
> +			}
> +		}
> +	}
> +
> +exit_recovery:
>  	/* create pre-declared device nodes */
>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>  		i2c_scan_static_board_info(adap);
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 5970266..c43e5c4 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -370,6 +370,55 @@ struct i2c_algorithm {
>  	u32 (*functionality) (struct i2c_adapter *);
>  };
> =20
> +/**
> + * struct i2c_bus_recovery_info - I2c bus recovery information
> + * @recover_bus: Recover routine. Either pass driver's recover_bus()=
 routine, or
> + *	pass it NULL to use generic ones, i.e. gpio or scl based.
> + * @skip_sda_polling: if true, bus recovery will not poll sda line t=
o check if
> + *	it became high or not. Only required if recover_bus =3D=3D NULL.
> + * @is_gpio_recovery: true, select gpio type else scl type. Only req=
uired if
> + *	recover_bus =3D=3D NULL.
> + * @clock_rate_khz: clock rate of dummy clock in khz. Required for b=
oth gpio and
> + *	scl type recovery.
> + * @clock_cnt: count of max clocks to be generated. Required for bot=
h gpio and
> + *	scl type recovery.
> + * @set_scl: controller specific scl configuration routine. Only req=
uired if
> + *	is_gpio_recovery =3D=3D false
> + * @get_sda: controller specific sda read routine. Only required if
> + *	is_gpio_recovery =3D=3D false and skip_sda_polling =3D=3D false.
> + * @get_gpio: called before recover_bus() to get padmux configured f=
or scl line.
> + *	as gpio. Only required if is_gpio_recovery =3D=3D true. Return 0 =
on success.
> + * @put_gpio: called after recover_bus() to get padmux configured fo=
r scl line
> + *	as scl. Only required if is_gpio_recovery =3D=3D true.
> + * @scl_gpio: gpio number of the scl line. Only required if is_gpio_=
recovery =3D=3D
> + *	true.
> + * @sda_gpio: gpio number of the sda line. Only required if is_gpio_=
recovery =3D=3D
> + *	true and skip_sda_polling =3D=3D false.
> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 implies
> + *	GPIOF_OUT_INIT_LOW.
> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
> + *	GPIOF_OUT_INIT_LOW.
Didn't you want to change this to GPIOF_OUT_INIT_HIGH |
GPIOF_OPEN_DRAIN? Hmm, I just wonder how to distinguish
GPIOF_OUT_INIT_LOW from unset. Hmm, maybe assume unset because _LOW is
wrong?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

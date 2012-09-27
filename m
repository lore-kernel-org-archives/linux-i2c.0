From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4 Resend 1/2] i2c/adapter: Add bus recovery
 infrastructure
Date: Thu, 27 Sep 2012 16:28:25 +0200
Message-ID: <20120927142825.GB16606@pengutronix.de>
References: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 27, 2012 at 10:41:26AM +0530, Viresh Kumar wrote:
> From: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
>=20
> Add i2c bus recovery infrastructure to i2c adapters as specified in t=
he i2c
> protocol Rev. 03 section 3.16 titled "Bus clear".
It's 3.1.16, not 3.16.

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
> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 125 +++++++++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/i2c.h    |  52 ++++++++++++++++++++
>  2 files changed, 177 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 96ef3d8..7ede75d 100644
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
> @@ -104,6 +106,88 @@ static int i2c_device_uevent(struct device *dev,=
 struct kobj_uevent_env *env)
>  #define i2c_device_uevent	NULL
>  #endif	/* CONFIG_HOTPLUG */
> =20
> +/* i2c bus recovery routines */
> +static int i2c_gpio_recover_bus(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +	unsigned long delay =3D 1000000;
> +	int i, ret, val =3D 1;
> +
> +	if (bri->get_gpio)
> +		bri->get_gpio(bri->scl_gpio);
get_gpio returns an int. That should be checked.

> +	ret =3D gpio_request_one(bri->scl_gpio, bri->scl_gpio_flags, "i2c-s=
cl");
> +	if (ret < 0) {
> +		dev_warn(&adap->dev, "gpio request fail: %d\n", bri->scl_gpio);
> +		return ret;
> +	}
> +
> +	if (!bri->skip_sda_polling) {
> +		if (bri->get_gpio)
> +			bri->get_gpio(bri->sda_gpio);
ditto.

> +
> +		ret =3D gpio_request_one(bri->sda_gpio, bri->sda_gpio_flags,
> +				"i2c-sda");
> +		if (ret < 0) {
> +			/* work without sda polling */
> +			dev_warn(&adap->dev,
> +				"sda_gpio request fail: %d. Skip sda polling\n",
> +				bri->scl_gpio);
> +			bri->skip_sda_polling =3D true;
> +			if (bri->put_gpio)
> +				bri->put_gpio(bri->sda_gpio);
> +		}
> +	}
> +
> +	delay /=3D bri->clock_rate_khz * 2;
=46or maximal correctness you should use DIV_ROUND_UP here.

> +
> +	for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
When do you want clock_cnt !=3D 9?

> +		ndelay(delay);
> +		gpio_set_value(bri->scl_gpio, val);
> +
> +		/* break if sda got high, check only when scl line is high */
> +		if (!bri->skip_sda_polling && val)
> +			if (gpio_get_value(bri->sda_gpio))
> +				break;
I'm not sure it's worth to conditionally shortcut here. Either always o=
r
never shortcut.

In a document by Atmel describing on of their at24 eeproms they suggest
to send an start and stop after the nine clocks. Yesterday I considered
that sensible but today I don't remember why.

Also it might be worth pointing out that this procedure isn't
multi-master save because it does neither clock synchronization (3.1.7)
nor arbitration (3.1.8). I'm not sure how relevant multi-master is, but
if you don't consider it maybe still make it explicit.

> +	}
> +
> +	gpio_free(bri->scl_gpio);
> +
> +	if (bri->put_gpio)
> +		bri->put_gpio(bri->scl_gpio);
> +
> +	if (!bri->skip_sda_polling) {
> +		gpio_free(bri->sda_gpio);
> +
> +		if (bri->put_gpio)
> +			bri->put_gpio(bri->sda_gpio);
> +	}
> +
> +	return 0;
> +}
> +
> +static int i2c_scl_recover_bus(struct i2c_adapter *adap)
> +{
> +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> +	int i, val =3D 0;
> +	unsigned long delay =3D 1000000;
> +
> +	delay /=3D bri->clock_rate_khz * 2;
> +
> +	for (i =3D 0; i < bri->clock_cnt * 2; i++,
> +			val =3D !val) {
> +		bri->set_scl(adap, val);
again for multi-master set_scl can fail and so if this scenario is
considered worth to be supported it should return an error indication
that needs handling.

> +		ndelay(delay);
> +
> +		/* break if sda got high, check only when scl line is high */
> +		if (!bri->skip_sda_polling && val)
> +			if (bri->get_sda(adap))
> +				break;
> +	}
> +
> +	return 0;
> +}
i2c_scl_recover_bus and i2c_gpio_recover_bus have a common pattern. Bot=
h
bitbang SCL and SDA. Is it worth to factor out the common stuff?

> +
>  static int i2c_device_probe(struct device *dev)
>  {
>  	struct i2c_client	*client =3D i2c_verify_client(dev);
> @@ -879,6 +963,47 @@ static int i2c_register_adapter(struct i2c_adapt=
er *adap)
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
> +			if (bri->is_gpio_recovery) {
> +				bri->recover_bus =3D i2c_gpio_recover_bus;
> +				dev_info(&adap->dev,
> +					"registered for gpio bus recovery\n");
> +			} else if (bri->set_scl) {
> +				if (!bri->skip_sda_polling && !bri->get_sda) {
> +					dev_warn(&adap->dev,
> +						"!get_sda. skip sda polling\n");
> +					bri->skip_sda_polling =3D true;
> +				}
> +
> +				bri->recover_bus =3D i2c_scl_recover_bus;
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
> index 5970266..9e0a14a 100644
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
> + *	as gpio. Only required if is_gpio_recovery =3D=3D true.
This is used for both, scl and sda. I don't know if there is a more
modern approach available using the pinmux framework? (Added Linus
Walleij to Cc.)

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
IMHO you should not make this configurable but use

	GPIOF_OUT_INIT_HIGH | GPIOF_OPEN_DRAIN

> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 implies
> + *	GPIOF_OUT_INIT_LOW.
> + */
> +struct i2c_bus_recovery_info {
> +	int (*recover_bus)(struct i2c_adapter *);
> +	bool skip_sda_polling;
> +	bool is_gpio_recovery;
> +	u32 clock_rate_khz;
> +	u8 clock_cnt;
> +
> +	/* scl/sda recovery */
> +	void (*set_scl)(struct i2c_adapter *, int val);
> +	int (*get_sda)(struct i2c_adapter *);
> +
> +	/* gpio recovery */
> +	int (*get_gpio)(unsigned gpio);
> +	int (*put_gpio)(unsigned gpio);
> +	u32 scl_gpio;
> +	u32 sda_gpio;
> +	u32 scl_gpio_flags;
> +	u32 sda_gpio_flags;
These are not the right types. gpio_request_one expects gpio to be
unsigned and flags to be unsigned long.

As scl/sda recovery and gpio recovery are mutually exclusive you could
use a union here. But maybe it's not worth the added complexity?

> +};
> +
>  /*
>   * i2c_adapter is the structure used to identify a physical i2c bus =
along
>   * with the access algorithms necessary to access it.
> @@ -393,6 +442,9 @@ struct i2c_adapter {
> =20
>  	struct mutex userspace_clients_lock;
>  	struct list_head userspace_clients;
> +
> +	/* Pass valid pointer if recovery infrastructure is required */
> +	struct i2c_bus_recovery_info *bus_recovery_info;
>  };
>  #define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

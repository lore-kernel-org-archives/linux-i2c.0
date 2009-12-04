From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] driver i2c-core: i2c bus should support PM entries in
	struct dev_pm_ops.
Date: Fri, 4 Dec 2009 17:24:00 +0800
Message-ID: <4e5ebad50912040124i35e8c8c7iba71737c966c26ea@mail.gmail.com>
References: <1259744920.25505.2.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259744920.25505.2.camel-x+10Id33CNwLe6dzpsQaEw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Any comments?

Thanks.

Sonic

On Wed, Dec 2, 2009 at 5:08 PM, sonic zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> Struct dev_pm_ops is not configured in current i2c bus type. i2c driv=
ers
> only depends on suspend/resume entries in struct dev_pm_ops are not
> informed of PM suspend and resume events by i2c framework.
>
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
> =A0drivers/i2c/i2c-core.c | =A0 39 ++++++++++++++++++++++++++++++++++=
+++++
> =A01 files changed, 39 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2965043..9713c0d 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -155,6 +155,39 @@ static void i2c_device_shutdown(struct device *d=
ev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0driver->shutdown(client);
> =A0}
>
> +#ifdef CONFIG_SUSPEND
> +static int i2c_device_pm_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct i2c_driver *driver;
> + =A0 =A0 =A0 struct dev_pm_ops *pm;
> +
> + =A0 =A0 =A0 if (!dev->driver)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 driver =3D to_i2c_driver(dev->driver);
> + =A0 =A0 =A0 pm =3D driver->driver.pm;
> + =A0 =A0 =A0 if (!pm || !pm->suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return pm->suspend(dev);
> +}
> +
> +static int i2c_device_pm_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct i2c_driver *driver;
> + =A0 =A0 =A0 struct dev_pm_ops *pm;
> +
> + =A0 =A0 =A0 if (!dev->driver)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 driver =3D to_i2c_driver(dev->driver);
> + =A0 =A0 =A0 pm =3D driver->driver.pm;
> + =A0 =A0 =A0 if (!pm || !pm->resume)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return pm->resume(dev);
> +}
> +#else
> +# define i2c_device_pm_suspend NULL
> +# define i2c_device_pm_resume =A0NULL
> +#endif
> +
> =A0static int i2c_device_suspend(struct device *dev, pm_message_t mes=
g)
> =A0{
> =A0 =A0 =A0 =A0struct i2c_client *client =3D i2c_verify_client(dev);
> @@ -219,6 +252,11 @@ static const struct attribute_group *i2c_dev_att=
r_groups[] =3D {
> =A0 =A0 =A0 =A0NULL
> =A0};
>
> +static struct dev_pm_ops i2c_device_pm_ops =3D {
> + =A0 =A0 =A0 .suspend =3D i2c_device_pm_suspend,
> + =A0 =A0 =A0 .resume =3D i2c_device_pm_resume,
> +};
> +
> =A0struct bus_type i2c_bus_type =3D {
> =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "i2c",
> =A0 =A0 =A0 =A0.match =A0 =A0 =A0 =A0 =A0=3D i2c_device_match,
> @@ -227,6 +265,7 @@ struct bus_type i2c_bus_type =3D {
> =A0 =A0 =A0 =A0.shutdown =A0 =A0 =A0 =3D i2c_device_shutdown,
> =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0=3D i2c_device_suspend,
> =A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0 =3D i2c_device_resume,
> + =A0 =A0 =A0 .pm =A0 =A0 =A0 =A0 =A0 =A0 =3D &i2c_device_pm_ops,
> =A0};
> =A0EXPORT_SYMBOL_GPL(i2c_bus_type);
>
> --
> 1.6.0
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>

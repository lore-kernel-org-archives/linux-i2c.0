From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] driver i2c-core: i2c bus should support PM entries in
 struct dev_pm_ops.
Date: Sun, 13 Dec 2009 22:12:22 +0100
Message-ID: <20091213221222.724bef54@hyperion.delvare>
References: <1259744920.25505.2.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754290AbZLMVMc@vger.kernel.org>
In-Reply-To: <1259744920.25505.2.camel@eight.analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sonic zhang <sonic.adi@gmail.com>
Cc: linux-i2c@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sonic,

On Wed, 2 Dec 2009 17:08:40 +0800, sonic zhang wrote:
> Struct dev_pm_ops is not configured in current i2c bus type. i2c driv=
ers
> only depends on suspend/resume entries in struct dev_pm_ops are not
> informed of PM suspend and resume events by i2c framework.

Good point. I was wondering some times ago what was the status of
pm_ops. I seem to understand this is the future of power management,
and "direct" .suspend and .resume callbacks will stop being supported
at some point in the future? If so, what is the migration plan? I don't
really want to support both forever.

Your patch introduces the following warnings:

drivers/i2c/i2c-core.c: In function =E2=80=98i2c_device_pm_suspend=E2=80=
=99:
drivers/i2c/i2c-core.c:167: warning: assignment discards qualifiers fro=
m pointer target type
drivers/i2c/i2c-core.c: In function =E2=80=98i2c_device_pm_resume=E2=80=
=99:
drivers/i2c/i2c-core.c:181: warning: assignment discards qualifiers fro=
m pointer target type

You will obviously have to fix them before I can accept your patch.
Missing const...

>=20
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/i2c/i2c-core.c |   39 ++++++++++++++++++++++++++++++++++++++=
+
>  1 files changed, 39 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 2965043..9713c0d 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -155,6 +155,39 @@ static void i2c_device_shutdown(struct device *d=
ev)
>  		driver->shutdown(client);
>  }
> =20
> +#ifdef CONFIG_SUSPEND
> +static int i2c_device_pm_suspend(struct device *dev)
> +{
> +	struct i2c_driver *driver;
> +	struct dev_pm_ops *pm;
> +
> +	if (!dev->driver)
> +		return 0;
> +	driver =3D to_i2c_driver(dev->driver);
> +	pm =3D driver->driver.pm;

This makes little sense, sorry. Why go from device_driver to i2c_driver
and then again to device_driver? The following is equivalent and more
efficient:

	pm =3D dev->driver->pm;

> +	if (!pm || !pm->suspend)
> +		return 0;
> +	return pm->suspend(dev);
> +}
> +
> +static int i2c_device_pm_resume(struct device *dev)
> +{
> +	struct i2c_driver *driver;
> +	struct dev_pm_ops *pm;
> +
> +	if (!dev->driver)
> +		return 0;
> +	driver =3D to_i2c_driver(dev->driver);
> +	pm =3D driver->driver.pm;

Same here.

> +	if (!pm || !pm->resume)
> +		return 0;
> +	return pm->resume(dev);
> +}
> +#else
> +# define i2c_device_pm_suspend	NULL
> +# define i2c_device_pm_resume	NULL

No space between "#" and "define", please.

> +#endif
> +
>  static int i2c_device_suspend(struct device *dev, pm_message_t mesg)
>  {
>  	struct i2c_client *client =3D i2c_verify_client(dev);
> @@ -219,6 +252,11 @@ static const struct attribute_group *i2c_dev_att=
r_groups[] =3D {
>  	NULL
>  };
> =20
> +static struct dev_pm_ops i2c_device_pm_ops =3D {

Could be const.

> +	.suspend =3D i2c_device_pm_suspend,
> +	.resume =3D i2c_device_pm_resume,
> +};
> +
>  struct bus_type i2c_bus_type =3D {
>  	.name		=3D "i2c",
>  	.match		=3D i2c_device_match,
> @@ -227,6 +265,7 @@ struct bus_type i2c_bus_type =3D {
>  	.shutdown	=3D i2c_device_shutdown,
>  	.suspend	=3D i2c_device_suspend,
>  	.resume		=3D i2c_device_resume,
> +	.pm		=3D &i2c_device_pm_ops,
>  };
>  EXPORT_SYMBOL_GPL(i2c_bus_type);
> =20

I've made all the changes above myself, it build OK but I can't test.
Modified patch is here:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvar=
e-i2c/i2c-core-i2c-bus-should-support-pm-entries-in-struct-dev_pm_ops.p=
atch

Please test and report if anything's wrong.

Thanks,
--=20
Jean Delvare

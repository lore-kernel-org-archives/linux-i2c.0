From: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] add MAX17040 Fuel Gauge driver
Date: Sat, 6 Jun 2009 22:29:03 +0530
Message-ID: <5d5443650906060959w678a29acn8200239d35869dca@mail.gmail.com>
References: <4A28BC20.3010307@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A28BC20.3010307-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Minkyu Kang <mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Minkyu Kang,

On Fri, Jun 5, 2009 at 12:03 PM, Minkyu Kang<mk7.kang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrot=
e:
> The MAX17040 is a I2C interfaced Fuel Gauge systems for lithium-ion b=
atteries
> This patch adds support the MAX17040 Fuel Gauge
>

Thanks for making change. Some more comments.

> =A0endif # POWER_SUPPLY
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 2fcf41d..9c48995 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_BATTERY_TOSA) =A0 =A0+=3D tosa_battery=
=2Eo
> =A0obj-$(CONFIG_BATTERY_WM97XX) =A0 +=3D wm97xx_battery.o
> =A0obj-$(CONFIG_BATTERY_BQ27x00) =A0+=3D bq27x00_battery.o
> =A0obj-$(CONFIG_BATTERY_DA9030) =A0 +=3D da9030_battery.o
> -obj-$(CONFIG_CHARGER_PCF50633) +=3D pcf50633-charger.o
> \ No newline at end of file
> +obj-$(CONFIG_BATTERY_MAX17040)) =A0 =A0 =A0 =A0+=3D max17040_battery=
=2Eo

Are we following any alphabetical order in this Makefile?

> +static int max17040_suspend(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_message_t state)
> +{
> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(clien=
t);
> +
> + =A0 =A0 =A0 cancel_delayed_work(&chip->work);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int max17040_resume(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(clien=
t);
> +
> + =A0 =A0 =A0 schedule_delayed_work(&chip->work, MAX17040_DELAY);
> + =A0 =A0 =A0 return 0;
> +}
> +

Please add #ifdef CONFIG_PM around suspend resume functions.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni

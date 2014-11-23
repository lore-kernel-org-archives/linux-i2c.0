From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [5/5] i2c: davinci: use ICPFUNC to toggle I2C as gpio for bus
 recovery
Date: Sun, 23 Nov 2014 18:04:00 +0100
Message-ID: <20141123170400.GC4431@pengutronix.de>
References: <1416477788-5544-6-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1416477788-5544-6-git-send-email-grygorii.strashko-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>, Mike Looijmans <milo-software-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Thu, Nov 20, 2014 at 12:03:08PM +0200, Grygorii Strashko wrote:
> @@ -664,6 +759,7 @@ static int davinci_i2c_probe(struct platform_devi=
ce *pdev)
>  		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>  			&prop))
>  			dev->pdata->bus_freq =3D prop / 1000;
> +		dev->pdata->has_pfunc =3D true;
I don't understand this. Why does this ICPFUNC recovery work if the bus
is probed by oftree, but doesn't if not?

>  	} else if (!dev->pdata) {
>  		dev->pdata =3D &davinci_i2c_platform_data_default;
>  	}
> @@ -705,7 +801,9 @@ static int davinci_i2c_probe(struct platform_devi=
ce *pdev)
>  	adap->timeout =3D DAVINCI_I2C_TIMEOUT;
>  	adap->dev.of_node =3D pdev->dev.of_node;
> =20
> -	if (dev->pdata->scl_pin) {
> +	if (dev->pdata->has_pfunc)
> +		adap->bus_recovery_info =3D &davinci_i2c_scl_recovery_info;
> +	else if (dev->pdata->scl_pin) {
>  		adap->bus_recovery_info =3D &davinci_i2c_gpio_recovery_info;
>  		adap->bus_recovery_info->scl_gpio =3D dev->pdata->scl_pin;
>  		adap->bus_recovery_info->sda_gpio =3D dev->pdata->sda_pin;
> diff --git a/include/linux/platform_data/i2c-davinci.h b/include/linu=
x/platform_data/i2c-davinci.h
> index 2312d19..89fd347 100644
> --- a/include/linux/platform_data/i2c-davinci.h
> +++ b/include/linux/platform_data/i2c-davinci.h
> @@ -18,6 +18,7 @@ struct davinci_i2c_platform_data {
>  	unsigned int	bus_delay;	/* post-transaction delay (usec) */
>  	unsigned int    sda_pin;        /* GPIO pin ID to use for SDA */
>  	unsigned int    scl_pin;        /* GPIO pin ID to use for SCL */
> +	bool		has_pfunc;	/*chip has a ICPFUNC register */
Space after /* please

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

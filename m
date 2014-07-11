From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: efm32: correct namespacing of location property
Date: Fri, 11 Jul 2014 10:28:26 +0200
Message-ID: <20140711082826.GJ11056@pengutronix.de>
References: <CAOesGMjgX5PWBSD2YP7mTGMWafxBjeMDmzZoPCXb27YPUHEcyw@mail.gmail.com>
 <1405066940-12919-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405066940-12919-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

> diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-=
efm32.c
> index f7eccd682de9..5c4cf94527e3 100644
> --- a/drivers/i2c/busses/i2c-efm32.c
> +++ b/drivers/i2c/busses/i2c-efm32.c
> @@ -370,7 +370,13 @@ static int efm32_i2c_probe(struct platform_devic=
e *pdev)
>  		return ret;
>  	}
> =20
> -	ret =3D of_property_read_u32(np, "efm32,location", &location);
> +
> +	ret =3D of_property_read_u32(np, "energymicro,location", &location)=
;
> +
> +	if (!ret)
This must be "if (ret)". I noticed during testing but obviously forgot
to fixup before sending out. Should I resend?

Best regards
Uwe
> +		/* fall back to wrongly namespaced property */
> +		ret =3D of_property_read_u32(np, "efm32,location", &location);
> +
>  	if (!ret) {
>  		dev_dbg(&pdev->dev, "using location %u\n", location);
>  	} else {

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

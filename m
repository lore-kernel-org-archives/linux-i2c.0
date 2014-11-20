From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [1/5] i2c: i2c-davinci: switch to use platform_get_irq
Date: Thu, 20 Nov 2014 22:48:38 +0100
Message-ID: <20141120214838.GA346@pengutronix.de>
References: <1416477788-5544-2-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416477788-5544-2-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-i2c@vger.kernel.org

Hello Grygorii,

On Thu, Nov 20, 2014 at 12:03:04PM +0200, Grygorii Strashko wrote:
> Switch Davinci I2C driver to use platform_get_irq(), because
> - it is not recommened to use
>   platform_get_resource(pdev, IORESOURCE_IRQ, ..) for requesting IRQ'=
s
>   resources any more, as they can be not ready yet in case of DT-boot=
ing.
> - it makes code simpler
>=20
> CC: Sekhar Nori <nsekhar@ti.com>
> CC: Kevin Hilman <khilman@deeprootsystems.com>
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/i2c/busses/i2c-davinci.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2=
c-davinci.c
> index 4d96147..9bbfb8f 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -640,13 +640,13 @@ static int davinci_i2c_probe(struct platform_de=
vice *pdev)
>  {
>  	struct davinci_i2c_dev *dev;
>  	struct i2c_adapter *adap;
> -	struct resource *mem, *irq;
> -	int r;
> +	struct resource *mem;
> +	int r, irq;
> =20
> -	irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (!irq) {
> -		dev_err(&pdev->dev, "no irq resource?\n");
> -		return -ENODEV;
> +	irq =3D platform_get_irq(pdev, 0);
One bad thing about platform_get_irq is its unusual handling of irq=3D0=
=2E
I'm pretty sure you don't want to use this value, so adding something
like:

	if (!irq)
		irq =3D -ENXIO

would be welcome because the usual value for "invalid irq" is 0 and not
-ESOMETHING. platform_get_irq is one of the very few functions that
don't adhere to this convention. With handling <=3D 0 as error your cod=
e
is immune to changes in this area. Although I notice that
platform_get_irq got worse in this respect to handle -EPROBE_DEFER. hmm=
=2E

Apart from your change I wonder if platform_get_irq should handle
of_irq_get returning 0 as an error.

> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "can't get irq resource ret=3D%d\n", irq);
Please don't print an error if irq=3D-EPROBE_DEFER.

> +		return irq;
>  	}

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

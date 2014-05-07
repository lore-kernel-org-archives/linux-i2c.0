From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 03/16] i2c: efm32: remove unnecessary OOM messages
Date: Wed, 7 May 2014 09:32:54 +0200
Message-ID: <20140507073254.GY28564@pengutronix.de>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
 <018701cf69ab$42fd89f0$c8f89dd0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <018701cf69ab$42fd89f0$c8f89dd0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, May 07, 2014 at 01:17:30PM +0900, Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-efm32.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-=
efm32.c
> index 777ed40..f7eccd6 100644
> --- a/drivers/i2c/busses/i2c-efm32.c
> +++ b/drivers/i2c/busses/i2c-efm32.c
> @@ -320,10 +320,8 @@ static int efm32_i2c_probe(struct platform_devic=
e *pdev)
>  		return -EINVAL;
> =20
>  	ddata =3D devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> -	if (!ddata) {
> -		dev_dbg(&pdev->dev, "failed to allocate private data\n");
> +	if (!ddata)
>  		return -ENOMEM;
> -	}
I don't have a strong feeling here, but given that this is only dev_dbg
(i.e. the message doesn't appear without further intervention) the
expected effect is "only" saving some bytes.

If you still feel this patch is worth to have, you can add my Ack.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

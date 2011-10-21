From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Let i2c-mxs be built for MX23
Date: Fri, 21 Oct 2011 20:20:43 +0200
Message-ID: <20111021182043.GI15299@pengutronix.de>
References: <1319220379-2960-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1319220379-2960-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 21, 2011 at 04:06:19PM -0200, Fabio Estevam wrote:
> MX23 and MX28 share the same I2C block, so let i2c-mxs be built for M=
X23 too.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 646068e..08748db 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -456,11 +456,11 @@ config I2C_MV64XXX
>  	  will be called i2c-mv64xxx.
> =20
>  config I2C_MXS
> -	tristate "Freescale i.MX28 I2C interface"
> -	depends on SOC_IMX28
> +	tristate "Freescale i.MXS I2C interface"
> +	depends on (SOC_IMX28 || SOC_IMX23)
You don't need the parenthesis here.

>  	help
>  	  Say Y here if you want to use the I2C bus controller on
> -	  the Freescale i.MX28 processors.
> +	  the Freescale i.MXS processors.
> =20
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-mxs.

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |

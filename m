From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] MXS: Implement DMA support into mxs-i2c
Date: Wed, 6 Jun 2012 11:47:30 +0800
Message-ID: <20120606034728.GC2667@S2101-09.ap.freescale.net>
References: <1338084656-11961-1-git-send-email-marex@denx.de>
 <1338084656-11961-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1338084656-11961-2-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, May 27, 2012 at 04:10:56AM +0200, Marek Vasut wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now=
 enabled
> via DT. The DMA operation is enabled by default.
>=20
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>
> CC: Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> CC: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> CC: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> CC: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    3 +
>  arch/arm/boot/dts/imx28.dtsi                      |    2 +
>  drivers/i2c/busses/i2c-mxs.c                      |  268 +++++++++++=
++++++++--
>  3 files changed, 251 insertions(+), 22 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Docu=
mentation/devicetree/bindings/i2c/i2c-mxs.txt
> index 790b5c6..f4b6244 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> @@ -6,6 +6,9 @@ Required properties:
>  - interrupts: Should contain ERROR and DMA interrupts
>  - speed: Speed of the bus in kHz (400 or 100 are supported)
> =20
> +Optional properties:
> +- use-pio: Use PIO transfers instead of DMA, useful for debug

It should be "fsl,use-pio" which is the one used in code?

> +
>  Examples:
> =20
>  i2c0: i2c@80058000 {
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.d=
tsi
> index d927155..d470276 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -381,6 +381,7 @@
>  				compatible =3D "fsl,imx28-i2c";
>  				reg =3D <0x80058000 2000>;
>  				interrupts =3D <111 68>;
> +				fsl,i2c-dma-channel =3D <6>;

You may need to document this property in binding doc as well.

>  				fsl,speed =3D <400>;
>  				status =3D "disabled";
>  			};
> @@ -391,6 +392,7 @@
>  				compatible =3D "fsl,imx28-i2c";
>  				reg =3D <0x8005a000 2000>;
>  				interrupts =3D <110 69>;
> +				fsl,i2c-dma-channel =3D <7>;
>  				fsl,speed =3D <400>;
>  				status =3D "disabled";
>  			};

--=20
Regards,
Shawn

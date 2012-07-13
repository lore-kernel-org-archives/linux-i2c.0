From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
Date: Fri, 13 Jul 2012 10:22:49 +0200
Message-ID: <20120713082249.GF32184@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1341850974-11977-2-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 09, 2012 at 06:22:54PM +0200, Marek Vasut wrote:
> This patch implements DMA support into mxs-i2c. DMA transfers are now ena=
bled
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
>  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    5 +
>  arch/arm/boot/dts/imx28.dtsi                      |    2 +
>  drivers/i2c/busses/i2c-mxs.c                      |  267 +++++++++++++++=
++++--
>  3 files changed, 252 insertions(+), 22 deletions(-)
>=20
> V2: Fixed return value from mxs_i2c_dma_setup_xfer().
>     Fixed coding style nitpicks
>     Call mxs_i2c_dma_finish() in failpath only if DMA is active
> V3: Align with changes in previous patch
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt b/Document=
ation/devicetree/bindings/i2c/i2c-mxs.txt
> index 30ac3a0..45b6307 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> @@ -6,6 +6,10 @@ Required properties:
>  - interrupts: Should contain ERROR and DMA interrupts
>  - clock-frequency: Desired I2C bus clock frequency in Hz.
>                     Only 100000Hz and 400000Hz modes are supported.
> +- fsl,i2c-dma-channel: APBX DMA channel for the I2C
> +
> +Optional properties:
> +- fsl,use-pio: Use PIO transfers instead of DMA, useful for debug

Having PIOQUEUE (not PIO) as a fallback is good. I'd rather like to see
this as a module parameter, though. For one reason, this is not a
hardware property or board specific, so not a good device tree property.
Also, it is implicitly deprecated somehow since either we want DMA to
fully work or, even better, somewhen be able to automatically switch
between PIOQUEUE and DMA depending on the i2c_msg size. Deprecated
properties are also troublesome. Third, we don't really need this per
instance, if somebody really has problems with DMA, it will apply to all
i2c busses. Makes sense?

> =20
>  Examples:
> =20
> @@ -16,4 +20,5 @@ i2c0: i2c@80058000 {
>  	reg =3D <0x80058000 2000>;
>  	interrupts =3D <111 68>;
>  	clock-frequency =3D <100000>;
> +	fsl,i2c-dma-channel =3D <6>;
>  };

> +	/*
> +	 * The MXS I2C DMA mode is prefered and enabled by default.
> +	 * The PIO mode is still supported, but should be used only

PIOQUEUE

> +	 * for debuging purposes etc.
> +	 */
> +	i2c->dma_mode =3D 1;
> +	if (of_find_property(node, "fsl,use-pio", NULL)) {
> +		i2c->dma_mode =3D 0;
> +		dev_info(dev, "Using PIO mode for I2C transfers!\n");
> +	}
> +
> +	/*
> +	 * TODO: This is a temporary solution and should be changed
> +	 * to use generic DMA binding later when the helpers get in.
> +	 */

@Shawn: Any idea when this is going to happen? And why do we need this?
AFAICT it will be always channel 6/7 on mx28?

> +	ret =3D of_property_read_u32(node, "fsl,i2c-dma-channel",
> +				   &i2c->dma_channel);
> +	if (ret) {
> +		dev_warn(dev, "Failed to get DMA channel!\n");
> +		i2c->dma_mode =3D 0;
> +	}
> +

Rest looks good, thanks!

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk//2tkACgkQD27XaX1/VRtCPQCfQ7wC+teAddLkx8H9wyYbG54R
OaEAoJ5GiL3QydUqeifT6envrGxiQ5Es
=qJa3
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

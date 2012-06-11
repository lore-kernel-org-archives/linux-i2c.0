From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 7/8] i2c: i2c-bfin-twi: Move TWI peripheral pin request
 array to platform data.
Date: Mon, 11 Jun 2012 18:35:11 +0200
Message-ID: <20120611163511.GG3887@pengutronix.de>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
 <1337152826-9850-7-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1337152826-9850-7-git-send-email-sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2012 at 03:20:25PM +0800, sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>=20
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Again, please state the dependency.

> ---
>  drivers/i2c/busses/i2c-bfin-twi.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-b=
fin-twi.c
> index d7e8fba..b2ca317 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -78,11 +78,6 @@ DEFINE_TWI_REG(XMT_DATA16, 0x84)
>  DEFINE_TWI_REG(RCV_DATA8, 0x88)
>  DEFINE_TWI_REG(RCV_DATA16, 0x8C)
> =20
> -static const u16 pin_req[2][3] =3D {
> -	{P_TWI0_SCL, P_TWI0_SDA, 0},
> -	{P_TWI1_SCL, P_TWI1_SDA, 0},
> -};
> -
>  static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
>  					unsigned short twi_int_status)
>  {
> @@ -719,7 +714,8 @@ static int i2c_bfin_twi_probe(struct platform_device =
*pdev)
>  	p_adap->timeout =3D 5 * HZ;
>  	p_adap->retries =3D 3;
> =20
> -	rc =3D peripheral_request_list(pin_req[pdev->id], "i2c-bfin-twi");
> +	rc =3D peripheral_request_list((unsigned short *)pdev->dev.platform_dat=
a,
> +					"i2c-bfin-twi");
>  	if (rc) {
>  		dev_err(&pdev->dev, "Can't setup pin mux!\n");
>  		goto out_error_pin_mux;
> @@ -766,7 +762,7 @@ out_error_add_adapter:
>  	free_irq(iface->irq, iface);
>  out_error_req_irq:
>  out_error_no_irq:
> -	peripheral_free_list(pin_req[pdev->id]);
> +	peripheral_free_list((unsigned short *)pdev->dev.platform_data);
>  out_error_pin_mux:
>  	iounmap(iface->regs_base);
>  out_error_ioremap:
> @@ -784,7 +780,7 @@ static int i2c_bfin_twi_remove(struct platform_device=
 *pdev)
> =20
>  	i2c_del_adapter(&(iface->adap));
>  	free_irq(iface->irq, iface);
> -	peripheral_free_list(pin_req[pdev->id]);
> +	peripheral_free_list((unsigned short *)pdev->dev.platform_data);
>  	iounmap(iface->regs_base);
>  	kfree(iface);
> =20
> --=20
> 1.7.0.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/WHj8ACgkQD27XaX1/VRvYvACeP0iWdGuRR5rSabkeMJ7/5E97
bK8An26lF+KI2ReXci0ccZiw1cX0B183
=EPA8
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

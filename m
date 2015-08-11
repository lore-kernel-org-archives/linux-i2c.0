From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [Patch V3] i2c: imx: add runtime pm support to improve the
 performance
Date: Tue, 11 Aug 2015 17:04:50 +0200
Message-ID: <20150811150450.GC1525@katana>
References: <1438565394-4599-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438565394-4599-1-git-send-email-b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2015 at 09:29:54AM +0800, Gao Pan wrote:
> In our former i2c driver, i2c clk is enabled and disabled in
> xfer function, which contributes to power saving. However,
> the clk enable process brings a busy wait delay until the core
> is stable. As a result, the performance is sacrificed.
>=20
> To weigh the power consumption and i2c bus performance, runtime
> pm is the good solution for it. The clk is enabled when a i2c
> transfer starts, and disabled after a specifically defined delay.
>=20
> Without the patch the test case (many eeprom reads) executes with approx:
> real 1m7.735s
> user 0m0.488s
> sys 0m20.040s
>=20
> With the patch the same test case (many eeprom reads) executes with appro=
x:
> real 0m54.241s
> user 0m0.440s
> sys 0m5.920s
>=20
> From the test result, the patch get better performance.
>=20
> ---
> V2:
> As Uwe Kleine-K=C3=B6nig's suggestion, the version do below changes:
> - call clk_prepare_enable in probe to avoid never enabling clock
>   if CONFIG_PM is disabled
> - enable clock before request IRQ in probe
> - remove the pm staff in i2c_imx_isr
>=20
> V3:
> - pm_runtime_get_sync returns < 0 as error
>=20
> Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

The signed-off lines should be before the "---" line.

Applied to for-next, thanks!


> ---

A second "---" line is not a good idea. Many workflow scripts will
break.

>  static struct platform_driver i2c_imx_driver =3D {
> -	.probe =3D i2c_imx_probe,
> -	.remove =3D i2c_imx_remove,
> -	.driver	=3D {
> +	.probe		=3D i2c_imx_probe,
> +	.remove		=3D i2c_imx_remove,
> +	.driver		=3D {
>  		.name	=3D DRIVER_NAME,
> +		.pm	=3D I2C_IMX_PM_OPS,
>  		.of_match_table =3D i2c_imx_dt_ids,
>  	},
>  	.id_table	=3D imx_i2c_devtype,

I fixed this to use one space as an indentation and no tabs. Experience
shows this is more future-proof.

Thanks,

   Wolfram


--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyg8SAAoJEBQN5MwUoCm2vv0P/3h1rRj2qDJ3efZ88CjgmcSd
QfbvyC+NObrCNR0YRvdPOoM3qFq48yr/qm1ens6Z1ZDIHPVRAYx+0coXtrneR82V
GIwMmCvS0Lhwoe4PzqmJnE/4NWSxmj8RF0UdxTi62vmpCr2ExRSLzme2FdkdDPUQ
sPtTR4vSwbne02qZINaoglb9qE4otVk43+YWIkoWbW6KxIt6U/lHnBAXT4uEgAPX
wadQxLaZX09uVUXXpz2HqMyEpd/a5kLxI4EQcPJqfy7U5Ozukxl+7y5NhAvFM+vw
bOp/A/3pT/qHmIejx/IIgb+MmSa/+1KJvVauA1rfEkbYYImnBQH97gnN02XZwsGX
AgymthymIrsT/WeaVYR+mtpamyRSNK6QUCFwviEeAfTzXj+a0rH9I+YN0nc+TsWj
Tdj6v9r7DibJRq0JLS6bXGvPAE67dVeagh1v05OfTmnvKMxfblUwXwHnCAR2fO5l
tynK9v6XWAsp+d1c9J/ji4R1zCQbYthNETZZw3lEK48QFIzcneRa2lNKDfQPSf4A
+0JIokbIMQazEqyh2K5ZPoHqGCP5ByPHdZ0BQ6Co9IQJC2yheFRHq64hv2SjHqQF
DIfC9XkbcHUIFDQqFe5S1WFlhhAq7v8R8PdtNKZvHNf0AmZpCEqpdY8yucMHYdO6
+rg3SxqNTi9jsiLu9LJ2
=BunB
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

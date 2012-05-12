From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-ocore: register OF i2c devices
Date: Sat, 12 May 2012 16:52:05 +0200
Message-ID: <20120512145205.GL20673@pengutronix.de>
References: <1336483529-19140-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1336483529-19140-2-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GU3/x65mZ6MFE8p3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336483529-19140-2-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--GU3/x65mZ6MFE8p3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2012 at 06:55:28PM +0530, Jayachandran C wrote:
> From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>=20
> Call of_i2c_register_devices() in probe function to register i2c devices
> specified in the device tree or OF.
>=20
> Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

Applied to next with a minor fixup.

More important: If you are happily using this driver without issues,
please consider removing EXPERIMENTAL for this driver from Kconfig.

> ---
>  drivers/i2c/busses/i2c-ocores.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-oco=
res.c
> index 18068de..ebd2700 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -55,6 +55,7 @@
>  #include <linux/i2c-ocores.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> +#include <linux/of_i2c.h>
> =20
>  struct ocores_i2c {
>  	void __iomem *base;
> @@ -343,7 +344,9 @@ static int __devinit ocores_i2c_probe(struct platform=
_device *pdev)
>  	if (pdata) {
>  		for (i =3D 0; i < pdata->num_devices; i++)
>  			i2c_new_device(&i2c->adap, pdata->devices + i);
> -	}
> +	} else
> +		of_i2c_register_devices(&i2c->adap);
> +

This empty line was too much; also the else branch could have had
braces.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GU3/x65mZ6MFE8p3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+ueRUACgkQD27XaX1/VRsI4ACfeDummHsA5A6nCLI9v2QLyIlm
XI0An07OHFfUmNjRPne2ixsNdsHxSbkX
=LAC7
-----END PGP SIGNATURE-----

--GU3/x65mZ6MFE8p3--

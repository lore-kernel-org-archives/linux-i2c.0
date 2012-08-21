From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c-i801: Add device tree support
Date: Tue, 21 Aug 2012 10:29:06 +0200
Message-ID: <20120821082906.GC28886@pengutronix.de>
References: <1344409609-1904-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7gGkHNMELEOhSGF6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344409609-1904-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Daniel Kurtz <djkurtz@chromium.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--7gGkHNMELEOhSGF6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2012 at 09:06:47AM +0200, Thierry Reding wrote:
> This commit adds support for probing slave devices parsed from the
> device tree.
>=20
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Jean, this one is for you, I guess?

> ---
>  drivers/i2c/busses/i2c-i801.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 6f00785..b5311cf 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -80,6 +80,7 @@
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  #include <linux/err.h>
> +#include <linux/of_i2c.h>
> =20
>  #if defined CONFIG_I2C_MUX || defined CONFIG_I2C_MUX_MODULE
>  #include <linux/gpio.h>
> @@ -1238,6 +1239,7 @@ static int __devinit i801_probe(struct pci_dev *dev,
>  		goto exit_free_irq;
>  	}
> =20
> +	of_i2c_register_devices(&priv->adapter);
>  	i801_probe_optional_slaves(priv);
>  	/* We ignore errors - multiplexing is optional */
>  	i801_add_mux(priv);
> --=20
> 1.7.11.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7gGkHNMELEOhSGF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAzRtIACgkQD27XaX1/VRuMKgCgv7WNAHl90AUOSP3UPu2pVD1C
SE4AoLDSi/Q0C2LFxHLTMvPIXD9B6hdJ
=SE4V
-----END PGP SIGNATURE-----

--7gGkHNMELEOhSGF6--

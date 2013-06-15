From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: nomadik: allocate adapter number dynamically
Date: Sat, 15 Jun 2013 16:20:59 +0200
Message-ID: <20130615142058.GB2923@katana>
References: <1370816153-9838-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370816153-9838-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2013 at 12:15:53AM +0200, Linus Walleij wrote:
> The Nomadik I2C was using a local atomic counter to number
> the I2C adapters. This does not work on configurations where
> you also add, say a GPIO bit-banged adapter to the system.
> They will start to conflict about being adapter 0.
>=20
> There is no reason to use the numbered adapter function, and
> the semantic effect on systems with only Nomadik I2C blocks
> will be none - instead of increasing the number atomically
> in the driver itself, it is done in the I2C core.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Basically fine...

> ---
>  drivers/i2c/busses/i2c-nomadik.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index 9f1423a..96c8515 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -15,7 +15,6 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/amba/bus.h>
> -#include <linux/atomic.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> @@ -981,8 +980,6 @@ static void nmk_i2c_of_probe(struct device_node *np,
>  		pdata->sm =3D I2C_FREQ_MODE_FAST;
>  }
> =20
> -static atomic_t adapter_id =3D ATOMIC_INIT(0);
> -
>  static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id =
*id)
>  {
>  	int ret =3D 0;
> @@ -1095,10 +1092,9 @@ static int nmk_i2c_probe(struct amba_device *adev,=
 const struct amba_id *id)
>  	adap->class	=3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
>  	adap->algo	=3D &nmk_i2c_algo;
>  	adap->timeout	=3D msecs_to_jiffies(pdata->timeout);
> -	adap->nr =3D atomic_read(&adapter_id);
> +	adap->nr =3D -1;

=2E.. only that line can be removed since you now use i2c_add_adapter
instead of i2c_add_numbered_adapter.

>  	snprintf(adap->name, sizeof(adap->name),
> -		 "Nomadik I2C%d at %pR", adap->nr, &adev->res);
> -	atomic_inc(&adapter_id);
> +		 "Nomadik I2C at %pR", &adev->res);
> =20
>  	/* fetch the controller configuration from machine */
>  	dev->cfg.clk_freq =3D pdata->clk_freq;
> @@ -1113,7 +1109,7 @@ static int nmk_i2c_probe(struct amba_device *adev, =
const struct amba_id *id)
>  		 "initialize %s on virtual base %p\n",
>  		 adap->name, dev->virtbase);
> =20
> -	ret =3D i2c_add_numbered_adapter(adap);
> +	ret =3D i2c_add_adapter(adap);
>  	if (ret) {
>  		dev_err(&adev->dev, "failed to add adapter\n");
>  		goto err_add_adap;
> --=20
> 1.8.1.4
>=20

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRvHhJAAoJEBQN5MwUoCm2XUUP/ifRYzIiko65vUOhCVKB2xF8
2MYKTjELwSyt6NVTmvVWy6HmgNFkGosMFkQtPLotTaKLyS0vGtgMrhw4o+95jv/d
TnoPLw5eIb0+OgLvXGkyvRGq6dOl+wZr4nxI8pY4o1KjYUqfWic5cI2g8bUkKxni
YVKPPR4vbGepB3ed21QmMIxQyhJhphJugW64hF6tAmK7SgNSjm5eH1rYiyFTAId3
YgprLCe0FX/deVF1LuveU+k9gefQJu3lrZbrH0WCSLWUFcv4Y8Bbrcp4bW9OR5oO
IhLyAOrs3VG7t1OVzIsiW/RSVmjJ9pq4QVVQKtnrPe8vQSYTq2IlS3C2FutX3GmQ
JmZqWreI24M7HZ7bDoObcZh2kgDUqN4fjtYcaOVQnfX5yqM+JqdengaXmfb97MLz
e4mSvW7+9vgLUEmC2vEuZzQVZasV05BqdQ/APPA4+K3GrVuNEa9cBOo1ktwrhAtL
jCALHw21FEHtn1KRlaZvRza9BCnOhCmPpvVjUc+Q77ZVL7Ft9cDytNQ76zanJRE/
NPqm6oI2YU3eHOC9EIZd6Ohmu6UyoJLT0qK8wEfw8P7M2bt5nGRZS1XvKI4Yc7p0
JFNPBRffzDs/4W2WXwhLNiK0OxLvgPEfAyYg5sx+N2Nrpcz+Aeufj6of48AH9R8P
LBr+hsu0+CiLRnRZS5cD
=nEP+
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

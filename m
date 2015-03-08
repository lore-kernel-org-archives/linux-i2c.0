From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
Date: Sun, 8 Mar 2015 09:28:45 +0100
Message-ID: <20150308082845.GB1904@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424880126-15047-4-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 05:01:54PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Hi Ludovic,

if you have a few minutes, could you please test this series? I'd like to
include it in 4.1. and because at91 is using the quirk infrastructure in
a more complex way, it is a really good test candidate.

Thanks,

   Wolfram

> ---
>  drivers/i2c/busses/i2c-at91.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 636fd2efad8850..b3a70e8fc653c5 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -487,30 +487,10 @@ static int at91_twi_xfer(struct i2c_adapter *adap, =
struct i2c_msg *msg, int num)
>  	if (ret < 0)
>  		goto out;
> =20
> -	/*
> -	 * The hardware can handle at most two messages concatenated by a
> -	 * repeated start via it's internal address feature.
> -	 */
> -	if (num > 2) {
> -		dev_err(dev->dev,
> -			"cannot handle more than two concatenated messages.\n");
> -		ret =3D 0;
> -		goto out;
> -	} else if (num =3D=3D 2) {
> +	if (num =3D=3D 2) {
>  		int internal_address =3D 0;
>  		int i;
> =20
> -		if (msg->flags & I2C_M_RD) {
> -			dev_err(dev->dev, "first transfer must be write.\n");
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -		if (msg->len > 3) {
> -			dev_err(dev->dev, "first message size must be <=3D 3.\n");
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -
>  		/* 1st msg is put into the internal address, start with 2nd */
>  		m_start =3D &msg[1];
>  		for (i =3D 0; i < msg->len; ++i) {
> @@ -540,6 +520,15 @@ out:
>  	return ret;
>  }
> =20
> +/*
> + * The hardware can handle at most two messages concatenated by a
> + * repeated start via it's internal address feature.
> + */
> +static struct i2c_adapter_quirks at91_twi_quirks =3D {
> +	.flags =3D I2C_AQ_COMB | I2C_AQ_COMB_WRITE_FIRST | I2C_AQ_COMB_SAME_ADD=
R,
> +	.max_comb_1st_msg_len =3D 3,
> +};
> +
>  static u32 at91_twi_func(struct i2c_adapter *adapter)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> @@ -777,6 +766,7 @@ static int at91_twi_probe(struct platform_device *pde=
v)
>  	dev->adapter.owner =3D THIS_MODULE;
>  	dev->adapter.class =3D I2C_CLASS_DEPRECATED;
>  	dev->adapter.algo =3D &at91_twi_algorithm;
> +	dev->adapter.quirks =3D &at91_twi_quirks;
>  	dev->adapter.dev.parent =3D dev->dev;
>  	dev->adapter.nr =3D pdev->id;
>  	dev->adapter.timeout =3D AT91_I2C_TIMEOUT;
> --=20
> 2.1.4
>=20

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/Ag9AAoJEBQN5MwUoCm2ZUQP/24pSAVpY6i8vCuMifwSFj/3
t5pljp+iU/Ryg0/qCUYYgftmfCWqFvOremeAF1Y1PF2GTquXpxNJdwI+slBNvtsL
QGlkESyk/bN/qAun0k1QH+YDLZORiSSgrQRJhCNJaKcgbiRVoVlBWXrZujF1ixLY
Wg8QOfEKla3iXLsasMnqUpzAzP1kvJMReOCaZfddbPFJjAL+P9SUkormjv2WWzkc
HqfyH27K9ZdtWroEAjZO9LOHGkg+KmPaI/9y/s9+B1X+o5hzuJaqaoNiToL9vtJd
IGDuFP3hk03IoU3QruXHLrQ9EBZTo5dUQFVSED0UkXfAd0iixl4TQFeorNzXC7xE
78ukLztk//dsRMmTNwH6FvJjwWlByGwmBEI/Xaj3iav7pX3hIvzeapsg8XImwkGw
Bgj4GivLxr4XLN5NUIFtIl3Fvfs0G51v/7Ngo6OyPaL3z0+YWTeaQVi2jXhchWcF
JJyLFToLRdE3O0aAUpzAXGwYa+n8METUtGPE64SAU1PY0QPjSlNV/Ef5NeNKUsXM
I9ZEi3VqzKIjTDbj8+RyIP5NkQEp1XbOzjq0CcopJrMXKfBm900xp4pCXr3Y5JMA
0WTjIIllVw4klSTKxuP5mbUobbxCoHsZmLgmc8BcxrALLzQNTxe79E3jtQFk4jXQ
Hb5TGoNb81lcd+Sfg6fB
=bwPY
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

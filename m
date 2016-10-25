From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] drivers/i2c/i2c-dev: Fix kernel memory disclosure
Date: Tue, 25 Oct 2016 11:45:13 +0200
Message-ID: <20161025094512.GF1597@katana>
References: <1476190348-37589-1-git-send-email-vlad@tsyrklevich.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49295 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751044AbcJYJpR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Oct 2016 05:45:17 -0400
Content-Disposition: inline
In-Reply-To: <1476190348-37589-1-git-send-email-vlad@tsyrklevich.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Cc: linux-i2c@vger.kernel.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2016 at 02:52:28PM +0200, Vlad Tsyrklevich wrote:
> i2c_smbus_xfer() does not always fill an entire block, allowing
> kernel stack memory disclosure through the temp variable. Clear
> it before it's read to.
>=20
> Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>

Yes, thanks. But what about clearing 'temp' when it is declared? This
would be rock-solid for all future code paths.

>=20
> ---
>  drivers/i2c/i2c-dev.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
> index 66f323f..62cb111 100644
> --- a/drivers/i2c/i2c-dev.c
> +++ b/drivers/i2c/i2c-dev.c
> @@ -393,6 +393,8 @@ static noinline int i2cdev_ioctl_smbus(struct i2c_cli=
ent *client,
>  	    (data_arg.read_write =3D=3D I2C_SMBUS_WRITE)) {
>  		if (copy_from_user(&temp, data_arg.data, datasize))
>  			return -EFAULT;
> +	} else {
> +		memset(&temp, 0, datasize);
>  	}
>  	if (data_arg.size =3D=3D I2C_SMBUS_I2C_BLOCK_BROKEN) {
>  		/* Convert old I2C block commands to the new
> --=20
> 2.7.0
>=20

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDymoAAoJEBQN5MwUoCm21+gP/0DgEgbaCIN/V5F2h5IaSvtR
C5zBPgfajvmWwclF2MdUObh7JdLs8xaE45yd9+fgM5mslyi+MiwpWR0mYqFikanj
QRxbH1vw/QA0rQHPSOXO5cvlAPOycm8c9J7VYrx9b2KYNuCYf4atLhi4a8T/IcIC
PHguodjkb3PCy4Yq7+0WPZ/oy0bRnV58doLNrpvUUErtQTmaJqrTLhM70g/7z++k
htiaNFOc+7kWqpFun0RaARhGN/GlXprFK2gERRi2sGve8OQJzlHRZ58b4M1IeUV7
6ezsG/H/SVr2N3PrPPBOhhbqwDTcleTMqHEcJf2w4SftgS6zTX7/gPK0WQ3EgrEC
mDTLZroFwKHJsH6nFX083iXSk+XNGtFjFJsrHW8mXf6mwwbutIBrsqXJC+OLiDEx
Y26Vigqz4TD1m64Vg3wSdUtHmwf3SCfL4BBmE++CtEMjmdTSfQfSm8blqiwBfvaV
nGd/jCFw+JHfe4ExdABDnj+A3sUjmav4MZf9vLkWPJwj5xM9vHyiF2YDU710KAbz
r6mCVESBAEqlZJOG7whenSWqsHXXQbX8iAl0GgyN/nUnsD04KZs1RNmiG9oJ90ct
AF5D0MGH6iNreJsIHAOCIh0dOig1tRBulZv94Kqj5axGj2wMAXncuyf8nLvqtFHL
V/3EuXM7yI5jPj4z8mzo
=vyYk
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--

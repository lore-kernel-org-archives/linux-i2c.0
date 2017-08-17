From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH][i2c-next] i2c-cht-wc: make cht_wc_i2c_adap_driver static
Date: Thu, 17 Aug 2017 18:29:57 +0200
Message-ID: <20170817162957.fes3tu64onuiqspe@ninjato>
References: <20170816091659.10738-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pahcufooeqkrvjxi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816091659.10738-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--pahcufooeqkrvjxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 16, 2017 at 10:16:59AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The structure cht_wc_i2c_adap_driver is local to the source
> and does not need to be in global scope, so make it static.
>=20
> Cleans up sparse warning:
> symbol 'cht_wc_i2c_adap_driver' was not declared. Should it be static?
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

CCing Hans to ask him if he maybe wants to create a MAINTAINERS entry
for this driver, so he'll get CCed for such patches? :)

> ---
>  drivers/i2c/busses/i2c-cht-wc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht=
-wc.c
> index fe5caf70c7fe..01c94c918d4c 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -322,7 +322,7 @@ static struct platform_device_id cht_wc_i2c_adap_id_t=
able[] =3D {
>  };
>  MODULE_DEVICE_TABLE(platform, cht_wc_i2c_adap_id_table);
> =20
> -struct platform_driver cht_wc_i2c_adap_driver =3D {
> +static struct platform_driver cht_wc_i2c_adap_driver =3D {
>  	.probe =3D cht_wc_i2c_adap_i2c_probe,
>  	.remove =3D cht_wc_i2c_adap_i2c_remove,
>  	.driver =3D {
> --=20
> 2.11.0
>=20

--pahcufooeqkrvjxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVxIUACgkQFA3kzBSg
KbY2ahAAnRbIYHsFufpguu1jtjmEKE8pn/OOXrkULzEy9LrTkDdlZ6FAi39eBJ1S
/iM6ayIYGMnvjJ3mekXxkqsmaF/UNKmwTfDsF7dLN90bt8vocwQKfJrF43lSjIPs
jYkC0ABFDn+MNqFVfy5tbKp/Il9v6QQp+2X4IXgqh1GiR5uuWCrfLmACMVWjrsBd
X0X0G4xBX1aW7NzofWn4nnlK/ZceFT/I1LShHFOaF0cD5KfRcGNi9uausqHZ7yGr
W/doMzEWOyIahh6+2Fgz6NgUF8hSBCETkO6z4axpcMwcHQUAhSxZ+s4p7PXO6gi2
TQ0Bf1VyrzgnSyzqZ1A+V2GOX0+9qmYtGdtbkXuzXm/sRHgjASU2B392GZeDC4bz
qqhDISywiinYW4N0Rqi2MILdsO30S02kpdkYNCARUPsRhDxxr82RMyxIEUbfnVHD
s2Smkv0Pp3zupffbp5kba8sPNwm16clo3kbNlzyKyTgy8C75grw0+JpO+Z8mCfCS
dNut53e+hviBe7ath7uOE73Vkbdu6tNZ7IZQW5Vlb8AQZ8JJGDpS17wMacNq7cfW
iS+S6DsPT8skjuKxtDiav1vs7ZVHWBTVwFS3IQ3iCP9Jt+CqUXZNjECzjM9NeRs0
qQFB9WAbgjtA1ozPtxGM8AcLaEzyluRyaPQD5Q9HxODXECiVZJ8=
=ZdsX
-----END PGP SIGNATURE-----

--pahcufooeqkrvjxi--

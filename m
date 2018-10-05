From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: squelch error: uninitialized symbol 'ret'
Date: Fri, 5 Oct 2018 18:28:41 +0200
Message-ID: <20181005162841.wy4uyespwcvffkpc@ninjato>
References: <20181005161826.2455-1-george_davis@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wnymki4pg66ttk4m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005161826.2455-1-george_davis@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "George G. Davis" <ggdavisiv@gmail.com>
Cc: "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "George G. Davis" <george_davis@mentor.com>
List-Id: linux-i2c@vger.kernel.org


--wnymki4pg66ttk4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 05, 2018 at 12:18:25PM -0400, George G. Davis wrote:
> The following smatch error was introduced by commit 7ca5f6be7900 ("i2c:
> recovery: add get_bus_free callback"):
>=20
> drivers/i2c/i2c-core-base.c:228 i2c_generic_scl_recovery() error: uniniti=
alized symbol 'ret'.
>=20
> Analysis of the code appears to show that the smatch error is a false
> positive since 'ret' will in fact be initialized after exiting the
> 'while()' loop.
>=20
> Squelch the smatch error since it is a false positive.

What about fixing smatch?

>=20
> Fixes: 7ca5f6be7900 ("i2c: recovery: add get_bus_free callback")
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> ---
>  drivers/i2c/i2c-core-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 9ee9a15e7134..7b25ecb6b616 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -185,7 +185,7 @@ static int i2c_generic_bus_free(struct i2c_adapter *a=
dap)
>  int i2c_generic_scl_recovery(struct i2c_adapter *adap)
>  {
>  	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> -	int i =3D 0, scl =3D 1, ret;
> +	int i =3D 0, scl =3D 1, uninitialized_var(ret);
> =20
>  	if (bri->prepare_recovery)
>  		bri->prepare_recovery(adap);
> --=20
> 2.14.4
>=20

--wnymki4pg66ttk4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3kTkACgkQFA3kzBSg
KbaFqA//ZUerrobPlFs57JtDyaGBvcrUbu5mYduhvINLLEeuvC6McHYmTt/02zTq
o9XwhNE2bOCa7mXEu6X/tG2VrX2iOrCtlIksMhsyjcUPh3k4+6cF6GNzP2glAaOs
1z7Hs3EtrbwF9ocpAD96ohYPba+V7M/HCA197Of2XAO5tKYKYz6DMYzH1sEQLdju
0NSNPQClrK2Um1cBQy3clzrR3VP10Fp2RHrSnQIvReHG/XYcalezO8rVcc+IIQNA
8afD4EKkkn6gmG2h3dH9vVnoHjpwaby8cJ592aAAbzWkNq4/q7rgCHQuuTXXi4Gq
oDP9GaOew/wBCW3NS4sZPmY3JpaKhfVxb7owH9X+gw1aBWUxiU/v2jWd4fGPvziy
KGmAfByl57c9Yc2IWH5uzJsoIMUr0rEBxWarTB2Y9PYBTaIJ5cZg1C2rJiuoOhKt
hgUo3uzyE+Gr5Qfncv3IfBQXrZ0jQFmZ1gDSeDbClgqneWLMCzuPG7trXpKjBlu4
Pt6iWSec35merIY2M20aqgebYMbaVz8AErOmQxzEwu50b2+iAG5tR9z4ZrMUJ5f2
j+BEaA31p32GTu83Lg/XiDXu9D+X5dUEIAj278wqvsYqKXIUEz362AhuxvqbuFWb
oejeAcS/FBVQ/RsjUBAW9SHAsqMqzn6hUA/kfkPPeLoJpQFcc6k=
=s9d7
-----END PGP SIGNATURE-----

--wnymki4pg66ttk4m--

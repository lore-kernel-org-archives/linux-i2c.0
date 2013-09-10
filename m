From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: davinci: Fix bad dev_get_platdata() conversion
Date: Tue, 10 Sep 2013 11:20:01 +0200
Message-ID: <20130910092001.GB4625@katana>
References: <1378409024-13432-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1378409024-13432-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2013 at 12:23:44PM -0700, Olof Johansson wrote:
> commit 6d4028c644e (i2c: use dev_get_platdata()) did a bad conversion
> of this one case:
>=20
> drivers/i2c/busses/i2c-davinci.c: In function 'davinci_i2c_probe':
> drivers/i2c/busses/i2c-davinci.c:665:2: warning: passing argument 1 of
> 	'dev_get_platdata' from incompatible pointer type [enabled by default]
>=20
> Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>

Gosh, need to find out why my build-tests failed on that. Thanks!

Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Jingoo Han: Did you buildtest?

> ---
>  drivers/i2c/busses/i2c-davinci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-da=
vinci.c
> index 5747341..132369f 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -662,7 +662,7 @@ static int davinci_i2c_probe(struct platform_device *=
pdev)
>  #endif
>  	dev->dev =3D &pdev->dev;
>  	dev->irq =3D irq->start;
> -	dev->pdata =3D dev_get_platdata(&dev->dev);
> +	dev->pdata =3D dev_get_platdata(&pdev->dev);
>  	platform_set_drvdata(pdev, dev);
> =20
>  	if (!dev->pdata && pdev->dev.of_node) {
> --=20
> 1.7.10.4
>=20

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSLuRAAAoJEBQN5MwUoCm2vR0P/1RRgEtzK6nouou7K3w/HpdL
7LByx1IfSgNbPT09t82z9XEDxZnaGrcA9Ov7ymfgZoKSJ1BVx/MxeRNj+3C6vcqf
cqyctXw3deumQf1DdbcHIjb39/2jA22Dt8rtjMZtgiOURgsAwxAeUj5xoz//cHMn
iqh/uNOf4hBtke3A6S3FNV7v9rMhJwvrhnEeeoWyVA21qymcnsJRGv+D9VhsIlKP
R+OwFAjvZwE/hmD6MZGS8pT6b4iRX6+bZwFOSbNuHK+kzCtCvE9my27LwBf9Si4Y
xVxUfJZV/l1sWeLAMn3ZQNX6TCCPfRVfCjLop9YYtkM9Hw4n1rAlvlBIId1Kw8KV
md9QOjer0vTc3FsEaOyp9V4/Td5bm8wo64z53gGnpaQBpk77HMF642YCCjZm7dgf
XFcE/RQ2sZx4lwdPek2rEQgeq29ZWvSzTjkON97nAwEhpSPkLLVzB46IMVqkcLzY
/V6zNJA3VrL9/KVAaEOtmuKwF1zw/Ml+YiXHfX+9AhiqsXeKOm5mkCyZW0gP4KgW
xrGAG10HOME5Ma5Rv1NM5zJSYhm8stihOGJmrZtuVkzm0YRGgDdC7aFD4s4Bd3k8
OOPYPtFnCZAQyNhd1FNHNDM07DvnBSCv6vRbcPrnjNgI2J3b4aOLIoTlMEa+Kp5R
G4PlCJEjfANPswkG5Su3
=R/Vj
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

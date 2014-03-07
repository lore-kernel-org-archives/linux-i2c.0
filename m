From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2] i2c: mv64xxx: fix circular Kconfig dependency
Date: Fri, 7 Mar 2014 10:28:41 +0100
Message-ID: <20140307092841.GM607@lukather>
References: <1394137975-3903-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SlNsYPPA1sYaSN7W"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394137975-3903-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--SlNsYPPA1sYaSN7W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Thu, Mar 06, 2014 at 09:32:55PM +0100, Wolfram Sang wrote:
> Commit 370136bc67c3 ("i2c: mv64xxx: Add reset deassert call")
> introduced:
>=20
> drivers/video/Kconfig:42:error: recursive dependency detected!
>=20
> ARCH_SUNXI selects RESET_CONTROLLER anyhow.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 70bcad941657..f8162441576f 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -527,8 +527,7 @@ config I2C_MPC
> =20
>  config I2C_MV64XXX
>  	tristate "Marvell mv64xxx I2C Controller"
> -	depends on (MV64X60 || PLAT_ORION || ARCH_SUNXI)
> -	select RESET_CONTROLLER
> +	depends on MV64X60 || PLAT_ORION || ARCH_SUNXI

I'm not sure it actually works.

MV64X60 and PLAT_ORION don't select RESET_CONTROLLER, and the
functions won't be declared, resulting in a compilation breakage too.

Maybe we can just depend on RESET_CONTROLLER too here, to fix the
circular dependency.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--SlNsYPPA1sYaSN7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTGZFJAAoJEBx+YmzsjxAgC1gP/RdNYFZ4IGX9hefB0+QPIzE0
+127VZIbCxDzmaOc/TDfwIoPurvou+oG/LUmu303mOLBcK6LUtuz+P2ODX1vcM8Y
B6V2+ViqRmXUgomPiYZVg69i1v4AG+cFgupQXa94iKovXQoWFK7jht5OBRzsRBMc
YkCsYlj4XiUUZlRAogl1Q0AziRWjUPd/tXc0zSFNFHiKkuFtZaFV1xIuGpU2DdHV
+aO0Z1oxLT9sfE4/JdZMX7+DjcW6v/PoeomywBCTRrOg69kv7WpVoOiETHdxmqm1
UqDHRjML1r24RTJytetKKPzlwa2yemX5nkaScUTJTveWqIslhsKeG6Ek/LXWwY4/
JC7Cw5SpU0h8Nc7eP1HN8rRb95DwCkxxX4wXX8WxJ3NZhyoQu9X1g07JOXEqA/Q8
0VvnzG7Y6/PiD200Xpzq0gh3RCoDRqLZ/pwBFFlz5DBUtg/oYLWGaZ3I7vZOD9vj
qTB2SB1IQI2eNGVPSr+lvuil5OZzpeoWR0vVXsERJdu0EEzPisHF++8UktW0h0zv
S8f0uy1ZiLkj1+JclLfxK6Cj+soUW38XgR/q6EYRh2DzIKc2OJM3roaflsfM/lFQ
e5CtHQ5YSn1cNCJnymErEanpcovnxrmZ6a+oH5PSznajptC1Bnni9qe2Eu6Q6hD4
772tUreCkkGiLeslskZq
=V9oO
-----END PGP SIGNATURE-----

--SlNsYPPA1sYaSN7W--

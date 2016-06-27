From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-mux-reg: wrong condition checked for
 of_address_to_resource return value
Date: Mon, 27 Jun 2016 11:26:24 +0200
Message-ID: <20160627092624.GC1602@katana>
References: <20160627092144.GA20023@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40332 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751215AbcF0J0b (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 27 Jun 2016 05:26:31 -0400
Content-Disposition: inline
In-Reply-To: <20160627092144.GA20023@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Cc: peda@axentia.se, linux-i2c@vger.kernel.org, alexander.sverdlin@nokia.com


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2016 at 11:21:48AM +0200, Lukasz Gemborowski wrote:
> of_address_to_resource return 0 on successful call but
> devm_ioremap_resource is called only if it returns non-zero value
>=20
> Signed-off-by: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  drivers/i2c/muxes/i2c-mux-reg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-=
reg.c
> index 26e7c51..012a7ab 100644
> --- a/drivers/i2c/muxes/i2c-mux-reg.c
> +++ b/drivers/i2c/muxes/i2c-mux-reg.c
> @@ -145,7 +145,7 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
>  		mux->data.idle_in_use =3D true;
> =20
>  	/* map address from "reg" if exists */
> -	if (of_address_to_resource(np, 0, &res)) {
> +	if (!of_address_to_resource(np, 0, &res)) {

Minor nit: I prefer '=3D=3D 0' in those cases to prevent the misleading
reading of "if not of_address_to_resource...". '=3D=3D 0' can be easier read
as 'is OK'.


--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcPFAAAoJEBQN5MwUoCm2VM0P/29U9hCYiJOfMkZ9wdtFY9vk
54nNBXdRj1mhq0tI07pd/7tr0RhTKRpwrZQRFNVqUw4L+zbmD8QQ2UTvUdPni3bX
EK4xLwByL0b1C6DRYDNTWq9UA0WfR+IM9khYm8yQuTwzkqwCgQynBoprZA/8txuW
QgUt/40iWP+ZDerOlN3c+5t+oOypOZoI4YTUNtnEdswoVAIs9rO5mTS2nRm0D8kW
2s9v9Y7rVXWWmpUkAHvawy9zc0yN2EXAiPhPcj3x9OJNrcrsbAc4q0a6b4TliF3S
1nt3+CjtxQBb1a0SgTvPBhx747b2arO59xc1JTXmRXp/ZoRn9bAHt2fZ7KILjoQH
QqU1CawTTAdv4xr7/sVc3K+X+x4PICd4NOHDXU8RC2vBbWNpUlnP5c2Px0YRfz8T
QJeXC0KyfIErLB5i52/ZE4tzw8A5yrMTqTux63gLeGIqr9yQYx8jF3LpnY9ziwo3
uZ6xMAUcay7Hqa4jzQpDuH+aVq+m1tKe4OW3QI17V15XEH77Cj1HHE7MllQWQif6
dFDQQPfhLfi884Cdpl0igt9OkQdWsGtF4/vsn1IGFbZN4JTEFY4kj57/oB6Htxqu
xPLlnrWTrqXgCFVAl5O+DNmXIp27/nh7y76vJfR245gL6zFJPQ1bzalUy2N7cIJP
jCDRZqC/AqUFmyZFYjwx
=F8z3
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--

From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Tue, 16 Jul 2013 10:05:03 +0200
Message-ID: <20130716080503.GA3125@lukather>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1373898278-4805-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gregory,

On Mon, Jul 15, 2013 at 04:24:36PM +0200, Gregory CLEMENT wrote:
> The I2C Transaction Generator offloads CPU from managing I2C
> transfer step by step.
>=20
> This feature is currently only available on Armada XP, so usage of
> this mechanism is activated through device tree.
>=20
> Based on the work of Piotr Ziecik and rewrote to use the new way of
> handling multiples i2c messages.
>=20
> Signed-off-by: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 207 +++++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 196 insertions(+), 11 deletions(-)

[...]

> +	/*
> +	 * For controllers embedded in new SoCs activate the
> +	 * Transaction Generator support.
> +	 */
> +	if (of_device_is_compatible(np, "marvell,mv78230-i2c"))
> +		drv_data->offload_enabled =3D true;
> +

Do you have a reason for not adding it to the match table? I mean, you
will introduce a new compatible here, but if that compatible is used
alone, won't probe the driver? That doesn't seem very right to me.

Also, you should probably add it to the bindings documentation.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR5P6vAAoJEBx+YmzsjxAgJD0QAKLp1zIFEKgyVJZygnRhgtQI
Oqd7xO2l3w4S/GGZuDC4IvWfxwYNo/P9MhCY0o43CySOUod1BQ6T+tOHTHgulqDW
TpPhMCRDdrlM0If/NzrboKmgqJ+B3YTHE7NUbvI7TrbeUal9nz1WBYIrJct1A2a/
hvGj4je3hh5oE4wyxPxcVX12Q61VNYx5krIwceQ4gszesWa0sQAve/bEVoL3FmEO
ELZrwf/OufsSCqjHA2ygvB4TBl9+ZinQdnfYzHlo/tl0fj0HTs3u2Z4Mx2oiRHBT
jMjuyauHk+7UptOqLvRkKn06bb6V6QizWZAaxbTgJsig8rlVUBdJYtjXeWHnHXV8
LofX5RKx8Q6Xatec6F9nJn4w/Wft1ILCCGT26v7ZM+hGVJA7RDz5lOwxXPpRvB0S
mVUYTXn9Qocbyup0tSIMXjwuBX2M1UxMzVMRdmD2susgPmHUKZv4d33spBoPTOQM
UxyrVSjP5AU/q0OkLc1cy0mx/EQVxC78k08bvG4Or2HNohUvwDVAbBP8z6UKH2ut
aaNudV24mF9cx2UjKN1Bbpj6BS3+C85Rzk3eoSIiYVtLIuTEm0JRNNd66nS0jqC+
5WbTNmIT8uQZN99i/O45Ak8Dr0X/DVz8HVwu/tH+jntikzuzE9aG5YJE7ROK1uJD
H1JGnq7aS9qBoPQoUGCc
=cxkO
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/5] mv64xxx updates
Date: Tue, 18 Feb 2014 12:29:30 +0100
Message-ID: <20140218112930.GE3142@lukather>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
 <20140213215100.1d714c4b@skate>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140213215100.1d714c4b@skate>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 13, 2014 at 09:51:00PM +0100, Thomas Petazzoni wrote:
> Dear Wolfram Sang,
>=20
> On Thu, 13 Feb 2014 21:36:28 +0100, Wolfram Sang wrote:
> > So, this is a series I came up with trying to fix the issue found by Ke=
vin.
> > Patches 1+2 are hopefully fixing the bug (in theory, I don't have the H=
W).
> > Patches 3-5 are RFC, and if patch 3 actually works (see the CHECKME), t=
hen 4+5
> > are further cleanup possibilities. And there is still more potential, I=
 mainly
> > wanted to give some inspiration and awareness that the driver could nee=
d some
> > more love. Please test at least 1+2, comments to 3-5 very welcome.
> >=20
> > Sorry for the delay, I got distracted by an NMI.
>=20
> I'm adding Maxime Ripard in Cc, since he is the maintainer of the
> Allwinner platform, which also uses this I2C driver. So I guess he
> would like to be notified of such changes in order to test that the
> driver still works for him.

I just gave a try to these patches, on my A31 board with the extra
patches sent previously.

Tested-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTA0QaAAoJEBx+YmzsjxAgEcAQAK2LZwvkQIkO6sbedlLI7o6p
T/pX5P4xal9sTjKweAIufH1uENIeVm7gTrIAW+4jzZxFCrnVQZpq1TvfjagHIyce
MNqx72jh1j7qPf7IC3CBrl8yLU0FkIfBzqkmWByLKX+972+H4HwyQjG14f36+71W
k/feeN5ElAQUHAxy54Ci0wVtenK7FIKDX8qbO97yznKHqoBExQNoPk+4ucwn9jPT
PIflQ87CRN5CkQ9HxXKgTWGAXjwQK8okbkEU6tV0Dpz+PSGrJBI2V0j1focfr/xE
AxTNGqEyCu+77gKgZ6PgkZ3zj31KEnGkBQh0SiWynqmgynZX1PJwHpq2Ug4zbsSk
k1jHtfP29ancmeSAYVBDL0/NWDK0SjeTM8v0gw+pVj8whr0hOK4znpQFzb0oilXf
lBMV7WAIdP/4csoDhiU4i33y0UKaQsAPFkvHZn0Uj7qFhoGHVwYf/Yynu3KT1kg6
K3XK+qI7wg5QHqczL8GJ92JSlutuB7ZGUJVVn+r1t9zfXod0RKBDYl440oFxUuko
VPIweW8/H6obN9pqWXuY1VUvs3dlAFteta6mLAEw0vA1pcEZo2IulG1eZfupBaJQ
qWKUJ9QEt1XzvtBs5sYoEn+oaRzd1V24D8MAo44MlGTqCBgAYeK4vzCGW0UtQT/Z
iU4fv30jztWNYXeuyZEl
=MHYl
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--

From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mv64xxx: Fix timing issue on Armada XP (errata
 FE-8471889)
Date: Fri, 14 Jun 2013 17:24:30 +0200
Message-ID: <20130614152430.GF2929@katana>
References: <1370620140-17177-1-git-send-email-gregory.clement@free-electrons.com>
 <1370620140-17177-2-git-send-email-gregory.clement@free-electrons.com>
 <20130607182500.10593e73@skate>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130607182500.10593e73@skate>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2013 at 06:25:00PM +0200, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
>=20
> On Fri,  7 Jun 2013 17:48:59 +0200, Gregory CLEMENT wrote:
>=20
> > +/*
> > + * 5us delay in order to avoid repeated start
> > + * timing violation on Armada XP SoC.
> > + */
> > +static int mv64xxx_i2c_errata_delay;
>=20
> This should probably be a per-I2C controller variable, i.e in
> mv64xxx_i2c_data.

Yes.

>=20
>=20
> > +	if (!mv64xxx_i2c_errata_delay &&
> > +	    of_machine_is_compatible("marvell,armadaxp"))
> > +		mv64xxx_i2c_errata_delay =3D 1;
>=20
> I am wondering whether it should be done this way, or using a separate
> DT property.

Need to think about it. It is similar to the sda-hold-time issue, I
guess.


--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuzWuAAoJEBQN5MwUoCm2M8cQAJepjpVlRj7NGrxK0gWpZ08C
6X5SNTywQWxOi1yR64huBo2gx/J2ku361l9KWY932HXEDVKNGtEY4zbPHu/DKLSk
MsvbIkxNFKf9TCeJIUVQfQpH4qQt41gP/HIoOeRd8AVzEe3V8LrcGhSjJlv4xojs
rvXt2CdD+oMzrwnaphhG+U6oJTprRLpgcuPjs7KqV5jc3mdnB7e8ivMF+sj8aNUs
ucmtb0V0CGGvUUD9GWE3txRB0MfXgmTYYBKoOQza0I6bkRbkakIHz9xk2b/zBDRC
CyNmR6TU/Twu4k+edrwymFdMc9WUM5w2ntJV0STaTgnqRy9UT3lmPdbhPbpBBK9E
0iyCe/yV4A/Iy3ZvFdMc1h1iKenSPKRFSMoIC7D/YpqMP3eo01WRb3eaOOpPHW4T
Y6zyGPC7F+wkigYOdqOab48otFz6bJCZXMee/jp/zZZnfO05KybP9YTq+4g43+uU
1U/iV2ARR54Z7W4lpObdMAdU6FRDf80IjuNEx58l0EZStHYv85Viqz8pX/LXPKqZ
GP+rDiYcKVy8Trz0lDdDtja2u5KhJh0+BT/K8jmrqWOc2UkIRqnoiqaSLZxkBAIJ
F4JwHgHUf2stMDZvnzGcUbXtNjMiylH3jV5QmUoQ5Rl9z/0oON4xc4SEn9Re7Esq
ZA++QwCyZ2uNAUDMlYXs
=87T6
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--

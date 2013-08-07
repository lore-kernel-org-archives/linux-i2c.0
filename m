From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Wed, 7 Aug 2013 16:35:46 +0200
Message-ID: <20130807143546.GD2978@katana>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather>
 <5200E684.5080003@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5200E684.5080003-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth@gm>
List-Id: linux-i2c@vger.kernel.org


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> But we shouldn't use it alone: we should always use:
> compatible =3D "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>=20
> From my point of view using  "marvell,mv78230-i2c" alone is an error.
>=20
> Wolfram what is your opinion on it?

It is not strictly an error, but risky. If you use an older Kernel
version (or other OS) which only offers "mv64xxx" you will have no
match. Although the driver theoretically could have basic support for
all mv64xxx variants skipping all additional features of later IP
revisions.


--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSAltBAAoJEBQN5MwUoCm23P8P/0Cr0Ez2zMh6nN1gyuR0XjG6
LE57iUNOiqVTH7P7h7pvBqK7c9lqsoN5loeCBDzGalBsgsGbE0dPRn8j7DL7U1CT
F9XqGZpiPxrExxZnapwXXM0uKbknZOcWiUqUvks42EwtfFAiAirj/1t7TkBV/1Rf
hJKIZFfKEAD4jK1bP8HRGj9gK1FS+TfRWd8WggDL2fSYbuClhP8hp88WK4HAp1a2
85/E4QzbzrhKeQlb128qEM1y/o+HHdPkGb86D6Dxnh6cfJADoKMMSCxsGcfO6sBw
VS74QoMO/MT2SPVYIKf5OcUSR/oLBJn3Mv8ot/n9EgeXnS4DYyhKXIyvptkMdqRM
zbPNHKC1ZWXuDXnS5P9UYcqhkycKix+g+WVP/bGeBcx9oven9dGeTiIJUt6SYzl4
Q8PlfxXJn5PikqjAxS17xvhu65bSmVMYOOoOS4GSd0Z4R5jrxOqnp8shSctgkcYR
31N08j3NxyuiPWJGNt7AuFBN82m8SnHXDWRyde5SAJAvDQ+tasbqSnzC2ysmaaYE
LIUdipGM1wmsUKBfSXYLw4nvwgx+0P3HeFM3HP8JS9VMgsH2F6J8VsTC300dSuow
QEHTyaWEXUHcI2/TGs2Bj9QQ/TNpzlT4K8SSWGQyjxW764tl0SYfgZhSAOye/nqp
c5noxxvpkVctmWPA8WYt
=c0Tj
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--

From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c-mv64xxx: Fix timing issue on Armada XP
 (errata FE-8471889)
Date: Wed, 19 Jun 2013 12:24:17 +0200
Message-ID: <20130619102416.GH2950@katana>
References: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
 <1371570024-11613-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371570024-11613-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2013 at 05:40:23PM +0200, Gregory CLEMENT wrote:
> From: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>=20
> All the Armada XP (mv78230, mv78260 and mv78460) have a silicon issue
> in the I2C controller which violate the i2c repeated start
> timing. The I2C standard requires a minimum of 4.7us for the repeated
> start condition whereas the I2C controller of the Armada XP this time
> is 2.9us.
>=20
> So this patch adds a 5us delay for the start case only if the
> mv64xxx_i2c_errata_delay flag is set.

You are correct that this does not need a seperate property since this
is a flaw of this specific controller. So, it needs a new compatible
entry ('mv78230-i2c' for example) and this entry should then have the
workaround enabled.

Thanks,

   Wolfram


--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwYbQAAoJEBQN5MwUoCm2kQUP/jE/YTwnSPubM1CLW5vCJkvB
CVDfBZzCcs2ZcIdeqfQSWLk+bALL0mNOFcgY5ex7JMRcxKTv7I+/ksCx8j/8GRHv
osm/7HDwIdy4aErsaRCNkc9Z0+yaA0CNhlQn6NxIANRv9/S7q2mBdYqvMROclHdS
LZtfDJhqyRBE/g6XubjRM4VjKVUyXxuogEpLxWxoViUZOSkt7oL+K2cGlUyy21tl
fjtYBcuDZ/iXCtXl9KILPdUKMQVR7JsJYcao0LQNUNeWfLDNLyCV3EaHbzzEfQTc
LmZ0cg6X6Ye952/8twN9hul+QpjFqHPut/s8Ow9xiT31riew26BgkadAKqfN2it8
nMWK5tPMRGUMGXS1skiC2IgUO53ZGzbnth11Uq2pDxv7983Uboo/o8fyK/5dvFBP
DTwqxrTrv/pm8GFsNau3HDfk+iSQHENvM1mn+EZahtBmLwkzKg6zYz8YaJRPc/67
GSrtvSDdsFR5ztucuXn/ez4ZmxBoAKEQMaBH0NZaGiYOj3z4ns6IeB0YRsAwMzPA
8pNUL7k4dQcfUJJ0q7TVSG5ReMpC9ZHviDoA1FzLHZ+62+3c4wUz79xOh3xHiCa5
lNmJMNA+QtRjHZQJIIYDSS+04/R3GDIkVuGD7W2XuO2Plucb9JtEakct+aYkeTGe
SFb0nCkyF+CdcStKZLwI
=5O5+
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--

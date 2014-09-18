From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c-core.ko renamed to i2ccore.ko
Date: Thu, 18 Sep 2014 17:10:48 +0200
Message-ID: <20140918150954.GA4420@katana>
References: <1411042678.7338.20.camel@chaos.site>
 <20140918125825.GR10854@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140918125825.GR10854-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2014 at 03:58:57PM +0300, Mika Westerberg wrote:
> On Thu, Sep 18, 2014 at 02:17:58PM +0200, Jean Delvare wrote:
> > Hi guys,
> >=20
> > Sorry for jumping in a bit late, but given that I did not get involved
> > in the discussions that led to this decision, better late than never.
> >=20
> > I almost had an heart attack when noticing that module i2c-core.ko has
> > suddenly been renamed to i2ccore.ko without an hyphen.
> >=20
> > Renaming kernel modules is almost always wrong, in particular subsystem
> > core modules. Such renames have an impact at various levels. We just had
> > to change a configuration file in the openSUSE Factory kernel to adjust
> > that change, and this is how I noticed it. But there can be several
> > other issues, including mkinitrd or equivalent tools, as well as
> > documentation. The extra work and confusion is a high price to pay, and
> > it can easily be avoided.
>=20
> I understand completely your point and I guess this was rather
> inadvertent change.

Yes. Thanks for pointing out, Jean!

>=20
> > So I am kindly asking that you revert this name change before kernel
> > v3.17 final. Rename source files if you really have to, git makes it
> > easy. Or merge the i2c-acpi.c code into i2c-core.c with ifdefs. Or
> > whatever. Just don't rename i2c-core.ko, please.
>=20
> My vote goes for merging i2c-acpi.c back to i2c-core.c with #ifdefs.
>=20
> Tianyu, Wolfram, comments?

Agreed.


--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUGvX2AAoJEBQN5MwUoCm2BDEP/i35Aykbdoy+eUOXotpP+dvM
NHSY81ySWLmSgKrr+j0NVaNxl3qKLDaU5LytU9Ta6tMPcQX49W6Y8axd9NPH26UO
SK1YLPTQq1nkDWujC+XmocFdt79croi0T9HaN372RsYVdc5F7zKSGNXFZaMUj3gH
9LEtG+/GqjzdKMVKiHdIc1XJlSJlxHNOV5gBrul5NgcXVvvuk/9Kof6nFSVAxbR/
FCar/U+3koIiPiB4Ai9JTcSqrfJLBBCUWgJ5JMPk5tnL27UnfTUqt8jLrOTv3d34
Rcv8UhRq/p+6ReD0ry1EKt0uQKiN5CosxzkrDtnMwZSEnyOopQnowMF31tbbgp0/
bUILFhqsYCxbSlzWUUyfaSYJ+g6E3mMPwNtjlyImCkBSktSYqHx4/vF5cD5aOuSR
BIsj3e9siL1gxf33G5enKQ1tDfhHdp8gZaqggtw8bdv4HX69QRw8Cvtf6PsKJ6Jq
QdZDbK3WAY0ditzCydbTH6JUxiMA5rQy/DKagBw/rnLuznxrnTpb6ilQYUODrJ9w
NkLiZ15t7bRrWNYnz67ryNyckvp9+J0NLi2/IpCRQdf0t1jFF9Yp2WT9Y1ByvKyq
68Hv2d0QHa6AnZ5rPAu+FNkDgYIJTOzmGjO6c3UjULsNx3B2w+hntO5EZv0ekb1Z
XCKlAYZy9Hx0XbsKmlZz
=ORtE
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

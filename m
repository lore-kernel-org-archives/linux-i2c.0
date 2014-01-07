From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] ARM: mvebu: Add quirk for i2c
Date: Wed, 8 Jan 2014 00:06:10 +0100
Message-ID: <20140107230610.GB2592@katana>
References: <1389112504-9931-1-git-send-email-gregory.clement@free-electrons.com>
 <1389112504-9931-3-git-send-email-gregory.clement@free-electrons.com>
 <20140107183853.GE4227@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140107183853.GE4227@obsidianresearch.com>
Sender: stable-owner@vger.kernel.org
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 11:38:53AM -0700, Jason Gunthorpe wrote:
> On Tue, Jan 07, 2014 at 05:35:03PM +0100, Gregory CLEMENT wrote:
> > +static struct property i2c_offload_broken =3D {
> > +	.name =3D "offload-broken",
> > +};
> > +
> > +static void __init i2c_quirk(void)
> > +{
> > +	struct device_node *np;
> > +	u32 dev, rev;
> > +
> > +	/*
> > +	 * Only revisons more recent than A0 support the offload
> > +	 * mechanism. We can exit only if we are sure that we can
> > +	 * get the SoC revision and it is more recent than A0.
> > +	 */
> > +	if (mvebu_get_soc_id(&rev, &dev) =3D=3D 0 && dev > MV78XX0_A0_REV)
> > +		return;
> > +
> > +	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c")
> > +		of_add_property(np, &i2c_offload_broken);
>=20
> I like this approach.

Sorry, but I don't.

> However, when I first read this I thought it should be a -a0 specific
> compatible string, not a 'offload-broken' property - any idea what the
> DT consensus is here? I've seen both approach in use ..

I prefer the replacement of the compatible string. If it should really
be a seperate property, then it should be a vendor specific property. It
is not generic, at all.


--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzIhiAAoJEBQN5MwUoCm24oMQALKaX7ZWRSw3vvT4S+oG2zXA
DhCC31oUODLEk8SznY5MvQdcUT3nWlOuCLa9RFg2VliLBPnddvEs4aJ5OR544yFA
KXoni0g1319yTJ0XiyahsO483YusOD1ai//6hSUmhYL3OcMxjHJxNhWDa1mNj+5n
nilrS5LlNz3Ajc9/eAWZg6foy5FuK2v2P9WOnwDViZZtdiYVHka3VrxwkSvY+UWu
IPCJYtMzgRnzvqqSGwj5xIEnmkFv9sL9A4sPPHByTTGk3WI1ONKESr2tgAJNkQs4
53SIx7zIwlnVE1a/QMrDsM7y9ki3SvfsNY6LTslVA8z+CGRpStTN+pTdq3vgTfvV
wEfXM/jvEMyJxygrlmRJ/afk6jsJ17uHpkl/YOGOdCurW3ZyO+IWt0+Vu1UTmIWc
xIU4pQt5aj69lraWdR9ph96cKZwYs5Y1CBFdUTsKp/9DDCPXppd4g1unqqAAOE6D
SC3FS6JNQfgbPDk9PXcDqh3xG0SZyWW7bMe7vShlrQom+DnNLGtElOwxa46W6Qra
3qYsfPDNrX1dl5sVkU76GPcLmnStKXEed7vDY4k+ThYDcVZCgQT2EZrE21wd7Ojv
C620+XUwKkntr67fSAIZ+0Q9og3ZIga7RLNmNNT+Pr3vKa6+yZjZrVlIfoKVOiJ/
NNM0pEn5JLAOdX5LDof6
=EX3S
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--

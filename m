From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: riic: remove fixed clock restriction
Date: Fri, 13 Oct 2017 20:56:34 +0200
Message-ID: <20171013185633.lakiw4cu5o22cwjf@ninjato>
References: <20170929171637.121262-1-chris.brandt@renesas.com>
 <SG2PR06MB11656505D83C3D552B2CAC2D8A4A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bwea6al3qep7ue4c"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11656505D83C3D552B2CAC2D8A4A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--bwea6al3qep7ue4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 03:20:29PM +0000, Chris Brandt wrote:
> On Friday, September 29, 2017, Chris Brandt wrote:
> > Most systems with this i2c are going to have a clock of either 33.3MHz =
or
> > 32MHz. That 4% difference is not reason enough to warrant that the driv=
er
> > to completely fail.
> >=20
> > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> > ---
> > v2:
> >  * simplified error message.
> > ---
>=20
> What ever happened to this patch?
> Was there any objection?

In deed, I'd prefer to limit the settings to the two known frequencies.
We shouldn't use the settings if someone is using it with e.g. 16MHz?

Of course, my most favorite option would be implementing the formula
instead of fixed settings, but I am not forcing that on you.


--bwea6al3qep7ue4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhDGEACgkQFA3kzBSg
KbaqixAAjE1TnemRJ29cKe44+kuu9x8af8nMMMwH/giZOVOaAQ/x1cFxxBIdW4/O
Mc07g47VjtCZMSnWP4A0rR0oMtasRemBm+o4x7+tlp7lP55cY+yIEFU/E3+MXNz6
gQQToTCbf+I4ufb5f4WHT+d01M0UTjiIuZ8WgDeMxZXCmTfNHHBnlh9rwozMpVIO
pjOTcpRjCNfkUDeaCSSkR1FUHJQG1TqmFMc9UkvStQqFD5oQkco830GZdUsqtQKx
BC5+XZcGCVjlcUVv7sWoZVUI6lHx0NYvRfWXhpCe0jSZr+FW7SBhYfznHPn6bF3L
wVqfzhU7Ndjf+jWbD5fqFWVzAnA0cyuTWu44SaLvSRLOKMr/xkVr058pKkSpM4B4
JG4I37hnWEB3kFCM2jKGvDHoI7V+MjBUp0rSs0FnZAZw6gv4lb/B0pLD5LVzud8A
lEj94Qgl2jnC2mlsU8XRybv7Zpy0eRngpI8y46F+c8mBiQgqbtQ1/D2tnZTI5vDH
IDK8cBQ1DlOix43zuSZOsb+oK9XhTQjVm9WgBczJTg1zUErAgqJHqBTY/e7OJaM1
09TfbQaBoPMDntGkBzCu9kmoKc3jSh+NYatdvk5YeKs88NOrYPm31OzQ24IEHjn2
aE5IHJLoYIGdqxrNM8LG9VZiUWBgJzbktrDXcbIdLScduAJiYQc=
=aUCw
-----END PGP SIGNATURE-----

--bwea6al3qep7ue4c--

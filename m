From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: riic: remove clock and frequency restrictions
Date: Wed, 18 Oct 2017 18:44:12 +0200
Message-ID: <20171018164412.agmhbvxky5rzz5wt@ninjato>
References: <20171018140459.104351-1-chris.brandt@renesas.com>
 <20171018163725.ik6ieofpd6ehilbo@ninjato>
 <SG2PR06MB1165C76C6B35511B21CC70668A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3nre6rbnha2cqel"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:57761 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdJRQoN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 18 Oct 2017 12:44:13 -0400
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165C76C6B35511B21CC70668A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>


--f3nre6rbnha2cqel
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 04:41:57PM +0000, Chris Brandt wrote:
> On Wednesday, October 18, 2017 1, Wolfram Sang wrote:
> > > +	brl -=3D t->scl_fall_ns / (1000000000/rate);
> > > +	brh -=3D t->scl_rise_ns / (1000000000/rate);
> >=20
> > However you solve the precision issue, please take care about the "space
> > around operators" rule afterwards. checkpatch should help you there.
>=20
> OK.
>=20
> I ran checkpatch and fixed everything it found, but it didn't flag that o=
ne.
>=20
>=20
> $ scripts/checkpatch.pl z_patches/riic/S4V1/*
> total: 0 errors, 0 warnings, 169 lines checked

I see. Yes, I recall that it missed it once for me, too.


--f3nre6rbnha2cqel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnnhNsACgkQFA3kzBSg
Kba3Ag//T8czEcUUnrXt9+OZR7J4bAGzZ3ak/dMXBFslqJiwkrU8RxjAGhzRA5y3
0+eI+h6vA49PkvGibzEOrBZLfB93Xndguxgnrl6sEG3wS6xDu5dYUnqKa3nJ+rF+
PkgZ6Byt3fsRvMZ7TRQC29+Yafu56RywJYWYpZcxIOg/xwVffHG1l7pQkQNlGwxe
Ztmwu20NqCXK7dQvJr7UK784IRTpYASsSGx6WLpTOPmtyWcFWTuaigrMLCb7cs1P
mPmgfKrHIJYVvCjxlZRgto+KuwjgHvcLnn5Dys8auksTHFsWgIxv9RX2D2WggT85
em4n6DxWmMSGTw26JbsnvNjfO9uPK2fJGgo9gMFp0gkqE02arginVF8Ny9GV0SJv
AI8bmK86oCB/IJgdcamd3wRfD5xZWFe/NZ6A6cMDsdm3zz32dohS89FCYZrveIFq
G6/mHooWwByuoTM1QhytuMX8j9b5nH4KKXQjQ2RwQ6veKn1VwtxrHHCMRV/dD1i0
997urrhgOb1A4ufiCViCVI6GphhhQaeBhcxZcwNaJMmc0j/yEJi7S/CaUVbvO4+0
F28Fj9yxgm54XXNjARSv3LdNxZi2DJd1KxUQwaIFCQAwmn9hbKM4O+v6rMn70udt
Wh/CdK/YlxIVTarboYn/HHUEDoVz5xy/s0aYAw+GV7Ta9RscEc0=
=ZmS9
-----END PGP SIGNATURE-----

--f3nre6rbnha2cqel--

From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Tue, 30 Sep 2014 07:57:50 +0200
Message-ID: <20140930055750.GA1325@katana>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140920093633.GG1612@katana>
 <20140922091207.GJ1786@lahna.fi.intel.com>
 <20140929212449.GC2758@katana>
 <20140930051956.GL1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140930051956.GL1786-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > 1) They do not apply cleanly on top of other i2c-designware changes I
> > applied (check i2c/for-next I just pushed out). The conflicts might not
> > be hard, but they were not trivial enough for me to do them inbetween
> > other things. I'd be very happy about a repost on top of i2c/for-next.
>=20
> OK, I'll do that.

Great, much appreciated!

> > 2) "pretty much have" is not so convincing to me. That is such a generic
> > core, it probably has enough out-of-tree users as well.
>=20
> I wasn't aware that we care about out-of-tree users.

This is one example coming from a feeling that we should at least try to
make this change having less impact.

> > And with all these ACPI regressions from this cycle, I am very
> > cautious right now.  Brainstorming: What about "depends on (ACPI &&
> > COMMON_CLK) || !ACPI"?
>=20
> Understood. I'll try the above.

Cool, thanks!


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKkZeAAoJEBQN5MwUoCm2iNQQAIDtqUsL02uuVkIyOVhpnBje
I5JM2VAZEutkzd8I8nus60GQWx1aTwzrglrSVBGIuL2nSJsABMGZrCFgKGa04g2r
7pwIklWMbgoXSfgoO+MRpZmVP26pZmliEH/kZA65n0I9f3sVfnT/9c3qcwAppclN
61vBB72tFFki6Scy9Bk2IJz09UHmZewdavmhMgz3C6W8gLCJ4A3bwyon7VB9Qy1j
dtxzJjC22lh9agCz9w4u2wlOUNk5T7e+F2MUXNNGMPXGBJdJRaRmoKjFGVTK2IN4
Gla9b2t7vJ8y9g4GliP7gi+j5Xt6ktSKB7VYPFwVIn90oqPCS/ObRd5kCPAa1Whk
SzB0qqBUyMF1r4xZgQMS7s7A+Jg6T47ykSfeGF2Ge0oUVx4ftR8Uj1dgBPAId2v9
0TJsCSnsdOmpaxWUTyRJoJArr7r9e9zXPo88bNpqjkz9iPuuDLsz3GhvXTIJeNeF
3hoVD3oaqQBU3Sd1ix/c4c9SpEtGxolukvkr4SDQ8xwsYbXzYfvWycjSQ6W6ixHF
2WLUneVfI5zKmxc56+2HGQMflV/b+Wfxc69yXJOBUOxK/rtgj+BQbdHpTLOdfjoa
I8E4OQqB+NvUhcnyW0XMLdGIzDe26C5zEBwMmqkGW5pIwbaHpInd6HzVVDNZGbXL
DK6JXqJ8ZMH/FGz8NMnX
=Eewo
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

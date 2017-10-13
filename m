From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: riic: remove fixed clock restriction
Date: Fri, 13 Oct 2017 23:51:09 +0200
Message-ID: <20171013215109.l35j652amscnrsfe@ninjato>
References: <20170929171637.121262-1-chris.brandt@renesas.com>
 <SG2PR06MB11656505D83C3D552B2CAC2D8A4A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171013185633.lakiw4cu5o22cwjf@ninjato>
 <SG2PR06MB11658FE2DCDC2A50FA5ED7258A480@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="76dla3w63pp2a7qz"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11658FE2DCDC2A50FA5ED7258A480@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--76dla3w63pp2a7qz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

> How about a range of -4% to +2% ?

I am fine with a range in general, but I don't like +x% because we should n=
ever
be faster than requested. Clients may have problems with that.

> Technically, to do it right, to calculate the ACTUAL I2C baud rate, you=
=20
> have to take into effect the load resistance and capacitance of the=20
> lines in order to factor in the rise and fall times correctly. Of course=
=20

We have those generic bindings upstream:

- i2c-scl-falling-time-ns
        Number of nanoseconds the SCL signal takes to fall; t(f) in the I2C
        specification.

- i2c-scl-internal-delay-ns
        Number of nanoseconds the IP core additionally needs to setup SCL.

- i2c-scl-rising-time-ns
        Number of nanoseconds the SCL signal takes to rise; t(r) in the I2C
        specification.

- i2c-sda-falling-time-ns
        Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
        specification.

So far, that was all that is needed, however...

> Just live with the fact that the speed might be off by 4%.

=2E.. as I said before, I won't force it on you for the frequencies you wan=
t to
support.

Regards,

   Wolfram


--76dla3w63pp2a7qz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnhNU0ACgkQFA3kzBSg
KbYlDQ//ZCXJ/eak9SC3zPg4tPBDatqoZtSmalFz8LqPHZPMUd+KpEsdtSkUnDO7
WsTIor51WWeOJJaBMdlbTqp+g0kwlmA67X9By54VuVJ7xiCTGh4/fI+2sHBSQEv4
c3Re2cmrc8ZFErOuZyPZzrk8unkc/y7L0WL1cXHFfQrmRcSvFimXPu/ImleKMKKz
NKTn7IqgV71qvR5cTxaI50UmfbW1dkF2GM6sT1CAjoRf1xBcDmaffg3dTrnsj4is
RWYO1dq0uAJKGFz62FNlGo7ulafkLHGcIhFHdAJ0gMMkqBjCIN2/1w/9jxaTjnD/
AOAjlTjXKwZhdZB/E+Z4AXvR4KstpoI5H6IoR8nN9dfISBpNAYn9a2+Kes2lG6ED
KM+NZFC9xovBQJOW4/GKXM2uB8Eadu2RGCoP/mpRD2ufzIpIHSqcxt6WaYipj3mI
IIEjM6/DZsflBswQz5TkvGWtDNnT7H9t0dAALfnMzxmvnpKl+w1MSbTLVlmnKC5i
tfftPFlh7sXrOOewbBK7BLszGkP92LO6HQA5Rehu99dTI1QgXA1p8zGB1PXaEGCR
Qp6vOPs2N0NhIRG3MkSRhMzK8EFihnNcdJwDK1w8RR1YGm59LKiW68FcWEFKwvfj
mRvTfRay7kIBZ0M7zoHlhjMnQ44bhEXfGvd0FzvOOmkPe/JNbpY=
=QmTK
-----END PGP SIGNATURE-----

--76dla3w63pp2a7qz--

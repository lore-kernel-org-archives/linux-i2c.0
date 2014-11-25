From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3] i2c-pxa: add support for SCCB devices
Date: Tue, 25 Nov 2014 15:26:33 +0100
Message-ID: <20141125142633.GE1843@katana>
References: <54711397.9060601@tul.cz>
 <20141123083112.GA1932@katana>
 <54725DE2.9090800@tul.cz>
 <20141124172753.GA25434@katana>
 <54740E1D.9060508@tul.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54740E1D.9060508-qphu/3gb4gc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2014 at 06:05:33AM +0100, Petr Cvek wrote:
> Fixed missing functionality flag I2C_FUNC_NOSTART.
>=20
> Added support for SCCB by implementing I2C_M_IGNORE_NAK and I2C_M_STOP fl=
ag and belonging functionality flag I2C_FUNC_PROTOCOL_MANGLING.
>=20
> Signed-off-by: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>

Applied to for-next, thanks!

Please send new patches as seperate threads, not as a reply to the old
patch.


--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdJGZAAoJEBQN5MwUoCm2G6EP/0KbFPivnNs4O/IN1jFLRDit
GMBnqP8TXqEaQxioLMQ8W8LEX0JxCD6AYGZGvB46H+yJhO374+NsSKusKr4NusSQ
6n4JBp6H+Op6FJFUELCVmM3YWM9eKXYc+8wP+IhMfmefetCtzOZtfVaqMMv6EYFp
jmnIJRyw7OcqYiuq1taO6l1S+Wve1xTFzZ8L7vfx8U3rEmm5pAEKILF9TNlt9GcP
hdlN4lBx5RYdFC30eBQXOsZkN+5+y+44zPeiASPeBA2iDa4G0vgUKaz1PUmws6hY
6YmbxuHvH346u9a2D8YeCLVw/x7vm/EB4FQO12al2qjqKw6lcvThGezCqC/pKe9+
gosLAZvGMOYhps5pxu2QkSsOiZ+BKkfFsihDMsmPcMUAS3L5kx0xn7dkU8pENuwn
PrmYqBexIDQ4SMCxYT9CzBQJqu7KCKwNisfll13gJOh6aiN+kc74TnQL9jv5wZsU
fNskOS0pdno8fk2HTVhSMC4s4IRnaAPvBexOpVVtibq1EC0kgB36fJqJZ/ccNt+B
8eoUbVQ/90JbHggtR/weRdgMjC5erJC3HJrYMRVBKqi5JLbzgMXsvVTAaXpu/XWw
9TQLE5S48F2zsM9WW1y0l2jg88b2rlwHBmUrPWBSa1963KmyrLserlp7semftaW5
JyZ0qn8bJA8Mb8/qW4GU
=Iv4s
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--

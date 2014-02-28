From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add message transfer tracepoints for SMBUS
Date: Fri, 28 Feb 2014 22:21:35 +0100
Message-ID: <20140228212134.GC2517@katana>
References: <20140218205418.GH18768@katana>
 <20140109214954.25590.73057.stgit@warthog.procyon.org.uk>
 <20140109215002.25590.51609.stgit@warthog.procyon.org.uk>
 <11165.1393507178@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <11165.1393507178-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Also, the I2C tracing has first 'f' then 'a', that should be consistent,
> > too.
>=20
> Flags first or address first?  Do you have a preference (for both)?

I'd say address first, yet no strong preference.

> > Can we have something like this for 'flags'?
>=20
> There's a __print_flags() which should work.  One thing I'm concerned abo=
ut
> there is how do we handle more flags being added - does that count as an =
ABI
> break if the printed format changes?

Not sure, I mean, this is debug output, no?

> SMBus flags are basically the same as I2C flags, right?

Basically, yes.

Thanks,

   Wolfram


--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTEP3dAAoJEBQN5MwUoCm2n6kP/RTSBe8QE3nBjDQIl5D3Dvsq
3UJRi1j657xk1PzIRwDxlexhKoqamnB/d2D13deOJVM52CCcvGa7XF5B64e2NNwl
DoaiCCGmzLSJAUUaFnnKGC+5LvBLspnSADHHgruRUiXTmITkkmpTIcaDKFkCKbJl
wKpyC/UXv4KAqdjzhVoDkd/+IWAMHrBdf0LfysB8C3b/+34mIMYZa+s8rrsBcpq+
HM4ABbI0s7rtfcf0QSGq34o5DT1IRsKV31+6AoxF+jkGAK+PDRaK5MNZLTLP9jEA
xVAYQn1gKA+79coHcxadD3i+OuHwBp+SKVnILtJSktVJmRfusAJcZ+qDSloMCKrt
st0V0KWOoCOA6TcsKMZo03OT8ONrivMmQaoI883o5VCjpFxxmIOtmy1eVoRRdrUB
gNNDd/xNnaZnW0+ihwmhfMCTJPnC87QuRVs61ABwMV/ekqJWTL9f0N2Wjb1+eFog
bs9Hz4H2d5vk9JWDXglyEU+I7Q57k1CaHaSXnEWwozeY5N7GqSDbJ+KdMf3faIsw
v2/MAhrKGlbXEKGCKfZJC9SOJCaumsbhgqca3p844JBSDkLi7HWTnfXCUqBD1rrV
KMm5gZmOgx2ER0chgrkfTQyzhwOTnLpC0Dep4iosc8bkFLukV0rO+3UbSCnqvCjY
uBogJ8qKXTFhAmLbJZq+
=IYV6
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--

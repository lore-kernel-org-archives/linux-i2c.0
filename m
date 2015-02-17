From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: linux-next: Tree for Feb 17 (i2c-designware-baytrail.c)
Date: Tue, 17 Feb 2015 20:11:58 +0100
Message-ID: <20150217191153.GA1616@katana>
References: <20150217160221.1a15340e@canb.auug.org.au>
 <54E38840.5060306@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E38840.5060306@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Randy,

thanks for the report!

> I suppose someone could make that:
>=20
> 	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=3Dy && ACPI
>=20
> or even make I2C_DESIGNWARE_BAYTRAIL be a tristate symbol.

I'll wait a day for input from David what he prefers, because I don't
own/know this platform. If there is no response, I'll apply the first
solution.

   Wolfram


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU45J5AAoJEBQN5MwUoCm2iSQP/R7dq5U+fxSg5wWD50KNMnTI
3chwTowlQMIbYivbPoMLTbhTLhNGAZ1Qb9EDbytEmdUFhkVSdo2uYdm1FbQ8JDX6
pU6P8pgG7GqqLadxOyHO0vl6jbxnR+j3ojYM0i/jBZKjFt1xN6QzUHGu5Px8Uls3
wmyfHHQMQ0bP3cfWdvUERqy80ekytaxDWQEZiDLAIiHlXHvjhbGjQtSlzid1jYo7
AXycstqSiU0uTksELt0JbkJg6iecZytqfvRVC6mlA9r7guZwAbF1eCYZNQogAz+d
3YY0gcomm7eYN+uOTv9kmSrEBwc2vba5/13k4poXvxQ20MHmOHBua9ed1FTieILI
/eLrhfRnFiYwCkkLcgJ/Nyd876P5shzSK2ttr5khgSuPCGXnZENZIajynpyTPrRs
ggwsf3o77j5X1pAy9Y4ailbrmd1VGe05TUsBNLVC3286n4ESGYHSsZ8E95yj5XxW
FCNlLxuR0S/2vef6hyLcAWb87lBdesGVSfZzdaW49TvNJeGbTQSeHZxVt7UmfzXS
RMkGGKzZVuTJgGc6OlRN61VlYjRknVGXGi5we4ISIp/Uh3GyNrFvuxofEh32+r3N
XK+/pXO+UHWGV4XK4FCbabgweXfrm5B+e4u2wKPKLudKPUMhsehtOVI+0j28+Z8h
xV9HXkf0RNf5REATbdYO
=KJWG
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

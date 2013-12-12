From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c-mux: Inherit retry count and timeout from parent
 for muxed bus.
Date: Thu, 12 Dec 2013 22:40:33 +0100
Message-ID: <20131212214033.GF19381@katana>
References: <1386499701-5522-2-git-send-email-eliedebrauwer@gmail.com>
 <1386614908-4872-1-git-send-email-eliedebrauwer@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1386614908-4872-1-git-send-email-eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 07:48:28PM +0100, Elie De Brauwer wrote:
> If a muxed i2c bus gets created the default retry count and
> timeout of the muxed bus is zero. Hence it it possible that you
> end up with a situation where the parent controller sets a default
> retry count and timeout which gets applied and used while the muxed
> bus (using the same controller) has a default retry count of zero
> and a default timeout of 1s (set in i2c_add_adapter()). This can be
> solved by initializing the retry count and timeout of the muxed
> bus with the values used by the the parent at creation time.
>=20
> Signed-off-by: Elie De Brauwer <eliedebrauwer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-current, thanks, good catch!


--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSqi1RAAoJEBQN5MwUoCm2ppMP/1rbCk1s3wD2pFl20TKgEgry
KLoTmKxH96li3NqkaShFBNOyr+pUNIh451lQhCPWzRzkEMSBxKTtTZsuKps9jn7l
5Tch8tUmzIXdeYBhvV31ghuWqRhNkAQUQD4fY9kCMJj5JH6UQOUdchXTA1p1/gvT
BpBh2Sr2pqvuatWQGguBBdy5OSZUCYr/fQIMRrf1dYMEvSWMPaROrjVkze5UfcQE
51It3r1FSbGciC5YnfxMiNE7QpaXjue1jgrxVCFr5+cOI0fjksyso+SSBPBzIN37
oegsW1lIJsajKfXWJ3i2SYle5FB4KSHd9iLkLYSoMwadeU4X6BgzSMoJKPmraBfs
8cY47TtyZ+A1HSzq/rFOsjlpNZIX1Tt4/fE5VFNajYQWjDoFgjma4J1p7RsU1AHe
G98Rd4nVmwWbJ6antAYRv4ygvHn+p2AqWRDWIBE8wbUBUkUJvwu45wPHNgnaJKnd
kCWI2OQmolXiSxihAoqdz/cY2sA7CSeuZ61mz84uxYct5E7Njw0yUGP2fbBdEXVS
r0RGGDIzKHYqdNKtLDTpUN/QTQxNZHrv7/mlPJ9felvPx+q3RyGxH4Gw0w/P8YBi
19X+yfgH1nIleeknmB9rE83DOKoWlQPAFdIdnsEvrqBKnTqv3hjWoeicHl0l2n/D
qZtfMBOBtuGzF9SqHCnf
=pBUF
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--

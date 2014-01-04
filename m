From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 01/13] i2c: bcm2835: Use devm_request_irq()
Date: Sat, 4 Jan 2014 22:06:45 +0100
Message-ID: <20140104210645.GA3150@katana>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <001d01cefaf3$b743e4c0$25cbae40$%han@samsung.com>
 <52B10691.2010105@wwwdotorg.org>
 <000601cefba7$d13450e0$739cf2a0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <000601cefba7$d13450e0$739cf2a0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: 'Stephen Warren' <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> If there is possible side effect, the patch should not be
> merged.
>=20
> Wolfram Sang,
> Please ignore this patch. Thank you.

Even more so, I will ignore this series unless there is someone having
actually tested the patch on real HW. Thanks for your effort, yet I need
to be sure it really works on the actual HW.


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSyHflAAoJEBQN5MwUoCm2Uv4P/1JsfFLmmgz0/J79Riheabiz
Ua5hfW648ZGQczEw3qofR5mEJh+4bQ1/00l7saucGggYPqanCuFJgDknWVFWb63x
vyKOmO4fW+9Tlrgg/uPQsm40ElrHWF7RwG4DKg2AzbkK2LxbmuNM/8cOJoJ4ouUc
EwklGrtK5fvs4M0RgfDVry8txqDCjBSXTcMZHw99gwD1iJjWKsTqgYDHGOFkLFDG
4eJhJ0rEW7wC9ENTPYwI85KQ5frhtHUZDupQ50WfWRKFCai8786eztChLQzVTzsB
09G0KhnwYw/8uJXJLPUiybHCjX08fz+cvcEb5QazvS6UsLMW8oAQ3jY7qqsWnWdH
O9hTtTBYzVaTb4PRK4QT5rJi9/OCPNFIHEbyygfYSmwQGTuxzP6FKYRaIN9sTecG
7+uvjgRJeY5EfYu5hNm+1gd/bWVGwwGWvXlKI8tzEwu4Cs2rD8QOeLg6QAhUhPbO
sXPnc98EAmw/0SK540aEZRPbZDAYEbkg3Yu6VydOoZbeCBNDSPZCdOW+u8aAHzGL
NEFGOgkjeiaSRHjDHRFU6qb/oE6SkW/R+oKRh8/utdRZB4ONHenW9EiR00OzWpbW
JWulNFJGxYMqnxo32LFI7k9ZhW9omGaZ0rMeRdxnteRVGanmUhDEyS8BKiND29tt
VZGtzwpKHFon+4xzG1+b
=Fkis
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

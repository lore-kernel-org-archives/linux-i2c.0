From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: xgene-slimpro: Fix missing mbox_free_channel call
 in probe error path
Date: Thu, 9 Jul 2015 22:14:22 +0200
Message-ID: <20150709201422.GN4744@katana>
References: <1435633726.14315.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wmhq21yAGFMoSpeN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435633726.14315.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Cc: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wmhq21yAGFMoSpeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2015 at 11:08:46AM +0800, Axel Lin wrote:
> Free requested mailbox channel before return error.
>=20
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Applied to for-next, thanks!


--wmhq21yAGFMoSpeN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVntYeAAoJEBQN5MwUoCm2tGMQALSO6MMkgfvvAh0S+1vjdoVo
oo6OWhrwqFu1vY0aFfeGK2udIKBShXzRMhKBu2FPZINymdShRmnUiL1JTcIedp0R
Hjdl2Piecpzm9HnFWYvIknRRz7J+QAJhfzTglpANPJOJMSk+A0JBB6anmxFDX/z3
iBZeaGcD2VOmHF+V4sEiFNeDoWyYEL+qaK5T5MkAU2JAFq0hKWjDpzJK11WyyzAG
3HZiOGMjOxQo5FENN+h9ayPRsN4z89dGUL7lzu/3jnZa+8ng5XApVYB31ce7GECw
+v0oD1OHB8xDK+/f3upTKRz4QSnITEhKM2kbOQIBNLA9sAc20avvdONiLpl5tY3Z
fLikRZ+6J/HPdarBKFoY3JRXc7+tG2rEsCFp7Wav+tx5/QGf3vHyoPSGCayxpxeb
3VX3cv4vkBnO+fFO2fA+Vx0hvzXlwa52LVvv62uHGQEu9G37ZR5Yai5bA1SStbKZ
yuoom145VQoVu2km+4xn+4sz32XbbIwAw6eGJYRtjRUVJqU49TjuVkz2HZdzse79
eowJu9qUBuTp2S++/S0XhDq//rW8cwFr2LaGhdJs/NIiXHfhz1EjpgYqnonKmyVH
DP8jVZ5E6DUb69u1rjyumuMQzG+gk/08s9JYR+HF0vlwy91FFKh/blTZKGQtgoBq
3bCrEoeaoeTTjWTUAuPU
=VKIA
-----END PGP SIGNATURE-----

--wmhq21yAGFMoSpeN--

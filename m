From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: elektor: Utilize the module_isa_driver macro
Date: Sun, 19 Jun 2016 19:46:48 +0200
Message-ID: <20160619174648.GI2933@tetsubishi>
References: <20160531153713.GA31615@sophia>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59207 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbcFSRqx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 19 Jun 2016 13:46:53 -0400
Content-Disposition: inline
In-Reply-To: <20160531153713.GA31615@sophia>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2016 at 11:37:13AM -0400, William Breathitt Gray wrote:
> This driver does not do anything special in module init/exit. This patch
> eliminates the module init/exit boilerplate code by utilizing the
> module_isa_driver macro.
>=20
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Applied to for-next, thanks!


--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZtqHAAoJEBQN5MwUoCm2UAIP/0PUpIJ2JK6HYgx2n+bKmAAV
mOu8t9m4UROiOpb9ik84C3FxyZeJJUfUY1ZmuOQlL6g95DTuq1gSgruUnEnbX7Xg
LMzDGbhk7WUJdF92X3wJeBGD3e2glfgGpqiVRecLVObu3nKWH54p/2Vjh8/E27LE
ht5TQgugUMbFkyuV0LuAcZ8Sq+otkd2fAZqnUUnea/gnGhQYBtf6+01/cNZntrWH
O6j+JRQ2XUG+Wc8kqn7iYe2teopzqhbqPEhp1ZGTxP1cIHwEk7ap7aBHyPAJu8mR
oUZ4dv0IWx2gRbMuzASlFXpXDAt2w5jUDPTIyc5g1ojDHwkwThcU3jke6F/Vvcf5
EEtCTjDDemGxpxk6k2NWXRqU6/K2onY+E0IaoXYButquy+Jw9RIm5f8//GZHm5N+
hdMOuJZCmIWgfqmTjV76tdyJ9uHnQWznGxkmMEOchqYAPNu/ya/bvNnxXH777/jw
mHrTddF3pC7pgJJn7B1f1SG49MldLAaApmGckAx8vCIYc0edNkvFrLGbNGDn4OC3
jWjvnXORgUrB1JdwENeRrCrAo9IwSn1UNyZlYViUVOQG9eXfdeiSiWycYloDEGFv
uk9b/cDAanHwpu1mmpKAFWvNELKEvM2rxAPpKLjN6NLLLbLWgbWgCc44/LzqW55W
Ppps8HcGMPleN+xGun12
=7+yJ
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: zx2967: always use the same device when printing
 errors
Date: Tue, 27 Jun 2017 21:59:01 +0200
Message-ID: <20170627195900.xrjygdinixzlxph4@ninjato>
References: <20170623190530.19614-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zb6omzij3kj4p6q4"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:54169 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753567AbdF0T7D (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 27 Jun 2017 15:59:03 -0400
Content-Disposition: inline
In-Reply-To: <20170623190530.19614-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>


--zb6omzij3kj4p6q4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2017 at 09:05:30PM +0200, Wolfram Sang wrote:
> Let's always use the platform device for dev_* and not sometimes the
> adapter device as well. Also fix this checkpatch check:
>=20
> CHECK: Macro argument 'i2c' may be better as '(i2c)' to avoid precedence =
issues
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--zb6omzij3kj4p6q4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllSuQQACgkQFA3kzBSg
KbampA//Vj5Essj64DSx7e+zpU/SoZDO073EjsI++xDtw6/ANkXjzfH/Pp9SESKd
ElNLz+DjbsW7eVumo2C9Pe8OByT89Cx5MjJ3SxDyFFtHFvRVeU3+tmp6avFR6oPr
kFo3vq5pqFmP3Q9eDOnSpw/YbnfXocjcp8Bmb87SETGhX/Vt33sP6oq4SjsPmm7h
UmYC7gscW/0e/I6flW9LuxNLzXxbUNkJ2jUUKGP8wVd6wqvw5lcAbNs9DuyqoGZa
KXTQXqDcfBQ0u1088uHPMTTDQMP4ggd8lAGsFeNhDJZ8khYG8v9Bmw04KZ3Mwhf5
OewmhUeBxcqQZD55YW0bpUqYoBfsTaMsHZZ9fg/0K6qK/h1HWbObcUToUOdTsx5m
24ekK30c7RA0ESXQsOAjNpKr7QnJtGjvR5OT7rOpnbvjk3EZSuyD51koWHytPTcW
jrRqKA/6DEc9NSQm1Kwy+mTyQjolF8Ib3P1GzVQGQHo/6seliVlWt8ijtbal0GaD
qK8rrJZFXbXyIuf4+8M7P1h+pF0OqWUTzcHD+UVN4eFC4K9ZJzyaP2Ysu3pwxes1
fLcdAkS3xKrd6vBnoKbxsooSnyjJJ4Su12h++tZE/hc30rd03ZmqHWvKYBvBepos
B8CrWrPgCSMqBofA09uahZA+ZAKocT/qPwSvM6fSKFqRVtJfze8=
=CjDY
-----END PGP SIGNATURE-----

--zb6omzij3kj4p6q4--

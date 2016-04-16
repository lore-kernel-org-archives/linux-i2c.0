From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 04/13] eeprom: at24: make locking more
 fine-grained
Date: Sat, 16 Apr 2016 22:56:55 +0200
Message-ID: <20160416205655.GB1522@katana>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
 <1460401049-25459-5-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52682 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbcDPU5A (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Apr 2016 16:57:00 -0400
Content-Disposition: inline
In-Reply-To: <1460401049-25459-5-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, Andrew Lunn <andrew@lunn.ch>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 11:57:20AM -0700, Bartosz Golaszewski wrote:
> The only field in struct at24_data that needs locking in the module
> code is u8 *writebuf. Other data is already protected by i2c core.
>=20
> Rename the lock in at24_data to wrbuf_lock and only use it where
> writebuf is accessed.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Did you run some tests to verify our assumption?


--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEqcXAAoJEBQN5MwUoCm2/dAP/0Pq6SXZZa6XYIFGCWkFVp3z
LhV7cxKgpiizisbDIsKLHNTnzHtE505x2kwxqxKniPyA8WL++T2mmcMzBJHqLJ5i
nFGL/thrfQmql+Jaj9NflWptGfZFAW/TgZrDrXeL7lOjzxdap3vncEkQxpuvrKsU
oF1eI4onjE911lAfs6JWYCqIEU6mmmx6TE70pt+JreywR77hI5ntref+hsr4ZuD5
nM+NAiGlWWSCXwzXDeh3Iv0vwxpn4r5e6TmkEX8z4V/HDyCxYFD6mvNiPbFICfUB
Z984w+M8dKQTaR2CtNikV4yfsAl10cxGaNRVpnABG2LJrSt+ozKHLBRFchq83kqq
cmlgCnn+ns5LAzJL/ioYl/Ypyj5XtgYUF8l2FmNdp55VaCtXKfLOti3YnLwBPgFZ
s6QSYFv5CQoLs+KwSVFUxcbB7KQSr2SDbdpt5UZpLzkZyLCU+YXDtS9tZ0VyIHGC
sFp7XTQlJ/7wOf/vlwh351wMmfMK8OXyjiZa3SDvYRpV/ZcWKAAz5bnoC8Wt7EDZ
ra1GanESKXQpuDTLXFX8lXLbHxE9P4PFys4ENKgraHd0OHPqGyyS5JWHzB1H2nT5
LWQi5keY+mAYva+t+F+CLHuqP4IYP89Ha7puB3S6u0kFeKsbpTatutR4/smIWLzZ
Z268pGeTHk937pVqwhBB
=g9yn
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

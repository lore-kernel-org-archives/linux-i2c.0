From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: at91: support atomic write xfer
Date: Sun, 22 Mar 2020 15:30:04 +0100
Message-ID: <20200322143004.GB1091@ninjato>
References: <55613934b7d14ae4122b648c20351b63b03a1385.1584851536.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55613934b7d14ae4122b648c20351b63b03a1385.1584851536.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dmitry Osipenko <digetx@gmail.com>, Stefan Lengfeld <contact@stefanchrist.eu>, Marco Felsch <m.felsch@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	/* FIXME: only single write request supported to 7-bit addr */

Hmm, this is quite limited. Would it be very hard to support multiple
messages? Or reads? 10 bits don't matter.

> +	if (!dev->pdata->has_alt_cmd)
> +		return -EOPNOTSUPP;

We should handle this in probe(), I think:

	if (dev->pdata->has_alt_cmd)
		at91_twi_algorithm.master_xfer_atomic = at91_twi_xfer_atomic;


--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl53dmgACgkQFA3kzBSg
KbY95g//dGarTg6cS+mlOrvC92nc9FsPDk4ovBNx5QEc5w7VYirESZJCs6+OTJEs
t0zYn9dzEAo1UVyYUzUetdM2Ma88oB40HCF4lS4A1d2sKzmvxX8niF9YUttD290A
A3gZIqr3hio6jeXPzFhaDv7IwpnTDDP4pVgQdVnLZdBPeObTIYNzyM+NKmBAivoG
VFKwRKONuhb1hL29jtqmQeSQCEUWLUKu8d4sEVK72/ONqHUX70M6Is5Xv32nVkb1
nPZkKMnUr3X0oX1Fa6S33Q7vqLx5eHNlUaD8hAcodhTJluiLw+wVKZdmNl99o8Hm
7HtEpGFo2jcyTDejstloWX5iPHcPjXIJgtRGwP3PlVWsgWqhTPolM8r025bjJt5E
FL46Bf656Gfisd6j7xNWQY6JwXw7kzhqPQCbUb0DZddXuYqtuFUswtLBg2/QQ99K
FdykWp76hOHTqCXFW3V6H7jZRW+J98upcsSQFNyHhjO2hYZ48A3yZ/A4W10R0VAe
J0fTuK5xLLi7PZn3Q/e/Z56jgoKdmucqcrE7jfBfW5nXtWIWgdcrJO35yBBDU00C
BGksiCA4Rpi0SHf0UCqqOfu/6bAXGVD9LxPzRc6O+l0qzD6rm7i21ZoXTkOMZQuF
B2TQW2Z/V8bN8zje+tZC6yvjBi5C9osHCeTMOHTIKpEqPhF3zio=
=Upnv
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--

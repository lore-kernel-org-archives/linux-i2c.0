From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C slave support
Date: Mon, 26 Jan 2015 18:45:14 +0100
Message-ID: <20150126174513.GA25317@katana>
References: <20150124210825.521bf923@endymion.delvare>
 <20150126113329.GB1052@katana>
 <20150126171745.3d6d0fec@endymion.delvare>
 <20150126163013.GE13494@katana>
 <20150126180747.07ddacfd@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150126180747.07ddacfd-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Hmm, what about bus drivers with slave mode support must select
> CONFIG_I2C_SLAVE? This solves my problem nicely, and makes no change
> compared to the current situation for people using slave mode.

I like that! Let's do it this way.


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxn0pAAoJEBQN5MwUoCm2UncP/igalwcq4YEsZiG83S+/8w4f
zYrdCh3o1iSWY6dG0Zgljj2sAJ8kwJlxtrEnCQxtwQ+6oywuBwmKsXHqbVEheY1O
GNNzNXdbeXQmmJp0u4wPNTvxgKA+icUa8Miyax8wsx2asl0zR2NYoAcLKx/UPA9M
rwtgiVusKWHzp8OaLkoYBqdCnfraSazK+U/NxNH9/uYG4Bbq4cxmm4N4PATQU9AS
KyPlOK56RfCzX85AAR1qqIgWwH2yEK+QQHfOFCi9gFZSNr96RJ7Tiu5eTRj8iJ0S
SGMYSCMEuoGY9w7eM76QSNGLEt/z9oK8tST0NHI55xLYpB53r++IRbdPw0wrJPRp
mVPMTqncFovdgRrvMziIZhErj40Z7hFQGTHYZpusD4eNnofTJXwjobewdr5vcvI0
RYz9FvZu/lkXRfph8OxdhqsuW1ccN60vkWFAt3Ucn7Avfzw8S2SlAbIwnGBBeDaW
J33Aftf2D5n4dWYHk0rb5fn/V+QqZ5MGhyHfGJ9trkKt7t9YOzBil9ibtlEi7wgq
kd7SWYTjaBs/H3OmCT+CViNqaZAMOnk9Y25gBlTgVBwWeyR9WSrBQrxcod/1CwPR
4ILrtwguComMteV9i+T53nWNDpGFgOtOYaylUydY2LfVSKewwcyAoZYAUbnMY32E
Fi7lIQqN9GPUxKOnoVnG
=c316
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

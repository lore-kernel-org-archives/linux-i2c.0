From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND,3/4] i2c: mpc: fix PORDEVSR2 mask for MPC8533/44
Date: Mon, 15 Jan 2018 19:22:01 +0100
Message-ID: <20180115182201.oz2ii2vrmmrujokd@ninjato>
References: <20171207102003.23496-4-asolokha@kb.kras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gy75m3hkps2mvzo4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207102003.23496-4-asolokha@kb.kras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>
List-Id: linux-i2c@vger.kernel.org


--gy75m3hkps2mvzo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 05:20:02PM +0700, Arseny Solokha wrote:
> According to the reference manuals for the corresponding SoCs, SEC
> frequency ratio configuration is indicated by bit 26 of the POR Device
> Status Register 2. Consequently, SEC_CFG bit should be tested by mask 0x2=
0,
> not 0x80. Testing the wrong bit leads to selection of wrong I2C clock
> prescaler on those SoCs.
>=20
> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>

Applied to for-next, thanks!


--gy75m3hkps2mvzo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc8UkACgkQFA3kzBSg
KbbleQ//cXKZTZ/p/UHPzu8QZH+iLEXLJJOq4YxrfXIqbEH8umyTXx7DFsYMxf3g
asggh9TXjOn/5Bj5c7zmmGEKRWtewR8Cm7MdsVcHreRTVZxtz3UF1zwKaE3c5Lb2
wy8UZYsIUPy0mg0aNZxJlvTSM54wriIjR+UbXbbZCTEZuVl5DIsVhvqTCFP/Jk7r
0QR9z4UvvkF+IHHWcYvc0oB0GaikTlTISzmHj/A5iSQsVDene4ZAXeZLbVL/aY3F
DTlLLQQlhEgOTA1rvjWoGfRy4eKC/zHdUM5DEDFX+2s9aSI0YtjKJQK+rH/nJ1mZ
EMMO66wLiBa8En1kmyZJ3XJLiMXr9ajvjPQaIAYGzchyX+iqp0FbqpICgcK/BaD7
T8BXFLnSOqfDkLc47ZK+KjjbaY45JtpdzoQRGE3d1o++p8OJgBrANQfMg8KuBnpM
h9aoMxSdO/Lo9BgzQvg3bBnJQ7Fj7lXb+nQWDUwruUp8hVSmT+L/XbqkfGeXX4/3
rL+p/JgIBn8vZtuBlD/wJcvzFv5uLMJ6t6nhmSQIceQ6acuUT3BCUd1rPFooljW3
NXqCzcWg0DqNV/JgaaaImPT8qiSWe0RSCvge7oJMzCnJho+Hl/RDRiKFQ7eL5Ywq
kj0UXEGP2Lt2c5ZqtiHTX/JSOr9Zj52pomGl98s6nvlrDCGIkWQ=
=Z5N5
-----END PGP SIGNATURE-----

--gy75m3hkps2mvzo4--

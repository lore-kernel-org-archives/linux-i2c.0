From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: core: squelch error: uninitialized symbol 'ret'
Date: Fri, 5 Oct 2018 19:43:01 +0200
Message-ID: <20181005174301.GA964@kunai>
References: <20181005161826.2455-1-george_davis@mentor.com>
 <20181005162841.wy4uyespwcvffkpc@ninjato>
 <20181005164520.GA2617@gandalf.middle.earth.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005164520.GA2617@gandalf.middle.earth.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "George G. Davis" <ggdavisiv@gmail.com>
Cc: "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "George G. Davis" <george_davis@mentor.com>
List-Id: linux-i2c@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Feel free to ignore if this is a topic already discussed in other
> threads. To be honest, I did not search the mailing list to determine if
> this particular issue was already discussed. =20

Not this particular issue, but in general we usually don't change
working code to silence false positives in code checkers.

But thanks for letting me know this is a false positive!

BTW next time CC Dan Carpenter, he might be interested to fix the issue
in smatch.


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu3oqEACgkQFA3kzBSg
KbY3Og/+N68VQHFdCT2SuhsrVWXy6C0KkdkFSJQ/0iE7E0+5e0bMbiRsu8KPtEIn
PCjKqwmvEAByJFtnlR6BkiVK55LoO3nQHLZO4z/qjdxaia1q6repELIFq10fWnj2
hYXcph6PW5k5TM3cKLSs1agV6EX/No1ps6Z3bLES62EBIwYCpkSh7JJfbDopTTFY
I//iyjH+TO+Xkw8Mr9mMaKN75cW5VdvsGq8mML60ATCwTX/+pPlmz8C2Xim0WQJW
vF2jjA2rqdIzC/fFKeDmXfVnglB42rZyLvritg6IdQhp7Gau2XF5kvQrBGGA83HJ
7o/RD5IKBTaTEXdx7IlIpUhGhqoIhWZj9KCYtgnorixzUXiQxex0g7Uxer8IPtnF
ZHq7LyzhNZgao0ZAAFlu39QMki/AEQsD8RpsEleoq4fjAq60L/H9v+KO1r2misnZ
a/HL8H1CRzzj9x5kPADCLqjBa9yOFla38qdwmwO0heUXh5A8FqKdJtlA2vy3VQ5k
iME8w4J9i7buJhV4vv8BmP8v8Dmh+F3ioa/jOmckjvuE16C1yt+Y4odi4TM6h/y6
IKbvjT2YptycCAyVHJvwyro9Gm0fHojt9wWKFK6ETmRgdnI4noOaxbtT2vxS4MiF
9n79u5K6A8jtUCrKZul3z0Fa2UTaG3aDNyhXcjHEUvWH9LLis1w=
=NpSr
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

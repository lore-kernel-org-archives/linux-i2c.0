From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 5/5] i2c:ocores: checkpatch fixes
Date: Mon, 11 Feb 2019 11:26:50 +0100
Message-ID: <20190211102649.pixedc2d4u3imoud@ninjato>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-6-federico.vaga@cern.ch>
 <fd5b5044-2415-c52c-ecb0-1f0f38267355@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4efbmwoassybo64t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fd5b5044-2415-c52c-ecb0-1f0f38267355@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Federico Vaga <federico.vaga@cern.ch>, Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--4efbmwoassybo64t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >  /* Read and write functions for the GRLIB port of the controller. Regi=
sters are
> >   * 32-bit big endian and the PRELOW and PREHIGH registers are merged i=
nto one
> > - * register. The subsequent registers has their offset decreased accor=
dingly. */
> > + * register. The subsequent registers has their offset decreased accor=
dingly.
> > + */
>=20
> The preferred multi-line comment styles is:
>=20
> /*
>  * Read...
>  * ...accordingly.
>  */
>=20
> So, please fix all issues when you are changing it to conform.

Yes. It is enough to send this updated patch alone; I applied the rest
already.


--4efbmwoassybo64t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhTekACgkQFA3kzBSg
Kbbdng//eA9O2upNhs3JFKhZpfb0tjxpRrw1VUdm9ioWOAaktg7WDvPObb/lu6s4
JQLPtWJ+xHwHBAgLddf2jkgmZ6kz8j3SlCj+bkMnDBs31UbNguIK9rG65n7s9F+8
RTpV0AGQei3V+GDYAFAeiveMuencAXvHbOZdnSc9UeyYgJXauBq3uIu9I1XLDUaQ
T1jfd+QfJ2FMiN70dOIuQU1Xk694e3uYlAJ025XDw/C9UcNq3JWKoJSNeo7AXH+X
iJ2+L+S1/qCeFgWQLmTo3fPMw2w8eciQw3wBbHzB4v+F2y/FrRY5T3R3+5rYmI/Z
GJ569knkL+C9MvDPOYRczksenrJJsre57BQTM0/qZahrF8uJjf76QHHXthVknMJW
2Ca+U8XokTx4vhw/rmlYWzJMuT42d5NlvKo9++thp5s0YhEanSNAsddQxxfKJfLu
LpPMQoFT2f1N2RsfQ1cSlOJWQ4SUCMLKOG52paDD/0xicfmERCw1WHX4aCKOEMxU
lzt/x1GJRQG9RSrh21I70xRtXKG2fYIoqAr8Iipk04xEnmLj+PsIrtSDU5uylk9e
D8fj31o3NMAlG20NsEJmdMUDfo44yN8yVkT4YLH6sTV46we4pRR0ry2H/Ldny3eK
LMUfHl6+Vtbrgtz/XvLEFH7k/MfC1dq6h7F+Hqz4K6qD3SqXs0c=
=hvH8
-----END PGP SIGNATURE-----

--4efbmwoassybo64t--

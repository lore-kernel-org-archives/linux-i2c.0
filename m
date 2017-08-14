From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH RESEND] blackfin: merge the two TWI header files
Date: Mon, 14 Aug 2017 12:20:07 +0200
Message-ID: <20170814102007.pjgekosppqd4latb@ninjato>
References: <20170813142117.3977-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ihrvsiua54l7g22a"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:49069 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbdHNKUL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 14 Aug 2017 06:20:11 -0400
Content-Disposition: inline
In-Reply-To: <20170813142117.3977-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: adi-buildroot-devel@lists.sourceforge.net
Cc: Steven Miao <realmz6@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org


--ihrvsiua54l7g22a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2017 at 04:21:17PM +0200, Wolfram Sang wrote:
> There seems to be no need for separate ones since all users include both
> files anyhow. Merge them because include/linux/i2c is to be deprecated.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>=20
> Reseding, rebased on v4.13-rc4. Now subscribed to the adi-ML as well.
> I'd prefer if this goes via the ADI tree but I can pick it, too, if desir=
ed.

Seeing the BF activity over the last months, it is probably easier if I
pick it?


--ihrvsiua54l7g22a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmReVIACgkQFA3kzBSg
KbYjIw//WAUXdNKm7B+W5hYCEvio83zi52yph897ffryPbXXs4vqg5CKHgQ3c+tg
UEOwfUYy4qcelXEsur/jK6GhcRUZA7DpHDdYbbr6lSBohrbZpoJGYKuHPqyNOEtt
BcRjAuaUX9y0lx0f0cOA1Ed3ye/jmO6NNztA0J8cw+6rXint9Pbqj1kjflg5TJqY
tmRIY79viSWNNoECKJX0PDnSiaytl0uDxqx5Fj7aDRgYYoPvy6/N2YZ8a4gt6gkR
aydHCsLCnQewdmPcC4dFF0WkEcPjvCEGZhaiXq6nq1gUzmmeOD8QPObCnDZhrgD+
OHfmKRC5wOcCAA1Rs1nztTCzHeiVJyCNAgGME4/01lOAlnq6jAPRGVuHSuVxthpu
/bkwx22QoytGY8uuiEQBBaF76yzJKs3keMMCdDZkd8moSWkZ69E1+KxnzThg9xcV
NF7ufpJgfax9hJxGivpGBH/wXFmQ8TD1pimmRsOanbXrtw+Mj4SGRMCXKrKP6BwQ
rrZTEgas3vvgcuu1vdbXxcACs1Bc/WQojoG0txZWQIv/8/gezTrxL+vJx7pkqa4H
7VKiaOZP8eU0lIaesFM3Ogr4Az/Ips/mFHb+VamBYpU2ILVS4/thi22BQXLltHx8
Blsrz02pMgWjraYqZJyV8mkPmmGLRPYzlVQrKD5SDG8MD449Yks=
=+Qk8
-----END PGP SIGNATURE-----

--ihrvsiua54l7g22a--

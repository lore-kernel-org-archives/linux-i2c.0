From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: robotfuzz-osif: Constify osif_table
Date: Thu, 9 Jun 2016 22:44:40 +0200
Message-ID: <20160609204440.GM23522@katana>
References: <1464845328.6532.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B9BE8dkJ1pIKavwa"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:35017 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbcFIUon (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 16:44:43 -0400
Content-Disposition: inline
In-Reply-To: <1464845328.6532.1.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org


--B9BE8dkJ1pIKavwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2016 at 01:28:48PM +0800, Axel Lin wrote:
> osif_table is never modified, so declare it as const.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied to for-next, thanks!


--B9BE8dkJ1pIKavwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWdU3AAoJEBQN5MwUoCm2nXEQAJncraalkM8Ad0wYKQ/SC5Bj
IfgvK3eMhm6iQHdgmDq0wkKyGCuP29hInXX1Bu3RseJHkYkc+R2SXXXJIkbXEJha
lJ+fqMKYaDALOHGiaLJlk8OKdhxJ8Gvawaa7ANuHYbFWoNly7Voui7G/WaMnMudl
mzr4vrSAw9h/zfHcEBByMyXRaN69g4hOYdki6+D2g1FuVKuDFVp6tqzXZkXr1OgB
Yx6AmPqJNacB0f6ihwG0r1AAcEIdLeqbGwRJdoUc0jycr7iZe9MUOBX3YjtzMS6M
dG+jev3MrCGKkuc9sbKbWGD5xlkjUyQ/wY4MGeuOgl9GLtE5PG6d8lmQtur6wj0e
Gv63+/mpQrEYypJK7r2+Pe7zdoEgUDKr7w2z6IGYgJG8KmeZ1LjpPs/4aV2SMJNG
m5TDu0lZ/W6/5aA0Eh+sCu1oXB5y3/fYNOQ/8zxJYVS2otO6wijKRFEel0LtxTq4
0huFYYflQOuiFE+PYcRuvgMA6Hqy3LfNfAXFWNg3oJrqS1EhS/tf5c01YW6qXp9h
txg0BdxmRbVwytbH+JFHiPAK2/TIe9oykSuGXXAUfcmwRQLkjoDY8UX+eMsnRuiQ
zBWgLguxsAkdLhBlUl8Fd20knnGP91QYvuTxorlGRPslCPO+OtBja14aWmvZgybW
8rMgjH2C39Qq2RpEiC3s
=yy2R
-----END PGP SIGNATURE-----

--B9BE8dkJ1pIKavwa--

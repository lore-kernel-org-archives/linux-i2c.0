From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-boardinfo: fix memory leaks on devinfo
Date: Mon, 27 Nov 2017 19:14:52 +0100
Message-ID: <20171127181452.c3cokz2ejqmhazfa@ninjato>
References: <20171122175224.2982-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xox2mrupi7jhr3oy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47922 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751415AbdK0SOy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 13:14:54 -0500
Content-Disposition: inline
In-Reply-To: <20171122175224.2982-1-colin.king@canonical.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org


--xox2mrupi7jhr3oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 05:52:24PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently when an error occurs devinfo is still allocated but is
> unused when the error exit paths break out of the for-loop. Fix
> this by kfree'ing devinfo to avoid the leak.
>=20
> Detected by CoverityScan, CID#1416590 ("Resource Leak")
>=20
> Fixes: 4124c4eba402 ("i2c: allow attaching IRQ resources to i2c_board_inf=
o")
> Fixes: 0daaf99d8424 ("i2c: copy device properties when using i2c_register=
_board_info()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to for-current, thanks!


--xox2mrupi7jhr3oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocVhwACgkQFA3kzBSg
KbZ1kw//R5jyfvLirieP7aBPRD2ZQTsFz6ibx6Oh9cHFz5P74lQ+Ntn/lMJorz7E
baK+NiTcc1AsWE/BwVEClHcttVIYXlxVBWz5ShnBXGmR+NkpYYIjAR9ejRT5Py+M
yy7YX2g8xlLdjltx9YX7hKgphRw0ze8fnniCettJ8Y+dHK0Z+YZsojiFslfYFIFd
6TvqljQiBHVXATcJvtEP5qAfe3Ubcj+sl2JvfqOlNb0Fl5BQowTX9Ktxq+8QcI60
RvmD/XLInJWj7tJo9EvttNvP33dEk+JDt0bNSQ/HYC60zpaAHQcbeK54PC1C1Puw
BnNnzXVnQGbvSNAgrro8rzOnRNoeCGFZ51oitt33XHy1LP+gXtqRTiD9ryUsCUps
GWDIVx2+0UZyM0dxtaiD7ljUNO0jvLbXaeuEmQlnkhomBJB2v2oInULk0a2Qrqmk
RFUVvV4dIgBAoMxX1JR/aXuziYgXNFApbn7lhwK2sRxUCpAQ9jWFNCHzpjfGKrH1
OGPj4KBdDyRBHlt+z7lNDMNTd6cedw0zGShZdOLM5Pu/hE+BqufbJeRK2hrnn8J0
6S6uZOrJTbhR5mTcmJByD73y6iB5Fgp1I5bTiy6z7tFdFP/BYWAljw7G5F0UFTJe
djDQi6pdutGQx5lE8yXzAlTVSy6RqAdgPh5q9LajyBxorn8G0ao=
=HkZO
-----END PGP SIGNATURE-----

--xox2mrupi7jhr3oy--

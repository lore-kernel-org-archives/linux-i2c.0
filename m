From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: retry transfer on transient failure
Date: Sun, 10 Jan 2016 09:25:16 +0100
Message-ID: <20160110082515.GA1526@katana>
References: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59154 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210AbcAJIZ0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 10 Jan 2016 03:25:26 -0500
Content-Disposition: inline
In-Reply-To: <a34c8973420a179cb195ddcfbb29ef1728f32ba3.1450889004.git.baruch@tkos.co.il>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Rolland Chau <zourongrong@gmail.com>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 06:43:24PM +0200, Baruch Siach wrote:
> Set the i2c_adapter retries field to a sensible value. This allows the i2=
c core
> to retry master_xfer() when it returns -EAGAIN. Currently the i2c-designw=
are
> driver returns -EAGAIN only on Tx arbitration failure (DW_IC_TX_ARB_LOST).
>=20
> Reported-by: Rolland Chau <zourongrong@gmail.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied to for-next, thanks!


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkhVrAAoJEBQN5MwUoCm2YJEP/1SLoKTMx8DJrZkFPadG/qft
0g9Qj2393uWgUMLiFFRskFFpCUolQ8n80csP7DA+qiv5Dd/lVXpS6Uha5s1y2MAJ
claPgsRVKu92qRepPeW358ucCD2NyfyUz6PnVHFD7u7CAN/TyfiHkyUGqvK9jH16
RKAx/xGOMcArOntFDYG394xtdzBVQiqlhvFM13eWjbORrem+bBUESsJEUnmE74Il
GZ5jhFmNtTb2AzCm6Ys7uIbyJ431PR8fjkY6cgPjKQqUIVQL5qmRbjqa+mld1GXQ
0R3qPeV+KlZZx1WNjL9OQFYT66opGRiFWPxNV6udKfTubqKtTrRpqfamO1Z+kWrO
qMZvWBnL99F7BQoYxaB9zzuBJkkfpafhVZW1L+O1TTmciihCCoBREVxgGXb3HpuH
qECaL1zfJStHNDq4IsGKgpXOElM2QbEwQh+9Qy0FveXxV2yS15WJ5q0HF9n9UX8i
sPW9MoQ4vNYLgG/6Xe6r5GruK9LUH4Hz4tAsXr2cF8sWVtqx3a0oFbMkC8EnzrcO
8/Nvx2di5fVqv1cDgRtIquThxmLFgsMpSSeV/LtFkc8mb9+A7WihHTMFw+ENfmnN
ccgFx7WWEFdejtyI+Xv3Xy/ztqbLiW57GBozS+CbAE4cPZ2CO04Zb2F+eSajMY7L
XxVqL6GhsXLf7IwEQRkZ
=DqWF
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

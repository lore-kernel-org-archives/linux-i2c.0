From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: img-scb: use setup_timer
Date: Sun, 16 Apr 2017 21:51:49 +0200
Message-ID: <20170416195148.3x25taazshuj3bhk@ninjato>
References: <0ff6e139159043e3416b0e5bc89e9aa5399bbb8e.1490601847.git.geliangtang@gmail.com>
 <0aa459186eb73a97664174c029bc0933c1db5b74.1490602022.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qxqzgb4bnx2ldowc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:57675 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756609AbdDPTvv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 16 Apr 2017 15:51:51 -0400
Content-Disposition: inline
In-Reply-To: <0aa459186eb73a97664174c029bc0933c1db5b74.1490602022.git.geliangtang@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--qxqzgb4bnx2ldowc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 09, 2017 at 09:41:31AM +0800, Geliang Tang wrote:
> Use setup_timer() instead of init_timer() to simplify the code.
>=20
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied to for-next, thanks!


--qxqzgb4bnx2ldowc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljzy1QACgkQFA3kzBSg
KbaIGw//aUbEJ+R6/Lx6O6j+TnMoRrcm0eOO+TJ3DGm4RQ7KhLCYSycU+b5cC5wM
ZNZWeQ0OwINGpxit36iPDR/7u28w/THFDKK3R61boAYkifMwe9BRhK4FN10TboxJ
tPABZk8zA44hcInm0Nx3StmXjGIJ21UC0QcA7QUHAcRexmx5zXxrkjh6IwG/p/s8
P/vclSmQaU1W7MHAZ7xbablyWwOCcGNt/i1h2DVJOzisZ6wfWLHXVnBpU+iY6/B6
UBefEEuYvU2TqRfAz/v10S5MjZtZG6yoD6n482D24P2LbUKr+2aE8kCO5k3Zkvhu
UpoyNgL7704GPNXrOt/I482MHCVGxxI7cZ9qUTbKa83zRVqBnPq/d0NfasTOwCsz
TWeUMM2moRYryROP6EebR99QtI7XwRBfIdbqSS9zOJzBKwz3hqY4I1L4Q4bUs34+
nsiSC0ZYW18u2CmvdrFIxC4uSlCLJ0epgzZXPwtrc32fnxlhL5wx84iAIfK0PE7X
OSuoBn862dN/PdQZA7mRLKIqIhMvsBIuMNuzYrXdpe9rB3kuQHMLiC+szPqwF5z8
tLm4NGUXgfKAiCageopOOV/iXESVOXcdVivfJaT2vD6vhK06wISRFumPKNMXgHEW
FaHHgq6YHqTkVF9YqbjM4odFiSYfL9NKm6PuaqeooeSYzqEC894=
=bEAY
-----END PGP SIGNATURE-----

--qxqzgb4bnx2ldowc--

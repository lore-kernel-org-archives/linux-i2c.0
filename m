From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Fix kerneldoc for renamed i2c dma put function
Date: Thu, 11 Oct 2018 23:02:10 +0200
Message-ID: <20181011210210.hsrxwqbc2loultks@katana>
References: <20181008145520.36810-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dng3cjxcefyt7pl7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008145520.36810-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--dng3cjxcefyt7pl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 07:55:20AM -0700, Stephen Boyd wrote:
> This function was renamed in commit 82fe39a6bc7b ("i2c: refactor
> function to release a DMA safe buffer") but this kernel doc wasn't
> updated to point at the new function. Rename it.
>=20
> Fixes: 82fe39a6bc7b ("i2c: refactor function to release a DMA safe buffer=
")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to for-current, thanks!


--dng3cjxcefyt7pl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu/ukwACgkQFA3kzBSg
KbYecRAAlUpqMldRD91/4Bpapu7M0C7rwGJ6PJPw43VweR9JQD/x0r/YE/6//EHs
4thzz2Ip7bUI/cQ8XfkfVLO/XylnIHRF9x+DbAyUO4yXWQiUBEoFMp179ZYSyrzp
Y8QdJNq8ykpNRezjJI4UjMudKLcwhoXFxOegFyXyN++IpUnru8QvyKz6ddgPSEJE
SQLpVlh1r/9U7r310ozxJi3VQMCd+saYekgXj5Vl0OO8MKlgX5vxK2+CrlD448v2
/Jazywg8l6CFCZLfsIzfMxpagRFAx2zmcIkI0EdVrcrZ8St8pPhl9+m7/2t+/ub/
ThHBm/fi+vjlfi5JllbbABTRlksHPaFivh39r1o5mzer/eRMbWT2huCBzXfmlbnx
rLiXPaGfYdI0Kr2B1c1nmDncRyAUsrPtYQ584kLHOD/urdvhFQ5+AYW24UhJ4tft
MaHPyKRxVVPqsTASeMrVCbiN/etfvruX+O/WkXp1Sjba+aHFPERZe8cFnib5D8w/
7sIS7CiUjhuR+dPau46n07qylx0i7y92UTQ8KJT+8BU6i+jHYXr0Bbf6TYWeU1sb
acxqiNeD9ydOZrcBJc3z1iZk27lvbeNQsju3z2jQ1Qu9hgK9VGuaY0wzT7IO3ynZ
WQlfiQWEiPE/aZ/8Krr5PQUO1G4X1ZrUjxcxIEZSuen9ElbolXQ=
=wISp
-----END PGP SIGNATURE-----

--dng3cjxcefyt7pl7--

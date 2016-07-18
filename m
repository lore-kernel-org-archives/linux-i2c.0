From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mv64xxx: Use clk_enable_prepare and
 clk_disable_unprepare
Date: Mon, 18 Jul 2016 20:23:27 +0200
Message-ID: <20160718182326.GD1973@katana>
References: <20160627144722.GA31362@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:54349 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751451AbcGRSXb (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 18 Jul 2016 14:23:31 -0400
Content-Disposition: inline
In-Reply-To: <20160627144722.GA31362@amitoj-Inspiron-3542>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 27, 2016 at 08:17:22PM +0530, Amitoj Kaur Chawla wrote:
> Replace clk_enable and clk_prepare with clk_enable_prepare and
> clk_disable and clk_unprepare with clk_disable_unprepare.
>=20
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression e;
> @@
>=20
> - clk_prepare(e);
> - clk_enable(e);
> + clk_prepare_enable(e);
>=20
> @@
> expression e;
> @@
>=20
> - clk_disable(e);
> - clk_unprepare(e);
> + clk_disable_unprepare(e);
>=20
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>

I can't apply this one. Can you rebase to my i2c/for-next or v4.7-rc1?


--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjR6eAAoJEBQN5MwUoCm2mDUP/j+rvuFdHoEWwlIXmmtXwTqv
P/wv3qR1gV5J3diVf8F4rU1GyqWw+3FF8wEOyCf0Ogh7Kwnir662f1RyIQ5B8TXo
i1NHYrPDtYY+FVSLEF+l6Q4Hsv6wzRakYArv3nRx9E+1UUol/iybP+8WgYMHiM4M
taipOB2GMt/BpSgSWOf93hrj/nYaV86IvzpZ7e4YN8PKXaU3C4kpL5LSGn1bLH1I
YUY6OLWMXtikiTW5ncwmaNMp3lgDW72SDM4lo4dPhoHO190Qe7irFBErc9E7UtQj
baORYqy85SkHWPK1XaJZwvD7nK1fv2e6dgjXekY5+cL9d+jgQgfd52zMVs3pOljE
rBIklorb7GK7WMXlYqb0A43OrX2Y9fO39WXRYUateRuRD7xuLXRFuD05YIaaNf4L
2LC+tG8MVlhLw9aVybxxk+0CbkYRYGNxdLV+zFKKJBj/bYGllDm56Kx2i6WOQAAt
GVHiF539keQBIZW+3Y+qsbj+Kd5SpObsa2hP7Vc4jMDwCZqk0mBE3vEe9cT2f40V
gTKsWBR0OXDgUdPkgGeetC/xH1yvddb5RTiDTKro2mCxWhX4p2H0DIQ2VuXhJ6IF
em1g44RQcdwdh9iTBDyBWoohbUJTGKgJlGo6eP/XbCRbk7+PZ5cMFlsvVAkazzaP
4jm4UV4T8jLDoCcij8ab
=E0sm
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--

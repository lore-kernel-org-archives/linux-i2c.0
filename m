From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [Patch V6 2/2] i2c: imx: add low power i2c bus driver
Date: Thu, 1 Dec 2016 23:45:09 +0100
Message-ID: <20161201224509.GG19261@katana>
References: <1480473647-24514-1-git-send-email-pandy.gao@nxp.com>
 <1480473647-24514-2-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nqkreNcslJAfgyzk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:46350 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753150AbcLAWvv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Dec 2016 17:51:51 -0500
Content-Disposition: inline
In-Reply-To: <1480473647-24514-2-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>
Cc: wsa@the-dreams.de, cmo@melexis.com, robh@kernel.org, vz@mleia.com, linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com


--nqkreNcslJAfgyzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2016 at 10:40:47AM +0800, Gao Pan wrote:
> This patch adds lpi2c bus driver to support new i.MX products
> which use lpi2c instead of the old imx i2c.
>=20
> The lpi2c can continue operating in stop mode when an appropriate
> clock is available. It is also designed for low CPU overhead with
> DMA offloading of FIFO register accesses.
>=20
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> Reviewed-by: Fugang Duan <B38611@freescale.com>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

Applied to for-next, thanks!


--nqkreNcslJAfgyzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYQKf1AAoJEBQN5MwUoCm2FrkQALTIv9FSxiHDPkuRkE7xd1Bt
5fmtlocmX4P+TOXzbrS2hyqiQh+rzYKcunrnFOFEquyJ64i/VwR3aofMGlvn66Aw
3m0wnXlWYYOlBUm9ot9h2W/hdtQ6iOQxnf6v9o/pwGQbrhQ5nRzdbmhAvB26z9/M
dyKyRyLlp2g2AGEbUhzDq5w9qaHzNY6YH+jkuGvRqwQinDMTOiNUNlap23+Gw8u4
Rb9P5FAepm+MRDh7BvfgqeTteVKoJxtPfLq3T2hWimRD9PVf+R394fOO+H2oKWzZ
q7+33ttVgsvfWwRJI2mIRoqAgqwkfRb9etD9JxppjZMQq7IJ3RVOA9aeMUkiYoeh
J0hLZIyJU4sQho28EeNYj3I5JO20LyYLyb1GuORda/SGhnlK4JxbYyPoYqAbZ/5P
7DSt9Myjejltf9kJuuAxzyybokd7SR5qm810irc3wSFZf2KxOPw6xr7iybFig4dG
jfc5ckGDkd0Z97RGdmbHMDU5qvjlIRbDBNq+aQNRI3arjUHaXDXgXrk4JhKdaL/t
eg3Cy7oUDZ3MDVJABMcx79i7FREFJ6Wc9msCw/W3hG5h2COWVNsFUk5j0o6PPbwo
WKXo+RCBAI3K8jxdJgoV++pymbDcZ6Z/mz7LnG7DcBgT3Dj6jRKaW7TBB8UOQ+cE
ovfav6DjY+21SKm4Cv2O
=c1Y8
-----END PGP SIGNATURE-----

--nqkreNcslJAfgyzk--

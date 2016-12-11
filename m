From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V1] i2c: fsl-lpi2c: read lpi2c fifo size in probe()
Date: Sun, 11 Dec 2016 23:07:09 +0100
Message-ID: <20161211220709.GI2552@katana>
References: <1480649896-5222-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v2/QI0iRXglpx0hK"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:57582 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753911AbcLKWHM (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 11 Dec 2016 17:07:12 -0500
Content-Disposition: inline
In-Reply-To: <1480649896-5222-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>
Cc: wsa-dev@sang-engineering.com, cmo@melexis.com, robh@kernel.org, vz@mleia.com, linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com


--v2/QI0iRXglpx0hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 02, 2016 at 11:38:16AM +0800, Gao Pan wrote:
> The lpi2c fifo size is a read only parameter resides Parameter
> Register. It's better to read lpi2c tx/rx fifo size in probe()
> other than just define a macro for it.
>=20
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>

Applied to for-next, thanks!


--v2/QI0iRXglpx0hK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTc4NAAoJEBQN5MwUoCm2d7IQAKHBfFeC397yHH9hFmI4GW+R
NddTrlTai+UpjmBxpXBJQbQlamPqURC5LMoOuGJWWUyOEpjYqQaQIxYtfSUhyqcQ
GecvPM0ScP4NVX3mm7IrfGShB0P57D/ExJdEA1mnHIcYgRKPbNoVK2tzL9b1QXJY
iycKf4JYaWCzeR6tHsONoDNxZr1zBw82d5StjDI2E5QTONgrEr+RJ19xx1ha3do8
dUfzIsDE1zNCDyNAbGFS5ox4NcUQf0wLcVJUNtsXnD9U190I2j498sxP07v+eQRB
wzSPjz2d1jw1n3pM1t3E/gYsNgNxyCREB3wE0/MO+65ySFCHM03brn+8BOvOjywW
lOVD+iNvsAMDhEDiW9EInKT94xwPrOYyqpC7DDxfT1J54nyuMLLPRNpb6gwZitDf
u2yWI7+bjrfSMMYtaomv990YoDIESh6OzU+OQcLcxyRB/iyAOWQvZOqQ6LH1lDSJ
Lo5Ktk7odUxr1g5W5HYGXYg1msXzRHzTyRiEXinJ3nJZn9AE/FZY6PAXq53n/tLs
7R2u1KkDDDVYE7lbjHRSQfgGTqpKVXdEL9ozOiUXzA0fC7CrZwFaEmWPLrDBYUED
xJAypj9IjFO4xZpxa5RiN4w7FyEITH4uLmzxjzKRPu6ed2SnWdTJa3gkJbq474GM
eA/+xLb5/MinjIstStIh
=J7b5
-----END PGP SIGNATURE-----

--v2/QI0iRXglpx0hK--

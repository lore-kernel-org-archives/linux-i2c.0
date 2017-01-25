From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V3] i2c: imx-lpi2c: add VLLS mode support
Date: Wed, 25 Jan 2017 21:53:06 +0100
Message-ID: <20170125205305.w2ohn46ouzrxutkm@ninjato>
References: <1484648455-5454-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfhj7rqdhcnmhwpj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38946 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbdAYUxI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Jan 2017 15:53:08 -0500
Content-Disposition: inline
In-Reply-To: <1484648455-5454-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>
Cc: wsa-dev@sang-engineering.com, vz@mleia.com, linux-i2c@vger.kernel.org, frank.li@nxp.com


--kfhj7rqdhcnmhwpj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 06:20:55PM +0800, Gao Pan wrote:
> When system enters VLLS mode, module power is turned off. As a result,
> all registers are reset to HW default value. After exiting VLLS mode,
> registers are still in default mode. As a result, the pinctrl settings
> are incorrect, which will affect the module function.
>=20
> The patch recovers the pinctrl setting when exit VLLS mode.
>=20
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>

Applied to for-next, thanks!


--kfhj7rqdhcnmhwpj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJEDEACgkQFA3kzBSg
KbZEMQ//WHTQOsTiwSzvaxpeTI0wyZTj6BF+LbTWL6Vw3J/sa5p4kR+vAuxTtjQr
oexqacUVXdAnj6oDMhYpX5vfgQZu0vjkqq09w2BMwieji/a4q0ZeAVDf88m2Wsqn
yULoBC0RiXRagIDYrZl0TqbW3ewxzN/f8u8I/OBPoXqew2ZP339blqsCDmF4pHcT
7Xd/pICn0KjtQgGbH5R2+aZV27Ez1/tj4pvkEOW8+G7h1hg6ciyICTzUGAwBZ70y
hOcSoeY/PSCWgkdsiRPzIOQA/B8gioPwi9CufMUJhjbk8Zu08g/5wsfigMzhkB9Z
0IJbaKh5VyicWWYPATqPWmJ+IBFe3I/27Lwm373k5s+hhI1ADS2r48p398A+5N5Z
rV3jgevS1p9jeA7NjYHMF8qPbSy4ekSIdgD2ra7qckGQ1o8kkh2S8MBcgkEmUTVV
lZOtJ7jz5UYJWcSpB6EnX/YDktLKDlKE1bzadY0SbCpJzFfb71leJiHg9/T8G6oU
rUaHgEOxZWVZYa9pZV2oNGysx4IZJTxgKqJhUBxxLpTS7AtE45u/Y6y7Bj0JasAT
ZpVTnXb5OcpVO3kqqg++epeVgoOq577HOiq9RY4IeCPSkd7Qp30UeElMeTX+aLVJ
2M5AoTw1pMQHNOVA3pd2GdUTRj0brUP6l+52UUCjoOdPRNvDk5o=
=z6C9
-----END PGP SIGNATURE-----

--kfhj7rqdhcnmhwpj--

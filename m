From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch v1] imx: i2c: fix i2c resource leak with dma transfer
Date: Sun, 10 Jan 2016 10:07:42 +0100
Message-ID: <20160110090742.GG1526@katana>
References: <1452231195-18425-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60998 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887AbcAJJHr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 10 Jan 2016 04:07:47 -0500
Content-Disposition: inline
In-Reply-To: <1452231195-18425-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>
Cc: u.kleine-koenig@pengutronix.de, linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com, kernel@pengutronix.de


--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 01:33:15PM +0800, Gao Pan wrote:
> In i2c_imx_dma_xfer(), when dmaengine_submit() returns error,
> the context goto label err_submit and then return. However, the
> memory allocated for txdesc has not been freed yet, which
> leads to resource leak.
>=20
> Signed-off-by: Gao Pan <b54642@freescale.com>
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Applied to for-next, thanks!


--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkh9eAAoJEBQN5MwUoCm2wgIP/2NAnEbAHxWzrrQusmw8jrJ8
CNPa1VYP/G/Sxqs46WUzyt6ZrtZcxcMRwQph83Sp+kocl8hnZ2/Xvd/bvOLBPUn8
SeNiNGlgtSlVlRnK1Q9HFu4dEO77Bv+l1Ero1P5/x23Gyy0XnEoX+ytp8beOkdO6
JauNWz3G22oELKfVw5XeaUwaNc7szw6wISVTg4fMGHdpQC+Eb+2BQ6ioGmUUmVTK
rRdwn/HusMVj7ATTUaBIICUxQMDK6W/X9tcZ4jC609oT6l/I59Fl1Sd2K+gknpRq
dNvePFKRDlkCYRx2ExVl5su/cF52XwI6PVhTwfTSZmXsHJIHs16877AxmdIwUTuh
IZuj+rsPPgC+o/MMP5gfsfJtF9osYaR72PeBQel7wMmSsl+99VALQdJGR+Xj5hFK
1w+IJVgbVcUofmHDrnREUi42d6S+Vw8OZO3GJOKODqtLN38tMFMiTWRJ4r8kCYsS
vciG6q1rIZoopRF9GoLvzb7NnZbzrsyO5TQFuH0T+NQWgGApnbTTz0vPiUj1IkE7
MPYapzuWHpNULvyz5HMSG7eUip5DExaCvmdEXzlpYDgd5iewU77gXHaolmGnH8IN
yFZGtYKZ6dM8v9r1m1Sitd8KpLmEN/+RPE5JiLzBWYLtlIN2XOQj7XuWTzTGGnnX
9rsWS8M2ZvMPUporLam/
=Xyiv
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: qup: Cleared the error bits in ISR
Date: Fri, 15 Jul 2016 15:33:18 +0900
Message-ID: <20160715063317.GB7675@tetsubishi>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36979 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbcGOGd2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 02:33:28 -0400
Content-Disposition: inline
In-Reply-To: <1462797871-8595-2-git-send-email-absahu@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: agross@codeaurora.org, sricharan@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2016 at 06:14:30PM +0530, Abhishek Sahu wrote:
> 1. Current QCOM I2C driver hangs when sending data to address 0x03-0x07
> in some scenarios. The QUP controller generates invalid write in this
> case, since these addresses are reserved for different bus formats.
>=20
> 2. Also, the error handling is done by I2C QUP ISR in the case of DMA
> mode. The state need to be RESET in case of any error for clearing the
> available data in FIFO, which otherwise leaves the BAM DMA controller
> in hang state.
>=20
> This patch fixes the above two issues by clearing the error bits from
> I2C and QUP status in ISR in case of I2C error, QUP error and resets
> the QUP state to clear the FIFO data.
>=20
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Applied to for-next, thanks!


--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXiIOtAAoJEBQN5MwUoCm2GFkP/RUTj5mSQ74BzhiliKvfijCZ
B+GFBDcp86iiMIgJ8ViEUirVVAPbFmBwGeINxNU8YklndZ/NuSl6+tC+YMVkheXr
btu/h/0PZsn5eS1Wd6FO4ND91yr1psaVZW03FOYE5/vxRSbFNxGvtAsriZEB0iGR
LiPI713vMZAIa1KvAC8lmRQkW7nMmbGxXdBJX5GpyPqfI6rlIY3p00AU1FrBcNdn
DJNrjVTrRHpW835brXQEI+z5YSbf3sQ4NVelwup6NP8lfKhUAJjIMTVBylWw1ohn
5YtUHtYa+eh2buqGWHTloGRiKdE1lISfZ6Z260stlRxqzjZCwke64NgatnmeDFSv
5JRAsgoW1DqZqUno/fOvBxuLKcpUhjHe9ko29NiTa0rTlVnplKW3Ea86y1imgTgn
CcEYBnK/7kPgX2eVdbQHg3thAw07xbvesf1tDP3zwHn9Kh7Lpb+r8TJuSs0Kx0F1
MrukZuOxeVnX9xiYQ87LpDc4Hy6apmxzHXsxIlkoDkHVeRrAWB/W5QBDfQHcXh71
4I6ujyfEiyOXDynUt3OrJ9HkWKBcAH9PksmUxiIdt14zlxOm4ouFbgu8Y2f/k/5p
Ntykg2Z0kn7RUDLvsvtA9CXz3dMrBh51Uwz2Lw4jgSk8Du2aI8tNzzUQLzs/iMTR
p2oJbNi7q6t/Id7v6W1F
=96Uc
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

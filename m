From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: qup: Fixed the DMA segments length
Date: Fri, 15 Jul 2016 15:38:07 +0900
Message-ID: <20160715063806.GC7675@tetsubishi>
References: <1462797871-8595-1-git-send-email-absahu@codeaurora.org>
 <1462797871-8595-3-git-send-email-absahu@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462797871-8595-3-git-send-email-absahu@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: agross@codeaurora.org, sricharan@codeaurora.org, architt@codeaurora.org, linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2016 at 06:14:31PM +0530, Abhishek Sahu wrote:
> 1. The current QCOM I2C driver code is failing for transfer length
> greater than 255. This is happening due to improper segments length
> as the I2C DMA segments can be maximum of 256 bytes.
>=20
> 2. The transfer length tlen was being initialized with 0 for 256
> bytes, which is being passed for DMA mappings resulting in improper
> DMA mapping length.
>=20
> This patch fixes the above said problems by initializing the block
> count with the values calculated in qup_i2c_set_blk_data and calculating
> the remaining length for last DMA segment. Also, the block data length
> need to be decremented after each transfer. Additionally, this patch
> corrects the tlen assignment for DMA mapping.
>=20
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>

Applied to for-next, thanks!


--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXiITNAAoJEBQN5MwUoCm29/MP+wd6KTbooyQp8A50v1rMXK/u
KOgGhk6M8QUaA0Ks0+eQxRy0CgEhy0vmU4UTvHrzv9w+eSjm+6wd/u7pi0YvoUPy
VO7VDc7aVpf94yBSk1gwyfGe/Dh5ly3cXYlYjFHbupIUdBlV6Pex6K+ufV+VoqI3
PeLIOUpUI6d4noZRVapBavT17ZBkfwlU2RdEyoJ2P6Le/xo5iZHpFxd0/BNryK0Y
MO9vSmHH4chpDuO+sBxyGAGOYPT3poqxvASyv3SITZ5xIQRQOgCETrXbnsMM8Bmh
BBtTWJDUhAJ+19DfZLoucNJfI/9/WZ7ST9dm1PFkY+fT2xtOSLt0q1qqv43DPLl5
bFeXDm1WPMDubVAATBIPYIZ80zSEVkzAWm4Osab5En6Zcp7EsitEm8+zORsGcDYW
CyGByFdAncKFnlsWJn11HLX8NDIEMrS+BltFjyhASlbA0tPfJc8NBeqnM7Ccvlq1
RT+5W80XPYkWq5pGIT7Xv3fHFmjtQB9QLtTlCqX72i5VtzO9RWq8ooRSHZjM2chN
uQkSdE0vdNHV23Kq+X8NQ0nLJMNXDkNosgCJc0kzTr3y89lxb9XV9HpabgB3FlPZ
DJhtmNty8N7o9+FwA8mqCgi9XSGlgMzsJA/Egrz648exhC1t+iXFzHe9fkeFyGrc
zaUAlCu+rDgWWWZs2nz6
=bYUC
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

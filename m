From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/4] i2c: xlp9xx: Handle transactions with I2C_M_RECV_LEN
 properly
Date: Mon, 26 Feb 2018 21:20:13 +0100
Message-ID: <20180226202013.l3z27ejdepjyk2oh@ninjato>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
 <1516253964-4615-2-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rllogxxrfymchyg4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516253964-4615-2-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--rllogxxrfymchyg4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 05:39:22AM +0000, George Cherian wrote:
> In case of transaction with I2C_M_RECV_LEN set, make sure the driver reads
> the first byte and then updates the RX fifo with the expected length. Set
> threshold to 1 byte so that driver gets an interrupt on receiving the fir=
st byte.
> After which the transfer length is updated depending on the received leng=
th.
>=20
> Signed-off-by: George Cherian <george.cherian@cavium.com>

Applied to for-next, thanks!


--rllogxxrfymchyg4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqUa/0ACgkQFA3kzBSg
KbZxJBAAjtAEFTugvWCoiIZntfgbfJU7pdcq/vMlq6sacI0vUCZ0RFru5ao//BPA
IdTPNDKLccmACy9iRjm7mlbvJAECqIbViim08NHbsLJ7biZ6Qg7ff0BfrlR8Voc3
4aLs4I5TyvorfhuT/jU54NVEXQeTxL1od0h449G3MS/21cbBCzgzHkM741V7HXa2
XZ8mfTPK97NXp4EXQ8Xy4QFxMmxvrc45DsIafWbOxJ3qanOZCZ5hkAsS084GxQb8
2o+xpceg5EFdW/65v1IuEwZjJ5HeQ2siff8MUuPDaKGari0zrNeckmVzlss8imBn
xci+/KmZr7XZeaAv8Jhn5DhIJQE167A7sdT5fs+ce3a3eulXw9QlXVMZOGFxNx1t
Y6cB6BRYsr97kQdw6SkFK0dW1LNulnA6CQY9XXhqMmky4FEIMvDP2TpQ/FgeivhL
LDJEVefBJpOvLirHZEU50/vNBjjBPUr0KdKwKP49IO/FGAPP2WT+pNFLEor6A5ni
sTp+xXLLml1t8GUvte6ob/2bWCkN/BAZ54APArqLsmvKbN5/EOEAgHlcwIfi1LVo
bINEDQrctPS4EqGE9iXwHYuAv7VBHDFzbzwiTlhO1F8iTZG9LtraFOTZ0ZetbMWY
FPWUiJUBuR9RADWyhHnaxQ0JRSisDSn+cnkRqHdhByFg0OyTzp0=
=J07U
-----END PGP SIGNATURE-----

--rllogxxrfymchyg4--

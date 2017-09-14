From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 3/5] i2c: i2c-stm32f7: add driver
Date: Thu, 14 Sep 2017 17:40:33 +0200
Message-ID: <20170914154033.gkovgxgjbghtqmre@ninjato>
References: <1505399319-14782-1-git-send-email-pierre-yves.mordret@st.com>
 <1505399319-14782-4-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="roakzwhqytjayd4c"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46334 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbdINPkf (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 14 Sep 2017 11:40:35 -0400
Content-Disposition: inline
In-Reply-To: <1505399319-14782-4-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--roakzwhqytjayd4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 04:28:37PM +0200, Pierre-Yves MORDRET wrote:
> This patch adds initial support for the STM32F7 I2C controller.
>=20
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Thanks for the quick update. I'd think the 'rate_max' variable can now
be dropped and replaced by 'rate'? If so, we can fix that later
incrementally.

Applied to for-next (will be in 4.14), thanks! The DTS patches need to
go via arm-soc.


--roakzwhqytjayd4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlm6ovEACgkQFA3kzBSg
KbYSUg/7B04dyZDkWjvBBDLsWcL6hjuDktAsHGzgJv0Hi83Nt1tvkZKH7Wfgqell
qkqWGr0+by1vWlyJTAxKWi4NicP1lZSsWyD3eVvGoFkgVay3n06Kdq1MPTcUQxVx
uNcgCCrqoSZ7Ys8xKc25L9fgo94hO2TGyte2rQP+nYK/LZGxFEEwll7XPy2M4Uj0
haj+zeh9UjvwVVyRcGANAfvEz+fcXiIRv2JHI6Lzqu0xJpBeqBW62RMC465XiD1R
DwEqZPhG9bV66y9z7FCkMf0Nsda9L4DLGT+uSmmTpwaEhw1K3608qNwdOlRGlMs2
iKBuYA9rnqFVuGyJLE3mb+Kllc3P5lz4XYKkD+rd7D4HpSg73lL2+O3Cdj4Yd73G
UuEumVYP2Q4dOVODYFMhQW+zGcp0+8McDQF7e9432jjJJL/d2vkGKcmIHPVSGlOb
lsXWsknRSNGQa4e0XyWVjQJIbxJ4ek84A07WZ926MYi2fhzob/arNCSx5+ZEbsa1
GujbEokEFl6h8ThQNLIAaKLJRFmmWWuSoYXevcZjglNGPq3XrSE6mtluO8Yr0OXJ
1X3QUjlMtlOexcG6fc6aTGYHnkZqS2twDcP05iro+l1JEffSFE4nBn5/KgjZaX7c
0A281ZIJIcnBMjLJAz5W8yaF/2Ryu6aze978f2jB6HT1zVWR6p0=
=8NUa
-----END PGP SIGNATURE-----

--roakzwhqytjayd4c--

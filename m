From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: I2C_RCAR should depend on HAS_DMA
Date: Thu, 26 May 2016 20:44:25 +0200
Message-ID: <20160526184425.GB1614@katana>
References: <1463902715-12680-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43732 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753268AbcEZSoa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 26 May 2016 14:44:30 -0400
Content-Disposition: inline
In-Reply-To: <1463902715-12680-1-git-send-email-geert@linux-m68k.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 22, 2016 at 09:38:35AM +0200, Geert Uytterhoeven wrote:
> If NO_DMA=3Dy:
>=20
>     drivers/built-in.o: In function `rcar_i2c_dma_unmap':
>     i2c-rcar.c:(.text+0x6f06c6): undefined reference to `bad_dma_ops'
>     drivers/built-in.o: In function `rcar_i2c_dma':
>     i2c-rcar.c:(.text+0x6f07e2): undefined reference to `bad_dma_ops'
>     i2c-rcar.c:(.text+0x6f0838): undefined reference to `bad_dma_ops'
>=20
> Add a dependency on HAS_DMA to fix this.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied to for-next, thanks!


--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXR0QJAAoJEBQN5MwUoCm2aroP/iE6g6Bse9EC93SQs2nivJMY
fN4yivezRU+Wz3O0Cx/7AadyXBYZAJzEUZyBQKiYYhxgErhYCa9nlbQPe1xC0toJ
aLR9e9tyWzKeXv2imQ1z1kpVqDo+x7DoJWK8jKB9DpGHjn6vfmZuepSvjpI2JBP7
M2/X2qvh//Dq2DDtl5abCceA/sPnB1OuNWYhA+vMfF2gBV+3mwu+dJ6guMR18JLd
bjB3h8mFNMdTDvoqvBlAk2le7KXBloKVxPM68t5LRpImF5HqKdsKlweYHOkwEy01
iquEsk8WZb/O+18gPFGKDn2ZaE3glRyFLk92RwtqAT4vySUtVFnUko1/R7uTW9Of
DK0C3U2Ig5J3KwXjeRx8h3WrLfv6kYkpRIcnhjPbXhG52yrqprcjk5NnA/rUrtm0
pP6K5AokzJZpVwTH2VHQ/oDoGFLv3Jidy5u7oxj89FQDf6MEe64f5RcZoTzH9AYL
PDIqFkZM1Th93f58M8/J2hHjz7bpC50nmoRyysXIXOvE9DcxUwwDOzXRCnFwvhRV
zs3ZroG8BSWsjRaRsypst2SaOLB2j3ykLCc/CVh19GcoTCOM+GfxNBwSEfGriOQK
kRlDHrDJTkBkwb7umErLPme8DNS3SPDuoMuitI0DPAzKbymlcTI8aJF+mByXtpjX
PEDRY2jqlrrg1u5ub+0K
=iERY
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

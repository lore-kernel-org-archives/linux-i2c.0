From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: rcar: avoid unused return
Date: Thu, 17 Aug 2017 17:50:26 +0200
Message-ID: <20170817155026.lpa7rtzt6bcvizht@ninjato>
References: <20170815203624.19274-1-erosca@de.adit-jv.com>
 <20170815203624.19274-2-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7b4lncmnskaavgvm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60264 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbdHQPu2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 11:50:28 -0400
Content-Disposition: inline
In-Reply-To: <20170815203624.19274-2-erosca@de.adit-jv.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org


--7b4lncmnskaavgvm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 10:36:23PM +0200, Eugeniu Rosca wrote:
> Fix smatch warning:
> drivers/i2c/busses/i2c-rcar.c:628 \
>   rcar_i2c_request_dma_chan() warn: unused return: ret =3D PTR_ERR()
>=20
> Fixes: 73e8b0528346 ("i2c: rcar: add DMA support")
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Applied to for-next, thanks!


--7b4lncmnskaavgvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVu0IACgkQFA3kzBSg
Kbaqkw//WGAGzbfug1dyw99hXJeFZaoq7xfJFXwZbrhbS6/RLZT+Vvv4k4G6pWoP
Sh0MtsZ8MSIgoo4QkanO+YRNXZq73jY6wg1ubD4HaPXms8/psVDO9GAL0auzRliT
YdU7/mB9uhIdvrftMedjJOcyngEFNLWjPCi1EPi8o1YukHQ4tz42jVEeN9l8JAhc
vbrY9AvoZJB2YdpblTx5eMlauvHMm/RUFg4dC2tuWMuNHENDKJT0x8MngMdCX9xo
ljdOw0aC2Zpo6fvfoEGqYI71NF9rvTEZyfyUIR4/STfw6WfZRE0RPXBJAgHnOjCR
f6/fEWDBUsnmo7/w4Eb/4RwmgAtxShN6AwY+QCdAm12FzOFHGcDgNKsqegr9cE2/
XklR4OGuPWpXOZXlVdlufYfJcADjjTc8nnes7xKxzBtg5A+XhAHhbpQDj1DT7DGo
S06b6cidSa5SNT4QoYxZlCvHAF1sQt5wdGiQQ8Vo2zcBf/oo8aq/PZabo+PAXORp
H5wpdV1gjy6n1w+VOJv2J0CmdjWMCJvJIQklAmYDtdY9svwiIujx8Miay4YxEXTq
I7XZAHDLtrNIbKNmiajZRZCWXIabG3TllyYyJuyXpSiAIVhkSqFGfgYVhbMsepfT
3AuHjZ/Fmf7wINknYwD7E40G3VNA8eBNowSLo14KpovIfgcJBxA=
=ZMU6
-----END PGP SIGNATURE-----

--7b4lncmnskaavgvm--

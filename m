From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: sh_mobile: avoid unused return
Date: Thu, 17 Aug 2017 17:50:33 +0200
Message-ID: <20170817155033.tsiuw6e2ugynx5xb@ninjato>
References: <20170815203624.19274-1-erosca@de.adit-jv.com>
 <20170815203624.19274-3-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tm4y4qdyp2vy77kv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:60269 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbdHQPue (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 17 Aug 2017 11:50:34 -0400
Content-Disposition: inline
In-Reply-To: <20170815203624.19274-3-erosca@de.adit-jv.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org


--tm4y4qdyp2vy77kv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 10:36:24PM +0200, Eugeniu Rosca wrote:
> Fix smatch warning:
> drivers/i2c/busses/i2c-sh_mobile.c:564 \
>   sh_mobile_i2c_request_dma_chan() warn: unused return: ret =3D PTR_ERR()
>=20
> Fixes: fe07adec730d ("i2c: sh_mobile: fix uninitialized var when debug is=
 enabled")
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Applied to for-next, thanks!


--tm4y4qdyp2vy77kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmVu0gACgkQFA3kzBSg
KbbXeg/9G5tJKDi6EzX9pHm5slAjDpx2yWZQNlCOcnd+8VY6Z1vdesHlOOgQGzup
5xE4ZroIsrCSWZ9bmnnYHKFt43xSYiP7E8X9oY/3LvWz6mkU0kRy+GQCddWzhhYh
lVxEd+PM/5eMDRic+vCM9UTflZRJmDe6xqEB493j5kcwWGsx8chuNOchGd8cAf+h
et3oE9N5O8RXpoUTlQyojrO/IEIFMR1i3RFRey7Ij00/QaXg5VqOEcJQaI+ZIif9
Z1/BUu/Sg5s1KyEM5dsAKf7/4MaIQAuqb+XNtnWr387J+uvE9Qgf1O73hVvpFT0q
0WbZrCuIaO62c0AEkRatBMwN9+yNjkaiFwqeyxHtL9nKImPF+GshOGQu1b9zvQkV
veHMpVsAI/7rNj0pvI3W+c7/o/PLR98caNptfeoOCIov4wyAI+sqzyokW5jAWyJv
URNOLls0mPReit3XrxDe1PcotK9LJi1TaeBFshOMSCRn4C6DSvopYWPAAIPE7v1L
A4SAS/VamK6nVdeNIevvle5HipS7zZIk/VOXmSz6BDmsnICGTIs/HaP+UH+gmBUD
8c+48fyNvvcqGAHFR6qDiyHSj8px1gqX0qo9Obq83BBYhjOYNlGiKhCPZqUpk9ov
xc+cf4pJ+eFMV9JBhoZ/tkGkir4G8rU5bymPt76iducT+VpQCf0=
=YlXu
-----END PGP SIGNATURE-----

--tm4y4qdyp2vy77kv--

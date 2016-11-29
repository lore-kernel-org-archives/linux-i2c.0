From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v3] i2c: i2c-mux-gpio: update mux with
 gpiod_set_array_value_cansleep
Date: Tue, 29 Nov 2016 20:15:02 +0100
Message-ID: <20161129191502.GB10865@katana>
References: <1480011568-13254-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:55650 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752106AbcK2TPF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Nov 2016 14:15:05 -0500
Content-Disposition: inline
In-Reply-To: <1480011568-13254-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2016 at 07:19:28PM +0100, Peter Rosin wrote:
> If the gpio controller supports it and the gpio lines are concentrated
> to one gpio chip, the mux controller pins will get updated simultaneously.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPdO2AAoJEBQN5MwUoCm2JwAQAIaFmpkJqhe8zwT90snYAwzg
ykqdWroaFtYfcak3caszunR0OLb5eWpcGOfhCj2daWSv26b6nPbQ1yM88A2XcBqg
RacwABiYD1kOR+0EohprRkLbUmfvMHEbwHv9vYorCV+IlYv8vQZ8wQSfAY9GBGG4
/uxZPf2hxSZ8GHx5AT4btLwOrSa+pwt002BrHyQMwW5iaBy69DBmHFiuOA9EejE7
PIbIUR+8VNNt31DaNq0q19m0/11XWURASzkhnZlbcpbSwdygqZfUpWtVfbXYVoCQ
lVRaicY+XtSxTJJT8X+eDU50zetkmZbA5ZKh5mAZXuaE7S/UnxQ9XJUgVx4RiHqP
Hm22Nc/SqemdqB/VVseVJYKNnIFnMB9uzfYqonEpozoQ3U2UfFCxTYytzF8LuEd0
NozHum0Ywoho1qpDU+MZpcVMfXo2J9FXBQyWhX87PU3sWgZUVTBtSeTxsF1tIIKv
xQVbs2hjdFuIrkSz/gvWzrwELqy1V4JMd8G32O7MJadGgcGSnpnTGtksAFvpoypT
AvYtK1xUlfjOewiLAhJcmexgWwh3gJoGkYwZaN7OsPrwstp9Xy3iTVQWGOamNQpP
J1fL11wFrlQwYVUw2PhIqN94aQKwniSgmGSCTl0XSm3MoaHrFOX/EfxK6vXUyH+i
bwVTDeQTCphnwAOLbPmc
=G+vu
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

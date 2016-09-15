From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-mux-pca954x: retry updating the mux selection
 on failure
Date: Thu, 15 Sep 2016 21:52:35 +0200
Message-ID: <20160915195235.GD7863@katana>
References: <1473859452-8069-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PHCdUe6m4AxPMzOu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50131 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754500AbcIOTwi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Sep 2016 15:52:38 -0400
Content-Disposition: inline
In-Reply-To: <1473859452-8069-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "open list:I2C MUXES" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>


--PHCdUe6m4AxPMzOu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2016 at 03:24:12PM +0200, Peter Rosin wrote:
> The cached value of the last selected channel prevents retries on the
> next call, even on failure to update the selected channel. Fix that.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Looks good. Is this 4.8 material or rather 4.9?


--PHCdUe6m4AxPMzOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2vwCAAoJEBQN5MwUoCm2WUoP/iriGCnMfzPve8vkeK4nTb/O
lFSMEjqFOTjy1RKqNJo/woQLEEdYZ9n3OWZfbD5POjgI7hmTY4lDmnMceToqoQmD
HOI6JZu6ABd8DHXTja+/CPDiSPgFWqomXZLSrrmzxJ33gwBSe3xmGMrUXwEwfV5b
5+8wRmQSzWl2cnG7oCySs9d/JeWz0JQ3sQAgfSNZ1g4YDyQjBUoWJIrfVZ1WeolX
IaHdr4GiwBPZctb4qgP1wgVV+yZ2Bk+JVGNgLetbz4PzryzQlkQBY19dPY5Eg0VZ
/cYg0bwKeefEcxSQUAkIvY4CwoG8QFbGD/lDfWx60sE1VN+y999F8/dorafU66sf
5n51SrlIfGf6NxP3D/h8Dznet/PywltffuhgZnycngjwDW8D2WH0+Gk0FWNIE6dr
ba39pKUnAoZZrKhjfEbL45RxdqdBh2gusTGqUdOHINcrxbBpedV2KTgQ1uR537B1
Cx1p7z1gucxWEaZy6zaOLKB1rD43EbwoT8Qelz9NVQJXF4bEJHM/dlAcVvSVdSIk
lT6MYJbpVdoHaoeZmrDm8OL3rNLPpT6zSSh103yfK6+MZ+cJWu890Ob9EqBSMeJf
9xqR7bjbVRFrUWQEYhFF2lw5yomUVL7X0As0AjDY9z1LtJmAS0eUqPqFTuCnOQwF
DhXzKtM8U/lv1LlCFi3L
=K/1N
-----END PGP SIGNATURE-----

--PHCdUe6m4AxPMzOu--

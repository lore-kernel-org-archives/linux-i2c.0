From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: nomadik: constify amba_id
Date: Tue, 29 Aug 2017 22:35:40 +0200
Message-ID: <20170829203540.qnds4j772c5v7npi@ninjato>
References: <8f8b0a93aa6838c4a33e273758e159ab264dec4e.1503508729.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hvjyno7ppv2tkmgm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:46354 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751757AbdH2Ufm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 16:35:42 -0400
Content-Disposition: inline
In-Reply-To: <8f8b0a93aa6838c4a33e273758e159ab264dec4e.1503508729.git.arvind.yadav.cs@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rubini@unipv.it, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org


--hvjyno7ppv2tkmgm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 10:50:50PM +0530, Arvind Yadav wrote:
> amba_id are not supposed to change at runtime. All functions
> working with const amba_id. So mark the non-const structs as const.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to for-next, thanks!


--hvjyno7ppv2tkmgm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlml0BwACgkQFA3kzBSg
Kbb5PRAArqsfOawN4d5ATibtz72e1DxM1ccCmTYfi7RCsuZTK/mOzDTtydgQgDlO
y9clNj3AAAnKoUNBM+oBqPbJNJWZERMJ2q4SyGnImmvFA+LQ/iJZmnJf9w3ioPVG
1dcA+4Q0rSEUcv8t2AR6y7FE0C0jGav6CNrnLWEDOYwUcPNowwuT/NLDDagwkwcx
uiBPbmra0tqumrIYOJHd+KTt+ptzEunF7dV/L19vcRBZgJ362u4MFJiYB8gU9hh4
1uz/umlR9eJANVC5u1DbD3G/cZyzKaqrt6gwWFRABWmlc/o+tmz0Ja89rGSAIP9a
41McLBsqu+lvEwe3kYpRaA+fQwbQGN60gww1I8jBLD+vsDoYPI3zIw/YrQ1jePJV
By6ogPX2D5efhjgyfbcTzKVdGEMFjvuqAwQfJqSt27w8rwRwqEw2Da5Fgb/lwFzO
NQ4vD/ojnYd9UOkNV76DURZB1vyEc/0WAyo18KfnxuVjyqK2ePZ3zw/n0z4JoQCh
a9rnqL4Zsf7GtEe8PjK4E05UKe3PWXC6uaiLizjz05r1D/x/lG0TrxRTNifo3A78
x2mfe7KBRwYlbnwo7809Jk+BnIC+zCWTRG9NP53v5uvL9o1N3cj/NxCbKcduqhmB
u+q2ObvtF3JCfEggDScFlnm11YTNOATanBHjbeUAPuO57XAlLMs=
=KJ+D
-----END PGP SIGNATURE-----

--hvjyno7ppv2tkmgm--

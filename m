From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 03/10] i2c: meson: set clock divider in probe instead
 of setting it for each transfer
Date: Thu, 23 Mar 2017 21:31:56 +0100
Message-ID: <20170323203156.jjsiu7hydebzh66l@ninjato>
References: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
 <c85a5f83-0013-001e-6c2d-3fe66c5267aa@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wf2ztin56vkglmzm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40960 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755233AbdCWUb7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:31:59 -0400
Content-Disposition: inline
In-Reply-To: <c85a5f83-0013-001e-6c2d-3fe66c5267aa@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org


--wf2ztin56vkglmzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 10:53:29PM +0100, Heiner Kallweit wrote:
> The bus frequency won't change, therefore we can set the clock divider
> in probe already and we don't have to set it for each transfer.

This is true for some SoCs, but not for all. So, some proof we can
really do it like this would be nice in the commit message, e.g. "parent
clock is fixed anyhow" or something.

>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

--wf2ztin56vkglmzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUMLwACgkQFA3kzBSg
KbYQcQ//To+Yd08GuTZZjaL7VYazS2WH9tZbCZZJPASXIvhI4GXG82bn1/ZQMVDC
jjJ91UAmtVL/aAB/qmXZKRpVML+JcgKxwWoxpdFIC52KurPtxgIZTOHYy1McsJHK
5dD1TUTlP1JiKR99bSv5Jq/PFETiyT2XmaoD/paKROZ/8K6LMGHMVi/FGYpdFBtZ
2wlCjNxMZD0R6j7uKTmLZ7sLNmv8v7uQQj8Bl6bJmdB2jjqr3lioKtiVnYfr2EWZ
ZO22QjNMRGhtqJM1kgUb6S2gdMoJOg/Pu5fh+xXNuqaTqNYVzLbIaD7PRVCj5/uO
CjNIf4AJmlsvMaE7ORrr2mtH2z1NKMtYsoZ41Hz9r81WIOS5afMmvmaOS6NXxaVc
VNK5Goo6RmIAsOvSJqEVVwxObXAAFoPbCijXLId4QaceW4u9en1CnfFEBGCuJW6W
WWjtJHykZFRQ+lUAVXZZay0xSK5aVyEvQp0WPZI26qNsETksCWwaAm+cz1Qmj23y
VPJTNvg5JwsNfLQTlauigX4xwgQposENlo4q+1PLRKjaaPUxRsvc6q+gtMKIIwa0
szGHc+2QZbotgJaQeIglE9RWe+gEV/Zkls4f81Ui4KJAOjzi4FXKCKYX3aHNl5qB
pUAKoy+wW8qI6zDVp+6p2FKyyc2PARvs2r1iINMWG+Dk34HZWMc=
=FVHy
-----END PGP SIGNATURE-----

--wf2ztin56vkglmzm--

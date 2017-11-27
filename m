From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFT] i2c: sh_mobile: let RuntimePM do the clock handling
Date: Mon, 27 Nov 2017 18:56:47 +0100
Message-ID: <20171127175647.hagan6opjco2jmyq@ninjato>
References: <20171108085037.1318-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ipqq442fl3bgy4tb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47844 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753166AbdK0R4t (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 12:56:49 -0500
Content-Disposition: inline
In-Reply-To: <20171108085037.1318-1-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>


--ipqq442fl3bgy4tb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 09:50:37AM +0100, Wolfram Sang wrote:
> No need to do it manually.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--ipqq442fl3bgy4tb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocUd8ACgkQFA3kzBSg
KbZugBAAlKxoplych0oUPSS0Bqsqd67ccFyUQh9G2OHbXAqPsOPr9r8SLHhtiGI1
1b8a1yJc0jz6vTYDYuiK3cTn+O5/KIJH1yo2RGJmUYDkwWWwRoBX58BJGmGm2Uu9
eEIs4BXnLrWmGXs0DAdsPu7uk2uiwrCtU4Ret9SDPVj0g7y87dhHU4VHsA6vpbd/
RC/BUcznheEhcUN3Qmer1H2MXV8Ryby6s8XzE+sQN6S1BnnOhgHqICDd9zKT896M
bph9duxKezBYh/6MTHbVckeoAjbnvFHgkWnBbAugJmszEwQirk/QUemSvdlAbApq
8zmpnqsixju1KEgXi10vaa+aMaTnkoBrMAWkaGZK0ZIP/gdKEcUni+Qt3koqiQYV
mjUKhcwHFA4hVnj9zdVzV1Zb1E3gWMuvL1DwPqjkX9nWP7LxKleXrxkqKWouMOGr
PPu5lB304grhjXqmyOZkgd5xG69hdr5tjOgB592nu85PgZdLb8wJkmESTrVkV74B
aYaAPUQ/3sR0jBrIKWp2cj58GWuYld7NbyACkyxoUM1JGjVUwbcl399UR0xEHGIL
OLL12xVC/T+FI7NuL5l254/hlrP1Ik5EvYYZiLTI/YBNPtwJo1iOIeG7vnOBIPQ6
aZjOzLGayMPZWiH1CeUgV6tgcYxZrYGkWoCfD1zS4TWpj1nrXxU=
=zrPC
-----END PGP SIGNATURE-----

--ipqq442fl3bgy4tb--

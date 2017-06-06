From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Tue, 6 Jun 2017 12:54:31 +0200
Message-ID: <20170606105431.bm7jiclz2k7h7lj2@ninjato>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
 <20170606092034.1516-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdVLV91TdpWz=AeCbLM0Occ4byGMZ37wDtBGStR+j9OL2Q@mail.gmail.com>
 <20170606102447.cftuyhtx7zo2fe2g@ninjato>
 <CAMuHMdWv9hBtYO_Xqwx_A64anC=4d3o_EE7FOSbknPYb-N5X8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="elfr4jronjrgqnyd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWv9hBtYO_Xqwx_A64anC=4d3o_EE7FOSbknPYb-N5X8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--elfr4jronjrgqnyd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So it won't fall back to PIO if CONFIG_DMA_API_DEBUG is enabled?

No, it will complain loudly with more details about the same things (and
some more). But for that to do, it cannot fall back to PIO.

Otherwise, you might get the idea that all is fine since you enabled
CONFIG_DMA_API_DEBUG but miss that most of you transfers fell back to
PIO. That was my thinking...


--elfr4jronjrgqnyd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlk2iecACgkQFA3kzBSg
KbYojxAAhbMu8Ji6cepg9YLKBgHQIT83edsz5W7RcEju0cyJ2pTu8InM+mKBu3ao
ofM3e+ZngssU0rwsFMscHStbh1NZ1DBeVCn1bZNPhoTHWoKPUclFA5msuz8DCK9f
X5x5IvCujlREB5zrQQcOgvQad5TZGCU8B3TH3qbEIWpNcrZ9JY8lNO/GAGXW2B1N
OinEocBrLMsS4G4gq6QidKo1kL8sGG6A9N1xNGwSPZqjCEwWZyC2ga0R9qsUCzi6
sAyxaa9vg4UA7Dl6RAy1YNrUi/f+znovxtIS4S2u4KKTx7vA4S6ewQbhoxMrP/40
JXt8VeGZTLmNFr2eQjWsaVPYxmiZoBWqfX+SSacPFLqVBOPacXi5IjCHOWrtHhLk
2CSTDpjV2uD5dWwUBA9YYNpBFtewGBXfPzOmBYf7cf8YnyIQ6J+oA/zTnQVJPm9F
I/JlwHfsOkh2zjRvPUyAwF1vaI7ogp0MC6RXiNZCjEK/GAXDsY2OiR7jLBxmpL5k
7FBwe+zZ7ohW7xRQgrCxNnuXNGt+Q6Vj2vy3sh89k4DWkxNij4+RpN5DJEwNzTSG
DIYyMVBYMJsLHmHYYKdHErxBN1w+7ztCIhQoSfvpk1GJIwb+/SOF0UCBvRdUhzip
6fJX1yVAtVmARVr8KdQAJFicL98+X55JHFucXT+e14fx6RQqhog=
=W5R3
-----END PGP SIGNATURE-----

--elfr4jronjrgqnyd--

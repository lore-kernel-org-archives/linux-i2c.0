From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: at91: Handle return value of clk_prepare_enable
Date: Mon, 19 Jun 2017 16:38:39 +0200
Message-ID: <20170619143839.skzmfcwokvdoq4r3@ninjato>
References: <74b05c5180872e368970562535bc305728da4be8.1496211597.git.arvind.yadav.cs@gmail.com>
 <20170619143232.yfjg7ydk3t3daeee@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xnis7upby7onve5t"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53536 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750782AbdFSOil (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 19 Jun 2017 10:38:41 -0400
Content-Disposition: inline
In-Reply-To: <20170619143232.yfjg7ydk3t3daeee@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: ludovic.desroches@microchip.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--xnis7upby7onve5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2017 at 04:32:32PM +0200, Wolfram Sang wrote:
> On Wed, May 31, 2017 at 12:27:44PM +0530, Arvind Yadav wrote:
> > clk_prepare_enable() can fail here and we must check its return value.
> >=20
> > Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>=20
> Shortened the commit message a little (i'd think one example is enough)
> and applied to for-next, thanks!

Ooops, this was meant for your second patch! Sorry for the noise!


--xnis7upby7onve5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllH4e8ACgkQFA3kzBSg
Kbazhw//WwCTkZMtvFy4E5VY4BoTBgC1kEqeKiM9dMvvot5WBWiUeLGOKXWDqkaP
gV5NH2Q09U0/Ac4jfRr22JGmplWXkTo4ylUzK/8yCbcPqlf/ufCkXM3PJ7BUwChz
UXVsVfczV+Ny652VOULTg9ozooMhhO0gxE0/hCiA+QudF9QkMZOTGsgtOMBVrEGH
Is/Tz1nHWq04LupMpoF39I9sITLVlc9rO+dh2BY0owLiuLR0yyB1XZmd+vyw4DIN
6f7xS09tubCp7eQhPfJOusovJeGSBFT3+bonZysMvOa2JoRXoCg5FTfc4VGmrSJT
vBRdwy/f+AOpzHhc980GnDKDizymYnjSy8opkrGaFOIoLD1hToKNABbCwyPb1GYL
D5BhEocLW7YFo9MndNGudGEZi1k9I7/3PMn1F2KEBmzCxtToiNqdqQLEHmcBtjxe
EVsVojTtH8ujbpTiMEb/5mlh9zqW5v2VsXGaJiDZq6heb1itHZ5oRVWP2Aw/OHyI
YJyZgfVMXw3GeEAfNAFt5IIUvvidrmov6y0XPGQvbxHt1Q4LMN1JGDqv/8GOizgv
u6uucQnZ5//f7JZFJE3m/jbvtJSVYmLpy6vF3UgNaa2pvp273wKb0QJop59PeHgp
3gwcGDouoyksZx+oDBDO8DuAuMQUinVzo50Xue1zRI9Nhet5szs=
=Eujl
-----END PGP SIGNATURE-----

--xnis7upby7onve5t--

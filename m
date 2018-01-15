From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 4/4] i2c: mpc: always determine I2C clock prescaler at
 runtime
Date: Mon, 15 Jan 2018 19:22:07 +0100
Message-ID: <20180115182207.7qh7lgmbjzyfyat4@ninjato>
References: <20171230181446.bxongiaogcqjrbos@ninjato>
 <20180110113607.412-1-asolokha@kb.kras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gkqkxt4t5bafj2fw"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40968 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbeAOSWJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 15 Jan 2018 13:22:09 -0500
Content-Disposition: inline
In-Reply-To: <20180110113607.412-1-asolokha@kb.kras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Arseny Solokha <asolokha@kb.kras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Longchamp <valentin.longchamp@keymile.com>


--gkqkxt4t5bafj2fw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2018 at 06:36:07PM +0700, Arseny Solokha wrote:
> Remove the facility for setting the prescaler value at compile time
> entirely. It was only used for two SoCs, duplicating the actual value
> for one of them and setting sometimes bogus value for another. Make all
> MPC8xxx SoCs obtain their actual I2C clock prescaler from a single place
> in the code.
>=20
> Changes from v2:
> - left Device Tree compatibles in place
>=20
> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>

Applied to for-next, thanks!


--gkqkxt4t5bafj2fw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpc8U8ACgkQFA3kzBSg
KbYDhQ//T5k2dJMmV/Pys+fXD7iuwTEKOdqXwiC+yDOSnm3DtLd/tnD6kquLyAmk
vYYGAmHoIjEkuTFQ0LK+rjHh8mekmPLSQTgvLc5vIPBsXSMZxlM+c2IKzvbcPqEk
zMRT9Y2k4rksgLKSxhhxopZSa1tLwEBOvP2SDaAGZg+4dUTfUONxg5+DpQk5rNYp
up5uOAFw33XCwSM4juw2p8WPxK18c5NSMN6Ok1btpgWjuiim3h+2sP1cSe1j/dFI
81Z3dVCt+1NBddD4I/dt1VMXIYJ8/OJ5+o3nAEG/f/J5qnvHboVih2bIiKb+Ulag
iVySe45pOkXE1qMUqqEQ6fTFK9ITXP97hJCC5VYheXCXAVigYlcP74NmDSsM+g3a
1xuT6qtSeSuiSqM+oaQq9G8oMr14o85dkE3eCT1CVnpheE5bydJgSz23j2YGYF8G
Pi2UhMi1WXz2nPTmWWDzYEeM13/GvT2hAEnhOYC1rRgy874aTS2FzOOEmYN50Jxx
7H0IbHoIyv0u0M9qpXU5sXBxgTZNhxDF3ZMfFHDeXkTIf769SymLK+FIpFRvYyij
5yGmBmEsOHvby+GqFOm6EGAY7HOdSd3OyGLofkiRsxE7hNUUtDaCaMjnvxi+I2fy
g1dURp5SRY/O4mMx7S1HbYSRhoYPgvRNjuLsCSK5aY5N0bcU2k8=
=GL6A
-----END PGP SIGNATURE-----

--gkqkxt4t5bafj2fw--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mxs: use true and false for boolean values
Date: Fri, 26 Jan 2018 18:35:15 +0100
Message-ID: <20180126173515.uwotl7myzy5zgkyj@ninjato>
References: <20180123173827.GA24756@embeddedgus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kn4wkx4zrkm2wrcj"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35606 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeAZRfR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Jan 2018 12:35:17 -0500
Content-Disposition: inline
In-Reply-To: <20180123173827.GA24756@embeddedgus>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>


--kn4wkx4zrkm2wrcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 11:38:27AM -0600, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
>=20
> This issue was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to for-next, thanks!


--kn4wkx4zrkm2wrcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlprZtMACgkQFA3kzBSg
KbbtFw/8DdjSO/1dajbtmV7ProCVpGlKqY0thPXwSCOUImNceIjnQjwLybh8y0Fg
5K8rz0OfZglQ2nTNksDtr5tyl0bk/MZ88YZKh0vxX2P1dhMLysg+krkbF0XwlQyP
0VNGba0zn/uqKqj/WOlf9+xIwZnuSKgZrMUIbr5Teo5txSUuH8Zhqbc+Qr3clmcB
xohqNhUqRrelNcsCrLc9AMIOTRQnyD93UKGTsiZw5qLweMBe02qXLr9l07bHxnuC
E05if17x2jsSqXwxgoexlC6DH7qB8TZPeJwk6hPhtZ/OPnq59HMgshBgYBUzrWU8
TkqogwuF+jz0Q/t+ab9QyAltoJrXJulBZIm924s87wmEHcD3EO8XAPvKqQZhmYtb
fk32CD7gUAIK+NrtmL3s9nlN3Kt30CJww8amldnKYVJdo1V2MA8zTmbQbrqHS7Zl
98+byEgUkEgki9/KLOFj8TPL4/i4uIfW4+VbGPIlyECkb7k00itxbaqWATgeJP2D
Eh7fjNhaFLDrPE9eDy+Au2UknRREOmuI8MiOf8lXoed/+08ktaX3c9b/KvLaAJST
yZ4F4/93TYDotdv1CsDOo6D+C780K9foHJEGzqQla/cO3lDG6JTLpnH6oeS2Q8Ze
u4QswZbekDPeA3/AefnWXFCbIIzXRRNigJZAU3kVT5yXUiEAWvU=
=9MeI
-----END PGP SIGNATURE-----

--kn4wkx4zrkm2wrcj--

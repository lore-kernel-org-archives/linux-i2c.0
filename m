From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: riic: remove clock and frequency restrictions
Date: Fri, 27 Oct 2017 21:40:33 +0200
Message-ID: <20171027194033.3rzzcbqcgb3lq4io@ninjato>
References: <20171027153756.90447-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nza6g7ufy7x3fefv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35275 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932438AbdJ0Tkj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 27 Oct 2017 15:40:39 -0400
Content-Disposition: inline
In-Reply-To: <20171027153756.90447-1-chris.brandt@renesas.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>


--nza6g7ufy7x3fefv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2017 at 10:37:56AM -0500, Chris Brandt wrote:
> Remove the restriction that the parent clock has to be a specific frequen=
cy
> and also allow any speed to be supported.
>=20
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Applied to for-next, thanks!


--nza6g7ufy7x3fefv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnzi7AACgkQFA3kzBSg
KbbQnQ/+MphOv6QU/oO2LzpL5zPBtxPu+dm9cUfjJgKIxUkna5qorgXFXRg3pUup
p+1ccVhs6zpQcx6Y6572b5UpP21EpGJsQQVTuxdoTJZI0Atzov4/IGJ5fA9B5roX
o6+chf9y7ZBlS1OKBG7+xGmSGJOW7TtX+oRuP+YolRNlAMfgFctM5eAz/YJdOS0l
8mME7+gkLIM4SI/11gkDdZpn4VEe9mEBs/PJ1kkwSR5iPUEfiKyPwyzHeGgiORSe
D+jG/rw+fVyK3XTlSUqkT2w1JIBjzYR8GwK9/563VUs+87aONFi8+eOjZShgWPim
URjWCjS0VSlz+oIy3hZgA6SnyC4eZ41gXZ3zqyqKwtbR9KapdM9sdnbnlhO8Tnc+
JgVnmerZjWj0vqszbsQpASxl6m0HefumRXA5p8z3IGa8faQR9MMvS21XWRNZw8qa
2bWThmpj+kZhe6p5+OpdP5exLBg/0BZ4kQlRpKIi92abdUZxH+xZxiqy26pm3vuB
VhfFxoTmuoZR8fCTwiBtORUQjV2YglrR1JIzIJwOaIqSbqDnzUUIQFDD7o9nRVGq
zr6qT8H8bMNr/QEHzKiUTBCGqE4e45OOwEbbAJIybfr+au1pt0wPeDOzhZbFFiR9
xN95mL1EFgBE7qPe9AF0XCawzgU1ye4Hl9v7sQyiN/A3vAKRxME=
=Upoq
-----END PGP SIGNATURE-----

--nza6g7ufy7x3fefv--

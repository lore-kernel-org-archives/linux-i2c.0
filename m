From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: Add newline characters into message
 printings.
Date: Sat, 21 Jul 2018 00:25:32 +0200
Message-ID: <20180720222532.o273zjv4lx7rkq7z@ninjato>
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wihqb6kqvskazihp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Feist <james.feist@linux.intel.com>, Vernon Mauery <vernon.mauery@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--wihqb6kqvskazihp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:13:59PM -0700, Jae Hyun Yoo wrote:
> There are some log printing without a newline character. This
> patch adds the missing newline characters.
>=20
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Applied to for-next, thanks!


--wihqb6kqvskazihp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltSYVgACgkQFA3kzBSg
KbYU5Q/8CHYKb4Oz94Wk9vwYE4D3uU0wJ2e48bajqBPX04l+RTqV1MtcpYsqzSai
sF53/0+XEnP3T34bQPTG2LVvrVOlHqT9ufrSpBmujAoZAvlVZ+Vb34yszla18xZn
BcTrkRQIWTnpi+STp59QaK7QQylnYDgNf72qpz1HtmC+Q2ZxLs2XJ/8JzI1e0kMA
yGDA96X3KnSixgDDy0+gH+w99IBjto5pCXKkES7WC3/sweXFvDM0eyF2k21jEqrn
nsP83c9FoeRKloBy7t17nTAUa9kv02vmi1yvjKxbbeGkGUpJOXBhGQO/rzKn2qzC
gH30aMjM3KmzyCvOwVWtTxYMn1corxUnCvPBpll21dtG9TMM84Il6YWOnoT1W6ni
SCm1YHLrUSh+nAxkZNiGMcqFCGo+9x+hesQnvbk5SSMkPH7NWWmRgHkA1X+refG7
9UgHDs6LRrhMXyEvCogi6JP66SAA2UYFMk+ILi6jpFGerf20/MDqZQi+wJvg+DeF
ZOdpmD9NveW34bfH0ocV/byM/QNthYiYqGyIbe33X4ivt6s9lqg4m/qJUkAcp2C7
DOYPo3FuBFKyc6YTOxnOtkgP3I112wMjA3+1sh0oPmkbJS7aLqTg+h402GkbPZzW
NwjLrHaL/PYuubKdypQb/h4W/L00I0KoV1lSOO4ChoJ8IcdV+gg=
=EgKQ
-----END PGP SIGNATURE-----

--wihqb6kqvskazihp--

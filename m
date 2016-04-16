From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 01/13] eeprom: at24: remove a reduntant if
Date: Sat, 16 Apr 2016 22:48:17 +0200
Message-ID: <20160416204817.GA1522@katana>
References: <1460401049-25459-1-git-send-email-bgolaszewski@baylibre.com>
 <1460401049-25459-2-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52644 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbcDPUs3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 16 Apr 2016 16:48:29 -0400
Content-Disposition: inline
In-Reply-To: <1460401049-25459-2-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, Andrew Lunn <andrew@lunn.ch>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2016 at 11:57:17AM -0700, Bartosz Golaszewski wrote:
> It seems as if the second check for I2C_FUNC_I2C functionality had
> been introduced accidentally during a merge. Tt's reduntant, so
> remove it.
>=20
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Reworded commit message (there was no merge conflict) and applied to
for-next, thanks!


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXEqURAAoJEBQN5MwUoCm2w1cP/i9F6PVNvjJ7drDNYmL+WWtD
DGbNBUItaJw/HjLCNoAnPiDRo/dgIXJu8VlfnCFdKt5K6rdCuASepAlAtOYe6n7x
tPpIy319dYB8M6lUeKRH4lbxLB3dj3NTeWtfmTRGeshlpZSpZ3vwNzLVfJIilsuG
ES6zUQHnn1r9lTSnzRUQFCJMwnAaTK2Y5hxai3F57cKFBYqpBa7LyJQUIKjICOs3
jo8r40CGpDsVXt47eRN29VWB+dveQRMPFirhLz8cWMs155hJ3phcext1Exk/wxHJ
o0AhEwQOXU9jzciCz8TvvinzCGixAUHQJvu2I+IAkYPBHTt3ouWwJBdomFxpBfRQ
0Xrb0wZ9uLU+xUfBu0rLEHITLt7i7+JgNQ9fowek25KxUkz7nVwG4xlhKYk/fvIT
IP842Yz3boFFUu9Uar8iR1wXDoU7/ERokXq/d2jbIWFHv748CL0pZZpE3tbDP4iH
V5bn7USM6ZhlZIz23uZLRtALpAvk8DJgUrlYOsZUx9sD4rAMXN5dlo4xQud7KcFR
2YE+Kfswjkcvio66e/06RCngtbJXsveIFckupXyogNYp8rqdRcN7NoRIRgNZf2DU
N8V7nv707n3yLTqpqcjFw2klG64HgehH9yXebHNEvltEEJS74Hp+HDa7zEejhJMu
4JLxDumaxLIX4Fb4BmHw
=VOwT
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

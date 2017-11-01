From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 03/15] i2c: thunderx: Remove duplicate NULL check
Date: Thu, 2 Nov 2017 00:04:47 +0100
Message-ID: <20171101230447.2tag5phowyqsogsu@ninjato>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
 <20171031142149.32512-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="unj7eo6hklfwwhou"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59343 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933336AbdKAXEs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 1 Nov 2017 19:04:48 -0400
Content-Disposition: inline
In-Reply-To: <20171031142149.32512-3-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>


--unj7eo6hklfwwhou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2017 at 04:21:37PM +0200, Andy Shevchenko wrote:
> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
>=20
> Cc: Jan Glauber <jglauber@cavium.com>
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to for-next, thanks!


--unj7eo6hklfwwhou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln6Uw8ACgkQFA3kzBSg
KbZVYg//S8nNw/83KzFTBoA0tTNeNmy0v449PK+DZNxGhmyVcBTDsSltJDJvkopn
S0iO9gUYWELVVZBEqJ9iSmbAxDQfRB9ISM+eC8THE3NLKaNABU1FFOFOAAEVn9cc
EtQJsaDrpVT1x6LBSdxoFmcdNUvMa1nEhicex7VTR1gElWWySj9P4Cq7ipoJ7Oqb
19koZFVNhT5CcZduXPt7lwFqNKJnb9ggmpIiVuCXpUxBTSvCRVW0Q7CCbFJpxQtJ
mVp/4/AvZro92TMrOosB66hq9+e36Zb5y0futY/GidW34oTfmafKE45jCc3yvFJ5
hUN1evHxQ/tenLJerLV94v5+Ex3KZXcObzT+VX2OguUqL8d5zoCfx82e9fSacNbo
SJXcocTtg+M8Qi1TW1IwLnAcOxrsoA8/uqb8Y7uxyrY2P616uuQZFRgMO/pkODzL
G5HH8M7qfvytpmR7l3i8QhzCc3vC9sJKlck5IIuM8wXsmDjyFEoOhouZINFwcftu
u+fzjBLNOJyVcRjfqnVObXKjLauMSmJeqnyMfrCJy67hk4c0lu95Jbhsr0s6eUAY
oFlWTuZZQeZ9K1oom2vCWU4ukZExkU1izW4VN3hcEzvm3hTrTFIxgUKRGlmJZ2XW
M7/I2UM/h959EDblTVoaiBerz18zsD1cbEIjQ3KZZM2AEEuaNBY=
=AVHv
-----END PGP SIGNATURE-----

--unj7eo6hklfwwhou--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1 1/1] i2c: i801: Add support for Kaby Lake PCH-H
Date: Thu, 22 Sep 2016 20:15:52 +0200
Message-ID: <20160922181552.GI1861@katana>
References: <1469457828-9871-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X+nYw8KZ/oNxZ8JS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50304 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966588AbcIVSP4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Sep 2016 14:15:56 -0400
Content-Disposition: inline
In-Reply-To: <1469457828-9871-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>


--X+nYw8KZ/oNxZ8JS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2016 at 05:43:48PM +0300, Andy Shevchenko wrote:
> Intel Kaby Lake PCH-H has the same legacy SMBus host controller than Intel
> Sunrisepoint PCH. It also has same iTCO watchdog on the bus.
>=20
> Add Kaby Lake PCH-H PCI ID to the list of supported devices.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I guess Jean also wants the table at the top of the file to be extended
;)


--X+nYw8KZ/oNxZ8JS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5B/YAAoJEBQN5MwUoCm2KDoQAIeJ4wJa5ddEbnu4RCugpc1e
IBK8k1794btl8apv4DrmXsPIbJyBf25uS9anioj+a5OAhaww2b7uekO3RIA0HF+m
L7AWIGVOms41RwlobzXEGlBK0TTv/qmBL7uUKpjEfUvy6MJARyJ/4HUdwZdZt/H0
HNBohce3ljQZ+TE153FnwDj6RU0QnRyppDYZLvLUWX+FZ/Ysk5a+r26r7gqPUJwJ
adfZ7mao9Kio97tgehbMIt4UBI4CqTKicsGvMmq/QlxweDveOSv84pu3ChWaEojs
8X0wTtemdHjwSKPBliYqFuTA/01KPZnzv6R1mIr9MA6MswW1beCdCy2KngGr/ilf
S4rdDV5V50FsFp0JabSiMCEC8HdYq0mJASc2Z/pjMRW2GsoKdm+J5RMdg+RgWc6s
keq7pZi4p2Ga7Rix9RQxXHE6mGwFI9HxASNoxHRtnLqbb6TUK1RttxK71cBQnPSI
tmP3IaE2IdAYJAce5m8Oyy2QGt66QpvbCotWYqKAAlF7JjU3I6e/6+b0ssXQf6e2
jL6eueiF4SbFvKvsM0cbTWKSevjES1+Yyooykr3Rvx3K08dzCr/pCae0h2aoY7AO
Fh1/Wns/mMeCY11AQyhff5mMppdVVtqUWwN/Oft3lx61ZwUmZZHLFoV2HqFSb8hF
fEsYWZiiYcrrEukB6wy0
=f54+
-----END PGP SIGNATURE-----

--X+nYw8KZ/oNxZ8JS--

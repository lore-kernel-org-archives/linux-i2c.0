From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 0/3] i2c: Hookup typec power-negotation to the PMIC
 and charger
Date: Mon, 4 Sep 2017 06:56:47 +0200
Message-ID: <20170904045645.fb6scegrypdodvfl@ninjato>
References: <20170903124156.7440-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rng2v3ppofqxig3k"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170903124156.7440-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--rng2v3ppofqxig3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> The first 2 patches are i2c patches, if you could review and
> merge these (preferably for 4.14, but 4.15 is fine too) that would
> be great.

Definately for v4.15 and I very likely won't be able to review them
before rc1 or rc2 time, if even that. Sorry, but I2C core changes need
extra careful review and I2C maintenance is largely done in my limited
spare time. If you could get other people to review/tag the patches,
this would be very helpful.

> Darren, Andy, the single platform/x86 patch in here should only
> be merged after the 2 i2c patches are in place, otherwise users
> of the board(s) in question will end up not having any battery
> monitoring. Also note that this patch applies on top of the
> "[PATCH v2] platform/x86: intel_cht_int33fe: Work around BIOS bug on some devices"
> patch I send out yesterday.

Is that dependency for v4.14? Would it be an idea if I take the platform
patch via the i2c tree then?

Regards,

   Wolfram


--rng2v3ppofqxig3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlms3QgACgkQFA3kzBSg
KbYRvg//ULvFA59lQDA9fSe0goAUkDYhlCkTt/gohCVBrASpOyjAOIeimgjAQU9d
UhLI+2LJ3YzlE2oSfMWJ9I5Th9Y72O1XQT1rEGXiydQKHaK7OmdXyLB79kuM3FGZ
OFATrp1MZMDgNiJwr3yI7khBdyufF6tzotBF0KXGWD0EOV5ILetKnYqHLMis3l4L
77M6EGPjxgkTKP0DRx5lXIq+YV3Nn57eHt2rrR7mJIDnjDeW4jOCb4pgKUeYMA9r
He68vBRFgMKMUPuEzSK/lgY5ZF52ZAiqPParnu3SSxv5KUFTvGDuO5veAxO/dlA3
XJcQAucvnogZrO/WjpSL9MG9MpFN3QjkE9oDtrXHlPOZvFlgkz6jq2gLQniCPAre
moyzXQp60zAfAqLhZJ9XxJHarFcuoMznGSRNxg/8lbMBfjXgeYQuzFeixjwOhXZe
zUwhMj/6oT2V891YXNM8qoHpsDVF0S8T4kOmqn2YNya/ZoZIw1jkIlphVtM+Dg9Q
3/fpMh2TSrd49hHgFPlr5o+HKEeYmifglYK2HGSPVWrJ0bsMqSuIynYIP3vzMunr
a44q8nqcC60zHPBjcpjOeyibYXpLwo48HGwO3YOZ7OmD2gMivW0vR40lGkGm+oIm
383pR5SLhpnBZalvoW4vsm3zftq0ukFbb51g9bnSfO94lAQgw9g=
=+qVf
-----END PGP SIGNATURE-----

--rng2v3ppofqxig3k--

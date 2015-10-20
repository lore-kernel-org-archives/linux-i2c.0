From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/6] i2c: ismt: improve usage of devres API
Date: Tue, 20 Oct 2015 16:47:30 +0200
Message-ID: <20151020144730.GD5379@katana>
References: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1443437132.8361.237.camel@linux.intel.com>
 <20150928110154.GU1536@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43195 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbbJTOre (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 10:47:34 -0400
Content-Disposition: inline
In-Reply-To: <20150928110154.GU1536@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-i2c@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2015 at 02:01:54PM +0300, Mika Westerberg wrote:
> On Mon, Sep 28, 2015 at 01:45:32PM +0300, Andy Shevchenko wrote:
> > On Wed, 2015-09-16 at 17:23 +0300, Andy Shevchenko wrote:
> > > pcim_release() will release any requested region. There is no need to=
=20
> > > duplicate
> > > this effort in the driver.
> >=20
> > Any comments on that clean up series?
>=20
> FWIW the whole series looks good to me,
>=20
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied all to for-next, thanks!



--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJlQCAAoJEBQN5MwUoCm2yuMP/jLRYFhRp535d9Ys1x3hw1gl
5u5yOlr4kSzxji3EpAi/PuylaWRyedoEDsaWg5sgGqxn8hkYwIjsKkoT2dSD1kqG
1l9ZjwgGiPE6sST2flWYjig4gkevWQ9zhZ/QaAKT3s7n+Lv295k2AvrTqJDhQVV7
2qhxhvDNNdZrSEm2uZeHpVfhmmz+f/t8dffUICkV3NtDqEDlAMzv6YiiYrHjx6k+
a6CLe1K5+HCEDwsS70QHP/9KHxqp20/vIbhX90CxocYKERhkQmCdhwqSX6p/gvQX
cB3DsIyANeAle+edbuXwh7K+aOMd4Q52zq/SdnIbzg/9OsNcFnYuwKdbvBoIsXaH
ICGB5ikwmzFVkQq71oWMNoIW78KwAAytvvcCDKYUn/WmWQ481It6ASs/gllBVUbT
GAXYuj0B+ZIkwFrJWyKfJuOdTc3B7TNn3oAMaxQfwk96aay+Qxgqj5tPqaYQHBNu
wbhDNkOVCQzlj8Pr6TrgXMElYDYwyFB6BwW6570HaLfZL+CBSi9/rB1nKqlBZGS7
QT3rjKpa/gJZ1KKd+LJYqZrwbLnUcI//Eg2oxzj0zKlcAGw+wnp+J+28AsBsapj9
GLnf8NV0ZC4pI0CN7qN3Zz5n+BKFtjmjTwyhrT50z6Jy930ewX6delCSmsjo0FUk
IRpGAj7ypa9fXJWTU/3r
=5v63
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--

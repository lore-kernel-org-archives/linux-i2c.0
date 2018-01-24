From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 0/3] i2c: mv64xxx: Fix clock resource for Armada 7K/8K
Date: Wed, 24 Jan 2018 07:35:07 +0100
Message-ID: <20180124063507.swvhh3cy5au2bfbu@ninjato>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x5eavt4rbk2pasnt"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:53993 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752206AbeAXGfJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 Jan 2018 01:35:09 -0500
Content-Disposition: inline
In-Reply-To: <20180116163540.1092-1-gregory.clement@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>


--x5eavt4rbk2pasnt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 05:35:37PM +0100, Gregory CLEMENT wrote:

> This short series fixes the way the clocks are used for the mv64xxx
> controller embedded in the Marvell Armada 7K/8K SoCs. On these SoCs a
> second one is needed in order to clock the registers. It was not
> noticed until now because we relied on the bootloader and also because
> the clock driver was wrong.
>=20
> Thanks to this fix, it would be possible to fix the clock driver
> without introducing a regression.
>=20
> The first patch is just a small cleanup found when I wrote the main
> patch.
>=20
> The last patch is not related to the series but as Wolfram to have a
> maintainer for this driver I added the patch here.

Thomas, Andrew, Maxime, any tags you'd like to donate?

>  - Add a maintainer for the i2c-mv64xxx driver, requested

Well, I'd say "asked for"...

> by Woflram Sang

=2E.. whoever that guy is ;)


--x5eavt4rbk2pasnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpoKRsACgkQFA3kzBSg
KbYfEw/8CjbhjwVrGLb0PQrLZ9135NdZppRLgNZqmZtfOKz1H7JPzB/ZDLjHzqr6
b3/MQlUhzVUB71tzHsOgtZV+j7QVfpl/TFc3yp11A7/9EYIGtbfdLwvYUKzQpx00
Iu2ilASmkxuuJ4DYJKoLMniqx9K2d3RkfQYtEhDON+s2WFlRZnYybvCg+E49a6H1
uyN8fd7H7RtCbKtemLcWD9h/tEJLSnyz5lHajaDFqMuRvghVnMUXrO5VqlSu8eQa
Fw46XTdSIt45ea4jQlU5IFH/+zUmzaIwTft5OscfqBIQY8gu730jVOZi1tomr0kk
WRUNp6QmVSyQ7Yf0kG0F78IsTlSOrvfeTRW+Ld9pbGuTGXFkTmoNC7G7cM84J4Yj
sn1W1tGV8+wBijbuI8FlZbjgJSED+aT4XMwZVcaffcESWvcsPrNgEUhBC2+nSH5u
+W8m9xDkjeNhKXIuNandIv01m762IpUiwmUgPrD4ryo+aLBUVU82M2/8VCbqOtG5
Hs/5yKJwwhjp5/LovRgsZCDdX0WQ0t15/QO1f7KRxFQGsNUAuLv8ui1w02O03NCu
xAafsaDpX2bsli7QC2gUfJIzPp5JEOXYp4UQQ4jdWsHQ8Z+vNiFYXvE4Hk5/HmRV
GoxmqWJFayPqTLLDksg6YV19SZoQkLXwGuWjBl7cIA5cHiDAg0A=
=jg98
-----END PGP SIGNATURE-----

--x5eavt4rbk2pasnt--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 1/3] i2c: mv64xxx: Remove useless test before
 clk_disable_unprepare
Date: Fri, 26 Jan 2018 18:53:45 +0100
Message-ID: <20180126175345.u2kobvakug223txs@ninjato>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
 <20180116163540.1092-2-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mqylcd6ouxgu2lxv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35695 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbeAZRxr (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Jan 2018 12:53:47 -0500
Content-Disposition: inline
In-Reply-To: <20180116163540.1092-2-gregory.clement@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>


--mqylcd6ouxgu2lxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 05:35:38PM +0100, Gregory CLEMENT wrote:
> The 2 functions called from clk_disable_unprepare() already check that
> the clock pointer is valid: no need to test it before calling it.
>=20
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to for-next with a shortened commit msg, thanks!


--mqylcd6ouxgu2lxv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpraykACgkQFA3kzBSg
KbYFiw/9GfJFvskqnUa0MuG9chbI+4URZbSkZ2LFcmNlRwBZubvPPS/Fz8wPBBEA
BJVc4cy+xGcSBjYKkac8jd10l2qswHqPgl1sM76gMsUfxBT/KSNOwpXb2xKjaIfX
R8xDa+lYiocwMrCQIsbIfR/zN2CeKoUH4H/HA+4cxRArWR7ti/+sqNEvDsbgm+km
BJQL/iNlt+7/LOniyKh0zK1y5s9EseTxpzxyhjBYIQX41O4bEy6v3+FZy8P/ZncY
fYKAckQB/3yy8lMMg1920c5PTcYMnbWwGLetnEkWr5MlYSXgRZVAlRJkuVoui96l
1bHgGhef5ywoTxeq1Zd8DAFtzKNVuOgeVy0F6zSEccKMsvulEhKejP7EDg4KuMWt
XKRY153VNrY7VeC3w1QnyS6fERD7UrmQzdppmjTVyLpcCMqbzYpv9iKVTxCQTPcS
5AEp6vPyYJ2ydg1kSQaTerARqZOkVZfiMIP0zqT9hHGVt/dIbPAVMADqVziKG/QF
ARntSqm5T3qqspG69q+/3156AcfyRLozVIFA8LDcH3SXCD1RKKx1iGFey0qlHVZ4
f3PN/paZsraCgZs3ViYbKT54BIKg1NL6ndIlWn8UOOhRDTMQvs5mn3t8j2zzWHIh
poWxAj6vT0DZ6SAWLUKekNRqS7xcKrim75CrLksXUKo5evTxS/E=
=DJk6
-----END PGP SIGNATURE-----

--mqylcd6ouxgu2lxv--

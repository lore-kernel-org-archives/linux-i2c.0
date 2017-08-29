From: Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH] i2c: aspeed: Retain delay/setup/hold values when
 configuring bus frequency
Date: Tue, 29 Aug 2017 18:16:29 +0930
Message-ID: <1503996389.5933.9.camel@aj.id.au>
References: <20170815072102.23067-1-andrew@aj.id.au>
         <20170828160702.x45hagij4kkm5zzc@ninjato>
         <1503989809.5933.5.camel@aj.id.au>
         <20170829084508.edybxf6zctgx4xwy@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-atHR4LNRxbeydv6T7sas"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170829084508.edybxf6zctgx4xwy@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, brendanhiggins@google.com, benh@kernel.crashing.org, joel@jms.id.au, openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, ryan_chen@aspeedtech.com
List-Id: linux-i2c@vger.kernel.org


--=-atHR4LNRxbeydv6T7sas
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-08-29 at 10:45 +0200, Wolfram Sang wrote:
> > I'd argue that Brendan's patch should go in for-current as well,
> > because it fixes a divisor rounding error for the ast2500 (bus is
> > clocked faster than requested).
>=20
> Hmmm, pity, the description said "potential" issue so I decided for
> for-next. However, I wouldn't like to reshuffle my branches much so
> short before the merge window. So, would it be OK with you that you send
> both patches to stable after rc1?
>=20

Will do.

Cheers,

Andrew
--=-atHR4LNRxbeydv6T7sas
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZpSnlAAoJEJ0dnzgO5LT52FMP/0msIRm4eNiY5zCU3cDhPzwu
xtiEkh9xbUtS39IEVEthjU6xop7gk8fED0xdoW8ZVqwDNmHbcoAuKe+OrjUq6hf1
UQ6iM5KzFVdzpiZYaStheMcZIyiJBcdd08xKPPVEoR3K9jRcdruh+X6VVNWshmkr
Lpq33lkAIML+FB3Z9pkQN+IZOYfPhKkNyXxzYC2e/pO8qpejl3oQIsxRTUTNrSKm
7tAFSQcs/KUF7Mf9RyoCKIjpGrY2fhRGUzcOg6E9JTpqDklvSKroQtA3HtlJK1HW
CmjRE0rvbDrcu3TZsRDjgwoV5FJAyek4+lZqq5CkCgZ+NJb6v6LrL9ERduj6O7ms
DLODsjMPNgAQY6V5v6GpqoiahDjiOj52nDTjcYvH4UV02Xt/QabUjT45Je6Ir/60
+D7YSk3YStpSuC5JhdaXOuMaYbpV1IvM0z0aMquGvTeyCtJaHvhwuHVN/ME898Xi
FFbtBCDj1FRH7AtdmmvYt+HK3PSGQL+HtRjjEDi24h4eIonMMg1XkLLZ9Xt/2UNT
uLVJreShMH4NOpTsW2sPpq1rNNXGKoefiRx8kXX1Ks38pKXnOGMHLoctxlER9ZEj
UHtlf/cHwCuo/YOABpl43SVN8sAYtpH89zWu8bkuA8+pJo1UNqPyavQXbNsLK3h0
CymjDnN3oN7gVVNw8m8C
=YSuO
-----END PGP SIGNATURE-----

--=-atHR4LNRxbeydv6T7sas--

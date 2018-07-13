From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: aspeed: Adjust spinlock scope in the irq handler
Date: Fri, 13 Jul 2018 22:33:27 +0200
Message-ID: <20180713203327.47yq4gucidbzn2hd@katana>
References: <20180702214011.16071-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g47nBCbF0mcYqEnQkDpz0Dhh0F0S1-wEL_yBHgs1b3yE5w@mail.gmail.com>
 <59538d26-f025-28da-63df-f675e80fd68b@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ozu3yupwr33o7jaq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59538d26-f025-28da-63df-f675e80fd68b@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed@lists.ozlabs.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jarkko.nikula@linux.intel.com, james.feist@linux.intel.com, vernon.mauery@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--ozu3yupwr33o7jaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> BTW, to whom should I ask applying this patch? Should I send v2 after
> adding your reviewed-by tag?

Not needed, thanks. I use 'patchwork' and this tool collects all the
tags for me. If I see a patch reviewed by a driver maintainer, I'll pick
it up in the next queue.


--ozu3yupwr33o7jaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltJDJMACgkQFA3kzBSg
KbYP4g/9E23oqMyK0JpzXmbmzTSnMNugOQyU7Ajmny8NuRdCXosPPPKdUchFUAVJ
n9HrV0Xz6cwLhI3MSljKy1l089lFLi9KTwwHaIZwT4qOuZjQkSGOrGcyPiN16SPX
/eh8KmGZKxQ8ve5XSwJaMjxwJZjKTNmv+KP1gmWjJTGhQiPsFVVy+s4X1XGioaB+
UM1X1u6k7HiXHfQz3QixfpIWhinj5tCDSU8Z0kolbpKb6JKEtMY4BGRoLAXd8q/s
iOfflGzYbAZvs/j8PghjGCMRtBVw2DoEyow8cA4oDaqal0doOp2g5E2WIjOKSgB2
W+98WRUqXlHE5p7Y058hvhIbBBu1V3hYqIUzlhBvEkekwe6BjnMTZvZkc4ZPqnmQ
LdR9jnVMfitNN+f/Yk7PhmhvzJmgVOxAHnPpAnc7lsfJB4DcQKicflRy7KZ/O6OV
zz1O10QTfP6zoopPdlS+UiuQhU8I8s/KyJ5clx0cdYvXTPD3nc4jyrcKAWqrRviy
t6xqrJtjLgZ/RbWvrqRomHiGVn/7IA+mMkg29nHWC0T0t/kg2Rj3wD1rkYDIcNcz
FpchlqC5qqPVD3Ch1mbp4sEfAv4CxsxmPWefIv97exyJOaYpXyNWHGU/GFnUB4o1
U3qPj5dWKTLMh4bqSJeTlApFxnLCg+0McnpZyqODciKV1NuKeDs=
=atsj
-----END PGP SIGNATURE-----

--ozu3yupwr33o7jaq--

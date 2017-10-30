From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: aspeed: Deassert reset in probe
Date: Mon, 30 Oct 2017 21:12:34 +0100
Message-ID: <20171030201234.oykbmdy7xdbwnh2t@ninjato>
References: <20171030034438.26482-1-joel@jms.id.au>
 <20171030142446.rsvytlcfcuhnkhdj@ninjato>
 <1509393946.26914.0.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rt2se5kknt3tscsa"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:48854 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932405AbdJ3UMg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Oct 2017 16:12:36 -0400
Content-Disposition: inline
In-Reply-To: <1509393946.26914.0.camel@kernel.crashing.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Joel Stanley <joel@jms.id.au>, Brendan Higgins <brendanhiggins@google.com>, Philipp Zabel <philipp.zabel@gmail.com>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--rt2se5kknt3tscsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > CHECK: braces {} should be used on all arms of this statement
>=20
> And checkpatch should die a horrible death, so what ? :-)

I buy this to some degree...

> Sorry, I can't help but trolling here when checkpatch enforce obviously
> disgusting and wasteful coding style.

=2E.. but not this. Most if not all code in my subsystem adheres to this
rule, and I value consistency.


--rt2se5kknt3tscsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln3h64ACgkQFA3kzBSg
KbbOcRAAsrM3PDUkva4bXIj1dHBqJEp8PALKf+vGGzwzFIoeurCmN4CctMDT9Xx7
1yjQgWsgECmg1RGjVZAcy3ARG5SKVjxTwlQENg8HNrKMmq+WJ39OH41sK9kZIQup
R1qoWgPS9ZcaagG6mdZuuodFFbdJsKw09iSrTu4IsularvedQ9UJlwdsxUAd9KdX
Li28mdrQz4y3fzDnUIJTRprY5DZm28PXm62P0VS0G1WUol7eE6sehhg/I5Dq4ZKq
KGBhjt0rsPivk7xaQhY0UJc7Vcso7XTLuSRFS6xl3xr1ef8+7pHydppCjpMIJxfn
Rnmf0IYC5sfOGv0b3oGa5SS1un1qMXPeQWdRbAHWyjq1SDbBTZD1VN0pKKhy0MUs
ph9wEbXWjEjm3xdyW4Jl99bQ765CG/yN2LykPypqkF4xTQQxQNFsdlBptPbPjd3h
8jp1PfcE0q139zynNB6g0KIki5mTNdPmJwqWx/x6pWUiW11+fVEnmslHzHBne8Oy
CjrMeQ8PcTwjnNZ0XuI94k9cGpulcspKfxlSzU1VsPmeR7jfnMOmUhhtxlTE0U1R
wEeGmjo1M2spyMrlkzuXak+13sKozHD3epARsAMHyCyBnr2X4GMbwztEkgpYY5Au
rrlY+Q9o/xnjo2Y0DkDje5zg5PmliIaAtncMLGcV/yi3tJFMo1w=
=M+/v
-----END PGP SIGNATURE-----

--rt2se5kknt3tscsa--

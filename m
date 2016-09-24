From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: uniphier-f: fix misdetection of incomplete STOP
 condition
Date: Sat, 24 Sep 2016 11:19:51 +0200
Message-ID: <20160924091951.GF1434@katana>
References: <1474637681-9589-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Bqc0IY4JZZt50bUr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58919 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761600AbcIXJTy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Sep 2016 05:19:54 -0400
Content-Disposition: inline
In-Reply-To: <1474637681-9589-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--Bqc0IY4JZZt50bUr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 10:34:41PM +0900, Masahiro Yamada wrote:
> Currently, the status register FI2C_SR is checked immediately after
> a STOP condition is issued in case of the deferred STOP condition.
> It takes typically 5-10 usec until the corresponding bits in the
> register are set, so the error check for "stop condition was not
> completed" is very likely to be false positive.
>=20
> Add wait code to relax the status register check.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to for-next, thanks!


--Bqc0IY4JZZt50bUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5kU3AAoJEBQN5MwUoCm2SwgP/jIAGJdcgSj8gnc5+9LlrIpc
z3GweqAMnMK7NRLrBIC37lcZLqctCtQs4mgbnKKaUqIq2vUBYrIg+E76fnW6dp6y
axbetfRMgQIU295E5fN8Xbi+BT1F6NspnffXXQgCn35StvjMsnYImszJVgU9Y2xn
5ID45u2BniTS0tGX4V+RLlZpgj0X4vj/8QxEH0eDTaWLBp6D/2pCjWmIU+407syQ
e6xmQt9ndF+E45i1Tanh/j3UqY+YvUa6pthQNBM24sJFCis8x8XhznpSaySjWWzy
jhjufvzdtWAQixpNRuTlIqstn1weQoIaCl41oHWATYGWRPRnbeCCV5B0ul4yGwPe
dNh6odXyijvOrmV61PG2X7y9NjFUHXF++RKxmveVpaOuY2DtKDQnsiUjZb1vTuVm
skjiNBER3mZEqZaM3WSlMDOjgekzfzqQmnYUqjWrmAMUygKgXCXTDPWAN98tcDSY
xhnoVJGb1j2TRw+5mvQ6TcchGiKi43nL8XhzdLFWNHWj+izInRicfWGBeCB1jhsL
7XWEn5A9LqLTdYt16ztwZNZwLZsNuSZR3p78Wq9mbZGIjRAeHybAxDFWmxIxtjoO
kQG5jNFkezWqdenFqA0Fxh6GeqwJpfwSrvD7kK8G/4TQ3B7DVqi5FCAZI0z1jqkL
ij1jWbixDGy73H+aBBWD
=Q7kY
-----END PGP SIGNATURE-----

--Bqc0IY4JZZt50bUr--

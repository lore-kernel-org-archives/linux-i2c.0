From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Get selected speed mode sda-hold-time
 via ACPI
Date: Thu, 23 Mar 2017 22:00:48 +0100
Message-ID: <20170323210048.c45uiolhdpgqfk5o@ninjato>
References: <1487051641-31927-1-git-send-email-chin.yew.tan@intel.com>
 <1487051641-31927-2-git-send-email-chin.yew.tan@intel.com>
 <20170323205825.w26jcbv6gz7wu6zg@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aund36unu4kzkp5d"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41133 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756113AbdCWVLv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 17:11:51 -0400
Content-Disposition: inline
In-Reply-To: <20170323205825.w26jcbv6gz7wu6zg@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: chin.yew.tan@intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org


--aund36unu4kzkp5d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> This describes why you change NULL to dev->sda_hold_time. But it doesn't
> say why you introduce the switch-block instead of populating all fields
> like it was done before.
>=20
> Furthermore, since now there is no NULL case for dw_i2c_acpi_params()
> anymore, we can remove NULL handling in that function, or?

And since designware driver had a few changes meanwhile, can you base
the next version on top of i2c/for-next?



--aund36unu4kzkp5d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUN4AACgkQFA3kzBSg
KbZK8w/+OL998xLpm8mspbD+Wh/iYkSJjyUkKb65BE/yiOcH0QHXbyinua1FZInw
y9Zl0+6Mp9IJ0fcADBjvLwIh8+QleXj9gKKNFExjUY3EBEKLsKfdRa8eBt8yPWXj
1ogJBjqv0Za9wypy+H77QZlKCj/8apuT/6rdxvbhLjhS7+0VIWCo2c5JkLplWyaG
GbsrgpEm5afT84C7EmP3R6a/Qf0MCX1BnKTRyUbZl5O5vvTP4CEMhMiJblahUZXp
p+lrxQEt279dVDzaw18bUJ1/mY+AgcPBT3SxuzKxZ7kELFC3IPjAEO0STiNl0pq+
uozOWjZfUJljoQhfskg2tWQuuSazotVjwPjzIDuonUifnMM80BD/sYENzdtlZ+41
0bgBHFR5nEZhdUYC5BfZ3EOLBEfxE6qn9/RX9ke0AAyU1rCHbgYcJyLs8dTdDaRx
e4dy5jivQOQtTnS3KAmnaKdkWpV+AsKA2p7oqSv6lIHFFu0fdYux6X0LP1aeochZ
WSlYQh3P7YlRZ5NVI+Bs4uAtb4R2KsNk55QHRz0Gs2RbAMsuszz62hdK48Kn9akN
11zabNy4Zl8uNdwVkElg7vKmaZ7v+d94LMcZuQNLQcAxpQ9XF5T2Hgx30pNyxd1k
vEJEX7kGBaBXlTauBfOFPKKmKBoYYmq2AGU1TRwTmlfo5KBu49w=
=aXxU
-----END PGP SIGNATURE-----

--aund36unu4kzkp5d--

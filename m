From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/4] i2c: pmcmsp: Use proper printk format for
 resource_size_t
Date: Wed, 15 Jan 2020 18:45:53 +0100
Message-ID: <20200115174553.GI1239@ninjato>
References: <1578992765-1418-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39068 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728896AbgAORpz (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 15 Jan 2020 12:45:55 -0500
Content-Disposition: inline
In-Reply-To: <1578992765-1418-1-git-send-email-krzk@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +			"Unable to get memory/io address region %pap\n",
> +			&(res->start));

My first thought was "parens not needed"; not because I like being picky
but because it doesn't look more readable to me.

checkpatch agrees:

CHECK: Unnecessary parentheses around res->start
#30: FILE: drivers/i2c/busses/i2c-pmcmsp.c:278:
+			&(res->start));


--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4fT9EACgkQFA3kzBSg
Kbb91BAAjPtROcvdlQNblLFk8PxjameI1NyWeapD6DkN0jImw+pfJ5nJFMnOu+Wh
F6XntHHABtG0TIZrWZcaapSG2HtJBxJq1+1H00YyQMtlUqKnBsqZCcJ0qavL1Of8
4QoH/tLRxc263i7eSKo8Q/v7NJdrfzf6SXDGj0d2uyOgHXkiBcbiw7YOeIruvgF2
nPCAe65wsLvlS2/oVyEGjSuguyiFvkhz5y75LikWQ6KPA7mOTYYlsDFldEI0Jr0n
Cjcp26950LR3uH6dkPnKJncyvgo+bqTCXty2VQZriONaIM2BgsziesYD6lZchTvT
0OyNUxrFbM6ajIuwtLD5HMiQ7GmvfHRABUscFjhWutXrjyBTmLKiWlDHMsVLnYwb
z07XxGhjmufTlBSPI4rXIZtyMv81+aQGagjZXWDwefUnsKQjilb7DFo1f5fbnsxC
sKO/C6Pi4scgwXvUCBgok0xczp1jVE2NhVLgATIvSiGqzTaTSt0xzlIZd06bStO+
uUBiyilC5TPyGU9npLRLvcaDg2LROH9UrTrb+vZX4qz5EOs25uMKb55F9oLtC5cc
STUdu4uesKZgQc6xQEZ5ZoiuWiXTr/HZ6W8sBeaIO74SLgo+g4/6mtyaRBkz53u3
vibl9z27lUGZskp0ClfuU5AD1mH0GnRTizBlJmnZIBTmmzKM5bQ=
=cFSU
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--

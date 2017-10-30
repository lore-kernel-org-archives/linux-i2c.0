From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: aspeed: Deassert reset in probe
Date: Mon, 30 Oct 2017 15:24:46 +0100
Message-ID: <20171030142446.rsvytlcfcuhnkhdj@ninjato>
References: <20171030034438.26482-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kpri4qyidqsbziot"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47538 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751694AbdJ3OYt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 30 Oct 2017 10:24:49 -0400
Content-Disposition: inline
In-Reply-To: <20171030034438.26482-1-joel@jms.id.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joel Stanley <joel@jms.id.au>
Cc: Brendan Higgins <brendanhiggins@google.com>, Philipp Zabel <philipp.zabel@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--kpri4qyidqsbziot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  #include <linux/clk.h>
>  #include <linux/completion.h>
> +#include <linux/delay.h>

Sorry, I missed it from previous reviews, but why is delay.h needed?

> +	bus->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
> +	if (IS_ERR(bus->rst)) {
> +		dev_err(&pdev->dev, "invalid reset controller in device tree");
> +		bus->rst = NULL;
> +	} else
> +		reset_control_deassert(bus->rst);

checkpatch --strict says:

CHECK: braces {} should be used on all arms of this statement


--kpri4qyidqsbziot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln3Ni4ACgkQFA3kzBSg
KbZKEg/+ITxM9qPseyiyQ3WoZvbcedurgSUWiJ87KtDJ9iNdM3GWxwa2ORXpFg6v
gZZraH/S+opyLWIK4Orvfrgi/IG8lDTnf9Nc2MqbsaqwxlF6H8X7yb49e8fn6mN3
YbuOFforcJMBdXY9rMBMj57JUcBQaLPzw3nZaR2fes850IPRPKA/KUQZpfBgN+C0
7MXK1KwTa7HI+gkpyVEynY/dMXRkYGrYYpbwtZDKqjPOZhRVxA8xKYpePKwNhuPx
swmfwFHK+8qCC+F9SmSd3EEUTOl99scanwVaf4ErNen9LgY39vcXmBglDc9XKKyU
JDVkSjVLPFMobeG+Fbnpr755I4NBoknzRJ/tQVboCQaoWCYaIcrerFKwaPCZyjgZ
Hy+XuCOzfCX6X9ZI6QxHclgpGq4IzUcV7YflMDZfOPkNc5zJF6tvKfN9XE1PKHGF
HZZ+H19+bkdl9pNvjyfMY0K9TS37f1CgtjVbUQ724GpBdEM3JnzFkf8P8rtVqZxE
j8eo5a6wHbBOZONfhkPZjkvaKX9s07jWmj7kB71YdoXKytpw8Q2MklVIYODzeaQt
rZ5jlgnFD0g5DRFAXBwmWQneXtoxShEOCZBn2X9HvcTUBh7NTD87PY/O9FN5bc6G
bFHVkkj5K1VJ7Q6COy0UJHPDJZYyMCbm9qikw0mviZO+p/vPdVw=
=tKtz
-----END PGP SIGNATURE-----

--kpri4qyidqsbziot--

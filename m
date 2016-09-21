From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: xlp9xx: ACPI support for I2C clients
Date: Wed, 21 Sep 2016 23:17:25 +0200
Message-ID: <20160921211725.GI1513@katana>
References: <1473967659-9000-1-git-send-email-tanmay.jagdale@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46807 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932959AbcIUVR3 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 21 Sep 2016 17:17:29 -0400
Content-Disposition: inline
In-Reply-To: <1473967659-9000-1-git-send-email-tanmay.jagdale@broadcom.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Tanmay Jagdale <tanmay.jagdale@broadcom.com>
Cc: linux-i2c@vger.kernel.org, jayachandran.chandrashekaran@broadcom.com


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	ACPI_COMPANION_SET(&(priv->adapter.dev), ACPI_COMPANION(&pdev->dev));

No need for parenthesis in the first argument.


--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX4vjlAAoJEBQN5MwUoCm2YP8QALLcuvM2KnHNchZQMCs6QfJJ
4aSkDJY/IIxTg0ttcRjDP9oqJcpn80SLUFbcNIIa7T3jE6EvcA0QyPOGCbcsuCPY
DPQryFA7GAaV24HrTYKL/3wDyJnZHGEEz8uYs4m7KlUhYK+qab+ZOzSPK+ZWHlh9
KQIIwt/9jp25ffap45U7heB2GYBdTxHlGbaHumkdbuSltDQ7QAF7GwDwyOgZS5FE
Tw7Ipc0EeL0I9m8Z9SUMS4qX+i2xqG89WSl8Je9g4i/VMRi3UUTeGs9xVmLRalKj
asE0+O04vdADT4mkFT8Io2m70C4Jv0jTDBmSknIIps2P07V5z8ZsvMiEpIjd9hgQ
STfD/9Yxai76Mx3HqACYwxTR8q9cB6qctxcZTFFVoG92xl60a5lg3GvC63qIBVyM
l7Tlgn0acxx9h2ML4KRkob0Hg5CfneY6O4C5TZrLc4ra5cEpaKh6bYU1ecW9iWXT
Cqq3hJTSyMCapfNc7wz/fklLaqipp2m7RLr2wdIs9l/22IHw8lVwQEjejol5HVw/
WDh0hxmxnZu+SubSKFG/Lt93faaBdg5YCkhWOOT1cmaxl61WfPsD4cSbzS6jUtg0
1qGcjlM2Ih17LZqFgiwOo7kSdrGDdc9lS1cZKv7om3t+fvHKDIX7VcuALyZcZD6g
V11odJc5aYWqKTRIGjiW
=w9lT
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--

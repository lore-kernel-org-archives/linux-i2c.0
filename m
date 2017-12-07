From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Fix port number check on release
Date: Thu, 7 Dec 2017 15:33:48 +0100
Message-ID: <20171207143348.tvxvzehzf3b7cgmv@ninjato>
References: <20171207122545.1b8e17c6@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hiubdbrglfduforp"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:56333 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753800AbdLGOdu (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 7 Dec 2017 09:33:50 -0500
Content-Disposition: inline
In-Reply-To: <20171207122545.1b8e17c6@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>


--hiubdbrglfduforp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Thankfully 0 is always 0 no matter how you shift it, so this was a
> bug without consequences.

So, why do we shift at all?


--hiubdbrglfduforp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlopUUgACgkQFA3kzBSg
KbaqFRAAguZVrcSPt9C5I6VCEGsmFWTfWiadTDxbCosEhvQru8WRGhUtUs1/v0Ry
x1dAeOJb7BwRNQMDaBve9lzHmSDWQF7L2MQx3gfDrQXYZ1mKx1q7YJGcgExEb4fJ
UMQngPeIbOzvl3aB5CvziA5h6uspphLyiAiBULjTW/JX7uGE5d4TlhNx4TiKbz5C
Arqc1ubwpjoTkm3lndjXbkHB8RlVZKdCZv6FBf/yfjx7b0zg2p60HFP7L//B88dc
eZfLdTz1414Mc5hW13GdIw5CN6bfSRUSaDRxTWbjQr+vixXVbRxQCSvk+xSOgVia
WjGUrqq8FbB+zQoaskcqTCMi1P/8FGoBdqh3WvC//h4mPmSbp5C8yoMLOiIByR2i
9fFdWAqMLZefcCiDGl7e5q9Fb7uS1ClSlydEnLU6tG0LFmQxKoaMHMnyXfWYpNh7
EKfk7cGKRZxKdaKrBGwA6SJrQDvuBL+bRP4m47MamQNhtP5rUmHouB1AAgpEpSjn
5PvfmvIlnrotuNaC7f8U9TWrQqC/8jU+JxxaZUr1Btj3yH7R4353fWJ1kj7Vk9Sg
XdF7YcXYFaTJ4e3MBlpBFCn7JAHPA55333sB6MPmq5R4nnlfoPPDluV7yT11+6lI
t3c9jFAkZAls1nA18H+NXZvc7saGdZIDlBGC9TMGSFG/6cu2t/w=
=gomI
-----END PGP SIGNATURE-----

--hiubdbrglfduforp--

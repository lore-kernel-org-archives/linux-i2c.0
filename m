From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 05/10] i2c: meson: use full 12 bits for clock divider
Date: Thu, 23 Mar 2017 21:34:04 +0100
Message-ID: <20170323203404.nuobb4wtgsepnilu@ninjato>
References: <1a2ecdc8-a326-a7a7-22ec-658fd147daf4@gmail.com>
 <fbc241ed-ec1e-b433-50af-5d0ebca09711@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vfph4zscjogtftqg"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:40974 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752034AbdCWUeG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:34:06 -0400
Content-Disposition: inline
In-Reply-To: <fbc241ed-ec1e-b433-50af-5d0ebca09711@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, linux-amlogic@lists.infradead.org


--vfph4zscjogtftqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	/* clock divider has 12 bits */
> +	WARN_ON(div >= (1 << 12));

Do you insist on WARN_ON? I wonder what it gives over dev_err?


--vfph4zscjogtftqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUMTsACgkQFA3kzBSg
KbafvRAAkIXpVjV5AVFgiT6ZCwQwQqhbnMjFhwUFDasajPNnUh6I9QTFqK27HcCv
HcDSdx7VppnKbp6PTplbH4ypeATFu2GIIouzhJKzpyaKhQS1WHNYaAz0ic5hWGCx
OysSn+RA0zeBOuC80G6d+7H3cb3JY3jMZuMELvR0tqvAi4OQOHaVjPxYwDX0iunN
H/UDTiNCtWq0JoBeq55fy6JtkwAkQ/oz2twAvrf1P2h1dMbKtyYG1xvDeTXBdmrP
3TssLoixSAcDaM0Zf2NwFzbImnWQtLqfM/0sYo8zWKsDCifJ0QMZm+GpBN9cSl7E
Q34ltubYNXcgOfwpaTgf+8U6tGS2nu5zGeI4IQnGKSqTSNFlt4LY5UE1nuLFTUBW
0ewx4HxBffeU6+NVHDIDHvy9+BfvVOWSTmkEAerI9gzroyzdnz/zLw5dTGnN4hWq
UBCDgB8gA2/Cx209cLF2roSsf7daM+3C3ePzOEyUKzyJWUtVDUP5Q7JsvV2Ziewj
rNifJxfDMEYEi4kLMtKsAlJjHRHY0Fg+cYk749Gu4+jU4qc0gC3TXwHyMSlbJE/g
FcntewIDdJeB/zVdiG+iEWkWcQPFPLfrt127+vEwkQ1+koAv/e4prqZ3aNY+THjP
kQH8NotCCitK+OIvVHGPUmaveiJxZbSQ5goOfgxYFr5ovCDX1pA=
=b0YK
-----END PGP SIGNATURE-----

--vfph4zscjogtftqg--

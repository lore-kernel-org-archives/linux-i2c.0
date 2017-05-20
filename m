From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv2] i2c: i2c-tiny-usb: fix buffer not being DMA capable
Date: Sat, 20 May 2017 22:14:30 +0200
Message-ID: <20170520201429.GA4299@katana>
References: <20170505090650.28412-1-sebastian.reichel@collabora.co.uk>
 <20170520160959.bgl4nadqs6xaqi5d@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170520160959.bgl4nadqs6xaqi5d@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Till Harbaum <till@harbaum.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This fixes a regression making the driver effectively useless.

Sorry, I missed that this is a regression. Will apply it for rc3.


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkgo6EACgkQFA3kzBSg
KbYKJhAApR9kSANOGR/NEiSQUOhlQ+u8bdiIbw4VhS1S0qhp2pUNOkBoC59p1ZNT
2Gcmk43jzFLFgUG1iRSHQbrzQUru+v3C1tnkqAIkWKx42d/AdNpKlkct2Wc1xUIf
XXlLnTwCacc3gC+TrUHgpvP2sn/7+g8rE36HQ9m9HDTHVzKocGG8sDJFjSaMdN8Q
lZNnEtWilqu0GcxPCPNKGqX9EbNElssQi9dJjqX8vGWUa+r/6YPJtdNJ6BPAjpD/
NpqO2B0nsuFpd6OqfyDHBAgNndBx+fvLQboGhr6vFPq4IM4u8OWM/3se9CHcgMjA
oiM2zKvhiM8qGw6AAgD4IakoW85K9iLpJFQaMfYf+g3tB2+jTcWBsCIBnN1n+PN1
Jb5Zhw3BW2r01/driujdXY0nAeXe2zgmM4LjvxRzsjKy0M7f22C7SvOi0f6EF5h/
iqu2/6VnKRV+zuGpxhh4+CWkEKCES4s1ug1HRKdFiwgMfPZ+IprwAjSH26X7Ymro
bjCVGYV/RVNvQvDtpxsUu8eCNpaG/I5X2QqhZqnzFUoiF47t79P99ZO9d1P3+ur0
lbASX+Mgppf7nmwsCFiT1b6j1w5b7IrkCvQJMgZfYqgSfYkOonXKG+aL/GiLK3XG
PTBG3afw4PY2MZiPbuPQBBvFuhUitgDe5Kj3AMRo5nFZ7FPQDAI=
=5t70
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

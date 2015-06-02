From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 0/6] i2c: at91: add support to FIFOs and alternative
 command
Date: Wed, 3 Jun 2015 00:58:34 +0900
Message-ID: <20150602155833.GF2661@katana>
References: <cover.1433250713.git.cyrille.pitchen@atmel.com>
 <20150602152647.GA2806@odux.rfo.atmel.com>
 <20150602153622.GB2661@katana>
 <20150602155222.GB2806@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150602155222.GB2806-FuRPzXQv2LUWBfJKYY8PcdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I was thinking the same so I have tried to cherry-pick the patch on a 3.10.79
> and it didn't cause any conflicts so I thought it could be sent to stable as
> is.

OK, so reducing context seems to help. Thanks for checking!


--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbdKpAAoJEBQN5MwUoCm2xr4P/A+D3KDnvfeV7iiA8H0laEW3
1ec7ifPZ6gUbkcpKxMk7mBLUcllAIzyHhvOmYxsfHONLD06AyOwfJHAAlaWAcezz
lUnbKNMtpRAwl3TUd6BopRbEWxPqv5JP9HbavN3/134C6LaA1sw6wAxf89+GdS5d
dour/BPOYjfHrjTLgZbxyPDwHFN1orMnHGLMlDYUwIVqs45b2POtGICTUabM91Qd
KuosyQ1NcF7S95VJuClu1lkZmu0/O9xRa/WLe0bx91sTX6dWdZBocg12AWAFgx71
z2kG+lVtRtcpJcuLmH6vyb/TVffHJyUIyITWtJfrqWbSxI0kcGPUWou4MH+KNwqr
pbSjwGnUaCKNkstWwwPWx0JWbjRizOTmVBqM28VxZZ54PH1hglz9KUsew4Bg2KQM
wqd6jVX2d4ALkF0L1FaE5rHUA2rDflF4HPyWlT0D2Ad2BORG/YKXx/bgPigX6q5/
6eGO0Skjgw64ZZ93VP44n6oPeHUyup3rUKqF29vkfaak94waM01ZB70Pg27L2g10
CYk8Fgg2WIFcCfcH83Lq6S1jc6Vt/UdYzpkvO0BCKHS/u9U+3UK/1qN3Um4+U9Td
K/soziWj5P3Vy9kVkAPHEiB7B23d1tNmM0Qg7XAeHpFrNs0PqLxABu7kx4FDw8S2
YYzf1bESRHge8lvgdOPI
=V7H2
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c-gpio slave support
Date: Thu, 25 Feb 2016 22:06:33 +0100
Message-ID: <20160225210633.GB1936@tetsubishi>
References: <CAACqyoFWnacy9nPfDtqnJg=BjeujDv+ddZXDn8ZjD_aTduf-cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:41877 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbcBYVGi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 25 Feb 2016 16:06:38 -0500
Content-Disposition: inline
In-Reply-To: <CAACqyoFWnacy9nPfDtqnJg=BjeujDv+ddZXDn8ZjD_aTduf-cA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ido Reis <ido.reis@gmail.com>
Cc: linux-i2c@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Is there such implementation (couldn't find any in the list history)?

Nope.

> Are there any restrictions to implement one?

Honestly, I don't think this is feasible. Even at a kind of slow bus
speed of 100 kHz, you'd probably create quite some load. And since you
don't have any guarantee of interrupt latency being below your desired
threshold, you have no guarantee to keep up with the timing of the
master. Which you must.


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWz2zYAAoJEBQN5MwUoCm2eNwP/iWknzzFW5Pk64fQ+HNLJ592
9+OKZJeYKAXJvsnAAc0+UnwEGkxt/iATvb6w2BDa5u9SG65hx9LPrqCNICBIzucw
URDRSvYmaA1YQANEoRkhVtXFcy08KaGH1rQxINITTB772R9L7Q/UPYAHt/dSgMf7
m/v0UcP2skEfgjoIrpUwFPNl0tmJ4oIu+etTrtc01oTfHO9kzcg3SEX4xi4ET2RI
8HDiTsZJdRAn+QF5z6wGbUclYWiFh91EB+89wggPxlilWCArcd/nPsjbjJy/x8if
GHGcbWDrw6T22WRZ51uiZpyFV7rXobf77fc8GeHiYPmKeFH4e2fjd8zdQ/IBXxCD
oOtavYOpR5pFbQ+OfR4ogrGbmnScOVu397QRB1Ie7s4SJ0xLjmEvhnYLtS22BRMU
uQrXaKhUozeZ9H2HMDYaqiMaR0ue8LfkGd5DwM59g4C47dFKCDsLb/76xIuNXRwU
Y6unDL2xPPiYp7WyHK1dfLn7Y+loIPvq+Wnm4ABxEsaD4rm0H5cCXNMHKpd4tluT
71uYEDb+8c0eG7fVpEJtr7Qty7fv2CtkVpSavkT+2xEng84S8/Ur6nIFqJB4xsvG
O2OGZiSaxnIpi78TyjrmF8wR8WwJ0OqFvhkcYBqxyTDt+nsJPbq33PfRJw91VdfI
UT5vfqENIFfBwMV9W2c8
=+sL4
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

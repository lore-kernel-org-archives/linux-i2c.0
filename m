From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
Date: Tue, 29 Sep 2015 14:29:34 +0200
Message-ID: <20150929122934.GQ7104@lukather>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl>
 <20150927165303.GI31209@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CMEQapY8OuP5ao1l"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52782 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753984AbbI2M3g (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 29 Sep 2015 08:29:36 -0400
Content-Disposition: inline
In-Reply-To: <20150927165303.GI31209@lunn.ch>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Olliver Schinagl <oliver+list@schinagl.nl>, hdegoede@redhat.com, Wolfram Sang <wsa@the-dreams.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sunxi@googlegroups.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--CMEQapY8OuP5ao1l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2015 at 06:53:03PM +0200, Andrew Lunn wrote:
> > >+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-i2c") ||
> > >+	    of_device_is_compatible(np, "allwinner,sun6i-a31-i2c"))
>=20
> Rather than have to extend this list every so often, how about adding
> a helper of_device_is_compatible_vendor(), so you can just have:

I don't know, I kind of like the fact that it's explicit. If we ever
have another SoC coming in with a different behaviour, we won't have
to expand it back.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--CMEQapY8OuP5ao1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJWCoQuAAoJEBx+YmzsjxAgM8EP91VT/RmC+HwiDYm6IXkeIKnE
8tASAS/2/AfBv2OZISXt2rt9vjZhTpLX9/G36Ht6rmJ7ctiqw6Qj8p5Tpwv0GcXo
PVBN+ceYsHbddfurEzvqT4M7F0csQVkiNcLz/GAlVt4sM5J63gQZpuULjnLPhyda
U8tv/UjTJmFnjWkVx4o8dXvjJDsOshyoAuRmBR3GkJtGeJf/g8k1CGwbtg3mWgjq
siozf0vMycz2FSHl5Xk0SHAKjzEDonmZA/OoF3vanb5jPrFPzpfTU1S++6gZ9ZM7
Xmn2P9fV9pwS3ie5hFz4UCyXloj+bur9+upgONaXA5iJICZuovwUBVfv8OJhWbs8
6dWM0+RvJpH4c3Bq+eiWB7x682a3D+3SeFBCH3+qljpJ05Em0RovMYu+4oMPPuy1
b0vFjxRNP9bQxpOjvDvApKJv00EBIVhthXN9Yq+eVDKaU1vcFKWVNpXnX3nVcyPU
SowqOp2SgcdypHgldMajsuyxtgIlDdZ7mKx0gw8VmVC7D6ar2bslwIqw26SLds/O
VXXgUAQxCijoVv0ZeysyF5NKIJZv5awiWNHreXwJDNl8Bth3N1RmHfSDk+czASyr
PJXzjdE5aT1GF1LtzkEsL9HV8njib3SJch2CBoBKPJB9p0Y8JRjmSNBYoQ2ohvXo
scEsXu8R8KJJDgWYg0c=
=zZMi
-----END PGP SIGNATURE-----

--CMEQapY8OuP5ao1l--

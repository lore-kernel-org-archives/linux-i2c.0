From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: cadence: fix Kconfig dependency
Date: Mon, 7 Apr 2014 08:56:52 +0200
Message-ID: <20140407065651.GA2609@katana>
References: <1396811227-8851-1-git-send-email-wsa@the-dreams.de>
 <20140407063100.GN29751@pengutronix.de>
 <5342481B.6020600@monstr.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5342481B.6020600-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I would suggest to add relaxed IO helper function to asm-generic/io.h
> to be available for all archs. Then we can avoid this type of errors.

I favour this, too. For the cadence driver, I needed a quick solution
before linux-next breaks, though.


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTQkwzAAoJEBQN5MwUoCm2ImcP/0ge1bJvrpj03Y3z1jQ80lrb
5oJhSJxHTtO91ghHGtYXWte3GPaQuTGxW3ucU1FjWCDVScCnz/DVxepEFlCVMbqb
nr74THNnxclIM0Mwf5MPvp64wAqOr4cQRoD/utpdWilhtkl/z47G0zkykaopMs05
dQygM3RiIukEE8Tl9Z/czzScusUWFB6mp3UIOj+RMYCqg1l04AvU2ZJcBScriRuj
Lxj93bhEqkLV4jWcj4OCQ8BFbAhR9bPHZ/8f3gUAWVNKkqc6+IcjzwOQMTJxImsi
sAm9gG2MGyMMoDRt6kDG3D+3DeUYRNdq3hNTTpAcXENnEm6NH5irPTjc9LSYv5Bi
VKsADC+fdm4jNscPBfy3/4aqy69n44mAsQ8rfxRLOjdmW390YmFvQQLASxchCr86
vjMt4YXTTcCrsIVJavauHR9o3hHeQOOwEc6myquirGh8JKny6zDkVGuXGN+DrEVQ
a2C0FTJAKBg3PyNK6VfPjD+defgg5LC2xba/FPKkXYmaQuZFyOBp+e19yiJ8H/PT
6qFgGaw1oiX+nETvczPXXNrHXBVBsmePUeeBP60pxOs1tgJdNLoo/b/wRgZfUJFG
sSMT1xLzHkgIO/y0kXY7vIr10iv1EpB9eyPpRu/qlRmp++79XntZ/y436n7D/RHX
UGMPpkZ3flsZm1jL0lzn
=NQBE
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

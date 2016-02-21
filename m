From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC] i2c_check_functionality and error code
Date: Sun, 21 Feb 2016 23:56:06 +0100
Message-ID: <20160221225606.GA1386@katana>
References: <CAKzfze-B4dx9aghERaRDu7xz0i6pMJcAUGMQX7OWJpWh7i=bxw@mail.gmail.com>
 <56CA1F0D.2060707@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56CA1F0D.2060707-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Hohum. Wolfram what do you think?

I'd go for "EOPNOTSUPP" since it is most descriptive. I wouldn't say we
really need to fix it up in the kernel tree. However, I neither would
vote against it.


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWykCGAAoJEBQN5MwUoCm2QSAQAKr8kPm7y/uMbwHJVCWKpinl
VpQbA8teaquwYhR3am2EdiIiCHKNztnkovuW27x6uFyO7q2URHJ92WQrwAWZGxBT
+Xa9XK+3dZXGBN9CVoxn0WKUOZvx6dZ00pQ1Hga18IMj7VSnvDaEHE35xu5A33iV
QAXIiLPDkypgmZc3+xtJ4x7dOxyUe08/jvjtbFcsEK9AneXIjLaiTKC7WFeIvmmp
7aN6ZneiHX5ZVFXwVYwP/d9P3aT7rBTw7pMmr4pxEKBWEVpYsHAvOlLbfgaMBj1c
ELgpJriNoq4IRNLNKKcoHzVZ0x94jF1Y2+us2hBraNPQHzwBvS3WDv+wpBzwJgjV
kmwWDgfD8S3Og+IFZZzbfX6rfS7WVNN0+mt0rD4YDsoOHGPrmJcdPV/MR9TsUFWq
RDpxp8PwYfycZ/29lV4IycLNKGkqJND6JkVs5GpxPeh0J9daOqq2i8v0QnobKRaM
0qoBjVfOdwSiZXJ2LPKtGYOJSt3CmnDEQovGt/Xwx/QgHEKui+t50MmbYIzOD7fY
BiZYzlxyj5owcmilLvghdfG2pVj/nzvTRPN9JSttHr5NhdjH1EM1kJEd+sQGRRzG
R0Novgd1Dx4eUDl5bFig73lFxFdsbIkslRPMlcOJReOtiSxs/CVPyJgaDZlSUMhR
Kum8ykG7c3bdA3C6gwEI
=dLJR
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

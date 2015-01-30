From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 4/6] i2c: busses: add SLIMpro I2C device driver on APM
 X-Gene platform
Date: Fri, 30 Jan 2015 07:11:18 +0100
Message-ID: <20150130061118.GA995@katana>
References: <1412726809-7525-1-git-send-email-fkan@apm.com>
 <1412726809-7525-5-git-send-email-fkan@apm.com>
 <1894616.4yY7dajl4R@wuerfel>
 <CAL85gmCuJtS2DMVHc96FtM_nP2++wMXNrrUp0Kvx0qajKsFuCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL85gmCuJtS2DMVHc96FtM_nP2++wMXNrrUp0Kvx0qajKsFuCw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>, jassisingbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hieu Le <hnle-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > ctx->dev is probably the wrong device here. The i2c controller is not
> > DMA capable itself, you need to have a pointer to the device that actua=
lly
> > performs the DMA here.
>=20
> Arnd, I do agree this may not be the best identification. There is no
> representation for this on the Linux side. I could put it as NULL. Howeve=
r,
> there are other i2c bus drivers that seem to do the same thing. Please
> let me know what you think.

For completeness: Those drivers need fixing!

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyyCGAAoJEBQN5MwUoCm21qoP/jrxGVhAt3T7TvAJGsRf/8Ey
Z+zphJ2Zdg3lbXU6NH8AzdF+EGiPXISD0wCmaZT3K1LNAbAnGMiRoUJJ3IaeNAXS
FLQp1jyeySd5S7itoQCWAKD0gRc1se5h5Wg3EvQSOLP5H6SuROJEtmkVacx70DKx
epjtxp0YAeMFGmf63zH74N4LOzvPJWLZt+5U1EDxXP0DqD9wHifCm1H7kg5/lzZi
FvET2UaukICUDPgALkPki/D81Ez1Lzfho4BfQXF9ll+BL72dlZ84Ts0uMEf8Jgmy
ch1OAQnX/CC2A8WFBv51raZOYEqXBkErXP8CeaVHTqLDD83YNlnHswLJ8Wc/U1AH
IAJw0jgEHpsX0c+l/fNAXHqTYWmGGq4f4Xzo3TvE+BBfHYKfe996JdibyBtFr2eX
J3LySNXyUFNo+uhR3dwLY6inz9FF07IDPNCUqXGvIsyiX089UNTSF7kxKYP6HgIZ
x32sYEMs1H5pgKUZPYqRt34FQ9PjStYkZjaHXH23IV90sCDWyEF6R48CTDLNqBzv
msaHq34auHzfiWlJK+EshpmSutlGwoX/W6kWEaJFLIiZISFXOb1+ApwbLc6iV7XX
u4O0riTYzcZ8999wADkGpLItNKX1JMEeeC1IMyVujfJt47uJE4lzOt/1/bqitTKF
KubGLaz1v6M1JqZrRQg8
=cogh
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

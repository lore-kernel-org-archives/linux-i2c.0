From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: add Kconfig dependency on COMMON_CLK
Date: Mon, 24 Nov 2014 10:58:00 +0100
Message-ID: <20141124095800.GE3733@katana>
References: <1499103.qTrcqP28lh@typ>
 <20141124080509.GK4431@pengutronix.de>
 <20141124093116.GB3733@katana>
 <20141124093823.GN4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141124093823.GN4431-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Applied to for-next, thanks!
> Just for me to learn: is your for-next stable once pushed?

Nope, I push manually when I feel comfortable. That might change,
though.

> As you didn't push out yet, it's
>=20
> Fixes: 5a6f1566f6a0 ("i2c: rk3x: handle dynamic clock rate changes correc=
tly")

Actually, it is 249051f49907. I rebased my internal i2c/for-3.19 tree to
fix an authorship and merged that into i2c/for-next. For those reasons,
my current policy is to use "Fixes:" only for commits which hit the
linus-tree. I probably shouldn't do such things, but as long as I was
working on my own, this worked pretty well ;)


--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcwEoAAoJEBQN5MwUoCm2mx4P/R2fHh12c5ztERhaNlEbb1Nd
KXR7NQmGhQDYQ4wMWnekSJsl3lBoVQ1ObwGIW+zNZ5ExxXf2IzLdJXD5unfSp4YH
s2uTEWssmD3LA4w4yZbgc4qrKVnRJAVQusAMIEd/xMjxGZdDZQu/N424gb6yvARN
mADOwUeSZVYWO6eViHGsg5cMHPFE1CfLtx4wuMpt426AZk9+XJ9AHBDaP7xV/Pl9
YxeWyMqcShy42JEjmuvuLEzM9HJPJ35OYekNJv4axGHcvkWgEJkjW3uWnSqJ97aX
NUsYuWsCw9XvHoUnQChWbaHmRP8JT35uM9EzlDQ24AXXcgZ1AobdAlmmPF81ysQg
EbffBahoHeSiPJjuAumJly92gk0jsKjAd9W2M6XBiQJANNTFQtdXP7GZytYYewJp
lAEVjCRRFTW7zjxudPxMJW+ARC7UJ9ln43LWscCT6e5TpftP++J2ViocY35ITY4/
M0qJz7TNIkEjIS4P93lVjykkoWam+Aj4TCJ7txmI2Sxt6bV/O5Oyv/uAuGCKKAO5
B/f0D3xA2/BCC9Ev3CQZVG7ifigo5fyjbpH/461oYqWfvvz/GtXgruVqcat0HSoE
HWdbW02IuMWCiXE0b5oocFAYrKUaDyhmUmb8+sl+BI7BMnrQMvRHAFh86+g4K8GU
QvPHZWNru4egCL9cSiYU
=okrp
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--

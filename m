From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 4/5] i2c: davinci: use bus recovery infrastructure
Date: Mon, 6 Apr 2015 18:09:30 +0200
Message-ID: <20150406160930.GA937@katana>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-5-git-send-email-grygorii.strashko@ti.com>
 <20150318203151.GA12072@katana>
 <550C67D6.3080909@linaro.org>
 <20150403201846.GH2016@katana>
 <55228613.2060607@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55228613.2060607-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Grygorii.Strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> Of course,  i2c_davinci_wait_bus_not_busy() has to be fixed first
> >> as proposed by Alexander Sverdlin here:
> >>   https://patchwork.ozlabs.org/patch/448994/.
> >=20
> > Okay, good that you said it. So I'll give his patch series priority over
> > this one.
>=20
>=20
> Sorry, but this series already mises few merge windows and it has a lot
> of revied-by and tested-by, so could we proceed please?
>=20
> Re-based & re-sent http://www.spinics.net/lists/arm-kernel/msg410810.html

??? Didn't you say above that Alexaders's patch is needed first?


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVIq+6AAoJEBQN5MwUoCm20SwP/1DRNQf3efS7dxdJhJZEBCqo
my5AQ5K1CqmeFDEKG5faU13ZaS61FOGKm1bEZIpTRovtX0VMzhvnVvzHTaikXRWJ
YvTYgEKRinJebj3XC4Nw8FhqRFuQhlnjBN0O+IkqVA/wyTteUPuES5gmwpQvAGbJ
xLTkInx7rSt69/xC13YrtDeq7YZPer/4dFuQ3vtAfo4mMhP3IRnE+KCUc2H7+50W
KSKHFQhfEhF/nJSNW5R1cUgSLZo+ROCGfjdkqLfJPCX4b/MgVrjUATqyETPz3Xk1
TMBP9HpS7m+qaRJ7BH1GiTLRGiBFXeOv4/Ysv9eF9O8/6zBvKpmTvpW0ZwLn5Wr9
7zDeBHj+Py9LkIjCrOgWFcql6EJbdWf484K5Qkk6YL9DpaWv3/MaG1uaOVpuV3G0
O6Egbe9ypTkVF2lSxru/gKeJH9X8ySw9ps+38RWWGzjSrAbyi4/RgXvBojXBH3IJ
MwCxM5r0LD2cp3nxMHlmd+wEwrw47ZEhMbfGNIOy80KGqHUIMjWxs13Ui+xN5AWj
RCUb0gdm1+FDC5RjBKO1Ecytdn5l66sDQZhePFifntyRlxwrrGOE6aocidoJzJGL
X2wAoNymMLoPjrp3gx0gbNI99N31WLpcrH/rwI5yW6ht+VMD6nvmB1fuPegxYAmq
EabTsqPgMLAIclTlYKeG
=YhOr
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

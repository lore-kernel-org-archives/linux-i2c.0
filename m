From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-mxs: Check the return value from
 stmp_reset_block()
Date: Fri, 16 Aug 2013 18:13:34 +0200
Message-ID: <20130816161334.GD3046@katana>
References: <1373505568-21477-1-git-send-email-festevam@gmail.com>
 <20130815100022.GC2987@katana>
 <201308152331.23742.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201308152331.23742.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2013 at 11:31:23PM +0200, Marek Vasut wrote:
> Dear Wolfram Sang,
>=20
> > On Wed, Jul 10, 2013 at 10:19:28PM -0300, Fabio Estevam wrote:
> > > From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > >=20
> > > stmp_reset_block() may fail, so let's check its return value and
> > > propagate it in the case of error.
> > >=20
> > > Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >=20
> > Applied to for-next, thanks!
> >=20
> > Marek: can you base your pio rework on top of this patch, too?
>=20
> Yeah, where is this tree/branch please ?

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

Forgot to push yesterday, will do soon. Lothar's patch will be there as
well.


--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDk+uAAoJEBQN5MwUoCm2OtIP/1N9GGLkTnh+qcIMwwXVXSCn
kMYJG7HeWWihzs6FJcKt0foRA+kt8EcGP1ratSaCRk7bwBx0q6vzdbHoZmDoTJgT
5stPf9g/shO/elsOZqWU6gxA8SyaNlgRE5B0KM0yaUoGSEZIID+YQ/Hm7qasdF/R
UiFItMdhD06RTAmMM78UBTFEnOSaXwad9RounkE8ZXVqTsFNzooiBZpjV5Wd/NwR
musMqr58HJvkFmljk05Gej3hIF93TOCjoeEA5aOz50Xq9g7lwjIl+Fpmj2RL3psW
G16N9xYILsoGKrDbJcNmNZCz6ixIGPE25clghQd6hn0yN4DpidJVbG7eHyTby27y
qZGQ3aFnibZD9O66mHSa5lzos2xK9vHOX6hp26XJQxf0vzwht6Wz7ekh6yClsgzg
4pBTLnHePC/U/yTooUIijt6RvWMT+nWz3XwiJDj/oOrh+chqoLRBY/Mwl51MckrH
zdh3J81+yrfH3eU8uyFU0JZqQH7zRyMCU+cQ2Zp1ybkGRtA5knFftBC8FBrvAiIB
tFfwOX7QdIVZrq5BbhgyOPn4gCLS8sy14AjwqV4k02e8i84A6yaMUWS86Kzsi7fp
huywNaRX/y0WglzuM32ysOsFtm4alq+Es6rjAZz4ApyiNmoTbQ12rbUTDbgCx1B8
qm2eaZti8St0foIQYVD2
=hqiD
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--

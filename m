From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v7] i2c: rk3x: handle dynamic clock rate changes correctly
Date: Fri, 21 Nov 2014 19:18:34 +0100
Message-ID: <20141121181834.GE3754@katana>
References: <1827790.Sq6eyYqr17@typ>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1827790.Sq6eyYqr17@typ>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Huang Tao <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 10:26:50AM +0100, Max Schwarz wrote:
> The i2c input clock can change dynamically, e.g. on the RK3066 where
> pclk_i2c0 and pclk_i2c1 are connected to the armclk, which changes
> rate on cpu frequency scaling.
>=20
> Until now, we incorrectly called clk_get_rate() while holding the
> i2c->lock in rk3x_i2c_xfer() to adapt to clock rate changes.
> Thanks to Huang Tao for reporting this issue.
>=20
> Do it properly now using the clk notifier framework. The callback
> logic was taken from i2c-cadence.c.
>=20
> Also rename all misleading "i2c_rate" variables to "clk_rate", as they
> describe the *input* clk rate.
>=20
> Signed-off-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
> Tested-by: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org> on RK3188

Superfluous, I assume that you tested a patch when you send it :)

> Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> on RK3288
> Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Please drop such tags when there are significant changes between the
revisions (which happened here). They need to be sent again explicitly,
so I know really this version has been worked on.

So, Doug, please confirm those tags.


--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb4H5AAoJEBQN5MwUoCm2ldgP/A140e12/vHdJbzzJqIiXEE1
B0u/WGjyFoiQQemKq+2C6ADdpwy18J+RpvWXXmoDdgKhgcT8hkNa2QymL/Z00KN2
zNtfGKUiAS6k+owweXsXKlkyrsfYTkgocpUQbWo9lGqxLmxNwTNwcQDrmlCAfKlW
KkehrFt/r+E4OPmgHitdgk+AQue1gb9Qj3w+3tsa0xfY4KccABKaZCz3qIfGpvUn
wIS8ZeZQ07iiXQpPzvJXj0XEmBFTevS9B1ThOVZqG1vAES4yfS1/opGDD8uQpxe/
QPMcEb1jhFjsx+Q+ZwuIOo+fF01f4+N4aOTWU0kQ/0SgXHaJEMQhDeC9FHsaHQvv
ZWKOHk3KOmuOpBKAqin1zvq4Vqvs6+tXSzP7/RT83LQUAWN1XPcDRMje9jBhS3jU
UbW9WwV2vIDcrRTdw2l1kPgNpnVCGIfPGP4xDJGFo76L/WEmxYiuv9UuhTvmiMXS
6tcoCI8hdOzljf+I+s8860+vj2h6GoNkFxKyvhSXdPEpnag/WIZ77ex61DLCq1EL
xCwNWgHwEmuNd0Zl9RwbA1g9R7urAoxwldDs6nYilEe/WGya2Wf2ZaV3Mutm7qfB
JMFIHf2GNwpxeuqSJalfU4VW+Ju9Yx3DzUk1xBi2/oyVq1vxtHLnDuRK7yxmf4Fi
C0A2Ok6tau2Ksn2EKoEA
=nc9K
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--

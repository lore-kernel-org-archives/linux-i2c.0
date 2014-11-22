From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v7] i2c: rk3x: handle dynamic clock rate changes correctly
Date: Sat, 22 Nov 2014 14:29:03 +0100
Message-ID: <20141122132903.GD2679@katana>
References: <1827790.Sq6eyYqr17@typ>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1827790.Sq6eyYqr17@typ>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, addy ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Huang Tao <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--3Pql8miugIZX0722
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
> Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> on RK3288
> Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Applied to for-next, thanks!


--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUcI+fAAoJEBQN5MwUoCm2F+wP/2W01PglFlCkOggGL7uFfT4p
B0INqmDTXlnPuOAgn3krkY86X5C7Aov9m0HNhhQCTgdBW0cby3gAL6TIuAVipDeH
zFKVw1J6pKFq8URngsiYNFQHLtsphOjUzpy1xijyO8x46v/FALmKEb1Iu5H88vze
qGhcmAoSzOjMFMu2Q6FLQkWQkUtaR/g57TleaY2HAYjaa2ikSRrR0DZ0AZp0voR2
5svNlLDsxbClwYa0sJ8mFu+NM3LwZCzUxpXcUVPtdDGykJpkWLcPAsd3CgDqTQGN
hd6IrXkgm4vvV2vGW+RTjtpNiQOOYUtD/7cjVvQqQVCa9MN5JurV+n1raR3N4gpX
qkJ0vt/2ZIXLIk8FZGJ48BnCqGc92HpCpf+W/7T/sujyFN9WTQlUN73piUK7K3/5
vOVdKod9yTjMLt9PWTwiAYjBIvL8U4dLfXBEJYxKi8ehjit+1ch/rXXhE5dhmLr4
4nvtb5MB7nIM0DOU5TAP4miAHjUsn5m5igC/ruYi0BReqkM2NxiYK7jxweSLEpti
syJ3YieUdw1bfsEwb0czF0a9ITU8KmQrpK/wwncsFhqIFP+YqFfwrXiYZEgpVoaL
elEX8ehlP6pGIMzuL3FCb5AKHJH1yg6ZtDmL6L8/WYGjtDK5MP8HYSWQi6pav3mM
ccGpsmtNyRk17ytkDGB4
=k8rj
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--

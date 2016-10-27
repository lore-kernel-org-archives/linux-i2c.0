From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: Give the tuning value 0 during
 rk3x_i2c_v0_calc_timings
Date: Thu, 27 Oct 2016 15:11:21 +0200
Message-ID: <20161027131121.GB1559@tetsubishi>
References: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5881455956383642301=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1477125822-30644-1-git-send-email-david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============5881455956383642301==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 22, 2016 at 04:43:42PM +0800, David Wu wrote:
> We found a bug that i2c transfer sometimes failed on 3066a board with
> stabel-4.8, the con register would be updated by uninitialized tuning
> value, it made the i2c transfer failed.
>=20
> So give the tuning value to be zero during rk3x_i2c_v0_calc_timings.
>=20
> Signed-off-by: David Wu <david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

What I missed to say in my review:

Please use a subject line that describes WHY the change is needed not so
much WHAT is done. Like: "fix missing initialization causing boot
problems"


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYEfz5AAoJEBQN5MwUoCm2K1YP/jsZyYSzW44vvUAOF4LzjrlO
HNEKroLkxHQGCxHO3NqM4hqT9v0bTDQ07D6YjrgdzNBvg1/GohD+17ggjjAaRhOa
zHIDz4Gfclmi25y4CfD5IzMGhOXwrEQLiKxBQFBuLPMHhx5xeLY676B+WqnO+W3v
QFkiSJXvpqB6yKBMcQuNUxSNiUkcgUMr9UI+1vd1EQbtHyLzsc6WKzabRPPQgkTX
yULWqzJ5iy8tNxkufu2UZCZWhTC68f/fDCo2f11qW8Xwnb16ZFb7AlqzKQXINAvt
txuMFi0n/Lkqk+SaAZ/wbjtdWHprIGUenM1nOXf8y0lg60xbtEYMLg6lmLs0V1Eg
RRE/oz6eHDmhw67dwYnVhccBawfJygE1mRxB1t2neSAMUXIhK/unVqmcXp6bXRgD
hdsRUw0NBu98/1FvXMtorYECCLl/8CYqJ9oHM6NbIjeQf4MVfIMf8f+bz4X6o5UG
ztZuNIkT88WuIuzkt09QxIa9BdhSXl4srBnb1eIHcteJwVfbmwBfzMo/Y+jzsK3X
A38i7J40IMMzbL3kd8NiS07jD/5M6cTXJRhc1jpT18rBEWuTVo/9Z/0GY7cU//cP
hjeBDbGxCCGgoIYfoc44IFL4OUsdkj1/G817VSnSoaZtwIEMuTT0APyr8xHaAf5P
JPuOOgtdOKeVKvFVZOzv
=extK
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--


--===============5881455956383642301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============5881455956383642301==--

From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c-eg20t: change timeout value 50msec to 1000msec
Date: Wed, 18 Apr 2012 17:00:11 +0200
Message-ID: <20120418150011.GD19802@pengutronix.de>
References: <1332741325-7746-1-git-send-email-tomoya.rohm@gmail.com>
 <1332741325-7746-3-git-send-email-tomoya.rohm@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1332741325-7746-3-git-send-email-tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2012 at 02:55:25PM +0900, Tomoya MORINAGA wrote:
> Currently, during i2c works alone, wait-event timeout is not occurred.
> However, as CPU load increases, timeout occurs frequently.
> So, I modified like this patch.
> Modifying like this patch, I've never seen the timeout event with high
> load test.
>=20
> Signed-off-by: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied. (I think we need to clarify the timeouts in I2C, but for now
this has to do.)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+O1vsACgkQD27XaX1/VRv5ZgCgpC7xcmFq4Y0ODfB4lSyiBiMV
qgUAoIY4zxqbvpENwaHFK2SJRkU/ajs2
=cyZ8
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--

From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c-eg20t: Rework pch_i2c_wait_for_bus_idle to reduce
 wait time
Date: Wed, 7 Mar 2012 19:16:31 +0100
Message-ID: <20120307181631.GC1130@pengutronix.de>
References: <1329725656-32715-1-git-send-email-alexander.stein@systec-electronic.com>
 <20120301101502.GB2535@pengutronix.de>
 <CANKRQniA2icHddFG22r7VtLTuoefbK61tpcUQnXgShFHuffUuA@mail.gmail.com>
 <2041940.hOTQq1CLVz@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2041940.hOTQq1CLVz@ws-stein>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Cc: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Alexander's patch looks good.
> > Did Alexander test i2c-eg20t driver with this patch ?
>=20
> Yes, I did test it.

Applied to for-3.4, thanks!

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9Xpf8ACgkQD27XaX1/VRtKqgCeKEQt9C9HEGEWQplDoz44gncA
SMQAn1xMID0ybya2qjwtggb3fUez6tDt
=ADwC
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--

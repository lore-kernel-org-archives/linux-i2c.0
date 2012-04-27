From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: possible MXS-i2c bug
Date: Fri, 27 Apr 2012 16:59:36 +0200
Message-ID: <20120427145936.GD16504@pengutronix.de>
References: <201204261326.29388.marex@denx.de>
 <20120426114201.GC3548@pengutronix.de>
 <201204270110.21377.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GyRA7555PLgSTuth"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204270110.21377.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--GyRA7555PLgSTuth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> I've been thinking about the DMA approach. The problem I found out is tha=
t we=20
> need to transfer all messages we're given at time in one DMA chain ... at=
 least=20
> that's how I understand it from the FSL manual (see Fig. 27-10 in the mx2=
8=20
> manual).

I can't follow you:  mxs_i2c_xfer() gets a list of messages, yet they
are iterated over in mxs_i2c_xfer_msg(). A single I2C message is
unscattered and can't be bigger than 64KB, so that should be doable?

Am I missing something by already being in weekend-mode? :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--GyRA7555PLgSTuth
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+atFgACgkQD27XaX1/VRvB+QCeOxd8Of/CMgfHUw2TG7MuElmQ
AeAAn1tFOY2aHey+wGNwF/vfpl7TnXis
=MdPE
-----END PGP SIGNATURE-----

--GyRA7555PLgSTuth--

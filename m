From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Sat, 3 Apr 2010 18:29:39 +0200
Message-ID: <20100403162939.GA2190@pengutronix.de>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 17, 2010 at 01:59:03PM +0100, Yegor Yefremov wrote:
> Hi,
>=20
> I'm using PCA9564 attached to a ks8695 SoC. During my efforts to get
> 2.6.33/34 running on my system I noticed sporadic problems with RTC:

[...]

> static struct i2c_pca9564_pf_platform_data  __initdata pca_data =3D{
> 	    .gpio =3D -1,
> 	    .i2c_clock_speed =3D 59000,
> 	    .timeout =3D 1,
> };

Commit 8e99ada8deaa9033600cd2c7d0a9366b0e99ab68 changed the timeout setting=
s to
jiffies. So, one jiffy as timeout will not work. Try 'HZ' here.

> before. Diffing i2c-algo-pca.c between 2.6.26 and 2.6.33 showed that
> there were some minor changes regarding waiting policy in pca_xfer().
> Could this be the reason for such behavior? Any idea?

You were almost there, just use 'git log' next time.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAku3bPMACgkQD27XaX1/VRtQLwCeKf1fxot/AI+GLSES+qDZz5D+
bYAAnjNHbvDPKXNqMyKxFSzEL1NKfDtS
=4PQp
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

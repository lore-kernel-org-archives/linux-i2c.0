From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] media: video: do not clear 'driver' from an i2c_client
Date: Mon, 15 Nov 2010 23:28:15 +0100
Message-ID: <20101115222815.GB25167@pengutronix.de>
References: <1289398455-21949-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1289398455-21949-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Sergio Aguirre <saaguirre-l0cyMroinI0@public.gmane.org>, Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Philipp Wiesner <p.wiesner-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, =?iso-8859-15?Q?M=E1rton_N=E9meth?= <nm127-Y8qEzhMunLyT9ig0jae3mg@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2010 at 03:14:13PM +0100, Wolfram Sang wrote:
> The i2c-core does this already.
>=20
> Reported-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>=20
> Not sure if this should go via i2c or media?

Okay, as Jean did not pick it up in his latest pull request, I guess this m=
eans
it shall go via the media-tree? :) Mauro, will you pick it up?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkzhs/8ACgkQD27XaX1/VRvWegCfVM9iYnOkrjJqwXN/NkSvPCp3
9GUAoI6SAxrwPd4WTAouJIfU7DpENPAn
=RhbN
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

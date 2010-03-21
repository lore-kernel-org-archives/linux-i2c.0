From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 12/24] media/video: fix dangling pointers
Date: Sun, 21 Mar 2010 12:31:14 +0100
Message-ID: <20100321113114.GB26984@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de> <1269094385-16114-13-git-send-email-w.sang@pengutronix.de> <201003202302.49526.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201003202302.49526.hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Hans,

> > Fix I2C-drivers which missed setting clientdata to NULL before freeing =
the
> > structure it points to. Also fix drivers which do this _after_ the stru=
cture
> > was freed already.
>=20
> I feel I am missing something here. Why does clientdata have to be set to
> NULL when we are tearing down the device anyway?
>=20
> And if there is a good reason for doing this, then it should be done in
> v4l2_device_unregister_subdev or even in the i2c core, not in each driver=
s.

Discussion to take this into the i2c-layer has already started. Regarding V=
4L,
I noticed there is a v4l2_i2c_subdev_init() but no v4l2_i2c_subdev_exit(), =
so I
grepped what drivers are doing. There are some which set clientdata to NULL=
, so
I thought this was accepted in general.

> And why does coccinelle apparently find this in e.g. cs5345.c but not in
> saa7115.c, which has exactly the same construct? For that matter, I think

It was the to_state()-call inside kfree() which prevented the match. I would
need to extend my patch for V4L, it seems.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkumA4IACgkQD27XaX1/VRuJKACfYtVBg2DgQcE85z2GznQ4PTFK
OaMAnign0fO1MzKYEi6BQ0BQ5cvBIkoD
=4EBn
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--

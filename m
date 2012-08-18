From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c: omap: Prevent NULL pointer dereference in remove
Date: Sat, 18 Aug 2012 20:39:58 +0200
Message-ID: <20120818183958.GB19802@pengutronix.de>
References: <1344519467-14295-1-git-send-email-shubhrajyoti@ti.com>
 <1344519467-14295-2-git-send-email-shubhrajyoti@ti.com>
 <20120818100923.GD24812@pengutronix.de>
 <CAM=Q2csCuf1LBuf2T8wnthXC_eSxW_b88XmJ07jzegbJOr3xMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM=Q2csCuf1LBuf2T8wnthXC_eSxW_b88XmJ07jzegbJOr3xMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> BTW it was pointed out that the The
> platform_device object will be destroyed.
>=20
> Do you agree with
>=20
> http://www.spinics.net/lists/linux-omap/msg75553.html

Yes. I was actually wondering if that would be possible but wanted to
check that somewhen later. Nice that it has already been done :)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAv4X4ACgkQD27XaX1/VRtlPgCeNO9dHVJ/BnHbRhnGfOU00Qk1
aQIAnjvlsOIWAxeDYEwe69IOOTcszzNn
=d1PO
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--

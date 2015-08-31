From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RESEND PATCH 1/7] i2c: core: Export I2C module alias
 information in dummy driver
Date: Mon, 31 Aug 2015 22:31:44 +0200
Message-ID: <20150831203144.GC1544@katana>
References: <1440484277-32675-1-git-send-email-javier@osg.samsung.com>
 <1440484277-32675-2-git-send-email-javier@osg.samsung.com>
 <20150826165532.GC1521@katana>
 <55DE00F6.1070206@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55DE00F6.1070206-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The dummy driver is always loaded when the i2c core inits.
> >=20
>=20
> Ok, I wondered if that was the case but I
> was not sure so I posted it just in case.

Check the source code, this part is pretty obvious...


--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV5LmwAAoJEBQN5MwUoCm2KhsQALWR02aoScDs5ggvdjhnMeBy
jQF6F21NwMykPNb5dBdqJNDIE/0K2MraEvh3JvuhUAb1uhGAi3v6i/E5wUjeLiJK
7TICKiExfAXbm8HTOQ53C6d5dKvn/PkvpKtRsxokwb+2vQiVI59WVFX0KypZfPYe
xdIpv6KNUcufZr3cV+E+6WQO7O4l3WugtEt58Vo9/DZYgofy7ZUX26FG44GKDPSJ
OM7rDb4QU5Qc9SPSr5EOull5VRPKWiMQRre9/XtgnflIHtq0fMySUkpxr8qRtEro
mnd4Zfvc8ymWZ+yzcsbHcE+B7GkawBmLltLxbWnn8eIKPmBXs+EaMrN13t2y+rZe
y4AHOPntIrXAt0eilDaQuzU3MwcYVYH4Pu6ygoRJ3YtR/4Xvq324Len2iqo3k2yq
k3cuSBrp9knr8w31dGOfltNsvM5nrmJSzjj38BtkxCgMVq2KaB7spw0oGrZPiZrZ
TrUzt/uBppV/reu6LBTEeY1LtlHHJITwpzU4iU3UdHCldm6TMzR69FDUHu6Z+KKt
qTxRHu92Y2vM3CQrdTR9Nqm9Qsc125lgAM9V8YF/ipR2OQJ51ZyNglQv0rSQfdSp
UtEqzaaMziLQHzp5r8kP1s7KKxPgz+LKZRrec7GEZlr0F+i3+DXgV0S0Rf27khdx
jpLGf1hDh3JIlKjvwt+R
=DaN8
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--

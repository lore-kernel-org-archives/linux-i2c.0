From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Add device tree support
Date: Sat, 18 Aug 2012 21:01:52 +0200
Message-ID: <20120818190152.GE19802@pengutronix.de>
References: <1344409609-1904-1-git-send-email-thierry.reding@avionic-design.de>
 <20120818094846.GA24812@pengutronix.de>
 <20120818111745.GA15702@avionic-0098.mockup.avionic-design.de>
 <20120818121628.GB12839@pengutronix.de>
 <20120818123527.GA28701@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120818123527.GA28701-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I thought to recall that busses which can be probed at runtime should
> > not have nodes but should be probed. Maybe that was wrong. Can you point
> > me to a dts-file with an example?
>=20
> That approach doesn't work for I2C controllers, though because you
> couldn't attach an slaves to them. The same goes for SPI controllers or
> any other dumb busses that can't be probed.

I understand the problem. I was wondering how it has been solved. Thanks
for the pointer, I got the idea now.

> arch/x86/platform/ce4100/falconfalls.dts is an example for an X86
> platform where PCI devices have associated device tree nodes.

Do you intend to send a dts file mainline which needs the patch you sent?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlAv5qAACgkQD27XaX1/VRsBCgCgnMfKEoOhgv4MIwrZwaDet8Yn
dNgAoJnrGR/qWQYZ1tVDv5kkc9jFHVcQ
=KhcD
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--

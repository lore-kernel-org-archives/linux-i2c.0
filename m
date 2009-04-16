From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] assign a default class to MPC adapter
Date: Thu, 16 Apr 2009 16:05:04 +0200
Message-ID: <20090416140504.GF3052@pengutronix.de>
References: <49E6F4F9.3060705@gmx.de> <20090416092012.GB3052@pengutronix.de> <49E7101E.6070806@gmx.de> <20090416114701.GD3052@pengutronix.de> <49E7344C.2060704@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49E7344C.2060704-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2009 at 03:36:12PM +0200, Michael Lawnick wrote:
> Wolfram Sang said the following:
> >> Could you please elaborate?
> >=20
> > Instead of probing you specify the devices on the i2c-bus in the dts. E=
xample
> > for the pcm032 looks like this (from the kernel-tree):
> >=20
> > i2c@3d40 {
> > 	#address-cells =3D <1>;
> > 	#size-cells =3D <0>;
> > 	compatible =3D "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
> > 	reg =3D <0x3d40 0x40>;
> > 	interrupts =3D <2 16 0>;
> > 	fsl5200-clocking;
> >=20
> > 	rtc@51 {
> > 		compatible =3D "nxp,pcf8563";
> > 		reg =3D <0x51>;
> > 	};
> > 	eeprom@52 {
> > 		compatible =3D "at24,24c32";
> > 		reg =3D <0x52>;
> > 	};
> > };
> >=20
> > Boards which relied on probing need to have such child nodes added.
>=20
> Ok, that doesn't help :-(
> I hoped you show me a way how to set the class of adapter. My clients
> are loaded with insmod, so dts has no effect (or is this wrong?)

Are you sure you put the correct names into the compatible field?

With my dts-files, I can see the i2c-devices in sysfs. After modprobing
the necessary modules, I can access the devices. Example on my current
board:

root@A:~ hwclock -r
hwclock: can't open '/dev/misc/rtc': No such file or directory
root@A:~ modprobe rtc-ds1307
rtc-ds1307 0-0068: rtc core: registered ds3231 as rtc0
root@A:~ hwclock -r
Sat Jan  1 01:23:06 2000  0.000000 seconds
root@A:~ hwclock -r
Sat Jan  1 01:23:12 2000  0.000000 seconds

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknnOxAACgkQD27XaX1/VRuSJgCfRfZFc+gEXwtB3gJDfk3pK4M/
a8kAn1BJPhsee4fnibbwkbmxiI3i3Pch
=LuyC
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--

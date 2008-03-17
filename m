From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2.6.24.3] 24xx Eeprom driver
Date: Mon, 17 Mar 2008 10:21:54 +0100
Message-ID: <20080317092154.GA6159@pengutronix.de>
References: <47DE2ECB.6050609@elpa.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3054850549515161818=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <47DE2ECB.6050609-Rm2/HqoNtBE@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "ing. Davide Rizzo" <davide-Rm2/HqoNtBE@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============3054850549515161818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Davide,

it was already discussed that writing to EEPROMs will not be included in
the mainline kernel (it creates the possibility to destroy RAM modules).

Besides, your driver uses the old I2C-binding model and other soon
to-be-removed stuff like .id's.

You might also consider using David Brownell's AT24 driver:

http://lists.lm-sensors.org/pipermail/i2c/2007-May/001208.html

(Side note to David: I already worked on adding platform_data, just need
to test it in a quiet minute.)

To all: Surely a lot of people need an eeprom driver with write
capabilities, especially in the embedded world. I think it would be a
good idea to make David's driver more visible. This wheel was probably
reinvented too many times already (we also had a custom driver in our
company). EEPROMs can be nasty, so one central driver would also be very
good to collect all the quirks.

To make a start I would suggest the following:

Give the AT24 driver a repository (my company would provide this, if
wanted/needed). Place a comment in mainline/eeprom.c (and maybe
Kconfig?) that an advanced driver exists at this repository.

Opinions? Especially David?

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH3jgyD27XaX1/VRsRAmvgAJ4/DbOW8dC5ysihM5dvNRJCoz2jrACgnMt7
FcElR7mI6fZElimtg2xC7WI=
=M9Jp
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


--===============3054850549515161818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============3054850549515161818==--

From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Bugfixes for i2c-cpm.c
Date: Fri, 27 Jun 2008 10:40:27 +0200
Message-ID: <20080627084027.GA3931@pengutronix.de>
References: <20080620084155.GA17701@pengutronix.de>
	<200806241615.08826.laurentp@cse-semaphore.com>
	<4864A342.4020900@scram.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2147819218779942607=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <4864A342.4020900-NIgtFMG+Po8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============2147819218779942607==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jochen,

On Fri, Jun 27, 2008 at 10:22:26AM +0200, Jochen Friedrich wrote:

> What kind of problems have this been? In normal operation there shouldn't=
 be
> any I2CER_TXE interrupts being generated.
I had problems when writing to an EEPROM, reading worked, though.

I didn't really investigate why this happened. I just saw that the old
version used a hardcoded 0x13 to set interrupts and the replacement
using defined constants resulted in 0x7. Changing constants to achieve
0x13 solved my problems.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIZKd7D27XaX1/VRsRAhtXAKCdUJXZTj1e4tlVxDlDewkAsgBbjQCfYpnO
VhxUzQqs3/ddcIgDQk+8EDw=
=/o+k
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--


--===============2147819218779942607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2147819218779942607==--

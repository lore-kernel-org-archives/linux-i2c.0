From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-pca-algo: Fix errorcode
Date: Tue, 20 May 2008 21:42:07 +0200
Message-ID: <20080520194206.GA11088@pengutronix.de>
References: <20080520171848.10908.23451.stgit@octopus.labnet.pengutronix.de>
	<20080520201755.59b140f5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5648589681013881833=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080520201755.59b140f5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============5648589681013881833==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Tue, May 20, 2008 at 08:17:55PM +0200, Jean Delvare wrote:

> EBUSY is a fatal error, while a you should be able to retry the
> transaction later when the bus is free. So I think that EAGAIN would be
> more appropriate.
Okay, fine with me. (Does somebody know of a guide with references for
using errorcodes? EBUSY or EAGAIN? ENODEV or ENXIO? Preferred error
value if ioremap fails? It seems a bit messy. The patch that was
recently posted, defining possible situations for errorcodes within I2C
is really great. I wished I would have something like this for the
general kernel-routines.)

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIMymOD27XaX1/VRsRAkHQAKCwjfMzDmnYqyKroD5EGz8MEFlseACdHfwC
4I21Gg6WxzWB3walC76NcIo=
=+MBa
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--


--===============5648589681013881833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============5648589681013881833==--

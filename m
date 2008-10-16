From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/6]: i2c-pcf: Add a way for bus driver to ask	for
	no smbus quick mode support.
Date: Thu, 16 Oct 2008 12:46:23 +0200
Message-ID: <20081016104623.GB3432@pengutronix.de>
References: <20080821.024327.144744678.davem@davemloft.net>
	<20081015143321.7df02b35@hyperion.delvare>
	<20081015.143452.114860633.davem@davemloft.net>
	<20081016121315.2adb5de1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2789933301782609392=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081016121315.2adb5de1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============2789933301782609392==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Thu, Oct 16, 2008 at 12:13:15PM +0200, Jean Delvare wrote:

> > The pcf driver sets the class bit used by FAN and temperature sensors,
> > so the I2C layer goes poking around all of the standard address
> > locations each of those drivers list.
>=20
> By setting this class flag in your driver, you ask for these probes.

What about making this more obvious? Something like this?

All the best,

   Wolfram

=3D=3D=3D

i2c: Make clear what the class field of i2c_adapter is good for

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 include/linux/i2c.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/linux/i2c.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/i2c.h
+++ linux-2.6/include/linux/i2c.h
@@ -345,7 +345,7 @@ struct i2c_algorithm {
 struct i2c_adapter {
 	struct module *owner;
 	unsigned int id;
-	unsigned int class;
+	unsigned int class;		  /* classes to allow probing for */
 	const struct i2c_algorithm *algo; /* the algorithm to access the bus */
 	void *algo_data;

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj3G38ACgkQD27XaX1/VRtGwQCfWdsIpVSSK4+YNmSLjfbxPPmt
xKUAoKq8Bi6aOlAnWouI6h/dnw4R6k6t
=ZOvU
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--


--===============2789933301782609392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============2789933301782609392==--

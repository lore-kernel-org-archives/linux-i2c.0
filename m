From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: platform_data when using of?
Date: Thu, 24 Apr 2008 11:00:45 +0200
Message-ID: <20080424090045.GA4201@pengutronix.de>
References: <20080423164523.GA4190@pengutronix.de>
	<20080423203012.24ed38b6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0428926065383703309=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080423203012.24ed38b6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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


--===============0428926065383703309==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2008 at 08:30:12PM +0200, Jean Delvare wrote:

Hello Jean,

> Each i2c driver can support many different devices, which are
> differentiated simply by their name. So the driver can behave
> differently for each device type as needed.
We exactly threw this out of at24 in the new revision, as name-matching
stored quite some data in the driver which was needed only once during
initialization. Also, it was not very flexible; what if you want to mark
this chip as read-only, your variant has bigger page size and could be
faster... The list of device names would grow too fast IMHO, adding a
new feature which is selectable by a flag could easily double it.

Then again: If Jochen's patches get applied, then I have to use
MODULE_DEVICE_TABLE anyhow, or?

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIEEw9D27XaX1/VRsRAu1fAJ9aMqUa6GZG07x/vsz7p4GKeOzgFwCfZ9nu
pE8rPBupYLCH+Gcd8AyyxyY=
=UK8I
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


--===============0428926065383703309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============0428926065383703309==--

From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-pcf8575: check for errors when accessing
	the	chip
Date: Thu, 15 May 2008 21:15:59 +0200
Message-ID: <20080515191559.GA16057@pengutronix.de>
References: <1210862127-9493-1-git-send-email-w.sang@pengutronix.de>
	<20080515205416.0a6bdaf9@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1380387132714938963=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080515205416.0a6bdaf9-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: bart.vanassche-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, hennerich-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============1380387132714938963==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2008 at 08:54:16PM +0200, Jean Delvare wrote:

> This driver is deprecated and you should be using
> drivers/gpio/pcf857x.c instead if you can.
Well, sadly , I cannot :) The whole platform is kind of deprecated and
adding gpio-support for it is too much in this case.

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILIvvD27XaX1/VRsRAid8AJ0fA4L42EqQ5BSy1ynvWgbVMH1tqwCffvie
u5uxGSO0kMrBmsQMpl+Nrak=
=G0Ik
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--


--===============1380387132714938963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1380387132714938963==--

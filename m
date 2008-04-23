From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: platform_data when using of?
Date: Wed, 23 Apr 2008 18:45:23 +0200
Message-ID: <20080423164523.GA4190@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8949838498501884249=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============8949838498501884249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I finally could get the work started with I2C on a MPC8260-based
platform. I applied Jochen's series on top of 2.6.25 and it seems I
could get the i2c-cpm and the rtc-rs5c372 driver working (except that it
doesn't autoload as a module, but I think this is my fault somewhere).
I have not checked all yet, but at least some reasonable things do happen.

I now wanted to test the latest at24-driver on top of that and stumbled
over the fact, that I can't directly add platform_data to the dts-file.
(As at24 shall be a generic driver, data about the eeprom type needs to
be provided.) If I understood of correctly, I need to create another
child node and put all necessary data in there (what also means one
cannot use the predefined macros for known chips in at24.h). After that
I use of_get_property and collect the data.

So, at the end, every driver using platform_data has to cope with two
mechanisms to get the desired data? This sounds questionable to me, but
maybe I just got something wrong as this is my first contact with of.

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFID2ejD27XaX1/VRsRAt6XAJoDaOgpybdGMF3jNQTWJ34WdvMmhgCfeMW2
KQt77EFFfsUHWO3uC2VjTaM=
=+aCi
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--


--===============8949838498501884249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============8949838498501884249==--

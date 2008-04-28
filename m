From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 0/2] i2c: Add support for device alias names
Date: Mon, 28 Apr 2008 17:35:43 +0200
Message-ID: <20080428153543.GB4353@pengutronix.de>
References: <20080428113052.6d024bda@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6678767877752803099=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080428113052.6d024bda-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
Cc: Sievers <kay.sievers-tD+1rO4QERM@public.gmane.org>, Laurent-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Kay-cy1Wll9GaHOsTnJN9+BGXg@public.gmane.org, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--===============6678767877752803099==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jean,

I tested on this hardware

 MPC8260 (powerpc) + PCF8575 (io expander) + LM84 (sensor)
 + RS5C372 (rtc) + X24645 (eeprom)

the following software

 2.6.25-git11 + your 2 patches + Patches 5-7 from Jochen's series
 (for the CPM2-bus-driver)

The rtc and the eeprom were assigend through of-tree. The expander
and the sensor were assigned via the old-binding method using
force-parameters.

It builds fine, except for two warnings of redefinitions in Jochen's
patches. (I think they need a few updates anyhow). The output in
modules.alias and /sys make sense. I2C works flawlessly for all
devices.

Please let me know, if you need to more information.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIFe7PD27XaX1/VRsRApJ0AJ4hu0eSjFjaM/lgiLv3bOoz7mv+zQCdH9jE
aPqEJiBlQhXddi3O389OFrI=
=5Vz8
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--


--===============6678767877752803099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============6678767877752803099==--

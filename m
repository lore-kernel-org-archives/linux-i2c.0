From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Fri, 5 Mar 2010 08:41:55 +0100
Message-ID: <20100305074155.GD21925@pengutronix.de>
References: <1267772895-25409-1-git-send-email-yang.shi@windriver.com> <20100305071130.GB21925@pengutronix.de> <4B90B341.9000601@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4B90B341.9000601-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yang Shi <yang.shi-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Is the use of 'eeprom' instead of 'at24' intentional?
> >  =20
>=20
> Unfortunately, at24 driver can't work on this board, I must use legacy
> eeprom.

Well, you are of course free to choose here :)

I'd just be interested if there is a software limitation which prevents you=
 from
using AT24. Because, it _should_ work with all kind of eeproms the legacy d=
river
deals with. Otherwise it is probably a bug which needs to be fixed.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuQtcMACgkQD27XaX1/VRvudwCcDh5SKi1uF8McyFVJphGbTzrw
DyQAn3VWHIc3yopV++1OvlM+2Ixe2e1+
=YLUF
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--

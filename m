From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: New home for DS1682 driver
Date: Wed, 7 Oct 2009 11:56:10 +0200
Message-ID: <20091007095610.GF3177@pengutronix.de>
References: <20091007115017.6941faa7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091007115017.6941faa7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2009 at 11:50:17AM +0200, Jean Delvare wrote:
> Hi Grant,
>=20
> Driver ds1682 needs a new home, as drivers/i2c/chips will be gone soon.
> Do you have a preference for where it should go?
>=20
> As the device includes an EEPROM, the driver could go in
> drivers/misc/eeprom, but OTOH the EEPROM in question is so small that
> this can hardly be considered the main feature of the driver. So maybe
> just drivers/misc?

I would much prefer drivers/misc. What about tsl2550.c? I thought the plan =
back
then was to wait for IIO becoming mainline? Or shall we also put it to
drivers/misc until then?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrMZboACgkQD27XaX1/VRsYJACaAiRyONWAdJFdgGb0BmaBdIW4
aooAn0JDuTaeHKVUAMMIT74i4xvA2vdB
=4ZuJ
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--

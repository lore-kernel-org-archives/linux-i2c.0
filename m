From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: New home for DS1682 driver
Date: Wed, 7 Oct 2009 12:25:57 +0200
Message-ID: <20091007102557.GG3177@pengutronix.de>
References: <20091007115017.6941faa7@hyperion.delvare> <20091007095610.GF3177@pengutronix.de> <20091007120734.31a41f33@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rnP2AJ7yb1j09OW/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091007120734.31a41f33-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--rnP2AJ7yb1j09OW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2009 at 12:07:34PM +0200, Jean Delvare wrote:
> On Wed, 7 Oct 2009 11:56:10 +0200, Wolfram Sang wrote:
> > On Wed, Oct 07, 2009 at 11:50:17AM +0200, Jean Delvare wrote:
> > > Hi Grant,
> > >=20
> > > Driver ds1682 needs a new home, as drivers/i2c/chips will be gone soo=
n.
> > > Do you have a preference for where it should go?
> > >=20
> > > As the device includes an EEPROM, the driver could go in
> > > drivers/misc/eeprom, but OTOH the EEPROM in question is so small that
> > > this can hardly be considered the main feature of the driver. So maybe
> > > just drivers/misc?
> >=20
> > I would much prefer drivers/misc.
>=20
> OK, fine with me. Will you send a patch?

Will do if you want one. My idea was to wait for IIO becoming mainline and =
then
take care of both.

> For tsl2550, the plan is indeed to wait for iio to become mainline. Or
> the alternative ALS subsystem. I hope we won't have to wait too long.

Good you mentioned ALS; I forgot about it. I am afraid it will still take a
while for IIO, but moving drivers twice is also ugly :(

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rnP2AJ7yb1j09OW/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrMbLUACgkQD27XaX1/VRvVpQCeOoqELVj/1F3BKxEtP5zcvvRk
vFgAn1+d5A883JQpYN/pt67ABoHojX07
=UQx+
-----END PGP SIGNATURE-----

--rnP2AJ7yb1j09OW/--

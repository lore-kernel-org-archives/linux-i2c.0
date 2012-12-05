From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RFC] misc/at24: distinguish between eeprom and fram
 chips
Date: Wed, 5 Dec 2012 17:41:53 +0100
Message-ID: <20121205164153.GA5011@pengutronix.de>
References: <201212041758.38600.poeschel@lemonage.de>
 <20121204183238.GA15067@pengutronix.de>
 <201212051043.07460.poeschel@lemonage.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201212051043.07460.poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 05, 2012 at 10:43:07AM +0100, Lars Poeschel wrote:
> I see there where to much "no"s to get anything in, but thank you for
> your comments and explanations.

Not necessarily, just not in this form :)

>=20
> > > I wanted to use a fm24c04 i2c fram chip with linux. I grepped the sou=
rce
> > > and found nothing. I later found that my chip can be handled by at24
> > > eeprom driver. It creates a sysfs file called eeprom to read from and
> > > write to the chip. Userspace has no chance to distinguish if it is
> > > writing an eeprom or a fram chip.
> >=20
> > Why should it?
>=20
> Because writes are much faster and it doesn't have to take care on erase
> cycles. It could use other write strategies on such devices and update
> informations that have to survive power downs more often.

I agree. I think that a seperate attribute named e.g. 'page_size' would
be more helpful than renaming the binary file to fram?

> > The method of accessing EEPROMs is used by way more chips than FRAMs.
> > So, I'd prefer to have the text updated more generic like "EEPROMs and
> > similar devices like RAMs, ROMs, etc...". Describing setting .flags in
> > Kconfig is overkill.
>=20
> A patch updating Kconfig is below.

Looks good from a glimpse, will apply it later.

> No one knows all chips out there.
> For the fm24c04 I use page_size !=3D chip_size. It does not buffer but it=
 has=20
> two pages, 256 bytes each.

Yup, it uses two I2C adresses...

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlC/eVEACgkQD27XaX1/VRtFGACeMTUgM/IelOSf6mgZnFu9xAii
UaMAoMCK7HaKqB5m+DaETquLdYLUPz+p
=DnTJ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

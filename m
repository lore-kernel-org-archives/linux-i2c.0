From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] i2c: i801: Register optional lis3lv02d i2c device on
 Dell machines
Date: Sun, 28 Jan 2018 15:45:09 +0100
Message-ID: <20180128144509.pobnj7cayc4psgrj@pali>
References: <20180127133209.28995-1-pali.rohar@gmail.com>
 <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fu7yxevz6pow27fd"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdWA-0a_FeicHSi_FfWurQ9EvkdW0raqgoRVySTyxDJ0Q@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <Mario_Limonciello@dell.com>, Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org


--fu7yxevz6pow27fd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 28 January 2018 16:39:25 Andy Shevchenko wrote:
> On Sat, Jan 27, 2018 at 3:32 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> > +static bool is_dell_system_with_lis3lv02d(void)
> > +{
>=20
> > +       /*
> > +        * Check that ACPI device SMO88xx exists and is enabled. That A=
CPI
> > +        * device represent our ST microelectronics lis3lv02d accelerom=
eter but
> > +        * unfortunately without any other information (like i2c addres=
s).
> > +        */
>=20
> Isn't it simple
>=20
> return acpi_dev_present("SMO88", NULL, -1);
>=20
> call?

ACPI device name is SMO8800, SMO8810, ... Will that acpi_dev_present
function match only prefix and not exact string?

> > +       found =3D false;
> > +       status =3D acpi_get_devices(NULL, check_acpi_smo88xx_device, NU=
LL,
> > +                                 (void **)&found);
> > +       if (!ACPI_SUCCESS(status) || !found)
> > +               return false;
> > +
> > +       return true;
> > +}
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--fu7yxevz6pow27fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWm3h8wAKCRCL8Mk9A+RD
UhL9AKCa7T1iAU8Dn+wkqCW36ktmrtQf/QCfQveRhexCX3Wwgj/ikwaFcmZKEZs=
=svZr
-----END PGP SIGNATURE-----

--fu7yxevz6pow27fd--

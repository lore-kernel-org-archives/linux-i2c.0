From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-scmi: add a MS HID
Date: Thu, 30 Mar 2017 17:52:33 +0200
Message-ID: <20170330155233.dfnqe7d2xkr32zlo@ninjato>
References: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
 <20170323204747.w2nxxrpjwypiygwb@ninjato>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gnrvw7pdweomcqbh"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170323204747.w2nxxrpjwypiygwb@ninjato>
Sender: linux-acpi-owner@vger.kernel.org
To: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>, Michael Brunner <Michael.Brunner@kontron.com>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org


--gnrvw7pdweomcqbh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 09:47:47PM +0100, Wolfram Sang wrote:
> On Fri, Mar 10, 2017 at 04:58:35PM +0300, Viktor Krasnov wrote:
>=20
> Thanks for the patch!
>=20
> adding linux-acpi to CC. This is more an ACPI question than I2C.

Mika? Andy? Jarkko? Any input on this?

>=20
> > From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> >=20
> > Description of the problem:
> >  - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIB=
M";
> >  - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
> >    Interface Specification, version 1.0": "Each device must specify=20
> >    'SMBUS01' as its _HID and use a unique _UID value";
> >  - unfortunately, BIOS vendors (like AMI) seem to ignore this requireme=
nt
> >    and implement "SMB0001" HID instead of "SMBUS01";
> >  - I speculate that they do this because only "SMB0001" is hard coded in
> >    Windows SMBus driver produced by Microsoft.
> >=20
> > This leads to following situation:
> >  - SMBus works out of box in Windows but not in Linux;
> >  - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
> >    SMBus work in Linux. Moreover the same board vendors complain that
> >    tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
> >    and produce errors.  So they need to constantly patch the compiler f=
or=20
> >    each new version of BIOS.
> >=20
> > As it is very unlikely that BIOS vendors implement a correct HID in
> > future, I would propose to consider whether it is possible to work arou=
nd
> > the problem by adding MS HID to the Linux i2c-scmi driver.
> >=20
> > Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> > Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
> > Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
> > ---
> >  drivers/i2c/busses/i2c-scmi.c | 1 +
> >  include/acpi/acpi_drivers.h   | 2 ++
> >  2 files changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scm=
i.c
> > index dfc98df..fb9aee0 100644
> > --- a/drivers/i2c/busses/i2c-scmi.c
> > +++ b/drivers/i2c/busses/i2c-scmi.c
> > @@ -51,6 +51,7 @@ struct acpi_smbus_cmi {
> >  static const struct acpi_device_id acpi_smbus_cmi_ids[] =3D {
> >  	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
> >  	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
> > +	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
> >  	{"", 0}
> >  };
> >  MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
> > diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> > index 29c6912..d34538b 100644
> > --- a/include/acpi/acpi_drivers.h
> > +++ b/include/acpi/acpi_drivers.h
> > @@ -60,6 +60,8 @@
> >  #define ACPI_DOCK_HID			"LNXDOCK"
> >  /* Quirk for broken IBM BIOSes */
> >  #define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
> > +/* SMBUS HID definition as supported by Microsoft Windows */
> > +#define ACPI_SMBUS_MS_HID		"SMB0001"
> > =20
> >  /*
> >   * For fixed hardware buttons, we fabricate acpi_devices with HID
> > --=20
> > 1.9.3
> >=20



--gnrvw7pdweomcqbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljdKb0ACgkQFA3kzBSg
KbasTRAAqAB//05EKR4ylTU9DIfzr6Gtq7T4/KISf3hCtLp6PBePc1Y2J5ICOC43
p/kSOwy898nYXCvXZED/hIPtJzYil+56mBhMcUC7X7KBLXhCRRf8p7BrRXRygZGN
6rGSbLAxMF3hGb4L8JObQA9aGw//b5BjxMpiymcVr+vMr35alHzyJNk03dODjXvQ
YocAPjlvA/v65xzhlP/XZfH+DSotH4w5ZHhZpfPTGHdEo22wMVEQvJrENRUF3/8r
SYRyTO7Pmt+LhoBPmk4VtojRfdJtpEzVELP21ojoXb9r6toyGThOdX7d7MCjDUZO
uS+cO4IhWTba8YZgsNBwRCMyJZP0PNW0EMUquibprhg8gE9pEvRvuH5gBCMuo2hR
RGtqVBQs322WK+nbDBCq9UhL/IXEp8ClR9av9/TqwU65vV4yzc5vAgqAR54iHD6e
vf8j3QADH0uX0PcnE8PZq/9nzsTAvHDf+ac4dYyMY63JthlE0Ozol86r9KqsGX6b
sRGCUxCvdWd+R34K6HuJ+vzHvMKB0YdWgd0FY8ehKle9NNox624ZTxXWM1k8qMG8
H/ByKtgmDlWRg4pszS+EdKgu6zfHELcdzfyR+fKJ7X+33dr6T39IcZWZapPp+02U
V/m8DbD+KLd+6Ki6zZbze0Uue+vPLmsgytve88xVIxGdG1f2Fio=
=UQGP
-----END PGP SIGNATURE-----

--gnrvw7pdweomcqbh--

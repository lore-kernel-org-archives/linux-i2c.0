From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-scmi: add a MS HID
Date: Thu, 23 Mar 2017 21:47:47 +0100
Message-ID: <20170323204747.w2nxxrpjwypiygwb@ninjato>
References: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cm7mxmapcxnhkggf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41041 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751672AbdCWUru (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 23 Mar 2017 16:47:50 -0400
Content-Disposition: inline
In-Reply-To: <1489154315-26499-1-git-send-email-vkrasnov@dev.rtsoft.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
Cc: jdelvare@suse.com, linux-i2c@vger.kernel.org, Edgar Cherkasov <echerkasov@dev.rtsoft.ru>, Michael Brunner <Michael.Brunner@kontron.com>, linux-acpi@vger.kernel.org


--cm7mxmapcxnhkggf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 04:58:35PM +0300, Viktor Krasnov wrote:

Thanks for the patch!

adding linux-acpi to CC. This is more an ACPI question than I2C.

> From: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
>=20
> Description of the problem:
>  - i2c-scmi driver contains only two identifiers "SMBUS01" and "SMBUSIBM";
>  - the fist HID (SMBUS01) is clearly defined in "SMBus Control Method
>    Interface Specification, version 1.0": "Each device must specify=20
>    'SMBUS01' as its _HID and use a unique _UID value";
>  - unfortunately, BIOS vendors (like AMI) seem to ignore this requirement
>    and implement "SMB0001" HID instead of "SMBUS01";
>  - I speculate that they do this because only "SMB0001" is hard coded in
>    Windows SMBus driver produced by Microsoft.
>=20
> This leads to following situation:
>  - SMBus works out of box in Windows but not in Linux;
>  - board vendors are forced to add correct "SMBUS01" HID to BIOS to make
>    SMBus work in Linux. Moreover the same board vendors complain that
>    tools (3-rd party ASL compiler) do not like the "SMBUS01" identifier
>    and produce errors.  So they need to constantly patch the compiler for=
=20
>    each new version of BIOS.
>=20
> As it is very unlikely that BIOS vendors implement a correct HID in
> future, I would propose to consider whether it is possible to work around
> the problem by adding MS HID to the Linux i2c-scmi driver.
>=20
> Signed-off-by: Edgar Cherkasov <echerkasov@dev.rtsoft.ru>
> Signed-off-by: Michael Brunner <Michael.Brunner@kontron.com>
> Acked-by: Viktor Krasnov <vkrasnov@dev.rtsoft.ru>
> ---
>  drivers/i2c/busses/i2c-scmi.c | 1 +
>  include/acpi/acpi_drivers.h   | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
> index dfc98df..fb9aee0 100644
> --- a/drivers/i2c/busses/i2c-scmi.c
> +++ b/drivers/i2c/busses/i2c-scmi.c
> @@ -51,6 +51,7 @@ struct acpi_smbus_cmi {
>  static const struct acpi_device_id acpi_smbus_cmi_ids[] =3D {
>  	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
>  	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
> +	{ACPI_SMBUS_MS_HID, (kernel_ulong_t)&smbus_methods},
>  	{"", 0}
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_smbus_cmi_ids);
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index 29c6912..d34538b 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -60,6 +60,8 @@
>  #define ACPI_DOCK_HID			"LNXDOCK"
>  /* Quirk for broken IBM BIOSes */
>  #define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
> +/* SMBUS HID definition as supported by Microsoft Windows */
> +#define ACPI_SMBUS_MS_HID		"SMB0001"
> =20
>  /*
>   * For fixed hardware buttons, we fabricate acpi_devices with HID
> --=20
> 1.9.3
>=20

--cm7mxmapcxnhkggf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljUNHMACgkQFA3kzBSg
KbbEFBAAqNW4jx65vvcQlosolgTcga7o2rVDyDfFPC/5tWo2R0zxK6H+q/DAGuHr
FDxWzb/Zkz67XKiyPmJgVTj5b6jqGY7uvJl3iGaMPv0PQEfEjYqYAQBp33Oa6wSr
p7xNZ76fXCi0Kh18SfjploRXIug5sCw/ox4tLGo56MGs4XNpWGHt7ubXQEQNJ2jB
L8vSr76qvLxZRFMQXZZpPXWBKyEUJ4RqKShNn14kNIXRnWxVDBqaYp39PxYuTXGB
moBLzITYymQTR0SSC5S0jJI1B2gEVrSUoKxzvT4TlB3s+bNw7mz/xxdDty+OVqxx
OkJ/EcXEQUj+x2dwuXQKkb01EJ/ONiRbK3lPllEQlrrEkOgztoViA9z1CglMB/xg
LB9m8uH/arSzJH6KqGxK3WvpCy2plJ7AtKO7dSpJSzpj50HQA34EJSzQAQ+sAMEk
3p8qMPLRK2hTXl/6lyMWNIT3Vt1798zFu69IB8hNUSmrfBV69EVMPN6QKqNQtwzm
cbG0DLx+NU3vfTieXE2baeTN6JxqIEJ7sA/2jIm1hUztkye5XQkKusqg1mvNakNg
Vh5JsQtGTbbbQUpZesSZ3P4ZJ3hTCZPaR1O078nxMBBlufqhgSvYVrKsOC2K6kpL
Ih1QTGDJjiyq/UqDc5zVy36mnM0X5MPGSdJq33WkOiI5JJr/et0=
=sfYP
-----END PGP SIGNATURE-----

--cm7mxmapcxnhkggf--

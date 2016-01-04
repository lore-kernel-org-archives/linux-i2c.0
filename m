From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4] i2c: designware: Do not require clock when SSCN and
 FFCN are provided
Date: Mon, 4 Jan 2016 17:15:25 +0100
Message-ID: <20160104161525.GC1599@katana>
References: <1451920655-10798-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1451920655-10798-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 04, 2016 at 09:17:35AM -0600, Suravee Suthikulpanit wrote:
> The current driver uses input clock source frequency to calculate
> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do n=
ot
> currently have a good way to provide the frequency information.
> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
> to directly provide these values. So, the clock information should
> no longer be required during probing.
>=20
> However, since clk can be invalid, additional checks must be done where
> we are making use of it.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Loc Ho <lho@apm.com>=20
> ---
>=20
> Note: This has been tested on AMD Seattle RevB for both DT and ACPI.
>=20
> Changes from V3 (https://lkml.org/lkml/2015/12/22/596):
>     * Add i2c_dw_plat_prepare_clk() per Andy's suggestion
>     * Add tested-by Loc Ho.

The changes from V3 are big enough that I'd appreciate a new Tested-by
tag.


--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWipqdAAoJEBQN5MwUoCm2D0AP/A1LPN7NPILxvLhinn8z2kQr
hk5y/D/4ZoSrjkyLYac48X2jOSmXRTHFip4/Xq9LoUnD46anXa+S08RxppnOee4q
HrwoDig+odlT8+4OsDivsVPYmSqDrpPHCc7C3jkFEtCHN3lgGc9kNfldyU0sCFHY
fp4HROQS1a4GpZjXfeSXJs62MJxxRPu39xenpB8y4DSjYIKKaCpMjuH7Lwnk0jkD
L1VxBn+KiSgoQdq26/uEh3Nlb3sF7xW+FtVCeh2cAHRku3LHwr1jTmg/3PUhrQZl
jPfLxJx3TcfLuc79+Zd6se7uQwgNxNF2Dvuv2+8klfGM3Jm+l0nHiXSaS8d0xBxX
FWr5RJINZFreU4ZOm6hpdQblmHRXSzDzYA+cWaYX1BSgEZ67Ys7nVa8hkNjQDEkY
0oAfAR4OVx4InEmZYSSv3GjhmmNvBQxLuEyM2V6FaTcrAOa47DlmI8L2ic9+KNdd
7701EWD+eQokqSPtkMUv3qgF0emE/ptUbPRewRiad6zdRzrCAMy3ihSCkX9VdzIF
Ys4BpssA4KscVzwf8SAIjyCk1teH7Kk7zdxereDlnhO+eVSeshFn5T6DE8aPlBsf
tOMV9sLkjbpoVc0z8Tx6w3QCwNAv5ER91CJvIFu0BMz04SHOt50geKm9lwJxwr2y
/MDbFKu0Ejdam0NsCS/r
=JSng
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--

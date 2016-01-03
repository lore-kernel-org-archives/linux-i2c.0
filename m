From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Add support for AMD Seattle I2C
Date: Sun, 3 Jan 2016 19:45:55 +0100
Message-ID: <20160103184555.GG1522@katana>
References: <1450216553-5641-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <5670C90A.5020305@amd.com>
 <20151216091652.GN1762@lahna.fi.intel.com>
 <56717552.4060203@amd.com>
 <20151216145401.GX1762@lahna.fi.intel.com>
 <567206B7.1050405@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9/eUdp+dLtKXvemk"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <567206B7.1050405@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--9/eUdp+dLtKXvemk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 16, 2015 at 06:49:59PM -0600, Suravee Suthikulanit wrote:
> Mika,
>=20
> On 12/16/2015 8:54 AM, Mika Westerberg wrote:
> >On Wed, Dec 16, 2015 at 08:29:38AM -0600, Suravee Suthikulpanit wrote:
> >>>
> >>>
> >>>On 12/16/2015 03:16 AM, Mika Westerberg wrote:
> >>>> >On Tue, Dec 15, 2015 at 08:14:34PM -0600, Suravee Suthikulpanit wro=
te:
> >>>>> >>Hi Mika,
> >>>>> >>
> >>>>> >>On 12/15/15 15:55, Suravee Suthikulpanit wrote:
> >>>>>> >>>Add device HID AMDI0510 to match the I2C controlers on AMD Seat=
tle platform
> >>>>>> >>>
> >>>>>> >>>Signed-off-by: Suravee Suthikulpanit<Suravee.Suthikulpanit@amd.=
com>
> >>>>>> >>>---
> >>>>>> >>>  drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
> >>>>>> >>>  1 file changed, 1 insertion(+)
> >>>>>> >>>
> >>>>>> >>>diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/driv=
ers/i2c/busses/i2c-designware-platdrv.c
> >>>>>> >>>index 57f623b..a027154 100644
> >>>>>> >>>--- a/drivers/i2c/busses/i2c-designware-platdrv.c
> >>>>>> >>>+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> >>>>>> >>>@@ -117,6 +117,7 @@ static const struct acpi_device_id dw_i2c_a=
cpi_match[] =3D {
> >>>>>> >>>  	{ "80860F41", 0 },
> >>>>>> >>>  	{ "808622C1", 0 },
> >>>>>> >>>  	{ "AMD0010", 0 },
> >>>>>> >>>+	{ "AMDI0510", 0 },
> >>>>>> >>>  	{ }
> >>>>> >>
> >>>>> >>Since this driver seems to be used by several SOCs, and we have b=
een adding
> >>>>> >>the HID from various SOC vendors. Do you think it would be better=
 to assign
> >>>>> >>a CID so that each SOC vendor can specify in their ACPI DSDT and =
we can
> >>>>> >>match them here?
> >>>> >
> >>>> >Sure _CID would work here.
> >>>
> >>>Do you know if Synopsys has already provided a CID that we can use for=
 this?
> >No.
> >
> >>>If not, who do you think should provide this?
> >Why can't you make _CID for AMD part only? For Intel we are going to get
> >new IDs for every major SoC release no matter what.
> >
> Actually, after discussed with the team. We have decided to go with the
> AMDI0510 at this point, and we will reuse this as CID in future SOC if it
> contains compatible I2C controller.

So, can I take the patch as is?


--9/eUdp+dLtKXvemk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiWxjAAoJEBQN5MwUoCm2PmwP/1S+d+1fGQyg7crfEKHU6v6f
WHwhr3QWdkvb9p3DUwvxAh7X0xbWHATTYovZ2ORxvJdq1lAKPBB40w+WQa/JJXzz
9D0w+KrmNAcV6D57V86nXmECge1jfFgWEcX4izPIV1uC17weNDSojKNLx6pvZm8r
fYtWhlojY/P7A28aEzae720oINf8MS5ItDUz5ezgpwN7GJ1w132tSoVWNgI1XyhF
owhwHTJvSKAXTGIIKEhVNtnOraUogxVdcSB25MJfDFvO8Byes+L3hurc+MhkO5Bn
vBwupWgokibO8PZyQQjr/yveROMRtJlpSQaVBT+JD6qREsVxfmGuTZNZ9+2ro2h5
o5FnTMTPdusEauylkW852djvpIAw6pyVxhdPWLQw/abbYux+EGSDBPLnLZ22SBZy
dB0SCaQT/7Ueu0D/VX4VHW41xda6iKHuIJOQoh40Uu4bq5nAuKtq2KAeV1tVBhG6
YkwkdZkp98NDLgk4kI13qskC/3s8kHH5AzkIxNjCaVV8NkUUAgaUyy5bN1Jv8Si5
zCcrctyeIQ8fzwuQ72m6u/8rwxDqzzWakgRp9nkSjgoDGCPmxzSuCRVJYe4dwbD9
N//b19fgk4h7tluYl2s5CAwNt1EvQtxJqfWzquGHjD10WsnT+YG4XL39QHPay0Ks
V6Oswa+ifBcWGMHKosJU
=G1UM
-----END PGP SIGNATURE-----

--9/eUdp+dLtKXvemk--

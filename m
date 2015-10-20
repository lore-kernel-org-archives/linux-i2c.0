From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/4] Support multiplexed main SMBus interface on SB800
Date: Tue, 20 Oct 2015 17:19:35 +0200
Message-ID: <20151020151935.GH5379@katana>
References: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43405 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbbJTPTl (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 11:19:41 -0400
Content-Disposition: inline
In-Reply-To: <1440500705-2288-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, tbrandonau@gmail.com, eddi@depieri.net, galandilias@gmail.com


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2015 at 01:05:01PM +0200, Christian Fetzer wrote:
> This is an attempt to upstream the patches created by Thomas Brandon and
> Eddi De Pieri to support the multiplexed main SMBus interface on the SB800
> chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg06757=
=2Ehtml)
>=20
> I have mainly rebased the latest patch version and tested the driver on a
> HP ProLiant MicroServer G7 N54L (where this patch allows to access sensor=
 data
> from a w83795adg).
>=20
> The patched driver is running stable on the machine, given that ic2_piix4=
 is
> loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4 calling
> sensors triggers some errors:
>     ERROR: Can't get value of subfeature temp1_min_alarm: Can't read
>=20
> While the kernel log shows:
>     i2c i2c-1: Transaction (pre): CNT=3D0c, CMD=3D05, ADD=3D31, DAT0=3D03=
, DAT1=3Dc0
>     i2c i2c-1: Error: no response!
>     i2c i2c-1: Transaction (post): CNT=3D0c, CMD=3D05, ADD=3D31, DAT0=3Df=
f, DAT1=3Dff
> Unfortunately I don't know how to tackle this specific issue.
>=20
> Please review and let me know required changes in order to get this upstr=
eam
> finally.
>=20
> Eddi, Thomas, it would be great if you could verify the changes on your
> machines.

Yes, additional tests are always good for a patch series

Asking the Intel guys for help, I have not much expierence with x86
platforms... Mika, Jarkko, Andy any chance to help?

>=20
> Regards,
> Christian
>=20
> Christian Fetzer (4):
>   i2c-piix4: Optionally release smba in piix4_adap_remove
>   i2c-piix4: Convert piix4_main_adapter to array
>   i2c-piix4: Add support for multiplexed main adapter in SB800
>   i2c-piix4: Add adapter port name support for SB800 chipset
>=20
>  drivers/i2c/busses/i2c-piix4.c | 151 +++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 134 insertions(+), 17 deletions(-)
>=20
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWJluHAAoJEBQN5MwUoCm2Dc4P/1S7qP04yaVGmk39iZJY8Mre
vvZfHa8071l4N61aNw2VH7dRZaNK0Zc1yI139aRaPZNsLuylpO2VOXbk5fYAHlaE
JtX/fthYLDI0ODMnnJ2i4k9BwnmmgHfyyTGSS4tjDA6T/3TDIK2VAgbyrQBNfcnM
4YHtF0jOkITLi3OAeCiNfOpr54ERb2z9by2T5DpuzYCUSjpTsdJaqKjElxFgRXKr
jZlweMbv21cn/gMQ4JM7kTN5jECy75npok4fYCv+NeWeJJXS8NiehT5+4Bx8M5sq
pZDkkAMIT5zj898z8Ek6Wt1VGZgY8aZJp+WASYCPP91Kio3eFXsFeVRy5358NwO5
KnWFFO3OnzyELgAiWQ/+R7qC/CJuhKNhFlRvCKZ5F9khBw/AaP4A6YrfTo06kS7v
4i54wWsXMiY6iX1PL9s8297nUM2bXdLHpGsotN5d3c7+QeL6WK+9vw1sNw0aLzBZ
abkAsmLFllz7rcc2rTx2IG4zDAmBAm0I37m/mNurjRYOd/Wz+TP11GXvhxkM1rhw
FxHAQsCaPO/Nc4D0VhsxYvGZN5vjG514eXZYEt1TH/XxjtNDksW2V6kim9FpWsSi
dLZY3gM0FMIDLC2GYUaWAhnvLaL1jhKcYXlhILM4TNp1di2M4cfBWQGWgE+lbRV5
I0S531ipi5CuezdMkM55
=N+yG
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--

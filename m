From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 0/3] Support multiplexed main SMBus interface on SB800
Date: Mon, 16 Nov 2015 11:26:48 +0200
Message-ID: <1447666008.31665.140.camel@linux.intel.com>
References: <1447587184-21965-1-git-send-email-fetzer.ch@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14478 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbbKPJ1A (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 16 Nov 2015 04:27:00 -0500
In-Reply-To: <1447587184-21965-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Christian Fetzer <fetzer.ch@gmail.com>, linux-i2c@vger.kernel.org
Cc: jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com

On Sun, 2015-11-15 at 12:33 +0100, Christian Fetzer wrote:
> This is an attempt to upstream the patches created by Thomas Brandon
> and
> Eddi De Pieri to support the multiplexed main SMBus interface on the
> SB800
> chipset. (https://www.mail-archive.com/linux-i2c@vger.kernel.org/msg0
> 6757.html)
>=20
> I have mainly rebased the latest patch version and tested the driver
> on a
> HP ProLiant MicroServer G7 N54L (where this patch allows to access
> sensor data
> from a w83795adg).
>=20
> The patched driver is running stable on the machine, given that
> ic2_piix4 is
> loaded before jc42 and w83795. If jc42 is loaded before i2c_piix4
> calling
> sensors triggers some errors:
> =C2=A0=C2=A0=C2=A0=C2=A0ERROR: Can't get value of subfeature temp1_mi=
n_alarm: Can't read
>=20
> While the kernel log shows:
> =C2=A0=C2=A0=C2=A0=C2=A0i2c i2c-1: Transaction (pre): CNT=3D0c, CMD=3D=
05, ADD=3D31, DAT0=3D03,
> DAT1=3Dc0
> =C2=A0=C2=A0=C2=A0=C2=A0i2c i2c-1: Error: no response!
> =C2=A0=C2=A0=C2=A0=C2=A0i2c i2c-1: Transaction (post): CNT=3D0c, CMD=3D=
05, ADD=3D31, DAT0=3Dff,
> DAT1=3Dff
> Unfortunately I don't know how to tackle this specific issue.
>=20
> Please review and let me know required changes in order to get this
> upstream
> finally.

One nitpick in one patch, though it looks okay for me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>=20
> Eddi, Thomas, it would be great if you could verify the changes on
> your
> machines.
>=20
> Regards,
> Christian
>=20
> v4:
> - Incorporated changes requested by Andy
> =C2=A0=C2=A0=C2=A0=C2=A0- added mutex to struct i2c_piix4_adapdata
> =C2=A0=C2=A0=C2=A0=C2=A0- added flag for releasing SMBus index region=
 to struct
> i2c_piix4_adapdata
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- this flag now indic=
ates that the adapter is a sb800 main
> adapter
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- together with the p=
ort number it simplifies the adapter
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0releasing=
 and the first patch in v3 is no more needed
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- unfortunately patch=
 3 and 4 in v3 had to be combined as
> only
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the patch=
 introducing multiplexing adds a separate
> add_adapters_sb800
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0method th=
at can be used to set the flag.
> =C2=A0=C2=A0=C2=A0=C2=A0- fixed releasing the SMBus index region in c=
ase setting up the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adapter fails
>=20
> v3:
> - Incorporated changes requested by Mika and Andy
> =C2=A0=C2=A0=C2=A0=C2=A0- main adapter name set to 'main'
> =C2=A0=C2=A0=C2=A0=C2=A0- defined constant idx address
> =C2=A0=C2=A0=C2=A0=C2=A0- block comment style, joined string literals=
, reworked for loops
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0into while loops
>=20
> v2:
> - Incorporated changes requested by Mika
> =C2=A0=C2=A0=C2=A0=C2=A0- remove adapter in reverse order
> =C2=A0=C2=A0=C2=A0=C2=A0- ERROR label
> =C2=A0=C2=A0=C2=A0=C2=A0- request base address index region only once
>=20
> Christian Fetzer (3):
> =C2=A0 i2c-piix4: Convert piix4_main_adapter to array
> =C2=A0 i2c-piix4: Add support for multiplexed main adapter in SB800
> =C2=A0 i2c-piix4: Add adapter port name support for SB800 chipset
>=20
> =C2=A0drivers/i2c/busses/i2c-piix4.c | 194
> +++++++++++++++++++++++++++++++++++------
> =C2=A01 file changed, 165 insertions(+), 29 deletions(-)
>=20

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

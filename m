From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Sat, 30 Apr 2016 10:12:46 +0200
Message-ID: <201604301012.46549@pali>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com> <CALCETrXF0PnEnHrNXkQJ6dFq3HhF7tRgkOt7zZF5EBinU_Wc+g@mail.gmail.com> <CALCETrUL9kFrGuRJVOhOvJXQRiYOyHMeWsANr__PfSSEvYWaYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2966837.uAxl91NtBG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CALCETrUL9kFrGuRJVOhOvJXQRiYOyHMeWsANr__PfSSEvYWaYw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-i2c@vger.kernel.org

--nextPart2966837.uAxl91NtBG
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 30 April 2016 02:56:14 Andy Lutomirski wrote:
> On Fri, Apr 29, 2016 at 2:42 PM, Andy Lutomirski <luto@amacapital.net>
> wrote:
> > On Fri, Apr 29, 2016 at 2:00 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > wrote:
> >> On Friday 29 April 2016 20:10:23 Andy Lutomirski wrote:
> >>> On Fri, Apr 29, 2016 at 2:03 AM, Pali Roh=C3=A1r
> >>> <pali.rohar@gmail.com>
> >>>=20
> >>> wrote:
> >>> > On Thursday 28 April 2016 11:34:38 Andy Lutomirski wrote:
> >>> >> On 04/28/2016 03:23 AM, Mika Westerberg wrote:
> >>> >> >Many Intel systems the BIOS declares a SystemIO OpRegion
> >>> >> >below the SMBus
> >>> >> >
> >>> >> >PCI device as can be seen in ACPI DSDT table from Lenovo Yoga
> >>> >> >900:
> >>> >> >  Device (SBUS)
> >>> >> >  {
> >>> >> > =20
> >>> >> >      OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
> >>> >> >      Field (SMBI, ByteAcc, NoLock, Preserve)
> >>> >> >      {
> >>> >> >     =20
> >>> >> >          HSTS,   8,
> >>> >> >          Offset (0x02),
> >>> >> >          HCON,   8,
> >>> >> >          HCOM,   8,
> >>> >> >          TXSA,   8,
> >>> >> >          DAT0,   8,
> >>> >> >          DAT1,   8,
> >>> >> >          HBDR,   8,
> >>> >> >          PECR,   8,
> >>> >> >          RXSA,   8,
> >>> >> >          SDAT,   16
> >>> >> >     =20
> >>> >> >      }
> >>> >> >
> >>> >> >There are also bunch of ASL methods that that the BIOS can
> >>> >> >use to access these fields. Most of the systems in question
> >>> >> >ASL methods accessing the SMBI OpRegion are never used.
> >>> >> >
> >>> >> >Now, because of this SMBI OpRegion many systems fail to load
> >>> >> >the SMBus
> >>> >> >
> >>> >> >driver with an error looking like one below:
> >>> >> >  ACPI Warning: SystemIO range
> >>> >> >  0x0000000000003040-0x000000000000305F
> >>> >> > =20
> >>> >> >       conflicts with OpRegion
> >>> >> >       0x0000000000003040-0x000000000000304F
> >>> >> >       (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
> >>> >> > =20
> >>> >> >  ACPI: If an ACPI driver is available for this device, you
> >>> >> >  should use
> >>> >> > =20
> >>> >> >       it instead of the native driver
> >>> >> >
> >>> >> >The reason is that this SMBI OpRegion conflicts with the PCI
> >>> >> >BAR used by the SMBus driver.
> >>> >> >
> >>> >> >It turns out that we can install a custom SystemIO address
> >>> >> >space handler for the SMBus device to intercept all accesses
> >>> >> >through that OpRegion. This allows us to share the PCI BAR
> >>> >> >with the ASL code if it for some reason is using it. We do
> >>> >> >not expect that this OpRegion handler will ever be called
> >>> >> >but if it is we print a warning and execute the read/write
> >>> >> >operation under a lock which prevents ASL and OS from
> >>> >> >messing each other.
> >>> >>=20
> >>> >> Tested-by: Andy Lutomirski <luto@kernel.org> # Dell XPS 13
> >>> >> 9350
> >>> >>=20
> >>> >> This successfully works around:
> >>> >>=20
> >>> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
> >>> >>=20
> >>> >> but the BIOS people should still fix their ASL.  Sigh.
> >>> >>=20
> >>> >> On the Dell laptop, the observable effect is that the driver
> >>> >> loads and finds the iTCO thing.
> >>> >>=20
> >>> >> Pali, this may be considerably more useful on your laptop.
> >>> >=20
> >>> > Andy, I am right that I will be able to load i2c-i801.ko driver
> >>> > without acpi_enforce_resources=3Dlax parameter?
> >>>=20
> >>> Yes, and it works on my laptop.
> >>=20
> >> Looks like it is working also on my laptop.
> >>=20
> >>> > If yes, then it sounds good! Finally I would be able to bind
> >>> > lis3lv02d_i2c.ko driver for accelerometer which is on my E6440
> >>> > machine.
> >>> >=20
> >>> > Andy, is there any way to tell i2c-i801.ko driver that on i2c
> >>> > bus (which that driver exports) is present some i2c device?
> >>> > Months ago I got list of Latitude machines on which i2c
> >>> > address is that accelerometer present.
> >>> >=20
> >>> > It is possible to hardcode that mapping (DMI name of laptop -->
> >>> > i2c address) into dell-laptop driver, so i2c-i801.ko and
> >>> > lis3lv02d_i2c.ko will be automatically loaded and lis3l binded
> >>> > correctly to i801 i2c address?
> >>>=20
> >>> I don't know how this part works, but I doubt that doing it in
> >>> dell-laptop will be convenient.  After all, dell-laptop can load
> >>> before i2c-i801.
> >>>=20
> >>> Jean and Wolfram: is there a quirk mechanism to add i2c devices
> >>> that aren't directly enumerable but are known to exist due to
> >>> DMI?
> >>=20
> >> Maybe something like i2c_register_board_info()?
> >=20
> > Maybe.  i think that wants to be called before the adapter shows
> > up, though.
>=20
> i2c_probe_optional_slaves may be a more appropriate place to put
> this.
>=20
> Also, is there any indication in your DSDT that this thing exists?

No :-( There is nothing which can tell us presence of accelerometer.=20
Dell people told me that on Latitude machines E6540, E6440, E6440 ATG,=20
E5250, E5450 and E5550 is accelerometer present on 0x29 address. So=20
there is no other way than hardcode those DMI strings and do manual=20
configuration...

Maybe it should go into dell-smo8800.ko driver. That one is ACPI and=20
from DSDT provides IRQ number (issued when laptop. fall)...

So maybe, we can guess, when SMO ACPI device is present there is=20
accelerometer on i2c bus, but we do not know exact address...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2966837.uAxl91NtBG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlckaP4ACgkQi/DJPQPkQ1J28wCgkW/k0zGGaXf0lyVYieiUu4Wp
zicAoIfh758W1g+OFGO3GIwoDolC9P1X
=F8O5
-----END PGP SIGNATURE-----

--nextPart2966837.uAxl91NtBG--

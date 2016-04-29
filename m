From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Fri, 29 Apr 2016 23:00:23 +0200
Message-ID: <201604292300.23616@pali>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com> <20160429090351.GS12528@pali> <CALCETrXO128w2ZyCj3TV96gS0k_f+9THYmT-Au7s26TLB18tpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1461971377.xvVVrqOhF8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CALCETrXO128w2ZyCj3TV96gS0k_f+9THYmT-Au7s26TLB18tpA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-i2c@vger.kernel.org

--nextPart1461971377.xvVVrqOhF8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 29 April 2016 20:10:23 Andy Lutomirski wrote:
> On Fri, Apr 29, 2016 at 2:03 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > On Thursday 28 April 2016 11:34:38 Andy Lutomirski wrote:
> >> On 04/28/2016 03:23 AM, Mika Westerberg wrote:
> >> >Many Intel systems the BIOS declares a SystemIO OpRegion below
> >> >the SMBus
> >> >
> >> >PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
> >> >  Device (SBUS)
> >> >  {
> >> > =20
> >> >      OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
> >> >      Field (SMBI, ByteAcc, NoLock, Preserve)
> >> >      {
> >> >     =20
> >> >          HSTS,   8,
> >> >          Offset (0x02),
> >> >          HCON,   8,
> >> >          HCOM,   8,
> >> >          TXSA,   8,
> >> >          DAT0,   8,
> >> >          DAT1,   8,
> >> >          HBDR,   8,
> >> >          PECR,   8,
> >> >          RXSA,   8,
> >> >          SDAT,   16
> >> >     =20
> >> >      }
> >> >
> >> >There are also bunch of ASL methods that that the BIOS can use to
> >> >access these fields. Most of the systems in question ASL methods
> >> >accessing the SMBI OpRegion are never used.
> >> >
> >> >Now, because of this SMBI OpRegion many systems fail to load the
> >> >SMBus
> >> >
> >> >driver with an error looking like one below:
> >> >  ACPI Warning: SystemIO range
> >> >  0x0000000000003040-0x000000000000305F
> >> > =20
> >> >       conflicts with OpRegion
> >> >       0x0000000000003040-0x000000000000304F
> >> >       (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
> >> > =20
> >> >  ACPI: If an ACPI driver is available for this device, you
> >> >  should use
> >> > =20
> >> >       it instead of the native driver
> >> >
> >> >The reason is that this SMBI OpRegion conflicts with the PCI BAR
> >> >used by the SMBus driver.
> >> >
> >> >It turns out that we can install a custom SystemIO address space
> >> >handler for the SMBus device to intercept all accesses through
> >> >that OpRegion. This allows us to share the PCI BAR with the ASL
> >> >code if it for some reason is using it. We do not expect that
> >> >this OpRegion handler will ever be called but if it is we print
> >> >a warning and execute the read/write operation under a lock
> >> >which prevents ASL and OS from messing each other.
> >>=20
> >> Tested-by: Andy Lutomirski <luto@kernel.org> # Dell XPS 13 9350
> >>=20
> >> This successfully works around:
> >>=20
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
> >>=20
> >> but the BIOS people should still fix their ASL.  Sigh.
> >>=20
> >> On the Dell laptop, the observable effect is that the driver loads
> >> and finds the iTCO thing.
> >>=20
> >> Pali, this may be considerably more useful on your laptop.
> >=20
> > Andy, I am right that I will be able to load i2c-i801.ko driver
> > without acpi_enforce_resources=3Dlax parameter?
>=20
> Yes, and it works on my laptop.

Looks like it is working also on my laptop.

> > If yes, then it sounds good! Finally I would be able to bind
> > lis3lv02d_i2c.ko driver for accelerometer which is on my E6440
> > machine.
> >=20
> > Andy, is there any way to tell i2c-i801.ko driver that on i2c bus
> > (which that driver exports) is present some i2c device? Months ago
> > I got list of Latitude machines on which i2c address is that
> > accelerometer present.
> >=20
> > It is possible to hardcode that mapping (DMI name of laptop --> i2c
> > address) into dell-laptop driver, so i2c-i801.ko and
> > lis3lv02d_i2c.ko will be automatically loaded and lis3l binded
> > correctly to i801 i2c address?
>=20
> I don't know how this part works, but I doubt that doing it in
> dell-laptop will be convenient.  After all, dell-laptop can load
> before i2c-i801.
>=20
> Jean and Wolfram: is there a quirk mechanism to add i2c devices that
> aren't directly enumerable but are known to exist due to DMI?

Maybe something like i2c_register_board_info()?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1461971377.xvVVrqOhF8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlcjy2cACgkQi/DJPQPkQ1JtOwCfV6DLIRygYAxxZMMWcHswHHyB
tBoAoKr5dYah5cuz07eJkuJgfRCdW5Th
=1EOJ
-----END PGP SIGNATURE-----

--nextPart1461971377.xvVVrqOhF8--

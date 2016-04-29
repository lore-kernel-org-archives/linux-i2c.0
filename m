From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Fri, 29 Apr 2016 11:03:51 +0200
Message-ID: <20160429090351.GS12528@pali>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-i2c@vger.kernel.org

On Thursday 28 April 2016 11:34:38 Andy Lutomirski wrote:
> On 04/28/2016 03:23 AM, Mika Westerberg wrote:
> >Many Intel systems the BIOS declares a SystemIO OpRegion below the S=
MBus
> >PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
> >
> >  Device (SBUS)
> >  {
> >      OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
> >      Field (SMBI, ByteAcc, NoLock, Preserve)
> >      {
> >          HSTS,   8,
> >          Offset (0x02),
> >          HCON,   8,
> >          HCOM,   8,
> >          TXSA,   8,
> >          DAT0,   8,
> >          DAT1,   8,
> >          HBDR,   8,
> >          PECR,   8,
> >          RXSA,   8,
> >          SDAT,   16
> >      }
> >
> >There are also bunch of ASL methods that that the BIOS can use to ac=
cess
> >these fields. Most of the systems in question ASL methods accessing =
the
> >SMBI OpRegion are never used.
> >
> >Now, because of this SMBI OpRegion many systems fail to load the SMB=
us
> >driver with an error looking like one below:
> >
> >  ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
> >       conflicts with OpRegion 0x0000000000003040-0x000000000000304F
> >       (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
> >  ACPI: If an ACPI driver is available for this device, you should u=
se
> >       it instead of the native driver
> >
> >The reason is that this SMBI OpRegion conflicts with the PCI BAR use=
d by
> >the SMBus driver.
> >
> >It turns out that we can install a custom SystemIO address space han=
dler
> >for the SMBus device to intercept all accesses through that OpRegion=
=2E This
> >allows us to share the PCI BAR with the ASL code if it for some reas=
on is
> >using it. We do not expect that this OpRegion handler will ever be c=
alled
> >but if it is we print a warning and execute the read/write operation=
 under
> >a lock which prevents ASL and OS from messing each other.
>=20
> Tested-by: Andy Lutomirski <luto@kernel.org> # Dell XPS 13 9350
>=20
> This successfully works around:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
>=20
> but the BIOS people should still fix their ASL.  Sigh.
>=20
> On the Dell laptop, the observable effect is that the driver loads an=
d finds
> the iTCO thing.
>=20
> Pali, this may be considerably more useful on your laptop.

Andy, I am right that I will be able to load i2c-i801.ko driver without
acpi_enforce_resources=3Dlax parameter?

If yes, then it sounds good! Finally I would be able to bind
lis3lv02d_i2c.ko driver for accelerometer which is on my E6440 machine.

Andy, is there any way to tell i2c-i801.ko driver that on i2c bus (whic=
h
that driver exports) is present some i2c device? Months ago I got list
of Latitude machines on which i2c address is that accelerometer present=
=2E

It is possible to hardcode that mapping (DMI name of laptop --> i2c
address) into dell-laptop driver, so i2c-i801.ko and lis3lv02d_i2c.ko
will be automatically loaded and lis3l binded correctly to i801 i2c add=
ress?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

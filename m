From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Fri, 29 Apr 2016 11:10:23 -0700
Message-ID: <CALCETrXO128w2ZyCj3TV96gS0k_f+9THYmT-Au7s26TLB18tpA@mail.gmail.com>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org> <20160429090351.GS12528@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160429090351.GS12528@pali>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 29, 2016 at 2:03 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> On Thursday 28 April 2016 11:34:38 Andy Lutomirski wrote:
>> On 04/28/2016 03:23 AM, Mika Westerberg wrote:
>> >Many Intel systems the BIOS declares a SystemIO OpRegion below the =
SMBus
>> >PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
>> >
>> >  Device (SBUS)
>> >  {
>> >      OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
>> >      Field (SMBI, ByteAcc, NoLock, Preserve)
>> >      {
>> >          HSTS,   8,
>> >          Offset (0x02),
>> >          HCON,   8,
>> >          HCOM,   8,
>> >          TXSA,   8,
>> >          DAT0,   8,
>> >          DAT1,   8,
>> >          HBDR,   8,
>> >          PECR,   8,
>> >          RXSA,   8,
>> >          SDAT,   16
>> >      }
>> >
>> >There are also bunch of ASL methods that that the BIOS can use to a=
ccess
>> >these fields. Most of the systems in question ASL methods accessing=
 the
>> >SMBI OpRegion are never used.
>> >
>> >Now, because of this SMBI OpRegion many systems fail to load the SM=
Bus
>> >driver with an error looking like one below:
>> >
>> >  ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305=
=46
>> >       conflicts with OpRegion 0x0000000000003040-0x000000000000304=
=46
>> >       (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
>> >  ACPI: If an ACPI driver is available for this device, you should =
use
>> >       it instead of the native driver
>> >
>> >The reason is that this SMBI OpRegion conflicts with the PCI BAR us=
ed by
>> >the SMBus driver.
>> >
>> >It turns out that we can install a custom SystemIO address space ha=
ndler
>> >for the SMBus device to intercept all accesses through that OpRegio=
n. This
>> >allows us to share the PCI BAR with the ASL code if it for some rea=
son is
>> >using it. We do not expect that this OpRegion handler will ever be =
called
>> >but if it is we print a warning and execute the read/write operatio=
n under
>> >a lock which prevents ASL and OS from messing each other.
>>
>> Tested-by: Andy Lutomirski <luto@kernel.org> # Dell XPS 13 9350
>>
>> This successfully works around:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
>>
>> but the BIOS people should still fix their ASL.  Sigh.
>>
>> On the Dell laptop, the observable effect is that the driver loads a=
nd finds
>> the iTCO thing.
>>
>> Pali, this may be considerably more useful on your laptop.
>
> Andy, I am right that I will be able to load i2c-i801.ko driver witho=
ut
> acpi_enforce_resources=3Dlax parameter?

Yes, and it works on my laptop.

>
> If yes, then it sounds good! Finally I would be able to bind
> lis3lv02d_i2c.ko driver for accelerometer which is on my E6440 machin=
e.
>
> Andy, is there any way to tell i2c-i801.ko driver that on i2c bus (wh=
ich
> that driver exports) is present some i2c device? Months ago I got lis=
t
> of Latitude machines on which i2c address is that accelerometer prese=
nt.
>
> It is possible to hardcode that mapping (DMI name of laptop --> i2c
> address) into dell-laptop driver, so i2c-i801.ko and lis3lv02d_i2c.ko
> will be automatically loaded and lis3l binded correctly to i801 i2c a=
ddress?

I don't know how this part works, but I doubt that doing it in
dell-laptop will be convenient.  After all, dell-laptop can load
before i2c-i801.

Jean and Wolfram: is there a quirk mechanism to add i2c devices that
aren't directly enumerable but are known to exist due to DMI?

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

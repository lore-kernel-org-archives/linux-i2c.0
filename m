From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Fri, 29 Apr 2016 18:13:52 -0700
Message-ID: <CALCETrWe+juuxO9bhv-=V6j9z=a2N+4BWO8Uaa_zMxYNQEA2Lg@mail.gmail.com>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org> <20160429085615.GK32610@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160429085615.GK32610@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Mario Limonciello <mario_limonciello@dell.com>
List-Id: linux-i2c@vger.kernel.org

On Fri, Apr 29, 2016 at 1:56 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Thu, Apr 28, 2016 at 11:34:38AM -0700, Andy Lutomirski wrote:
>> On 04/28/2016 03:23 AM, Mika Westerberg wrote:
>> >Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBus
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
>> >There are also bunch of ASL methods that that the BIOS can use to access
>> >these fields. Most of the systems in question ASL methods accessing the
>> >SMBI OpRegion are never used.
>> >
>> >Now, because of this SMBI OpRegion many systems fail to load the SMBus
>> >driver with an error looking like one below:
>> >
>> >  ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
>> >       conflicts with OpRegion 0x0000000000003040-0x000000000000304F
>> >       (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
>> >  ACPI: If an ACPI driver is available for this device, you should use
>> >       it instead of the native driver
>> >
>> >The reason is that this SMBI OpRegion conflicts with the PCI BAR used by
>> >the SMBus driver.
>> >
>> >It turns out that we can install a custom SystemIO address space handler
>> >for the SMBus device to intercept all accesses through that OpRegion. This
>> >allows us to share the PCI BAR with the ASL code if it for some reason is
>> >using it. We do not expect that this OpRegion handler will ever be called
>> >but if it is we print a warning and execute the read/write operation under
>> >a lock which prevents ASL and OS from messing each other.
>>
>> Tested-by: Andy Lutomirski <luto@kernel.org> # Dell XPS 13 9350
>
> Thanks for testing!

A question, though: there's nothing that keeps i801_access from being
called in between consecutive ACPI accesses.  Could this confuse the
ASL code?  Would it be helpful if i801_access were to save away the
old register state and restore it when it's done in the event that an
opregion access has been seen so that the ASL-configured state doesn't
get stomped on?

Also, what happens if i801_access happens while the i801 master is
busy with an ASL-initiated transaction?  Will it wait for the
transaction to finish?

If this is a problem, an alternative approach might be to virtualize
the registers as seen by ACPI and to only load them into the real
registers when a transaction starts.

Also, what happens if the opregion is declared globally instead of in
the scope of the ACPI companion?  Does that happen?  If so, it might
make sense to deny loading the driver unless in lax mode.

--Andy

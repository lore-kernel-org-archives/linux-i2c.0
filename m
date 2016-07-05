From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Tue, 5 Jul 2016 14:51:42 +0300
Message-ID: <20160705115142.GO23527@lahna.fi.intel.com>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160704102212.319cfd8e@endymion>
 <20160705101455.GM23527@lahna.fi.intel.com>
 <201607051330.23650@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201607051330.23650@pali>
Sender: linux-acpi-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 05, 2016 at 01:30:23PM +0200, Pali Roh=E1r wrote:
> On Tuesday 05 July 2016 12:14:55 Mika Westerberg wrote:
> > The whole point of this patch is that we expect that nobody never
> > uses that OpRegion. I'm 99% sure you don't find a single machine
> > where it is actually in use.
>=20
> HP EliteBook 8460p uses it for sure! Here are DSDT snips:
>=20
>=20
>                 Method (\_SB.PCI0.LPCB.SMAB, 3, Serialized)
>                 {
>                     If (LEqual (And (Arg0, 0x01), 0x00))
>                     {
>                         Store (0x01, Local0)
>                         Store (\_SB.PCI0.SBUS.SWRB (Arg0, Arg1, Arg2)=
, Local1)
>                         If (Local1)
>                         {
>                             Store (0x00, Local0)
>                         }
>                     }
>                     Else
>                     {
>                         Store (\_SB.PCI0.SBUS.SRDB (Arg0, Arg1), Loca=
l0)
>                     }
>=20
>                     Return (Local0)
>                 }
>=20

Crap, well that is in that 1% then ;-)

> ...
>=20
>                 Method (ALRD, 1, Serialized)
>                 {
>                     Store (\_SB.PCI0.LPCB.SMAB (0x33, Arg0, 0x00), Lo=
cal0)
>                     Return (Local0)
>                 }
>=20
>                 Method (ALWR, 2, Serialized)
>                 {
>                     Store (\_SB.PCI0.LPCB.SMAB (0x32, Arg0, Arg1), Lo=
cal0)
>                     Return (Local0)
>                 }
>=20
>=20
> And ALRD and ALWR methods are used by hp_accel.ko kernel driver.

So are you able to test what happens when you unload the driver? I thin=
k
the safest thing to do is that we just pin the driver in the kernel onc=
e
we notice the OpRegion is being accessed. Does anyone else have better
ideas?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

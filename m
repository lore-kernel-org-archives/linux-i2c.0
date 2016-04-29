From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Fri, 29 Apr 2016 11:56:15 +0300
Message-ID: <20160429085615.GK32610@lahna.fi.intel.com>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:5055 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbcD2I4V (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 29 Apr 2016 04:56:21 -0400
Content-Disposition: inline
In-Reply-To: <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Mario Limonciello <mario_limonciello@dell.com>

On Thu, Apr 28, 2016 at 11:34:38AM -0700, Andy Lutomirski wrote:
> On 04/28/2016 03:23 AM, Mika Westerberg wrote:
> >Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBus
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
> >There are also bunch of ASL methods that that the BIOS can use to access
> >these fields. Most of the systems in question ASL methods accessing the
> >SMBI OpRegion are never used.
> >
> >Now, because of this SMBI OpRegion many systems fail to load the SMBus
> >driver with an error looking like one below:
> >
> >  ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
> >       conflicts with OpRegion 0x0000000000003040-0x000000000000304F
> >       (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
> >  ACPI: If an ACPI driver is available for this device, you should use
> >       it instead of the native driver
> >
> >The reason is that this SMBI OpRegion conflicts with the PCI BAR used by
> >the SMBus driver.
> >
> >It turns out that we can install a custom SystemIO address space handler
> >for the SMBus device to intercept all accesses through that OpRegion. This
> >allows us to share the PCI BAR with the ASL code if it for some reason is
> >using it. We do not expect that this OpRegion handler will ever be called
> >but if it is we print a warning and execute the read/write operation under
> >a lock which prevents ASL and OS from messing each other.
> 
> Tested-by: Andy Lutomirski <luto@kernel.org> # Dell XPS 13 9350

Thanks for testing!

> This successfully works around:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=110041
> 
> but the BIOS people should still fix their ASL.  Sigh.

For what it's worth Kabylake BIOS should not have this OpRegion anymore.

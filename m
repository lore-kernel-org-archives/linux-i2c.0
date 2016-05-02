From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Mon, 2 May 2016 13:21:57 +0300
Message-ID: <20160502102157.GO32610@lahna.fi.intel.com>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
 <CAJZ5v0irGCpV1xXroQyPk5yYbLyAY3R8HtMKiq76C4ZBA=AKgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52534 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044AbcEBKWD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 2 May 2016 06:22:03 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0irGCpV1xXroQyPk5yYbLyAY3R8HtMKiq76C4ZBA=AKgw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-i2c <linux-i2c@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>

On Fri, Apr 29, 2016 at 10:21:29PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 28, 2016 at 12:23 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBus
> > PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
> >
> >   Device (SBUS)
> >   {
> >       OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
> >       Field (SMBI, ByteAcc, NoLock, Preserve)
> >       {
> >           HSTS,   8,
> >           Offset (0x02),
> >           HCON,   8,
> >           HCOM,   8,
> >           TXSA,   8,
> >           DAT0,   8,
> >           DAT1,   8,
> >           HBDR,   8,
> >           PECR,   8,
> >           RXSA,   8,
> >           SDAT,   16
> >       }
> >
> > There are also bunch of ASL methods that that the BIOS can use to access
> > these fields. Most of the systems in question ASL methods accessing the
> > SMBI OpRegion are never used.
> >
> > Now, because of this SMBI OpRegion many systems fail to load the SMBus
> > driver with an error looking like one below:
> >
> >   ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
> >        conflicts with OpRegion 0x0000000000003040-0x000000000000304F
> >        (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
> >   ACPI: If an ACPI driver is available for this device, you should use
> >        it instead of the native driver
> >
> > The reason is that this SMBI OpRegion conflicts with the PCI BAR used by
> > the SMBus driver.
> >
> > It turns out that we can install a custom SystemIO address space handler
> > for the SMBus device to intercept all accesses through that OpRegion. This
> > allows us to share the PCI BAR with the ASL code if it for some reason is
> > using it. We do not expect that this OpRegion handler will ever be called
> > but if it is we print a warning and execute the read/write operation under
> > a lock which prevents ASL and OS from messing each other.
> >
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

> If it addresses any public BZ bugs, it would be good to add Link: tags
> for those and maybe Reported-by: for the reporters?

Good point. I can add those.

However, after reading ACPI 6.1 spec again, I'm having second thoughts
about this patch. See my other email to Andy on this thread.

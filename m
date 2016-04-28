From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with
 PCI BAR
Date: Thu, 28 Apr 2016 11:34:38 -0700
Message-ID: <577f885f-b54d-cf55-b1a3-0b04358271d8@kernel.org>
References: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50383 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865AbcD1Sem (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 28 Apr 2016 14:34:42 -0400
In-Reply-To: <1461839010-110231-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Mario Limonciello <mario_limonciello@dell.com>

On 04/28/2016 03:23 AM, Mika Westerberg wrote:
> Many Intel systems the BIOS declares a SystemIO OpRegion below the SMBus
> PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
>
>   Device (SBUS)
>   {
>       OperationRegion (SMBI, SystemIO, (SBAR << 0x05), 0x10)
>       Field (SMBI, ByteAcc, NoLock, Preserve)
>       {
>           HSTS,   8,
>           Offset (0x02),
>           HCON,   8,
>           HCOM,   8,
>           TXSA,   8,
>           DAT0,   8,
>           DAT1,   8,
>           HBDR,   8,
>           PECR,   8,
>           RXSA,   8,
>           SDAT,   16
>       }
>
> There are also bunch of ASL methods that that the BIOS can use to access
> these fields. Most of the systems in question ASL methods accessing the
> SMBI OpRegion are never used.
>
> Now, because of this SMBI OpRegion many systems fail to load the SMBus
> driver with an error looking like one below:
>
>   ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
>        conflicts with OpRegion 0x0000000000003040-0x000000000000304F
>        (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
>   ACPI: If an ACPI driver is available for this device, you should use
>        it instead of the native driver
>
> The reason is that this SMBI OpRegion conflicts with the PCI BAR used by
> the SMBus driver.
>
> It turns out that we can install a custom SystemIO address space handler
> for the SMBus device to intercept all accesses through that OpRegion. This
> allows us to share the PCI BAR with the ASL code if it for some reason is
> using it. We do not expect that this OpRegion handler will ever be called
> but if it is we print a warning and execute the read/write operation under
> a lock which prevents ASL and OS from messing each other.

Tested-by: Andy Lutomirski <luto@kernel.org> # Dell XPS 13 9350

This successfully works around:

https://bugzilla.kernel.org/show_bug.cgi?id=110041

but the BIOS people should still fix their ASL.  Sigh.

On the Dell laptop, the observable effect is that the driver loads and 
finds the iTCO thing.

Pali, this may be considerably more useful on your laptop.

--Andy

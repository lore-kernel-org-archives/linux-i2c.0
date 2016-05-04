From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Wed, 4 May 2016 12:40:38 +0300
Message-ID: <20160504094038.GS1717@lahna.fi.intel.com>
References: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58852 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383AbcEDJko (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 4 May 2016 05:40:44 -0400
Content-Disposition: inline
In-Reply-To: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, May 04, 2016 at 12:27:25PM +0300, Mika Westerberg wrote:
> Many Intel systems the BIOS declares a SystemIO OpRegion below the SM=
Bus
> PCI device as can be seen in ACPI DSDT table from Lenovo Yoga 900:
>=20
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
>=20
> There are also bunch of AML methods that that the BIOS can use to acc=
ess
> these fields. Most of the systems in question AML methods accessing t=
he
> SMBI OpRegion are never used.
>=20
> Now, because of this SMBI OpRegion many systems fail to load the SMBu=
s
> driver with an error looking like one below:
>=20
>   ACPI Warning: SystemIO range 0x0000000000003040-0x000000000000305F
>        conflicts with OpRegion 0x0000000000003040-0x000000000000304F
>        (\_SB.PCI0.SBUS.SMBI) (20160108/utaddress-255)
>   ACPI: If an ACPI driver is available for this device, you should us=
e
>        it instead of the native driver
>=20
> The reason is that this SMBI OpRegion conflicts with the PCI BAR used=
 by
> the SMBus driver.
>=20
> It turns out that we can install a custom SystemIO address space hand=
ler
> for the SMBus device to intercept all accesses through that OpRegion.=
 This
> allows us to share the PCI BAR with the AML code if it for some reaso=
n is
> using it. We do not expect that this OpRegion handler will ever be ca=
lled
> but if it is we print a warning and prevent all access from the SMBus
> driver itself.
>=20
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

=46orgot to add link to the bugzilla entry and reporters:

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
Reported-by: Andy Lutomirski <luto@kernel.org>
Reported-by: Pali Roh=E1r <pali.rohar@gmail.com>

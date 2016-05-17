From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v4] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Tue, 17 May 2016 12:45:23 +0200
Message-ID: <20160517124523.5697e260@endymion>
References: <1463143555-20261-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56164 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755807AbcEQKp4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 17 May 2016 06:45:56 -0400
In-Reply-To: <1463143555-20261-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Mika,

On Fri, 13 May 2016 15:45:55 +0300, Mika Westerberg wrote:
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
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D110041
> Reported-by: Andy Lutomirski <luto@kernel.org>
> Reported-and-tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: stable@vger.kernel.org
> ---
> Changes to v3:
> =20
>  - Added Tested-by from Pali Roh=C3=A1r (The patch did not change tha=
t much so I
>    though it is still valid)
>  - Return -EBUSY instead of -EIO
>  - Move dev_warns() to be inside if (!priv->acpi_reserved) block
>  - Remove unnecessary variable "val"
>  - Do not clear priv->acpi_reserved in i801_acpi_remove()
>  - Return -ENODEV if we detect conflict
>  - Call i801_acpi_remove() after i2c_del_adapter().
> (...)

Tested-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
--=20
Jean Delvare
SUSE L3 Support

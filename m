From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Wed, 04 May 2016 22:04:40 +0200
Message-ID: <2682382.6cA2VZCBS9@vostro.rjw.lan>
References: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49316 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752471AbcEDUB3 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 4 May 2016 16:01:29 -0400
In-Reply-To: <1462354045-94455-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

On Wednesday, May 04, 2016 12:27:25 PM Mika Westerberg wrote:
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
> There are also bunch of AML methods that that the BIOS can use to access
> these fields. Most of the systems in question AML methods accessing the
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
> allows us to share the PCI BAR with the AML code if it for some reason is
> using it. We do not expect that this OpRegion handler will ever be called
> but if it is we print a warning and prevent all access from the SMBus
> driver itself.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Hi,
> 
> This is a second try. The first version of the patch is here:
> 
>   https://patchwork.ozlabs.org/patch/616120/
> 
> This version inhibits all further driver access to the SMBus device when
> BIOS first time uses the conflicting OpRegion.
> 
> I've tested this using MinnowBoard MAX with modified DSDT where _STA
> (device status) method tries to read from the OpRegion and it seems to
> work. Below is the modified ASL if someone wants to give it a try:
> 
>   Device (SBUS)
>   {
>       Name (_ADR, 0x001F0003)  // _ADR: Address
>       OperationRegion (SMBP, PCI_Config, 0x40, 0xC0)
>       Field (SMBP, DWordAcc, NoLock, Preserve)
>       {
>               ,   2, 
>           I2CE,   1
>       }
> 
>       OperationRegion (SMPB, PCI_Config, 0x20, 0x04)
>       Field (SMPB, DWordAcc, NoLock, Preserve)
>       {
>               ,   5, 
>           SBAR,   11
>       }
> 
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
>       Method (_STA, 0, NotSerialized)
>       {
>           Local0 = HSTS
>           Local0 += 1
>           Local1 = SDAT
>           Local1 += 1
>           Return (0xF)
>       }
>   }
> 
> Basically it just does two reads from the OpRegion whenever device status
> is queried. After that accesses to the bus fails:
> 
>   # i2cget -y 9 0xc 0 b
>   Error: Read failed
> 
>  drivers/i2c/busses/i2c-i801.c | 106 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 5652bf6ce9be..e200cdbd2882 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -247,6 +247,13 @@ struct i801_priv {
>  	struct platform_device *mux_pdev;
>  #endif
>  	struct platform_device *tco_pdev;
> +
> +	/*
> +	 * If set to true the host controller registers are reserved for
> +	 * ACPI AML use. Protected by acpi_lock.
> +	 */
> +	bool acpi_reserved;
> +	struct mutex acpi_lock;
>  };
>  
>  #define FEATURE_SMBUS_PEC	(1 << 0)
> @@ -720,6 +727,12 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
>  	int ret = 0, xact = 0;
>  	struct i801_priv *priv = i2c_get_adapdata(adap);
>  
> +	mutex_lock(&priv->acpi_lock);
> +	if (priv->acpi_reserved) {
> +		mutex_unlock(&priv->acpi_lock);
> +		return -EPERM;

I'd return -EIO from here as that's what it looks like from the caller's perspective.

That's not a big deal, though, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

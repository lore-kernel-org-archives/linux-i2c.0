From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v3] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 with PCI BAR
Date: Wed, 11 May 2016 11:39:33 +0200
Message-ID: <20160511113933.6868d115@endymion>
References: <1462781834-7890-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41388 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664AbcEKJjj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 11 May 2016 05:39:39 -0400
In-Reply-To: <1462781834-7890-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, pali.rohar@gmail.com, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

Hi Mika,

=46irst of all, thank you very much for working on this problem, this i=
s
highly appreciated.

On Mon,  9 May 2016 11:17:14 +0300, Mika Westerberg wrote:
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
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: stable@vger.kernel.org
> ---
> Changes to v2:
>=20
>  - Return -EIO instead of -EPERM
>  - Added ACK from Rafael
>  - Added Link and Reported-by tags
>  - Tagged for stable inclusion
>=20
>  drivers/i2c/busses/i2c-i801.c | 106 ++++++++++++++++++++++++++++++++=
++++++++--
>  1 file changed, 102 insertions(+), 4 deletions(-)

I have tested this on my Dell OptiPlex 9020 MT system, and it works
well. Gives me access to the SPD EEPROMs on my memory modules.

Below is my review.

> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i=
801.c
> index 5652bf6ce9be..d69ad96460b5 100644
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
> =20
>  #define FEATURE_SMBUS_PEC	(1 << 0)
> @@ -720,6 +727,12 @@ static s32 i801_access(struct i2c_adapter *adap,=
 u16 addr,
>  	int ret =3D 0, xact =3D 0;
>  	struct i801_priv *priv =3D i2c_get_adapdata(adap);
> =20
> +	mutex_lock(&priv->acpi_lock);
> +	if (priv->acpi_reserved) {
> +		mutex_unlock(&priv->acpi_lock);
> +		return -EIO;

I see this has been discussed before, but I don't think EIO is
appropriate here. You didn't even try to issue an I/O to the device, so
how could it fail? EBUSY would better reflect the situation IMHO.

> +	}
> +
>  	pm_runtime_get_sync(&priv->pci_dev->dev);
> =20
>  	hwpec =3D (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIE=
NT_PEC)
> @@ -822,6 +835,7 @@ static s32 i801_access(struct i2c_adapter *adap, =
u16 addr,
>  out:
>  	pm_runtime_mark_last_busy(&priv->pci_dev->dev);
>  	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
> +	mutex_unlock(&priv->acpi_lock);
>  	return ret;
>  }
> =20
> @@ -1260,6 +1274,89 @@ static void i801_add_tco(struct i801_priv *pri=
v)
>  	priv->tco_pdev =3D pdev;
>  }
> =20
> +#ifdef CONFIG_ACPI
> +static acpi_status
> +i801_acpi_io_handler(u32 function, acpi_physical_address address, u3=
2 bits,
> +		     u64 *value, void *handler_context, void *region_context)
> +{
> +	struct i801_priv *priv =3D handler_context;
> +	struct pci_dev *pdev =3D priv->pci_dev;
> +	acpi_status status;
> +
> +	/*
> +	 * Once BIOS AML code touches the OpRegion we warn and inhibit any
> +	 * further access from the driver itself. This device is now owned
> +	 * by the system firmware.
> +	 */
> +	dev_warn_once(&pdev->dev, "BIOS is accessing SMBus registers\n");
> +	dev_warn_once(&pdev->dev, "Driver SMBus register access inhibited\n=
");

Given that you have priv->acpi_reserved to record if we've been there
before, maybe you could move the warnings below, and use simple
dev_warn? I suspect it's cheaper than dev_warn_once.

> +
> +	mutex_lock(&priv->acpi_lock);
> +
> +	if (!priv->acpi_reserved) {
> +		priv->acpi_reserved =3D true;
> +
> +		/*
> +		 * BIOS is accessing the host controller so prevent it from
> +		 * suspending automatically from now on.
> +		 */
> +		pm_runtime_get_sync(&pdev->dev);
> +	}
> +
> +	if (function =3D=3D ACPI_READ) {
> +		u32 val =3D (u32)*value;

I'm confused. acpi_os_read_port is writing the result of the read to
"val", it doesn't read from it, so I don't think it needs to be
initialized?

Also, looking at the acpi_os_read_port() call in
drivers/acpi/apei/apei-base.c, it would seem you can cast *value
directly in-place, without using a temporary variable. This would limit
the overhead.

> +		status =3D acpi_os_read_port(address, &val, bits);
> +		if (ACPI_SUCCESS(status))
> +			*value =3D val;
> +	} else {
> +		status =3D acpi_os_write_port(address, (u32)*value, bits);
> +	}
> +
> +	mutex_unlock(&priv->acpi_lock);
> +
> +	return status;
> +}
> +
> +static int i801_acpi_probe(struct i801_priv *priv)
> +{
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	adev =3D ACPI_COMPANION(&priv->pci_dev->dev);
> +	if (adev) {
> +		status =3D acpi_install_address_space_handler(adev->handle,
> +				ACPI_ADR_SPACE_SYSTEM_IO, i801_acpi_io_handler,
> +				NULL, priv);
> +		if (ACPI_SUCCESS(status))
> +			return 0;
> +	}
> +
> +	return acpi_check_resource_conflict(&priv->pci_dev->resource[SMBBAR=
]);
> +}
> +
> +static void i801_acpi_remove(struct i801_priv *priv)
> +{
> +	struct acpi_device *adev;
> +
> +	adev =3D ACPI_COMPANION(&priv->pci_dev->dev);
> +	if (!adev)
> +		return;
> +
> +	acpi_remove_address_space_handler(adev->handle,
> +		ACPI_ADR_SPACE_SYSTEM_IO, i801_acpi_io_handler);
> +
> +	mutex_lock(&priv->acpi_lock);
> +	if (priv->acpi_reserved) {
> +		priv->acpi_reserved =3D false;

Is this actually needed? priv is about to be destroyed anyway.

> +		pm_runtime_put(&priv->pci_dev->dev);
> +	}
> +	mutex_unlock(&priv->acpi_lock);
> +}
> +#else
> +static inline int i801_acpi_probe(struct i801_priv *priv) { return 0=
; }
> +static inline void i801_acpi_remove(struct i801_priv *priv) { }
> +#endif
> +
>  static int i801_probe(struct pci_dev *dev, const struct pci_device_i=
d *id)
>  {
>  	unsigned char temp;
> @@ -1277,6 +1374,7 @@ static int i801_probe(struct pci_dev *dev, cons=
t struct pci_device_id *id)
>  	priv->adapter.dev.parent =3D &dev->dev;
>  	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&dev->dev));
>  	priv->adapter.retries =3D 3;
> +	mutex_init(&priv->acpi_lock);
> =20
>  	priv->pci_dev =3D dev;
>  	switch (dev->device) {
> @@ -1339,10 +1437,9 @@ static int i801_probe(struct pci_dev *dev, con=
st struct pci_device_id *id)
>  		return -ENODEV;
>  	}
> =20
> -	err =3D acpi_check_resource_conflict(&dev->resource[SMBBAR]);
> -	if (err) {
> -		return -ENODEV;
> -	}
> +	err =3D i801_acpi_probe(priv);
> +	if (err)
> +		return err;

Before your patch we would return -ENODEV in case of conflict. Now we
are returning -EBUSY instead. I see no reason for this change. Or if
you think this is actually needed, that seems independent from what
your patch is doing, so it should be a separate patch.

> =20
>  	err =3D pcim_iomap_regions(dev, 1 << SMBBAR,
>  				 dev_driver_string(&dev->dev));
> @@ -1439,6 +1536,7 @@ static void i801_remove(struct pci_dev *dev)
>  	pm_runtime_forbid(&dev->dev);
>  	pm_runtime_get_noresume(&dev->dev);
> =20
> +	i801_acpi_remove(priv);
>  	i801_del_mux(priv);
>  	i2c_del_adapter(&priv->adapter);

This looks racy. Until i2c_del_adapter() is called, the SMBus may be
used. So I think you should call i801_acpi_remove() after
i2c_del_adapter().

>  	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);

Thanks again,
--=20
Jean Delvare
SUSE L3 Support

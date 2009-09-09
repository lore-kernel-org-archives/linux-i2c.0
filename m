From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] I2C: Add support for new AMD SMBus devices
Date: Wed, 9 Sep 2009 11:10:26 +0200
Message-ID: <20090909111026.21e85f54@hyperion.delvare>
References: <20090811014921.GB29858@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090811014921.GB29858@crane-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[Resending with fixed LKML address.]

Hi Crane,

Sorry for the late reply.

On Tue, 11 Aug 2009 09:49:21 +0800, Crane Cai wrote:
> AMD newer SMBus device uses the piix4 driver, and device is added by vendor ID
> and class code. This method will include AMD old SMBus controller in, and need
> to filter it out.

This is better, however I still have concerns:

* Your device ID comparison is fragile. Are you absolutely certain that
  you know _all_ the SMBus devices that were released by AMD in the
  past? If anything, I'd rather have a single comparison on the first
  device ID that _will_ be supported by the i2c-piix4 driver.

* Are you absolutely certain that AMD will never ever release an
  incompatible SMBus device in the future? I doubt it. In the past,
  various vendors have changed their implementations. Intel changed
  twice (i2c-piix4 -> i2c-i801 -> i2c-isch), AMD once already
  (i2c-amd756 -> i2c-amd8111), VIA once (i2c-via -> i2c-viapro), nVidia
  once (i2c-amd756 -> i2c-nforce2), etc. If history repeats itself (and
  it often does), I wouldn't be surprised to see future AMD SMBus chips
  not compatible with the i2c-piix4 driver, while with your patch
  applied, the driver would claim to support them. Binding a driver to
  an unsupported chip can have unpredictable, potentially bad
  consequences, and I'd rather have the driver not bind immediately to
  new supported devices than bind to unsupported ones.

* With your patch, the i2c-piix4 driver would load automatically on
  systems which do not need it (all old AMD-based PC systems.) While a
  minor issue, this is still a waste of boot time and memory for these
  users. I am not aware of any precedent of this.

So, all in all, I'd rather simply add the IDs of new supported devices
as they are released, rather than implement this broad matching
mechanism.

If AMD is bored with adding new device IDs to Linux drivers all the
time (and I certainly am) then the cleanest solution is to simply not
allocate new device IDs for fully compatible (if not even completely
identical silicon-wise) devices. For example, AMD could allocate a
single PCI device ID for their PIIX4-compatible SMBus chips, we name it
PCI_DEVICE_ID_AMD_SMBUS_PIIX4 for example, and all future compatible
chips use this device ID. You can use the revision ID field if you want
to be able to differentiate between the various incarnations.

> 
> Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-piix4.c |   17 +++++++++++++++--
>  1 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 0249a7d..2539282 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -232,6 +232,14 @@ static int __devinit piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  	unsigned short smba_idx = 0xcd6;
>  	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset = 0x10, smb_en = 0x2c;
>  
> +	/* Filter AMD old SMBus controller out */
> +	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
> +	    (PIIX4_dev->device <= PCI_DEVICE_ID_AMD_8111_SMBUS &&
> +	     PIIX4_dev->device >= PCI_DEVICE_ID_AMD_VIPER_740B)) {
> +		dev_info(&PIIX4_dev->dev, "Does not support this chip.\n");
> +		return -ENODEV;
> +	}
> +
>  	/* SB800 SMBus does not support forcing address */
>  	if (force || force_addr) {
>  		dev_err(&PIIX4_dev->dev, "SB800 SMBus does not support "
> @@ -479,6 +487,10 @@ static struct pci_device_id piix4_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
> +	/* AMD Generic, PCI class code and Vendor ID for SMBus */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_ANY_ID),
> +	  .class = PCI_CLASS_SERIAL_SMBUS << 8,
> +	  .class_mask = 0xffffff },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>  		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
> @@ -499,9 +511,10 @@ static int __devinit piix4_probe(struct pci_dev *dev,
>  {
>  	int retval;
>  
> -	if ((dev->vendor == PCI_VENDOR_ID_ATI) &&
> +	if (((dev->vendor == PCI_VENDOR_ID_ATI) &&
>  	    (dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS) &&
> -	    (dev->revision >= 0x40))
> +	    (dev->revision >= 0x40)) ||
> +	    dev->vendor == PCI_VENDOR_ID_AMD)
>  		/* base address location etc changed in SB800 */
>  		retval = piix4_setup_sb800(dev, id);
>  	else


-- 
Jean Delvare

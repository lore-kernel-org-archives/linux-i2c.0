From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] I2C: Add support for new AMD SMBus devices
Date: Wed, 5 Aug 2009 15:38:14 +0200
Message-ID: <20090805153814.70283b5a@hyperion.delvare>
References: <20090720073112.GA18219@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090720073112.GA18219@crane-desktop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Crane,

On Mon, 20 Jul 2009 15:31:12 +0800, Crane Cai wrote:
> Use driver to detect SMBus devices with Vendor ID AMD and class code is SMBus.
> 
> Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-piix4.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 0249a7d..034f388 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -479,6 +479,10 @@ static struct pci_device_id piix4_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
> +	/* AMD Generic, PCI class code and Vendor ID for SMBus */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_ANY_ID),
> +	  .class = PCI_CLASS_SERIAL_SMBUS << 8,
> +	  .class_mask = 0xffffff },

Hmm, this seems a little too broad. In particular the AMD 8111 SMBus
2.0 device [1022:746a] would match, while we know it isn't compatible
with the Intel PIIX4 (it has its own driver: i2c-amd8111).

As much as I would like not having to add PCI IDs to the driver with
every new chipset released by AMD, this doesn't sound realistic in
practice, I fear. I suspect you will have to list devices individually,
just as we do for all other vendors.

>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>  		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
> @@ -499,9 +503,10 @@ static int __devinit piix4_probe(struct pci_dev *dev,
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

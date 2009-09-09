From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 1/1] i2c: add support for new AMD SMBus devices
Date: Wed, 9 Sep 2009 09:46:15 +0200
Message-ID: <20090909094615.70689df4@hyperion.delvare>
References: <200908062302.n76N21kf031351@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200908062302.n76N21kf031351-AB4EexQrvXRQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, crane.cai-5C7GfCeVMHo@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 06 Aug 2009 16:02:00 -0700, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> 
> Use driver to detect SMBus devices with Vendor ID AMD and class code is
> SMBus.
> 
> Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
> ---
> 
>  drivers/i2c/busses/i2c-piix4.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/i2c/busses/i2c-piix4.c~i2c-add-support-for-new-amd-smbus-devices drivers/i2c/busses/i2c-piix4.c
> --- a/drivers/i2c/busses/i2c-piix4.c~i2c-add-support-for-new-amd-smbus-devices
> +++ a/drivers/i2c/busses/i2c-piix4.c
> @@ -479,6 +479,10 @@ static struct pci_device_id piix4_ids[] 
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
> @@ -499,9 +503,10 @@ static int __devinit piix4_probe(struct 
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

Nack:
http://marc.info/?l=linux-i2c&m=124947951705788&w=2

-- 
Jean Delvare

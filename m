From: "Cai, Crane" <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] I2C: Add support for new AMD SMBus devices
Date: Thu, 6 Aug 2009 08:59:03 +0800
Message-ID: <20090806005903.GA7026@crane-desktop>
References: <20090720073112.GA18219@crane-desktop> <20090805153814.70283b5a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090805153814.70283b5a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Wed, Aug 05, 2009 at 03:38:14PM +0200, Jean Delvare wrote:
> Hi Crane,
> 
> On Mon, 20 Jul 2009 15:31:12 +0800, Crane Cai wrote:
> > Use driver to detect SMBus devices with Vendor ID AMD and class code is SMBus.
> > 
> > Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-piix4.c |    9 +++++++--
> >  1 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> > index 0249a7d..034f388 100644
> > --- a/drivers/i2c/busses/i2c-piix4.c
> > +++ b/drivers/i2c/busses/i2c-piix4.c
> > @@ -479,6 +479,10 @@ static struct pci_device_id piix4_ids[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SMBUS) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
> > +	/* AMD Generic, PCI class code and Vendor ID for SMBus */
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_ANY_ID),
> > +	  .class = PCI_CLASS_SERIAL_SMBUS << 8,
> > +	  .class_mask = 0xffffff },
> 
> Hmm, this seems a little too broad. In particular the AMD 8111 SMBus
> 2.0 device [1022:746a] would match, while we know it isn't compatible
> with the Intel PIIX4 (it has its own driver: i2c-amd8111).
> 
> As much as I would like not having to add PCI IDs to the driver with
> every new chipset released by AMD, this doesn't sound realistic in
> practice, I fear. I suspect you will have to list devices individually,
> just as we do for all other vendors.

Thank you for your useful comments. I think in serveral years SMBus controller
hardware core will not change its interface. That's why we try to avoid
frequently add device ID in driver. But we forget outdate chips you mentioned.
Here is the solution for it: As we know device ID number is increaseed by its
manufacture year, we can filter out outdate chips by the feature. If in future
hardware interface changed (almost zero in factor), we also can use this method
to filter new chips out. code clips as this:
	pci_dev->device > PCI_DEVICE_ID_AMD_8111_SMBUS2 && 
	pci_dev->device < PCI_DEVICE_ID_AMD_FEATURE_ONE

All this code clips will be in piix4_setup_sb800 branch, and if filtered out, it
return with NODEV. It will not affect your driver main function, and will not
avoid other driver's PCI probing.

Do you approve this solution? If you approve, I will resend a new patch for it.

-- 
Best Regards,
- Crane

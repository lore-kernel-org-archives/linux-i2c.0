From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCHv2 5/5] i2c: i801: Use managed pcim_* PCI device
 initialization and reservation
Date: Fri, 13 Feb 2015 16:20:41 +0100
Message-ID: <20150213162041.2e298843@endymion.delvare>
References: <1423657928-25534-1-git-send-email-jarkko.nikula@linux.intel.com>
	<1423657928-25534-6-git-send-email-jarkko.nikula@linux.intel.com>
	<20150213114756.2f0b0df9@endymion.delvare>
	<54DDE43B.70902@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54DDE43B.70902-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 13 Feb 2015 13:47:07 +0200, Jarkko Nikula wrote:
> On 02/13/2015 12:47 PM, Jean Delvare wrote:
> > On Wed, 11 Feb 2015 14:32:08 +0200, Jarkko Nikula wrote:
> >> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> >> index 5fb35464f693..9f7b69743233 100644
> >> --- a/drivers/i2c/busses/i2c-i801.c
> >> +++ b/drivers/i2c/busses/i2c-i801.c
> >> @@ -1180,12 +1180,13 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >>   	}
> >>   	priv->features &= ~disable_features;
> >>
> >> -	err = pci_enable_device(dev);
> >> +	err = pcim_enable_device(dev);
> >>   	if (err) {
> >>   		dev_err(&dev->dev, "Failed to enable SMBus PCI device (%d)\n",
> >>   			err);
> >>   		goto exit;
> >>   	}
> >> +	pcim_pin_device(dev);
> >>
> >>   	/* Determine the address of the SMBus area */
> >>   	priv->smba = pci_resource_start(dev, SMBBAR);
> >
> > What is the benefit of this change, compared to just leaving the call
> > to pci_enable_device() in place?
>
> If you mean the patch itself I think easy pcim_pin_device() removal is 
> the biggest benefit if we ever want to experiment does hang during 
> power-off problem still exist in some machines. All PCI, ACPI and 
> power-off code have evolved in 9 years so original problem may not exist 
> anymore. Who knows.
> 
> Without this patch pcm_disable_device() needs to be added to error paths 
> and i801_remove(). (of course trivial but it's always more nice to get 
> regression from one-liner).
> 
> If you mean plain pcim_enable_device() it is required for other pcim_ 
> functions since it allocates pcim_release which takes care of cleanup 
> bunch of things including pci_release_region().
> 
> E.g. pcim_iomap_regions() without pcim_enable_device() causes an oops 
> when doing "cat /proc/ioports" after module removal since 
> pcim_iomap_release() only unmaps but does not release regions.

I meant the latter. If there's a good reason for calling
pcim_enable_device then alright.

-- 
Jean Delvare
SUSE L3 Support

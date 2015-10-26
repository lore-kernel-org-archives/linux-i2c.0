From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: i801: Add support for Intel DNV
Date: Mon, 26 Oct 2015 11:24:59 +0200
Message-ID: <20151026092459.GD1526@lahna.fi.intel.com>
References: <1444740099-137792-1-git-send-email-mika.westerberg@linux.intel.com>
 <20151025114518.338272cf@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59774 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbbJZJZF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 26 Oct 2015 05:25:05 -0400
Content-Disposition: inline
In-Reply-To: <20151025114518.338272cf@endymion.delvare>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>

On Sun, Oct 25, 2015 at 11:45:18AM +0100, Jean Delvare wrote:
> Hi Mika,
> 
> On Tue, 13 Oct 2015 15:41:39 +0300, Mika Westerberg wrote:
> > Intel DNV SoC has the same legacy SMBus host controller than Intel
> > Sunrisepoint PCH. It also has same iTCO watchdog on the bus.
> > 
> > Add DNV PCI ID to the list of supported devices.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/i2c/busses/i2c-i801.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> > index eaef9bc9d88c..47c2ddf76264 100644
> > --- a/drivers/i2c/busses/i2c-i801.c
> > +++ b/drivers/i2c/busses/i2c-i801.c
> > @@ -60,6 +60,7 @@
> >   * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
> >   * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
> >   * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
> > + * DNV (SOC)			0x19df	32	hard	yes	yes	yes
> >   *
> >   * Features supported by this driver:
> >   * Software PEC				no
> > @@ -202,6 +203,7 @@
> >  #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS	0x9ca2
> >  #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
> >  #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
> > +#define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
> 
> Can you please get this added to pci.ids?
> 
> http://pci-ids.ucw.cz/read/PC/8086

Sure.

> >  
> >  struct i801_mux_config {
> >  	char *gpio_chip;
> > @@ -863,6 +865,7 @@ static const struct pci_device_id i801_ids[] = {
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
> >  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
> > +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMBUS) },
> >  	{ 0, }
> >  };
> >  
> > @@ -1256,6 +1259,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >  	switch (dev->device) {
> >  	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
> >  	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
> > +	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
> >  		priv->features |= FEATURE_I2C_BLOCK_READ;
> >  		priv->features |= FEATURE_IRQ;
> >  		priv->features |= FEATURE_SMBUS_PEC;
> 
> Looks good, but please also update Documentation/i2c/busses/i2c-i801
> and drivers/i2c/busses/Kconfig.

Will do thanks.

Wolfram, do you want followup patch on top of this or do you prefer
updated patch?

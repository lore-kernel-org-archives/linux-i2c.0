From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Add support for Intel DNV
Date: Sun, 25 Oct 2015 11:45:18 +0100
Message-ID: <20151025114518.338272cf@endymion.delvare>
References: <1444740099-137792-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40755 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbbJYKpW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 06:45:22 -0400
In-Reply-To: <1444740099-137792-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Hi Mika,

On Tue, 13 Oct 2015 15:41:39 +0300, Mika Westerberg wrote:
> Intel DNV SoC has the same legacy SMBus host controller than Intel
> Sunrisepoint PCH. It also has same iTCO watchdog on the bus.
> 
> Add DNV PCI ID to the list of supported devices.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index eaef9bc9d88c..47c2ddf76264 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -60,6 +60,7 @@
>   * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
>   * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
>   * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
> + * DNV (SOC)			0x19df	32	hard	yes	yes	yes
>   *
>   * Features supported by this driver:
>   * Software PEC				no
> @@ -202,6 +203,7 @@
>  #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS	0x9ca2
>  #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
>  #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
> +#define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df

Can you please get this added to pci.ids?

http://pci-ids.ucw.cz/read/PC/8086

>  
>  struct i801_mux_config {
>  	char *gpio_chip;
> @@ -863,6 +865,7 @@ static const struct pci_device_id i801_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMBUS) },
>  	{ 0, }
>  };
>  
> @@ -1256,6 +1259,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	switch (dev->device) {
>  	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
>  	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
> +	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
>  		priv->features |= FEATURE_I2C_BLOCK_READ;
>  		priv->features |= FEATURE_IRQ;
>  		priv->features |= FEATURE_SMBUS_PEC;

Looks good, but please also update Documentation/i2c/busses/i2c-i801
and drivers/i2c/busses/Kconfig.

-- 
Jean Delvare
SUSE L3 Support

From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: i801: Intel DNV_N device IDs SMBus
Date: Wed, 10 Feb 2016 10:49:55 +0100
Message-ID: <20160210104955.029592e4@endymion>
References: <i2c: i801: Intel DNV_N device IDs SMBus>
	<1454716853-1336-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47048 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752196AbcBJJuA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 10 Feb 2016 04:50:00 -0500
In-Reply-To: <1454716853-1336-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Alexandra,

On Fri,  5 Feb 2016 16:00:53 -0800, Alexandra Yates wrote:
> Adding Intel codename DNV_N platform device IDs for SMBus.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-i801.c | 4 ++++

Please also update Documentation/i2c/busses/i2c-i801 and
drivers/i2c/busses/Kconfig.

>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index f62d697..fb1a3ca 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -60,6 +60,7 @@
>   * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
>   * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
>   * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
> + * DNV_N (SOC)			0x19ac	32	hard	yes	yes	yes
>   * DNV (SOC)			0x19df	32	hard	yes	yes	yes
>   * Broxton (SOC)		0x5ad4	32	hard	yes	yes	yes
>   * Lewisburg (PCH)		0xa1a3	32	hard	yes	yes	yes
> @@ -206,6 +207,7 @@
>  #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS	0x9ca2
>  #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
>  #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
> +#define PCI_DEVICE_ID_INTEL_DNV_N_SMBUS			0x19ac
>  #define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
>  #define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
>  #define PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS		0xa1a3
> @@ -871,6 +873,7 @@ static const struct pci_device_id i801_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_N_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BROXTON_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS) },
> @@ -1271,6 +1274,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	switch (dev->device) {
>  	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
>  	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
> +	case PCI_DEVICE_ID_INTEL_DNV_N_SMBUS:
>  	case PCI_DEVICE_ID_INTEL_DNV_SMBUS:
>  		priv->features |= FEATURE_I2C_BLOCK_READ;
>  		priv->features |= FEATURE_IRQ;

This last change doesn't apply here, as it conflicts with the other
i2c-i801 patch you just sent ("i2c: i801: Intel DNV_N device IDs
SMBus"). When you send multiple patches for the same driver, please
make sure they cleanly stack on top of each other.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

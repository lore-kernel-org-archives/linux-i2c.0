From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH V2] Intel Lewisburg device IDs for SMBus
Date: Thu, 5 Nov 2015 09:45:18 +0100
Message-ID: <20151105094518.62e76627@endymion.delvare>
References: <Intel Lewisburg device IDs for SMBus>
	<1446664156-9873-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35092 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030329AbbKEIpX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 5 Nov 2015 03:45:23 -0500
In-Reply-To: <1446664156-9873-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, wsa@the-dreams.de, corbet@lwn.net

Hi Alexandra,

On Wed,  4 Nov 2015 11:09:16 -0800, Alexandra Yates wrote:
> Adding Intel codename Lewisburg platform device IDs for SMBus.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> ---
>  Documentation/i2c/busses/i2c-i801 | 1 +
>  drivers/i2c/busses/Kconfig        | 1 +
>  drivers/i2c/busses/i2c-i801.c     | 6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
> index 6a4b1af..1bba38d 100644
> --- a/Documentation/i2c/busses/i2c-i801
> +++ b/Documentation/i2c/busses/i2c-i801
> @@ -32,6 +32,7 @@ Supported adapters:
>    * Intel Sunrise Point-LP (PCH)
>    * Intel DNV (SOC)
>    * Intel Broxton (SOC)
> +  * Intel Lewisburg (PCH)
>     Datasheets: Publicly available at the Intel website
>  
>  On Intel Patsburg and later chipsets, both the normal host SMBus controller
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index e24c2b6..7b0aa82 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -126,6 +126,7 @@ config I2C_I801
>  	    Sunrise Point-LP (PCH)
>  	    DNV (SOC)
>  	    Broxton (SOC)
> +	    Lewisburg (PCH)
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-i801.
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index c306751..76fcef4 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -62,6 +62,8 @@
>   * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
>   * DNV (SOC)			0x19df	32	hard	yes	yes	yes
>   * Broxton (SOC)		0x5ad4	32	hard	yes	yes	yes
> + * Lewisburg (PCH)		0xA1A3	32	hard	yes	yes	yes
> + * Lewisburg Supersku (PCH)	0xA223	32	hard	yes	yes	yes

It's a bit unfortunate that you used upper-case letters for the
hexadecimal numbers when all other entries used lower-case letters.

>   *
>   * Features supported by this driver:
>   * Software PEC				no
> @@ -181,6 +183,8 @@
>  				 STATUS_ERROR_FLAGS)
>  
>  /* Older devices have their ID defined in <linux/pci_ids.h> */
> +#define PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS		0xA1A3
> +#define PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS	0xA223

Same here. Plus, why are you adding the IDs at the top of the list here
while you added them at the bottom of the first list...

>  #define PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS		0x0f12
>  #define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
>  #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS		0x1c22
> @@ -864,6 +868,8 @@ static const struct pci_device_id i801_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },

... and now in the middle of the last list? I would appreciate more
consistency.

These are all details of course, overall the changes look good, so you
can add:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH V3] Intel Lewisburg device IDs for SMBus
Date: Fri, 6 Nov 2015 11:47:32 +0100
Message-ID: <20151106114732.0b6d6ab2@endymion.delvare>
References: <[PATCH V3] Intel Lewisburg device IDs for SMBus>
	<1446752425-14476-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42085 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032934AbbKFKrg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 6 Nov 2015 05:47:36 -0500
In-Reply-To: <1446752425-14476-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: wsa@the-dreams.de, corbet@lwn.net, linux-i2c@vger.kernel.org

On Thu,  5 Nov 2015 11:40:25 -0800, Alexandra Yates wrote:
> Adding Intel codename Lewisburg platform device IDs for SMBus.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
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
> index c306751..f62d697 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -62,6 +62,8 @@
>   * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
>   * DNV (SOC)			0x19df	32	hard	yes	yes	yes
>   * Broxton (SOC)		0x5ad4	32	hard	yes	yes	yes
> + * Lewisburg (PCH)		0xa1a3	32	hard	yes	yes	yes
> + * Lewisburg Supersku (PCH)	0xa223	32	hard	yes	yes	yes
>   *
>   * Features supported by this driver:
>   * Software PEC				no
> @@ -206,6 +208,8 @@
>  #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
>  #define PCI_DEVICE_ID_INTEL_DNV_SMBUS			0x19df
>  #define PCI_DEVICE_ID_INTEL_BROXTON_SMBUS		0x5ad4
> +#define PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS		0xa1a3
> +#define PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS	0xa223
>  
>  struct i801_mux_config {
>  	char *gpio_chip;
> @@ -869,6 +873,8 @@ static const struct pci_device_id i801_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BROXTON_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LEWISBURG_SSKU_SMBUS) },
>  	{ 0, }
>  };
>  

Perfect, thanks.

-- 
Jean Delvare
SUSE L3 Support

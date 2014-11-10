From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] SMBUS: Add DeviceIDs for SunrisePoint LP
Date: Mon, 10 Nov 2014 18:54:14 +0100
Message-ID: <20141110185414.6cd05260@endymion.delvare>
References: <1415400943.1954.9.camel@localhost.localdomain>
	<20141110074533.20cbd55f@endymion.delvare>
	<1415639581.1954.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415639581.1954.21.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Devin Ryles <devin.ryles@intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, james.d.ralston@intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, frank.riegel@intel.com
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Nov 2014 12:13:01 -0500, Devin Ryles wrote:
> From 8386c61977dce52fcdfe7fb279692606f47650bc Mon Sep 17 00:00:00 2001
> From: Devin Ryles <devin.ryles@intel.com>
> Date: Wed, 5 Nov 2014 16:30:03 -0500
> Subject: [PATCH] SMBUS: Add DeviceIDs for SunrisePoint LP
> 
> This patch adds the DeviceIDs for SunrisePoint LP
> 
> Signed-off-by: Devin Ryles <devin.ryles@intel.com>
> ---
>  Documentation/i2c/busses/i2c-i801 | 1 +
>  drivers/i2c/busses/Kconfig        | 1 +
>  drivers/i2c/busses/i2c-i801.c     | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
> index 793c83d..82f48f7 100644
> --- a/Documentation/i2c/busses/i2c-i801
> +++ b/Documentation/i2c/busses/i2c-i801
> @@ -29,6 +29,7 @@ Supported adapters:
>    * Intel Wildcat Point-LP (PCH)
>    * Intel BayTrail (SOC)
>    * Intel Sunrise Point-H (PCH)
> +  * Intel Sunrise Point-LP (PCH)
>     Datasheets: Publicly available at the Intel website
>  
>  On Intel Patsburg and later chipsets, both the normal host SMBus controller
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 917c358..06e99eb 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -123,6 +123,7 @@ config I2C_I801
>  	    Wildcat Point-LP (PCH)
>  	    BayTrail (SOC)
>  	    Sunrise Point-H (PCH)
> +	    Sunrise Point-LP (PCH)
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-i801.
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 7cfc183..e158e18 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -63,6 +63,7 @@
>   * Wildcat Point-LP (PCH)	0x9ca2	32	hard	yes	yes	yes
>   * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
>   * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
> + * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
>   *
>   * Features supported by this driver:
>   * Software PEC				no
> @@ -186,6 +187,7 @@
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS		0x9c22
>  #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS	0x9ca2
>  #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS	0xa123
> +#define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS	0x9d23
>  
>  struct i801_mux_config {
>  	char *gpio_chip;
> @@ -833,6 +835,7 @@ static const struct pci_device_id i801_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },
>  	{ 0, }
>  };
>  

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support

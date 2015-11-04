From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] Intel LBG device IDs for SMBus
Date: Wed, 4 Nov 2015 11:45:10 +0100
Message-ID: <20151104114510.6b650ebd@endymion.delvare>
References: <Intel LBG device IDs for SMBus>
	<1446576754-19683-1-git-send-email-alexandra.yates@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55150 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932340AbbKDKpP (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 4 Nov 2015 05:45:15 -0500
In-Reply-To: <1446576754-19683-1-git-send-email-alexandra.yates@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexandra Yates <alexandra.yates@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, wsa@the-dreams.de, corbet@lwn.net, lee.jones@linaro.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Hi Alexandra,

On Tue,  3 Nov 2015 10:52:34 -0800, Alexandra Yates wrote:
> Adding Intel codename Lewisburg platform device IDs for SMBus.
> 
> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
> ---
>  Documentation/i2c/busses/i2c-i801 | 1 +
>  drivers/i2c/busses/Kconfig        | 1 +
>  drivers/i2c/busses/i2c-i801.c     | 6 ++++++
>  3 files changed, 8 insertions(+)

This patch doesn't apply because it ignores recent changes made to the
same files: "i2c: i801: Add support for Intel DNV" by Mika Westerberg,
"i2c: i801: Add support for Intel Broxton" by Jarkko Nikula and "i2c:
i801: Document Intel DNV and Broxton" by Jarkko Nikula.

All of these patches are in Wolfram's i2c tree:
http://git.kernel.org/cgit/linux/kernel/git/wsa/linux.git/log/?h=i2c/for-next

So please rebase your patch on that tree. Also see my comments below.

> 
> diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
> index 82f48f7..2ccde60 100644
> --- a/Documentation/i2c/busses/i2c-i801
> +++ b/Documentation/i2c/busses/i2c-i801
> @@ -30,6 +30,7 @@ Supported adapters:
>    * Intel BayTrail (SOC)
>    * Intel Sunrise Point-H (PCH)
>    * Intel Sunrise Point-LP (PCH)
> +  * Intel Lewisburg (PCH) (LBG)

"(LBG)" doesn't need to be mentioned.

>     Datasheets: Publicly available at the Intel website
>  
>  On Intel Patsburg and later chipsets, both the normal host SMBus controller
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 08b8617..3adc2b7 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -124,6 +124,7 @@ config I2C_I801
>  	    BayTrail (SOC)
>  	    Sunrise Point-H (PCH)
>  	    Sunrise Point-LP (PCH)
> +	    Lewisburg (PCH)
>  
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-i801.
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index eaef9bc..34da07b 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -60,6 +60,8 @@
>   * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
>   * Sunrise Point-H (PCH) 	0xa123  32	hard	yes	yes	yes
>   * Sunrise Point-LP (PCH)	0x9d23	32	hard	yes	yes	yes
> + * Lewisburg (PCH)		0xA1A3	32	hard	yes	yes	yes
> + * Lewisburg Supersku (PCH)	0xA223	32	hard	yes	yes	yes
>   *
>   * Features supported by this driver:
>   * Software PEC				no
> @@ -179,6 +181,8 @@
>  				 STATUS_ERROR_FLAGS)
>  
>  /* Older devices have their ID defined in <linux/pci_ids.h> */
> +#define PCI_DEVICE_ID_INTEL_LBG_SMBUS			0xA1A3
> +#define PCI_DEVICE_ID_INTEL_LBG_SSKU_SMBUS		0xA223

Please spell out LEWISBURG here. 3-letter shortcuts everywhere hurt
readability considerably over time.

>  #define PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS		0x0f12
>  #define PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS		0x2292
>  #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS		0x1c22
> @@ -860,6 +864,8 @@ static const struct pci_device_id i801_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LBG_SMBUS) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LBG_SSKU_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BRASWELL_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS) },


-- 
Jean Delvare
SUSE L3 Support

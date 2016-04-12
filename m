From: "David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Allow build Baytrail semaphore
 support when IOSF_MBI=m
Date: Tue, 12 Apr 2016 14:46:55 -0700
Message-ID: <20160412214655.GA27603@pathfinder>
References: <1449748124-20744-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:57633 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756492AbcDLVrv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Apr 2016 17:47:51 -0400
Content-Disposition: inline
In-Reply-To: <1449748124-20744-2-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, Dec 10, 2015 at 01:48:44PM +0200, Jarkko Nikula wrote:
> I believe i2c-designware-baytrail.c doesn't have strict dependency that
> Intel SoC IOSF Sideband support must be always built-in in order to be
> able to compile support for Intel Baytrail I2C bus sharing HW semaphore.
> 
> Redefine build dependencies so that CONFIG_IOSF_MBI=y is required only
> when CONFIG_I2C_DESIGNWARE_PLATFORM is built-in.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Hi David. Can you ack/nak this patch as I'm not fully familiar with this
> HW semaphore can there be problems when IOSF_MBI is built as a module.
> At least I'm getting similar sensible looking "punit semaphore
> acquired/held for x ms" debug messages when I modprobe/rmmod
> i2c_designware_platform independently is the CONFIG_IOSF_MBI=y or =m.
> ---
>  drivers/i2c/busses/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 69c46fe13777..76f4d024def0 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -490,7 +490,9 @@ config I2C_DESIGNWARE_PCI
>  
>  config I2C_DESIGNWARE_BAYTRAIL
>  	bool "Intel Baytrail I2C semaphore support"
> -	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI=y && ACPI
> +	depends on ACPI
> +	depends on (I2C_DESIGNWARE_PLATFORM=m && IOSF_MBI) || \
> +		   (I2C_DESIGNWARE_PLATFORM=y && IOSF_MBI=y)
>  	help
>  	  This driver enables managed host access to the PMIC I2C bus on select
>  	  Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows
> -- 
> 2.6.2
> 
Acked-by: David Box <david.e.box@linux.intel.com>

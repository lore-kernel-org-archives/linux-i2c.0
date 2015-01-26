From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware-baytrail: use proper Kconfig dependencies
Date: Mon, 26 Jan 2015 10:47:34 -0800
Message-ID: <20150126184734.GA32373@pathfinder>
References: <1422290974-24561-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422290974-24561-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 26, 2015 at 05:49:34PM +0100, Wolfram Sang wrote:
> IOSF_MBI depends on PCI, so we should not select it but depend on it.
> This ensures also we compile on X86 only, other archs will break because
> of an arch specific include. Also depend on ACPI since this driver uses
> it.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Acked-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> ---
>  drivers/i2c/busses/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 83062b2c0e6b..442408d2e7b7 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -467,8 +467,7 @@ config I2C_DESIGNWARE_PCI
>  
>  config I2C_DESIGNWARE_BAYTRAIL
>  	bool "Intel Baytrail I2C semaphore support"
> -	depends on I2C_DESIGNWARE_PLATFORM
> -	select IOSF_MBI
> +	depends on I2C_DESIGNWARE_PLATFORM && IOSF_MBI && ACPI
>  	help
>  	  This driver enables managed host access to the PMIC I2C bus on select
>  	  Intel BayTrail platforms using the X-Powers AXP288 PMIC. It allows
> -- 
> 2.1.3
> 

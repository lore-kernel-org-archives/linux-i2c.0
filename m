From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 1/1] i2c-i801: make it depend on CONFIG_X86
Date: Thu, 16 Jun 2016 11:49:15 +0200
Message-ID: <20160616114915.0446f3a3@endymion>
References: <1465996923-76230-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38882 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbcFPJtT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 16 Jun 2016 05:49:19 -0400
In-Reply-To: <1465996923-76230-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

Hi Andy,

On Wed, 15 Jun 2016 16:22:03 +0300, Andy Shevchenko wrote:
> The IP seems not used outside of x86 world, so, make it depend on CONFIG_X86.

I've seen the ICH10 used on at least one IA64 system (Supermicro I8QBH
mainboard.) So, nack, sorry. However I'd be OK with:

	depends on X86 || IA64 || COMPILE_TEST

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/Kconfig    | 4 ++--
>  drivers/i2c/busses/i2c-i801.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f167021..78609ad 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -89,8 +89,8 @@ config I2C_HIX5HD2
>  
>  config I2C_I801
>  	tristate "Intel 82801 (ICH/PCH)"
> -	depends on PCI
> -	select CHECK_SIGNATURE if X86 && DMI
> +	depends on X86 && PCI
> +	select CHECK_SIGNATURE if DMI
>  	help
>  	  If you say yes to this option, support will be included
> for the Intel 801 family of mainboard I2C interfaces.  Specifically,
> the following diff --git a/drivers/i2c/busses/i2c-i801.c
> b/drivers/i2c/busses/i2c-i801.c index b436963..9dcc417 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -902,7 +902,7 @@ static const struct pci_device_id i801_ids[] = {
>  
>  MODULE_DEVICE_TABLE(pci, i801_ids);
>  
> -#if defined CONFIG_X86 && defined CONFIG_DMI
> +#ifdef CONFIG_DMI
>  static unsigned char apanel_addr;
>  
>  /* Scan the system ROM for the signature "FJKEYINF" */
> @@ -1020,7 +1020,7 @@ static void i801_probe_optional_slaves(struct
> i801_priv *priv) #else
>  static void __init input_apanel_init(void) {}
>  static void i801_probe_optional_slaves(struct i801_priv *priv) {}
> -#endif	/* CONFIG_X86 && CONFIG_DMI */
> +#endif	/* CONFIG_DMI */
>  
>  #if (defined CONFIG_I2C_MUX_GPIO || defined
> CONFIG_I2C_MUX_GPIO_MODULE) && \ defined CONFIG_DMI


-- 
Jean Delvare
SUSE L3 Support

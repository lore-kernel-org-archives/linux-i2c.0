From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/3] watchdog: iTCO_wdt: Export vendorsupport
Date: Wed, 26 Feb 2020 05:32:40 -0800
Message-ID: <5e56f8b1-c411-69bd-6e02-c0dde3db69dd@roeck-us.net>
References: <20200226132122.62805-1-mika.westerberg@linux.intel.com>
 <20200226132122.62805-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33159 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgBZNcp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 26 Feb 2020 08:32:45 -0500
In-Reply-To: <20200226132122.62805-2-mika.westerberg@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: Martin Volf <martin.volf.42@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/26/20 5:21 AM, Mika Westerberg wrote:
> In preparation for making ->smi_res optional the iTCO_wdt driver needs
> to know whether vendorsupport is being set to non-zero. For this reason
> export the variable.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I assume you'll send the series upstream in one go (through i2c ?).
If not, please let me and Wim know.

Thanks,
Guenter

> ---
>  drivers/watchdog/iTCO_vendor.h         |  2 ++
>  drivers/watchdog/iTCO_vendor_support.c | 16 +++++++++-------
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_vendor.h b/drivers/watchdog/iTCO_vendor.h
> index 0f7373ba10d5..69e92e692ae0 100644
> --- a/drivers/watchdog/iTCO_vendor.h
> +++ b/drivers/watchdog/iTCO_vendor.h
> @@ -1,10 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* iTCO Vendor Specific Support hooks */
>  #ifdef CONFIG_ITCO_VENDOR_SUPPORT
> +extern int iTCO_vendorsupport;
>  extern void iTCO_vendor_pre_start(struct resource *, unsigned int);
>  extern void iTCO_vendor_pre_stop(struct resource *);
>  extern int iTCO_vendor_check_noreboot_on(void);
>  #else
> +#define iTCO_vendorsupport				0
>  #define iTCO_vendor_pre_start(acpibase, heartbeat)	{}
>  #define iTCO_vendor_pre_stop(acpibase)			{}
>  #define iTCO_vendor_check_noreboot_on()			1
> diff --git a/drivers/watchdog/iTCO_vendor_support.c b/drivers/watchdog/iTCO_vendor_support.c
> index 4f1b96f59349..cf0eaa04b064 100644
> --- a/drivers/watchdog/iTCO_vendor_support.c
> +++ b/drivers/watchdog/iTCO_vendor_support.c
> @@ -39,8 +39,10 @@
>  /* Broken BIOS */
>  #define BROKEN_BIOS		911
>  
> -static int vendorsupport;
> -module_param(vendorsupport, int, 0);
> +int iTCO_vendorsupport;
> +EXPORT_SYMBOL(iTCO_vendorsupport);
> +
> +module_param_named(vendorsupport, iTCO_vendorsupport, int, 0);
>  MODULE_PARM_DESC(vendorsupport, "iTCO vendor specific support mode, default="
>  			"0 (none), 1=SuperMicro Pent3, 911=Broken SMI BIOS");
>  
> @@ -152,7 +154,7 @@ static void broken_bios_stop(struct resource *smires)
>  void iTCO_vendor_pre_start(struct resource *smires,
>  			   unsigned int heartbeat)
>  {
> -	switch (vendorsupport) {
> +	switch (iTCO_vendorsupport) {
>  	case SUPERMICRO_OLD_BOARD:
>  		supermicro_old_pre_start(smires);
>  		break;
> @@ -165,7 +167,7 @@ EXPORT_SYMBOL(iTCO_vendor_pre_start);
>  
>  void iTCO_vendor_pre_stop(struct resource *smires)
>  {
> -	switch (vendorsupport) {
> +	switch (iTCO_vendorsupport) {
>  	case SUPERMICRO_OLD_BOARD:
>  		supermicro_old_pre_stop(smires);
>  		break;
> @@ -178,7 +180,7 @@ EXPORT_SYMBOL(iTCO_vendor_pre_stop);
>  
>  int iTCO_vendor_check_noreboot_on(void)
>  {
> -	switch (vendorsupport) {
> +	switch (iTCO_vendorsupport) {
>  	case SUPERMICRO_OLD_BOARD:
>  		return 0;
>  	default:
> @@ -189,13 +191,13 @@ EXPORT_SYMBOL(iTCO_vendor_check_noreboot_on);
>  
>  static int __init iTCO_vendor_init_module(void)
>  {
> -	if (vendorsupport == SUPERMICRO_NEW_BOARD) {
> +	if (iTCO_vendorsupport == SUPERMICRO_NEW_BOARD) {
>  		pr_warn("Option vendorsupport=%d is no longer supported, "
>  			"please use the w83627hf_wdt driver instead\n",
>  			SUPERMICRO_NEW_BOARD);
>  		return -EINVAL;
>  	}
> -	pr_info("vendor-support=%d\n", vendorsupport);
> +	pr_info("vendor-support=%d\n", iTCO_vendorsupport);
>  	return 0;
>  }
>  
> 

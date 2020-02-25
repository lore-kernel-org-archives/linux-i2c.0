From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] watchdog: iTCO_wdt: Make ICH_RES_IO_SMI optional
Date: Tue, 25 Feb 2020 06:37:09 -0800
Message-ID: <20200225143709.GA450@roeck-us.net>
References: <20200225123802.88984-1-mika.westerberg@linux.intel.com>
 <20200225123802.88984-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41673 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgBYOhM (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 25 Feb 2020 09:37:12 -0500
Content-Disposition: inline
In-Reply-To: <20200225123802.88984-3-mika.westerberg@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, Wolfram Sang <wsa@the-dreams.de>, Martin Volf <martin.volf.42@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 03:38:01PM +0300, Mika Westerberg wrote:
> The iTCO_wdt driver only needs ICH_RES_IO_SMI I/O resource when either
> turn_SMI_watchdog_clear_off module parameter is set to match ->iTCO_version
> (or higher), and when legacy iTCO_vendorsupport is set. Modify the driver
> so that ICH_RES_IO_SMI is optional if the two conditions are not met.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/watchdog/iTCO_wdt.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 156360e37714..f1692452bc25 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -460,7 +460,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	p->smi_res = platform_get_resource(pdev, IORESOURCE_IO, ICH_RES_IO_SMI);
> -	if (!p->smi_res)
> +	if (!p->smi_res && iTCO_vendorsupport)
>  		return -ENODEV;
>  
>  	p->iTCO_version = pdata->version;
> @@ -492,15 +492,19 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
>  	p->update_no_reboot_bit(p->no_reboot_priv, true);
>  
> -	/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
> -	if (!devm_request_region(dev, p->smi_res->start,
> -				 resource_size(p->smi_res),
> -				 pdev->name)) {
> -		pr_err("I/O address 0x%04llx already in use, device disabled\n",
> -		       (u64)SMI_EN(p));
> -		return -EBUSY;
> -	}
>  	if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
> +		if (!p->smi_res) {
> +			pr_err("SMI I/O resource is missing\n");
> +			return -EINVAL;
> +		}
> +		/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
> +		if (!devm_request_region(dev, p->smi_res->start,
> +					 resource_size(p->smi_res),
> +					 pdev->name)) {
> +			pr_err("I/O address 0x%04llx already in use, device disabled\n",
> +			       (u64)SMI_EN(p));
> +			return -EBUSY;
> +		}

The request_region call is also needed if iTCO_vendorsupport is true.
Well, not strictly speaking, I guess, but then one could argue that
it isn't needed at all.

In this context - looking into the vendorsupport code, I wonder if
it is time to retire it. Separate patch, of course, but still.
Any thoughts ?

Guenter

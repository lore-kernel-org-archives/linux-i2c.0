From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v2 2/3] watchdog: iTCO_wdt: Make ICH_RES_IO_SMI optional
Date: Wed, 26 Feb 2020 05:33:00 -0800
Message-ID: <8565beae-e7b3-c683-cd39-5af869513f1a@roeck-us.net>
References: <20200226132122.62805-1-mika.westerberg@linux.intel.com>
 <20200226132122.62805-3-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200226132122.62805-3-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Martin Volf <martin.volf.42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2/26/20 5:21 AM, Mika Westerberg wrote:
> The iTCO_wdt driver only needs ICH_RES_IO_SMI I/O resource when either
> turn_SMI_watchdog_clear_off module parameter is set to match ->iTCO_version
> (or higher), and when legacy iTCO_vendorsupport is set. Modify the driver
> so that ICH_RES_IO_SMI is optional if the two conditions are not met.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Reviewed-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

> ---
>  drivers/watchdog/iTCO_wdt.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index 156360e37714..e707c4797f76 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -459,13 +459,25 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	if (!p->tco_res)
>  		return -ENODEV;
>  
> -	p->smi_res = platform_get_resource(pdev, IORESOURCE_IO, ICH_RES_IO_SMI);
> -	if (!p->smi_res)
> -		return -ENODEV;
> -
>  	p->iTCO_version = pdata->version;
>  	p->pci_dev = to_pci_dev(dev->parent);
>  
> +	p->smi_res = platform_get_resource(pdev, IORESOURCE_IO, ICH_RES_IO_SMI);
> +	if (p->smi_res) {
> +		/* The TCO logic uses the TCO_EN bit in the SMI_EN register */
> +		if (!devm_request_region(dev, p->smi_res->start,
> +					 resource_size(p->smi_res),
> +					 pdev->name)) {
> +			pr_err("I/O address 0x%04llx already in use, device disabled\n",
> +			       (u64)SMI_EN(p));
> +			return -EBUSY;
> +		}
> +	} else if (iTCO_vendorsupport ||
> +		   turn_SMI_watchdog_clear_off >= p->iTCO_version) {
> +		pr_err("SMI I/O resource is missing\n");
> +		return -ENODEV;
> +	}
> +
>  	iTCO_wdt_no_reboot_bit_setup(p, pdata);
>  
>  	/*
> @@ -492,14 +504,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
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
>  		/*
>  		 * Bit 13: TCO_EN -> 0
> 

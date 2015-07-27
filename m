From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: designware-pci: use IRQF_COND_SUSPEND flag
Date: Mon, 27 Jul 2015 14:37:23 +0300
Message-ID: <1437997043.29746.86.camel@linux.intel.com>
References: <1436350536-99102-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436350536-99102-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-07-08 at 13:15 +0300, Andy Shevchenko wrote:
> The mentioned flag fixes a warning on Intel Edison board since one of 
> the I2C
> controller shares IRQ line with watchdog timer.
> 

Wolfram, do you have any comments on this?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c 
> b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 6643d2d..df23e8c 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -260,8 +260,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
>  
>  	snprintf(adap->name, sizeof(adap->name), "i2c-designware
> -pci");
>  
> -	r = devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr, 
> IRQF_SHARED,
> -			adap->name, dev);
> +	r = devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr,
> +			IRQF_SHARED | IRQF_COND_SUSPEND, adap->name, 
> dev);
>  	if (r) {
>  		dev_err(&pdev->dev, "failure requesting irq %i\n", 
> dev->irq);
>  		return r;

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy

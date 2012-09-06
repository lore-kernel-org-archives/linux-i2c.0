From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2] i2c: omap: Prevent NULL pointer dereference in
 remove
Date: Thu, 6 Sep 2012 14:21:35 +0200
Message-ID: <20120906142135.2cdebf93@endymion.delvare>
References: <1346932916-12365-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1346932916-12365-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 6 Sep 2012 17:31:56 +0530, Shubhrajyoti D wrote:
> Prevent the NULL pointer access by moving the platform_set_drvdata function
> after the access of the pdev.
> 
> [  654.961761] Unable to handle kernel NULL pointer dereference at virtual address 00000070
> [  654.970611] pgd = df254000
> [  654.973480] [00000070] *pgd=9f1da831, *pte=00000000, *ppte=00000000
> [  654.980163] Internal error: Oops: 17 [#1] SMP ARM
> [  654.985076] Modules linked in:
> [  654.988281] CPU: 1    Not tainted  (3.6.0-rc1-00031-ge547de1-dirty #339)
> [  654.995330] PC is at omap_i2c_runtime_resume+0x8/0x148
> [  655.000732] LR is at omap_i2c_runtime_resume+0x8/0x148
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

(This will rather go in Ben's or Wolfram's i2c tree.)

> ---
> v2: Implement Jean's suggestion of not deleting instead make it NULL at a safer time.
> 
>  drivers/i2c/busses/i2c-omap.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 5d19a49..c4ddb08 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1112,8 +1112,6 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  	struct resource		*mem;
>  	int ret;
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	free_irq(dev->irq, dev);
>  	i2c_del_adapter(&dev->adapter);
>  	ret = pm_runtime_get_sync(&pdev->dev);
> @@ -1127,6 +1125,7 @@ static int __devexit omap_i2c_remove(struct platform_device *pdev)
>  	kfree(dev);
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(mem->start, resource_size(mem));
> +	platform_set_drvdata(pdev, NULL);
>  	return 0;
>  }
>  


-- 
Jean Delvare

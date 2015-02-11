From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 4/5] i2c-designware-baytrail: cross-check lock
 functions
Date: Wed, 11 Feb 2015 08:46:53 -0800
Message-ID: <20150211164652.GD14753@pathfinder>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1423587970-19136-4-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423587970-19136-4-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 10, 2015 at 07:06:09PM +0200, Andy Shevchenko wrote:
> It seems the idea behind the cross-check is to prevent acquire semaphore when
> there is no release callback and vice versa. Thus, patch fixes a typo.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
> index d334744..036d9bdc0 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -71,7 +71,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
>  	if (!dev || !dev->dev)
>  		return -ENODEV;
>  
> -	if (!dev->acquire_lock)
> +	if (!dev->release_lock)
>  		return 0;
>  
>  	/* host driver writes to side band semaphore register */
> -- 
> 2.1.4
> 

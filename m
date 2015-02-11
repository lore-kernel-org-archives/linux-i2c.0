From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 2/5] i2c-designware-baytrail: fix typo in error path
Date: Wed, 11 Feb 2015 08:38:22 -0800
Message-ID: <20150211163822.GB14753@pathfinder>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1423587970-19136-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423587970-19136-2-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 10, 2015 at 07:06:07PM +0200, Andy Shevchenko wrote:
> It seems we have same message for different return values in get_sem() and
> baytrail_i2c_acquire(). I suspect this is just a typo, so this patch fixes it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Thanks for spotting this. Timeouts are infrequent and I didn't notice the
error here.

Dave

> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
> index e9cb355..9b67655 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -99,8 +99,8 @@ int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
>  	reset_semaphore(dev->dev);
>  
>  	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, BT_MBI_BUNIT_READ,
> -		PUNIT_SEMAPHORE, &sem);
> -	if (!ret)
> +				PUNIT_SEMAPHORE, &sem);
> +	if (ret)
>  		dev_err(dev->dev, "iosf failed to read punit semaphore\n");
>  	else
>  		dev_err(dev->dev, "PUNIT SEM: %d\n", sem);
> -- 
> 2.1.4
> 

From: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 5/5] i2c-designware-baytrail: baytrail_i2c_acquire()
 might sleep
Date: Wed, 11 Feb 2015 08:48:27 -0800
Message-ID: <20150211164827.GE14753@pathfinder>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1423587970-19136-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423587970-19136-5-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 10, 2015 at 07:06:10PM +0200, Andy Shevchenko wrote:
> This patch marks baytrail_i2c_acquire() that it might sleep. Also it chages
> while-loop to do-while and, though it is matter of taste, gives a chance to
> check one more time before report a timeout.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Acked-by: David E. Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-designware-baytrail.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-baytrail.c b/drivers/i2c/busses/i2c-designware-baytrail.c
> index 036d9bdc0..7d7ae97 100644
> --- a/drivers/i2c/busses/i2c-designware-baytrail.c
> +++ b/drivers/i2c/busses/i2c-designware-baytrail.c
> @@ -68,6 +68,8 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
>  	int ret;
>  	unsigned long start, end;
>  
> +	might_sleep();
> +
>  	if (!dev || !dev->dev)
>  		return -ENODEV;
>  
> @@ -85,7 +87,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
>  	/* host driver waits for bit 0 to be set in semaphore register */
>  	start = jiffies;
>  	end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
> -	while (!time_after(jiffies, end)) {
> +	do {
>  		ret = get_sem(dev->dev, &sem);
>  		if (!ret && sem) {
>  			acquired = jiffies;
> @@ -95,7 +97,7 @@ static int baytrail_i2c_acquire(struct dw_i2c_dev *dev)
>  		}
>  
>  		usleep_range(1000, 2000);
> -	}
> +	} while (time_before(jiffies, end));
>  
>  	dev_err(dev->dev, "punit semaphore timed out, resetting\n");
>  	reset_semaphore(dev->dev);
> -- 
> 2.1.4
> 

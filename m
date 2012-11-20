From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 002/493] i2c: remove CONFIG_HOTPLUG ifdefs
Date: Tue, 20 Nov 2012 09:13:13 +0100
Message-ID: <20121120091313.29614db3@endymion.delvare>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
	<1353349642-3677-2-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353349642-3677-2-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks  <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 19 Nov 2012 13:19:11 -0500, Bill Pemberton wrote:
> Remove conditional code based on CONFIG_HOTPLUG being false.  It's
> always on now in preparation of it going away as an option.
> 
> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> 
> Cc: "Ben Dooks " <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> 
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> ---
>  drivers/i2c/i2c-core.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a7edf98..9cebac0 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -86,9 +86,6 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
>  
> -#ifdef	CONFIG_HOTPLUG
> -
> -/* uevent helps with hotplug: modprobe -q $(MODALIAS) */

What was wrong with this comment?

>  static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct i2c_client	*client = to_i2c_client(dev);
> @@ -100,10 +97,6 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> -#else
> -#define i2c_device_uevent	NULL
> -#endif	/* CONFIG_HOTPLUG */
> -
>  static int i2c_device_probe(struct device *dev)
>  {
>  	struct i2c_client	*client = i2c_verify_client(dev);


-- 
Jean Delvare

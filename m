From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: remove CONFIG_HOTPLUG ifdefs
Date: Tue, 20 Nov 2012 16:46:09 +0100
Message-ID: <20121120164609.6a7347dc@endymion.delvare>
References: <1353423481-5163-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353423481-5163-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 20 Nov 2012 09:58:01 -0500, Bill Pemberton wrote:
> Remove conditional code based on CONFIG_HOTPLUG being false.  It's
> always on now in preparation of it going away as an option.
> 
> Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
> ---
> 
> The is a resend of patch 002/493 that retains a comment inadvertently
> removed in the first version.
> 
> ---
>  drivers/i2c/i2c-core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a7edf98..ff43d3b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -86,8 +86,6 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
>  	return 0;
>  }
>  
> -#ifdef	CONFIG_HOTPLUG
> -
>  /* uevent helps with hotplug: modprobe -q $(MODALIAS) */
>  static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
> @@ -100,10 +98,6 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
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

Looks reasonable.

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare

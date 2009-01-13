From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: Warn on deprecated binding model use
Date: Tue, 13 Jan 2009 15:44:29 +0000
Message-ID: <20090113154428.GK8032@fluff.org.uk>
References: <20090113144044.5b6fb53a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090113144044.5b6fb53a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 13, 2009 at 02:40:44PM +0100, Jean Delvare wrote:
> Let the kernel developers know that i2c_attach_client() and
> i2c_detach_client() are deprecated and should no longer be used.
> Drivers using these should be converted to the standard device
> driver binding model (probe and remove methods.)
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

This is a good idea, we should also signal a kernel date when the
old probe method will be removed (IMHO, the next merge window).

Acked-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
> This is only for linux-next for now, in the hope that it will speed up
> the conversion of the remaining legacy i2c drivers.
> 
>  include/linux/i2c.h |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux-2.6.29-rc1.orig/include/linux/i2c.h	2009-01-12 18:43:41.000000000 +0100
> +++ linux-2.6.29-rc1/include/linux/i2c.h	2009-01-13 14:37:27.000000000 +0100
> @@ -151,7 +151,7 @@ struct i2c_driver {
>  	 * has been dynamically allocated by the driver in the function above,
>  	 * it must be freed here.  (LEGACY I2C DRIVERS ONLY)
>  	 */
> -	int (*detach_client)(struct i2c_client *);
> +	int (*detach_client)(struct i2c_client *) __deprecated;
>  
>  	/* Standard driver model interfaces, for "new style" i2c drivers.
>  	 * With the driver model, device enumeration is NEVER done by drivers;
> @@ -429,8 +429,10 @@ static inline int i2c_add_driver(struct
>  	return i2c_register_driver(THIS_MODULE, driver);
>  }
>  
> -extern int i2c_attach_client(struct i2c_client *);
> -extern int i2c_detach_client(struct i2c_client *);
> +/* These are deprecated, your driver should use the standard .probe()
> + * and .remove() methods instead. */
> +extern int __deprecated i2c_attach_client(struct i2c_client *);
> +extern int __deprecated i2c_detach_client(struct i2c_client *);
>  
>  extern struct i2c_client *i2c_use_client(struct i2c_client *client);
>  extern void i2c_release_client(struct i2c_client *client);
> 
> 
> -- 
> Jean Delvare
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

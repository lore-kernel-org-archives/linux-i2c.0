From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/6] i2c: Make return type of i2c_del_adapter() void
Date: Sun, 31 Mar 2013 11:04:13 +0200
Message-ID: <20130331110413.5c055485@endymion.delvare>
References: <1362853009-20789-1-git-send-email-lars@metafoo.de>
	<1362853009-20789-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1362853009-20789-5-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat,  9 Mar 2013 19:16:47 +0100, Lars-Peter Clausen wrote:
> i2c_del_adapter() is usually called from a drivers remove callback. The Linux
> device driver model does not allow the remove callback to fail and all resources
> allocated in the probe callback need to be freed, as well as all resources which
> have been provided to the rest of the kernel(for example a I2C adapter) need to
> be revoked. So any function revoking such resources isn't allowed to fail
> either. i2c_del_adapter() adheres to this requirement and will never fail. But
> i2c_del_adapter()'s return type is int, which may cause driver authors to think
> that it can fail. This led to code constructs like:
> 
> 	ret = i2c_del_adapter(...);
> 	BUG_ON(ret);
> 
> Since i2c_del_adapter() always returns 0 the BUG_ON is never hit and essentially
> becomes dead code, which means it can be removed. Making the return type of
> i2c_del_adapter() void makes it explicit that the function will never fail and
> should prevent constructs like the above from re-appearing in the kernel code.
> 
> All callers of i2c_del_adapter() have already been updated in a previous patch
> to ignore the return value, so the conversion of the return type from int to
> void can be done without causing any build failures.
> 
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 6 ++----
>  include/linux/i2c.h    | 2 +-
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 7727d33..838d030 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1060,7 +1060,7 @@ static int __process_removed_adapter(struct device_driver *d, void *data)
>   * This unregisters an I2C adapter which was previously registered
>   * by @i2c_add_adapter or @i2c_add_numbered_adapter.
>   */
> -int i2c_del_adapter(struct i2c_adapter *adap)
> +void i2c_del_adapter(struct i2c_adapter *adap)
>  {
>  	struct i2c_adapter *found;
>  	struct i2c_client *client, *next;
> @@ -1072,7 +1072,7 @@ int i2c_del_adapter(struct i2c_adapter *adap)
>  	if (found != adap) {
>  		pr_debug("i2c-core: attempting to delete unregistered "
>  			 "adapter [%s]\n", adap->name);
> -		return 0;
> +		return;
>  	}
>  
>  	/* Tell drivers about this removal */
> @@ -1124,8 +1124,6 @@ int i2c_del_adapter(struct i2c_adapter *adap)
>  	/* Clear the device structure in case this adapter is ever going to be
>  	   added again */
>  	memset(&adap->dev, 0, sizeof(adap->dev));
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL(i2c_del_adapter);
>  
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 8ffab3f..dec1702 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -447,7 +447,7 @@ void i2c_unlock_adapter(struct i2c_adapter *);
>   */
>  #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
>  extern int i2c_add_adapter(struct i2c_adapter *);
> -extern int i2c_del_adapter(struct i2c_adapter *);
> +extern void i2c_del_adapter(struct i2c_adapter *);
>  extern int i2c_add_numbered_adapter(struct i2c_adapter *);
>  
>  extern int i2c_register_driver(struct module *, struct i2c_driver *);

Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare

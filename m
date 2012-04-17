From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: implement i2c_verify_adapter
Date: Tue, 17 Apr 2012 20:49:25 +0200
Message-ID: <20120417204925.29de7775@endymion.delvare>
References: <1334688214-8400-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334688214-8400-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Stephen,

On Tue, 17 Apr 2012 12:43:33 -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> This converts a struct device * to a struct i2c_adapter * while verifying
> that the device really is an I2C adapter. Just like i2c_verify_client.
> 
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |   17 +++++++++++++++++
>  include/linux/i2c.h    |    1 +
>  2 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index feb7dc3..a6ad32b 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -772,6 +772,23 @@ struct device_type i2c_adapter_type = {
>  };
>  EXPORT_SYMBOL_GPL(i2c_adapter_type);
>  
> +/**
> + * i2c_verify_adapter - return parameter as i2c_adapter or NULL
> + * @dev: device, probably from some driver model iterator
> + *
> + * When traversing the driver model tree, perhaps using driver model
> + * iterators like @device_for_each_child(), you can't assume very much
> + * about the nodes you find.  Use this function to avoid oopses caused
> + * by wrongly treating some non-I2C device as an i2c_adapter.
> + */
> +struct i2c_adapter *i2c_verify_adapter(struct device *dev)
> +{
> +	return (dev->type == &i2c_adapter_type)
> +			? to_i2c_adapter(dev)
> +			: NULL;
> +}
> +EXPORT_SYMBOL(i2c_verify_adapter);
> +
>  #ifdef CONFIG_I2C_COMPAT
>  static struct class_compat *i2c_adapter_compat_class;
>  #endif
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 195d8b3..b66cb60 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -232,6 +232,7 @@ struct i2c_client {
>  #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
>  
>  extern struct i2c_client *i2c_verify_client(struct device *dev);
> +extern struct i2c_adapter *i2c_verify_adapter(struct device *dev);
>  
>  static inline struct i2c_client *kobj_to_i2c_client(struct kobject *kobj)
>  {

I am fine with this patch:

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

I can merge it if you want, but if it is easier for you to merge it
through a different tree, this is equally fine with me, just let me
know what you prefer.

-- 
Jean Delvare

From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/9] i2c: Match using traditional OF methods, then by
 vendor-less compatible strings
Date: Sat, 07 Jun 2014 00:19:14 +0100
Message-ID: <20140606231914.2E2FDC4218F@trevor.secretlab.ca>
References: <1402069952-28022-1-git-send-email-lee.jones@linaro.org>
	<1402069952-28022-4-git-send-email-lee.jones@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402069952-28022-4-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri,  6 Jun 2014 16:52:26 +0100, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> This function provides a single call for all I2C devices which need to
> match firstly using traditional OF means i.e by of_node, then if that
> fails we attempt to match using the supplied I2C client name with a
> list of supplied compatible strings with the '<vendor>,' string
> removed.  The latter is required due to the unruly naming conventions
> used currently by I2C devices.
> 
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 13 +++++++++++++
>  include/linux/i2c.h    |  9 +++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index face8f9..80a2f2e 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1115,6 +1115,19 @@ const struct of_device_id
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(i2c_of_match_device_strip_vendor);
> +
> +const struct of_device_id
> +*i2c_of_match_device(const struct of_device_id *matches, struct device *dev)

Should be:
const struct of_device_id *
i2c_of_match_device(const struct of_device_id *matches, struct i2c_client *dev)

Since it is only applicable to i2c_client. Don't allow random subsystems
to call into it with any struct device (even if there is little risk due
to the name and location of the function). Same comment goes for
i2c_of_match_device_strip_vendor().

In fact, i2c_of_match_device_strip_vendor() should be rolled directly
into i2c_of_match_device(). I know you're calling it in patch 7/9, but
that needs to be removed. I'll comment directly on that patch though.

g.

> +{
> +	const struct of_device_id *match;
> +
> +	match = of_match_device(matches, dev);
> +	if (match)
> +		return match;
> +
> +	return i2c_of_match_device_strip_vendor(matches, dev);
> +}
> +EXPORT_SYMBOL_GPL(i2c_of_match_device);
>  #else
>  static void of_i2c_register_devices(struct i2c_adapter *adap) { }
>  #endif /* CONFIG_OF */
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index f7ec75b..ab5866f 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -565,6 +565,9 @@ extern struct i2c_client *of_find_i2c_device_by_node(struct device_node *node);
>  extern struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node);
>  
>  extern const struct of_device_id
> +*i2c_of_match_device(const struct of_device_id *matches, struct device *dev);
> +
> +extern const struct of_device_id
>  *i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
>  				  struct device *dev);
>  #else
> @@ -580,6 +583,12 @@ static inline struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node
>  }
>  
>  const struct of_device_id
> +*i2c_of_match_device(const struct of_device_id *matches, struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +const struct of_device_id
>  *i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
>  				  struct device *dev)
>  {
> -- 
> 1.8.3.2
> 

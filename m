From: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/7] i2c: Add the ability to match device to compatible
 string without an of_node
Date: Thu, 05 Jun 2014 18:36:20 +0100
Message-ID: <20140605173620.5BDFBC41CBF@trevor.secretlab.ca>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
	<1401883796-17841-4-git-send-email-lee.jones@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401883796-17841-4-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed,  4 Jun 2014 13:09:52 +0100, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> A great deal of I2C devices are currently matched via DT node name, and
> as such the compatible naming convention of '<vendor>,<device>' has gone
> somewhat awry - some nodes don't supply one, some supply an arbitrary
> string and others the correct device name with an arbitrary vendor prefix.
> 
> In an effort to correct this problem we have to supply a mechanism to
> match a device by compatible string AND by simple device name.  This
> function strips off the '<vendor>,' part of a supplied compatible string
> and attempts to match without it.
> 
> The plan is to remove this function once all of the compatible strings
> for each device have been brought into line.
> 
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 25 +++++++++++++++++++++++++
>  include/linux/i2c.h    | 10 ++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index d3802dc..7dcd5c3 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1090,6 +1090,31 @@ struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
>  	return i2c_verify_adapter(dev);
>  }
>  EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
> +
> +const struct of_device_id
> +*i2c_of_match_device_strip_vendor(const struct of_device_id *matches,
> +				  struct device *dev)
> +{
> +	const struct i2c_client *client = i2c_verify_client(dev);
> +	const char *name;
> +
> +	if (!(client && matches))
> +		return NULL;
> +
> +	for (; matches->compatible[0]; matches++) {
> +		name = strchr(matches->compatible, ',');
> +		if (!name)
> +			name = matches->compatible;
> +		else
> +			name++;
> +
> +		if (!strncmp(client->name, name, strlen(client->name)))
> +			return matches;
> +	}

Is it actually necessary to strip off the vendor name? It would be fine
to make users include the vendor prefix when creating the device in
sysfs. In fact that would be preferrable for new drivers so that vendor
prefixes start getting used correctly.

If you're worried about preserving exisiting ABI, then I would make
striping the prefix an option that drivers can enable, but by default
only match on the full string.

g.

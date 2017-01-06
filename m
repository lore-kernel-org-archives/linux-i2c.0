From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: core: helper function to detect slave mode
Date: Fri, 6 Jan 2017 23:46:30 +0200
Message-ID: <73246c4a-504c-52d7-dde4-970a45dca0bd@mleia.com>
References: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f4ec62119145bc70c938800c91eb396d30457304.1483636071.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Luis,

On 01/05/2017 07:24 PM, Luis Oliveira wrote:
> This function has the purpose of mode detection by checking the
> device nodes for a reg matching with the I2C_OWN_SLAVE_ADDREESS flag.
> Currently only checks using OF functions (ACPI slave not supported yet).
> 
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> ---
> Due to the need of checking if the I2C slave address is our own (in 
> other words: if we are the I2C slave) I created a helper function 
> (proposed to me by @Andy) to enable that check. 
> Currently (because I am not able to test it using ACPI) it only 
> supports devicetree declarations.
> 
>  drivers/i2c/i2c-core.c | 19 +++++++++++++++++++
>  include/linux/i2c.h    |  1 +
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 3de95a29024c..48e705b23c59 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -3691,6 +3691,25 @@ int i2c_slave_unregister(struct i2c_client *client)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(i2c_slave_unregister);
> +
> +int i2c_slave_mode_detect(struct device *dev)
> +{
> +	struct device_node *child;
> +	u32 reg;
> +
> +	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {

IS_BUILTIN(CONFIG_OF) looks excessive, check for non-NULL dev->of_node
should be sufficient.

But then you may do for_each_child_of_node() loop totally unconditionally,
because of_get_next_child() correctly handle NULL as the first argument.

> +		for_each_child_of_node(dev->of_node, child) {
> +			of_property_read_u32(child, "reg", &reg);
> +			if (reg & I2C_OWN_SLAVE_ADDRESS)
> +				return 1;

Leaked incremented reference to a child device node, please add
of_node_put(child) before return in the loop body.

Also reg variable may be uninitialized here, if child device node
does not have "reg" property.

> +		}
> +	} else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev)) {
> +		dev_dbg(dev, "ACPI slave is not supported yet\n");
> +	}

If so, then it might be better to drop else-if stub for now.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(i2c_slave_mode_detect);
> +
>  #endif
>  
>  MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index b2109c522dec..53cf99569af5 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -282,6 +282,7 @@ enum i2c_slave_event {
>  
>  extern int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
>  extern int i2c_slave_unregister(struct i2c_client *client);
> +extern int i2c_slave_mode_detect(struct device *dev);
>  
>  static inline int i2c_slave_event(struct i2c_client *client,
>  				  enum i2c_slave_event event, u8 *val)
> 

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

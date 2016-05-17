From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v2 2/5] of: changesets: Introduce changeset helper methods
Date: Tue, 17 May 2016 12:25:51 +0200
Message-ID: <e7dbb25a-0638-1c33-7473-60e047bf9d98@axentia.se>
References: <1463416888-22044-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1463416888-22044-3-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463416888-22044-3-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi!

I found a resource management bug in this patch.

Cheers,
Peter

On 2016-05-16 18:41, Pantelis Antoniou wrote:
> Changesets are very powerful, but the lack of a helper API
> makes using them cumbersome. Introduce a simple copy based
> API that makes things considerably easier.
> 
> To wit, adding a property using the raw API.
> 
> 	struct property *prop;
> 	prop = kzalloc(sizeof(*prop)), GFP_KERNEL);
> 	prop->name = kstrdup("compatible");
> 	prop->value = kstrdup("foo,bar");
> 	prop->length = strlen(prop->value) + 1;
> 	of_changeset_add_property(ocs, np, prop);
> 
> while using the helper API
> 
> 	of_changeset_add_property_string(ocs, np, "compatible",
> 			"foo,bar");
> 
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/of/dynamic.c | 226 +++++++++++++++++++++++++++++++++++
>  include/linux/of.h   | 328 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 554 insertions(+)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index e4dea94..83cc801 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -828,3 +828,229 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_changeset_action);
> +
> +/* changeset helpers */
> +
> +/**
> + * of_changeset_create_device_node - Create an empty device node
> + *
> + * @ocs:	changeset pointer
> + * @parent:	parent device node
> + * @fmt:	format string for the node's full_name
> + * @args:	argument list for the format string
> + *
> + * Create an empty device node, marking it as detached and allocated.
> + *
> + * Returns a device node on success, an error encoded pointer otherwise
> + */
> +struct device_node *of_changeset_create_device_nodev(
> +	struct of_changeset *ocs, struct device_node *parent,
> +	const char *fmt, va_list vargs)
> +{
> +	struct device_node *node;
> +
> +	node = __of_node_dupv(NULL, fmt, vargs);
> +	if (!node)
> +		return ERR_PTR(-ENOMEM);
> +
> +	node->parent = parent;
> +	return node;
> +}
> +EXPORT_SYMBOL_GPL(of_changeset_create_device_nodev);
> +
> +/**
> + * of_changeset_create_device_node - Create an empty device node
> + *
> + * @ocs:	changeset pointer
> + * @parent:	parent device node
> + * @fmt:	Format string for the node's full_name
> + * ...		Arguments
> + *
> + * Create an empty device node, marking it as detached and allocated.
> + *
> + * Returns a device node on success, an error encoded pointer otherwise
> + */
> +__printf(3, 4) struct device_node *
> +of_changeset_create_device_node(struct of_changeset *ocs,
> +	struct device_node *parent, const char *fmt, ...)
> +{
> +	va_list vargs;
> +	struct device_node *node;
> +
> +	va_start(vargs, fmt);
> +	node = of_changeset_create_device_nodev(ocs, parent, fmt, vargs);
> +	va_end(vargs);
> +	return node;
> +}
> +EXPORT_SYMBOL_GPL(of_changeset_create_device_node);
> +
> +/**
> + * __of_changeset_add_property_copy - Create/update a new property copying
> + *                                    name & value
> + *
> + * @ocs:	changeset pointer
> + * @np:		device node pointer
> + * @name:	name of the property
> + * @value:	pointer to the value data
> + * @length:	length of the value in bytes
> + * @update:	True on update operation
> + *
> + * Adds/updates a property to the changeset by making copies of the name & value
> + * entries. The @update parameter controls whether an add or update takes place.
> + *
> + * Returns zero on success, a negative error value otherwise.
> + */
> +int __of_changeset_add_update_property_copy(struct of_changeset *ocs,
> +		struct device_node *np, const char *name, const void *value,
> +		int length, bool update)
> +{
> +	struct property *prop;
> +	char *new_name;
> +	void *new_value;
> +	int ret = -ENOMEM;
> +
> +	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	new_name = kstrdup(name, GFP_KERNEL);
> +	if (!new_name)
> +		goto out_err;
> +
> +	/*
> +	 * NOTE: There is no check for zero length value.
> +	 * In case of a boolean property, this will allocate a value
> +	 * of zero bytes. We do this to work around the use
> +	 * of of_get_property() calls on boolean values.
> +	 */
> +	new_value = kmemdup(value, length, GFP_KERNEL);
> +	if (!new_value)

You leak new_name here.

> +		goto out_err;
> +
> +	of_property_set_flag(prop, OF_DYNAMIC);
> +
> +	prop->name = new_name;
> +	prop->value = new_value;
> +	prop->length = length;
> +
> +	if (!update)
> +		ret = of_changeset_add_property(ocs, np, prop);
> +	else
> +		ret = of_changeset_update_property(ocs, np, prop);
> +
> +	if (!ret)
> +		return 0;
> +
> +out_err:
> +	kfree(prop->value);
> +	kfree(prop->name);
> +	kfree(prop);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(__of_changeset_add_update_property_copy);

*snip*
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

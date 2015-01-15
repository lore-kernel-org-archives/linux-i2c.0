From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Mark instantiated device nodes with OF_POPULATE
Date: Thu, 15 Jan 2015 15:24:04 -0600
Message-ID: <CAL_JsqLL7EhW1ABJ8sM-WTAADsK3eiWVvTKP4bwwj_qXrJov5Q@mail.gmail.com>
References: <1421346798-17148-1-git-send-email-pantelis.antoniou@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421346798-17148-1-git-send-email-pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 15, 2015 at 12:33 PM, Pantelis Antoniou
<pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org> wrote:
> Mark (and unmark) device nodes with the POPULATE flag as appropriate.
> This is required to avoid multi probing when using I2C and device
> overlays containing a mux.
> This patch is also more careful with the release of the adapter device
> which caused a deadlock with muxes, and does not break the build
> on !OF since the node flag accessors are not defined then.

Why don't we define them then and get rid of the ifdef below.

It may be good to split this out of of.h because we don't want drivers
fiddling with these bits.

Rob

>
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 39d25a8..1d44e3a 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1122,6 +1122,10 @@ EXPORT_SYMBOL_GPL(i2c_new_device);
>   */
>  void i2c_unregister_device(struct i2c_client *client)
>  {
> +#if IS_ENABLED(CONFIG_OF_DYNAMIC)
> +       if (client->dev.of_node)
> +               of_node_clear_flag(client->dev.of_node, OF_POPULATED);
> +#endif
>         device_unregister(&client->dev);
>  }
>  EXPORT_SYMBOL_GPL(i2c_unregister_device);
> @@ -1441,8 +1445,11 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
>
>         dev_dbg(&adap->dev, "of_i2c: walking child nodes\n");
>
> -       for_each_available_child_of_node(adap->dev.of_node, node)
> +       for_each_available_child_of_node(adap->dev.of_node, node) {
> +               if (of_node_test_and_set_flag(node, OF_POPULATED))
> +                       continue;
>                 of_i2c_register_device(adap, node);
> +       }
>  }
>
>  static int of_dev_node_match(struct device *dev, void *data)
> @@ -1976,6 +1983,11 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
>                 if (adap == NULL)
>                         return NOTIFY_OK;       /* not for us */
>
> +               if (of_node_test_and_set_flag(rd->dn, OF_POPULATED)) {
> +                       put_device(&adap->dev);
> +                       return NOTIFY_OK;
> +               }
> +
>                 client = of_i2c_register_device(adap, rd->dn);
>                 put_device(&adap->dev);
>
> @@ -1986,6 +1998,10 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
>                 }
>                 break;
>         case OF_RECONFIG_CHANGE_REMOVE:
> +               /* already depopulated? */
> +               if (!of_node_check_flag(rd->dn, OF_POPULATED))
> +                       return NOTIFY_OK;
> +
>                 /* find our device by node */
>                 client = of_find_i2c_device_by_node(rd->dn);
>                 if (client == NULL)
> --
> 1.7.12
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

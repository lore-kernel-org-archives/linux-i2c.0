From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5] Add ov772x driver
Date: Mon, 20 Oct 2008 09:45:10 +0200
Message-ID: <20081020094510.4938d7fd@hyperion.delvare>
References: <uprlwm00v.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <uprlwm00v.wl%morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Kuninori Morimoto <morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: V4L <video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Kuninori,

On Mon, 20 Oct 2008 11:53:57 +0900, Kuninori Morimoto wrote:
> This patch adds ov772x driver that use soc_camera framework.
> It was tested on SH Migo-r board.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> PATCH v3 -> PATCH v5
> 1) fix drivers/media/video/Makefile alphabetical order
> 2) fix remove bits define
> 3) add i2c ML list
> 4) check hardware ID and Version (after power on)
> 5) remove noisy white space
> 6) add copyright / license on ov772x.h
> 7) un-changed data is changed into const data
> 8) change include line
> 
> Please ignore PATCH v4. And sorry again. 
> 
>  drivers/media/video/Kconfig     |    6 +
>  drivers/media/video/Makefile    |    1 +
>  drivers/media/video/ov772x.c    |  973 +++++++++++++++++++++++++++++++++++++++
>  include/media/ov772x.h          |   21 +
>  include/media/v4l2-chip-ident.h |    1 +
>  5 files changed, 1002 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/ov772x.c
>  create mode 100644 include/media/ov772x.h

Only commenting on the i2c part:

> +#ifdef CONFIG_VIDEO_ADV_DEBUG
> +static int ov772x_get_register(struct soc_camera_device *icd,
> +			       struct v4l2_register *reg)
> +{
> +	struct ov772x_priv *priv = container_of(icd, struct ov772x_priv, icd);
> +
> +	if (reg->reg > 0xff)
> +		return -EINVAL;
> +
> +	reg->val = i2c_smbus_read_word_data(priv->client, reg->reg);

Do you really want to read a _word_ from the chip? All other functions
read a byte...

> +
> +	if (reg->val > 0xff)

... and apparently you expect an 8-bit value anyway.

> +		return -EIO;
> +
> +	return 0;
> +}

Also note that i2c_smbus_read_* functions can return a negative value
on error. As you are handling this case in the "set" function below,
you may want to do the same for the "get" function above. If you really
want to call i2c_smbus_read_byte_data() as I suspect, then it's much
more useful to check for < 0 than > 0xff, as i2c_smbus_read_byte_data()
can't return a value greater than 0xff by construction.

> +
> +static int ov772x_set_register(struct soc_camera_device *icd,
> +			       struct v4l2_register *reg)
> +{
> +	struct ov772x_priv *priv = container_of(icd, struct ov772x_priv, icd);
> +
> +	if (reg->reg > 0xff ||
> +	    reg->val > 0xff)
> +		return -EINVAL;
> +
> +	if (i2c_smbus_write_byte_data(priv->client, reg->reg, reg->val) < 0)
> +		return -EIO;
> +
> +	return 0;
> +}
> +#endif


> (...)
> +/*
> + * i2c_driver function
> + */
> +
> +static int ov772x_probe(struct i2c_client          *client,
> +			const struct i2c_device_id *did)
> +
> +{
> +	struct ov772x_priv         *priv;
> +	struct ov772x_camera_info  *info;
> +	struct soc_camera_device   *icd;
> +	int                         ret;
> +
> +	info = client->dev.platform_data;
> +	if (!info)
> +		return -EINVAL;
> +
> +	if (!i2c_check_functionality(to_i2c_adapter(client->dev.parent),
> +				     I2C_FUNC_SMBUS_BYTE_DATA)) {
> +		dev_err(&client->dev,
> +			"I2C-Adapter doesn't support I2C_FUNC_SMBUS_BYTE\n");

This comment doesn't match the actual check.

> +		return -EIO;
> +	}
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->info   = info;
> +	priv->client = client;
> +	priv->win    = NULL;
> +	priv->fmt    = NULL;

No point initializing these to NULL after a kzalloc.

> +	i2c_set_clientdata(client, priv);
> +
> +	icd             = &priv->icd;
> +	icd->ops        = &ov772x_ops;
> +	icd->control    = &client->dev;
> +	icd->width_min  = 0;
> +	icd->width_max  = MAX_WIDTH;
> +	icd->height_min = 0;
> +	icd->height_max = MAX_HEIGHT;
> +	icd->y_skip_top = 0;
> +	icd->iface      = priv->info->link.bus_id;

You can skip the initializations to 0 for the same reason.

> +
> +	ret = soc_camera_device_register(icd);
> +
> +	if (ret)
> +		kfree(priv);
> +
> +	return ret;
> +}
> +
> +static int ov772x_remove(struct i2c_client *client)
> +{
> +	struct ov772x_priv *priv = i2c_get_clientdata(client);
> +
> +	soc_camera_device_unregister(&priv->icd);
> +	kfree(priv);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id ov772x_id[] = {
> +	{"ov772x", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ov772x_id);
> +
> +
> +static struct i2c_driver ov772x_i2c_driver = {
> +	.driver = {
> +		.name = "ov772x",
> +	},
> +	.probe    = ov772x_probe,
> +	.remove   = ov772x_remove,
> +	.id_table = ov772x_id,
> +};
> +
> +/*
> + * module function
> + */
> +
> +static int __init ov772x_module_init(void)
> +{
> +	printk(KERN_INFO "ov772x driver\n");
> +	return i2c_add_driver(&ov772x_i2c_driver);
> +}
> +
> +static void __exit ov772x_module_exit(void)
> +{
> +	i2c_del_driver(&ov772x_i2c_driver);
> +}

The rest looks OK to me.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

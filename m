From: "Voipio Riku" <Riku.Voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c: Drop legacy f75375s driver
Date: Sat, 28 Jun 2008 21:46:01 +0300 (EEST)
Message-ID: <54597.80.222.166.80.1214678761.squirrel@webmail.movial.fi>
References: <20080606145212.76f95d52@hyperion.delvare>
	<20080606160957.2ea712bb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080606160957.2ea712bb-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

Tested with the following patchset:

i2c-use-class_for_each_device.patch
i2c-simplify-i2c_del_driver.patch
i2c-core-add-detection-capability-to-new-style-drivers.patch
hwmon-f75375s-drop-legacy-driver.patch

and f75375s still works mighty fine when probed new-style. The rtc and led
drivers (both new-style) attached to i2c bus work too.

Acked-by: Riku Voipio <riku.voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>

> Drop the legacy f75375s driver, and add a detect callback to the
> new-style driver to achieve the same functionality.
>
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/hwmon/f75375s.c |   74
> +++++++----------------------------------------
>  1 file changed, 12 insertions(+), 62 deletions(-)
>
> --- linux-2.6.26-rc5.orig/drivers/hwmon/f75375s.c	2008-06-05
> 21:04:26.000000000 +0200
> +++ linux-2.6.26-rc5/drivers/hwmon/f75375s.c	2008-06-05 22:14:00.000000000
> +0200
> @@ -114,21 +114,12 @@ struct f75375_data {
>  	s8 temp_max_hyst[2];
>  };
>
> -static int f75375_attach_adapter(struct i2c_adapter *adapter);
> -static int f75375_detect(struct i2c_adapter *adapter, int address, int
> kind);
> -static int f75375_detach_client(struct i2c_client *client);
> +static int f75375_detect(struct i2c_adapter *adapter, int address, int
> kind,
> +			 struct i2c_board_info *info);
>  static int f75375_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id);
>  static int f75375_remove(struct i2c_client *client);
>
> -static struct i2c_driver f75375_legacy_driver = {
> -	.driver = {
> -		.name = "f75375_legacy",
> -	},
> -	.attach_adapter = f75375_attach_adapter,
> -	.detach_client = f75375_detach_client,
> -};
> -
>  static const struct i2c_device_id f75375_id[] = {
>  	{ "f75373", f75373 },
>  	{ "f75375", f75375 },
> @@ -137,12 +128,15 @@ static const struct i2c_device_id f75375
>  MODULE_DEVICE_TABLE(i2c, f75375_id);
>
>  static struct i2c_driver f75375_driver = {
> +	.class = I2C_CLASS_HWMON,
>  	.driver = {
>  		.name = "f75375",
>  	},
>  	.probe = f75375_probe,
>  	.remove = f75375_remove,
>  	.id_table = f75375_id,
> +	.detect = f75375_detect,
> +	.address_data = &addr_data,
>  };
>
>  static inline int f75375_read8(struct i2c_client *client, u8 reg)
> @@ -607,22 +601,6 @@ static const struct attribute_group f753
>  	.attrs = f75375_attributes,
>  };
>
> -static int f75375_detach_client(struct i2c_client *client)
> -{
> -	int err;
> -
> -	f75375_remove(client);
> -	err = i2c_detach_client(client);
> -	if (err) {
> -		dev_err(&client->dev,
> -			"Client deregistration failed, "
> -			"client not detached.\n");
> -		return err;
> -	}
> -	kfree(client);
> -	return 0;
> -}
> -
>  static void f75375_init(struct i2c_client *client, struct f75375_data
> *data,
>  		struct f75375s_platform_data *f75375s_pdata)
>  {
> @@ -700,21 +678,14 @@ static int f75375_remove(struct i2c_clie
>  	return 0;
>  }
>
> -static int f75375_attach_adapter(struct i2c_adapter *adapter)
> -{
> -	if (!(adapter->class & I2C_CLASS_HWMON))
> -		return 0;
> -	return i2c_probe(adapter, &addr_data, f75375_detect);
> -}
> -
>  /* This function is called by i2c_probe */
> -static int f75375_detect(struct i2c_adapter *adapter, int address, int
> kind)
> +static int f75375_detect(struct i2c_adapter *adapter, int address, int
> kind,
> +			 struct i2c_board_info *info)
>  {
>  	struct i2c_client *client;
>  	u8 version = 0;
> -	int err = 0;
> +	int err = -ENODEV;
>  	const char *name = "";
> -	struct i2c_device_id id;
>
>  	if (!(client = kzalloc(sizeof(*client), GFP_KERNEL))) {
>  		err = -ENOMEM;
> @@ -722,7 +693,6 @@ static int f75375_detect(struct i2c_adap
>  	}
>  	client->addr = address;
>  	client->adapter = adapter;
> -	client->driver = &f75375_legacy_driver;
>
>  	if (kind < 0) {
>  		u16 vendid = f75375_read16(client, F75375_REG_VENDOR);
> @@ -739,6 +709,7 @@ static int f75375_detect(struct i2c_adap
>  			goto exit_free;
>  		}
>  	}
> +	err = 0;	/* detection OK */
>
>  	if (kind == f75375) {
>  		name = "f75375";
> @@ -746,20 +717,9 @@ static int f75375_detect(struct i2c_adap
>  		name = "f75373";
>  	}
>  	dev_info(&adapter->dev, "found %s version: %02X\n", name, version);
> -	strlcpy(client->name, name, I2C_NAME_SIZE);
> +	strlcpy(info->type, name, I2C_NAME_SIZE);
> +	info->addr = address;
>
> -	if ((err = i2c_attach_client(client)))
> -		goto exit_free;
> -
> -	strlcpy(id.name, name, I2C_NAME_SIZE);
> -	id.driver_data = kind;
> -	if ((err = f75375_probe(client, &id)) < 0)
> -		goto exit_detach;
> -
> -	return 0;
> -
> -exit_detach:
> -	i2c_detach_client(client);
>  exit_free:
>  	kfree(client);
>  exit:
> @@ -768,21 +728,11 @@ exit:
>
>  static int __init sensors_f75375_init(void)
>  {
> -	int status;
> -	status = i2c_add_driver(&f75375_driver);
> -	if (status)
> -		return status;
> -
> -	status = i2c_add_driver(&f75375_legacy_driver);
> -	if (status)
> -		i2c_del_driver(&f75375_driver);
> -
> -	return status;
> +	return i2c_add_driver(&f75375_driver);
>  }
>
>  static void __exit sensors_f75375_exit(void)
>  {
> -	i2c_del_driver(&f75375_legacy_driver);
>  	i2c_del_driver(&f75375_driver);
>  }
>
>
> --
> Jean Delvare
>


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH RESEND 3/3] hwmon: w83793d: convert to use
 devm_i2c_new_dummy_device
Date: Tue, 3 Sep 2019 12:46:33 -0700
Message-ID: <20190903194633.GB32299@roeck-us.net>
References: <20190903181256.13450-1-wsa+renesas@sang-engineering.com>
 <20190903181256.13450-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190903181256.13450-4-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Rudolf Marek <r.marek@assembler.cz>, Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 03, 2019 at 08:12:56PM +0200, Wolfram Sang wrote:
> And simplify the error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/w83793.c | 30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
> index 46f5dfec8d0a..9df48b70c70c 100644
> --- a/drivers/hwmon/w83793.c
> +++ b/drivers/hwmon/w83793.c
> @@ -1551,9 +1551,6 @@ static int w83793_remove(struct i2c_client *client)
>  	for (i = 0; i < ARRAY_SIZE(w83793_temp); i++)
>  		device_remove_file(dev, &w83793_temp[i].dev_attr);
>  
> -	i2c_unregister_device(data->lm75[0]);
> -	i2c_unregister_device(data->lm75[1]);
> -
>  	/* Decrease data reference counter */
>  	mutex_lock(&watchdog_data_mutex);
>  	kref_put(&data->kref, w83793_release_resources);
> @@ -1565,7 +1562,7 @@ static int w83793_remove(struct i2c_client *client)
>  static int
>  w83793_detect_subclients(struct i2c_client *client)
>  {
> -	int i, id, err;
> +	int i, id;
>  	int address = client->addr;
>  	u8 tmp;
>  	struct i2c_adapter *adapter = client->adapter;
> @@ -1580,8 +1577,7 @@ w83793_detect_subclients(struct i2c_client *client)
>  					"invalid subclient "
>  					"address %d; must be 0x48-0x4f\n",
>  					force_subclients[i]);
> -				err = -EINVAL;
> -				goto ERROR_SC_0;
> +				return -EINVAL;
>  			}
>  		}
>  		w83793_write_value(client, W83793_REG_I2C_SUBADDR,
> @@ -1591,28 +1587,21 @@ w83793_detect_subclients(struct i2c_client *client)
>  
>  	tmp = w83793_read_value(client, W83793_REG_I2C_SUBADDR);
>  	if (!(tmp & 0x08))
> -		data->lm75[0] = i2c_new_dummy(adapter, 0x48 + (tmp & 0x7));
> +		data->lm75[0] = devm_i2c_new_dummy_device(&client->dev, adapter,
> +							  0x48 + (tmp & 0x7));
>  	if (!(tmp & 0x80)) {
> -		if ((data->lm75[0] != NULL)
> +		if (!IS_ERR(data->lm75[0])
>  		    && ((tmp & 0x7) == ((tmp >> 4) & 0x7))) {
>  			dev_err(&client->dev,
>  				"duplicate addresses 0x%x, "
>  				"use force_subclients\n", data->lm75[0]->addr);
> -			err = -ENODEV;
> -			goto ERROR_SC_1;
> +			return -ENODEV;
>  		}
> -		data->lm75[1] = i2c_new_dummy(adapter,
> -					      0x48 + ((tmp >> 4) & 0x7));
> +		data->lm75[1] = devm_i2c_new_dummy_device(&client->dev, adapter,
> +							  0x48 + ((tmp >> 4) & 0x7));
>  	}
>  
>  	return 0;
> -
> -	/* Undo inits in case of errors */
> -
> -ERROR_SC_1:
> -	i2c_unregister_device(data->lm75[0]);
> -ERROR_SC_0:
> -	return err;
>  }
>  
>  /* Return 0 if detection is successful, -ENODEV otherwise */
> @@ -1945,9 +1934,6 @@ static int w83793_probe(struct i2c_client *client,
>  
>  	for (i = 0; i < ARRAY_SIZE(w83793_temp); i++)
>  		device_remove_file(dev, &w83793_temp[i].dev_attr);
> -
> -	i2c_unregister_device(data->lm75[0]);
> -	i2c_unregister_device(data->lm75[1]);
>  free_mem:
>  	kfree(data);
>  exit:
> -- 
> 2.20.1
> 

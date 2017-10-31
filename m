From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v1 11/15] hwmon: (w83792d) Remove duplicate NULL check
Date: Tue, 31 Oct 2017 20:32:33 +0100
Message-ID: <20171031203233.25a5daac@endymion>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
        <20171031142149.32512-11-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20171031142149.32512-11-andriy.shevchenko@linux.intel.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 31 Oct 2017 16:21:45 +0200, Andy Shevchenko wrote:
> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hwmon/w83792d.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
> index d764602d70db..76aa39e537e0 100644
> --- a/drivers/hwmon/w83792d.c
> +++ b/drivers/hwmon/w83792d.c
> @@ -981,8 +981,7 @@ w83792d_detect_subclients(struct i2c_client *new_client)
>  /* Undo inits in case of errors */
>  
>  ERROR_SC_1:
> -	if (data->lm75[0] != NULL)
> -		i2c_unregister_device(data->lm75[0]);
> +	i2c_unregister_device(data->lm75[0]);
>  ERROR_SC_0:
>  	return err;
>  }
> @@ -1456,10 +1455,8 @@ w83792d_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	for (i = 0; i < ARRAY_SIZE(w83792d_group_fan); i++)
>  		sysfs_remove_group(&dev->kobj, &w83792d_group_fan[i]);
>  exit_i2c_unregister:
> -	if (data->lm75[0] != NULL)
> -		i2c_unregister_device(data->lm75[0]);
> -	if (data->lm75[1] != NULL)
> -		i2c_unregister_device(data->lm75[1]);
> +	i2c_unregister_device(data->lm75[0]);
> +	i2c_unregister_device(data->lm75[1]);
>  	return err;
>  }
>  
> @@ -1475,10 +1472,8 @@ w83792d_remove(struct i2c_client *client)
>  		sysfs_remove_group(&client->dev.kobj,
>  				   &w83792d_group_fan[i]);
>  
> -	if (data->lm75[0] != NULL)
> -		i2c_unregister_device(data->lm75[0]);
> -	if (data->lm75[1] != NULL)
> -		i2c_unregister_device(data->lm75[1]);
> +	i2c_unregister_device(data->lm75[0]);
> +	i2c_unregister_device(data->lm75[1]);
>  
>  	return 0;
>  }

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

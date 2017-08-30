From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v3 3/3] eeprom: at24: enable runtime pm support
Date: Wed, 30 Aug 2017 10:53:30 +0300
Message-ID: <20170830075329.cyhzitpfwojq3aox@valkosipuli.retiisi.org.uk>
References: <1504066266-30051-1-git-send-email-divagar.mohandass@intel.com>
 <1504066266-30051-4-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504066266-30051-4-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com
List-Id: linux-i2c@vger.kernel.org

Hi Divagar,

Thanks for the update. A few more comments below.

On Wed, Aug 30, 2017 at 09:41:06AM +0530, Divagar Mohandass wrote:
> Currently the device is kept in D0, there is an opportunity
> to save power by enabling runtime pm.
> 
> Device can be daisy chained from PMIC and we can't rely on I2C core
> for auto resume/suspend. Driver will decide when to resume/suspend.
> 
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
> ---
>  drivers/misc/eeprom/at24.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2199c42..a670814 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -24,6 +24,7 @@
>  #include <linux/i2c.h>
>  #include <linux/nvmem-provider.h>
>  #include <linux/platform_data/at24.h>
> +#include <linux/pm_runtime.h>
>  
>  /*
>   * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
> @@ -501,11 +502,22 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
>  static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>  {
>  	struct at24_data *at24 = priv;
> +	struct i2c_client *client;
>  	char *buf = val;
> +	int ret;
>  
>  	if (unlikely(!count))
>  		return count;
>  
> +	client = at24_translate_offset(at24, &off);
> +
> +	ret = pm_runtime_get_sync(&client->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(&client->dev);
> +		pm_runtime_put(&client->dev);

Two puts are too much here. How about dropping this one?

> +		return ret;
> +	}
> +
>  	/*
>  	 * Read data from chip, protecting against concurrent updates
>  	 * from this host, but not from other I2C masters.

If an error happens between the two chunks, you'll need pm_runtime_put(),
too.

> @@ -527,17 +539,30 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>  
>  	mutex_unlock(&at24->lock);
>  
> +	pm_runtime_put(&client->dev);
> +
>  	return 0;
>  }
>  
>  static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>  {
>  	struct at24_data *at24 = priv;
> +	struct i2c_client *client;
>  	char *buf = val;
> +	int ret;
>  
>  	if (unlikely(!count))
>  		return -EINVAL;
>  
> +	client = at24_translate_offset(at24, &off);
> +
> +	ret = pm_runtime_get_sync(&client->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(&client->dev);
> +		pm_runtime_put(&client->dev);

Same here.

> +		return ret;
> +	}
> +
>  	/*
>  	 * Write data to chip, protecting against concurrent updates
>  	 * from this host, but not from other I2C masters.

Ditto.

> @@ -559,6 +584,8 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>  
>  	mutex_unlock(&at24->lock);
>  
> +	pm_runtime_put(&client->dev);
> +
>  	return 0;
>  }
>  
> @@ -743,6 +770,15 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	i2c_set_clientdata(client, at24);
>  
> +	/* enable runtime pm */
> +	pm_runtime_get_noresume(&client->dev);
> +	err = pm_runtime_set_active(&client->dev);
> +	if (err < 0)
> +		goto err_clients;
> +
> +	pm_runtime_enable(&client->dev);
> +	pm_runtime_put(&client->dev);
> +

You're just about to perform a read here. I believe you should move the
last put after that.

>  	/*
>  	 * Perform a one-byte test read to verify that the
>  	 * chip is functional.
> @@ -810,6 +846,9 @@ static int at24_remove(struct i2c_client *client)
>  	for (i = 1; i < at24->num_addresses; i++)
>  		i2c_unregister_device(at24->client[i]);
>  
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +
>  	return 0;
>  }
>  

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi

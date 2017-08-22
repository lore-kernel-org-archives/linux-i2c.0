From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 3/3] eeprom: at24: enable runtime pm support
Date: Tue, 22 Aug 2017 11:55:56 +0300
Message-ID: <20170822085555.o4tqwxpa5ukgwet5@valkosipuli.retiisi.org.uk>
References: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
 <1502736119-32084-4-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:44700 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932205AbdHVIz7 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 22 Aug 2017 04:55:59 -0400
Content-Disposition: inline
In-Reply-To: <1502736119-32084-4-git-send-email-divagar.mohandass@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com

Hi Divagar,

Thanks for the patch. Please see my comments below.

On Tue, Aug 15, 2017 at 12:11:59AM +0530, Divagar Mohandass wrote:
> Currently the device is kept in D0, there is an opportunity
> to save power by enabling runtime pm.
> 
> Device can be daisy chained from PMIC and we can't rely on I2C core
> for auto resume/suspend. Driver will decide when to resume/suspend.
> 
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
> ---
>  drivers/misc/eeprom/at24.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2199c42..0d26681 100644
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
> @@ -501,11 +502,21 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
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
> +		return ret;
> +	}
> +

at24_read() may fail between the two chunks here. You'll need
pm_runtime_put() before returning the error code.

>  	/*
>  	 * Read data from chip, protecting against concurrent updates
>  	 * from this host, but not from other I2C masters.
> @@ -527,17 +538,29 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
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
> +		return ret;
> +	}
> +
>  	/*
>  	 * Write data to chip, protecting against concurrent updates
>  	 * from this host, but not from other I2C masters.

Ditto for write.

> @@ -559,6 +582,8 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>  
>  	mutex_unlock(&at24->lock);
>  
> +	pm_runtime_put(&client->dev);
> +
>  	return 0;
>  }
>  
> @@ -743,6 +768,13 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	i2c_set_clientdata(client, at24);
>  
> +	/* enable runtime pm */
> +	err = pm_runtime_set_active(&client->dev);
> +	if (err < 0)
> +		goto err_clients;
> +
> +	pm_runtime_enable(&client->dev);
> +

Here, too: at24_read() below can fail, as well as nvmem_register().

>  	/*
>  	 * Perform a one-byte test read to verify that the
>  	 * chip is functional.
> @@ -810,6 +842,8 @@ static int at24_remove(struct i2c_client *client)
>  	for (i = 1; i < at24->num_addresses; i++)
>  		i2c_unregister_device(at24->client[i]);
>  
> +	pm_runtime_disable(&client->dev);

pm_runtime_set_suspended(&client->dev)

> +
>  	return 0;
>  }
>  

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi

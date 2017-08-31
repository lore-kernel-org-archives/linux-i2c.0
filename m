From: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v4 3/3] eeprom: at24: enable runtime pm support
Date: Thu, 31 Aug 2017 11:24:38 +0000
Message-ID: <7B8CE47BD58441468D2BB13285B50E6031DE6BFC@BGSMSX107.gar.corp.intel.com>
References: <1504112740-14072-1-git-send-email-divagar.mohandass@intel.com>
 <1504112740-14072-4-git-send-email-divagar.mohandass@intel.com>
 <20170830211938.3m4xdwlfq5yozymq@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830211938.3m4xdwlfq5yozymq-S+BSfZ9RZZmRSg0ZkenSGLdO1Tsj/99ntUK59QYPAWc@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sakari,

Thanks for the review.
My comments below.

---
^Divagar

>-----Original Message-----
>From: Sakari Ailus [mailto:sakari.ailus-X3B1VOXEql0@public.gmane.org]
>Sent: Thursday, August 31, 2017 2:50 AM
>To: Mohandass, Divagar <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org;
>devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>Subject: Re: [PATCH v4 3/3] eeprom: at24: enable runtime pm support
>
>Hi Divagar,
>
>Thanks for the update.
>
>On Wed, Aug 30, 2017 at 10:35:40PM +0530, Divagar Mohandass wrote:
>> Currently the device is kept in D0, there is an opportunity to save
>> power by enabling runtime pm.
>>
>> Device can be daisy chained from PMIC and we can't rely on I2C core
>> for auto resume/suspend. Driver will decide when to resume/suspend.
>>
>> Signed-off-by: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/misc/eeprom/at24.c | 40
>> ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 2199c42..65a7d83 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/i2c.h>
>>  #include <linux/nvmem-provider.h>
>>  #include <linux/platform_data/at24.h>
>> +#include <linux/pm_runtime.h>
>>
>>  /*
>>   * I2C EEPROMs from most vendors are inexpensive and mostly
>interchangeable.
>> @@ -501,11 +502,21 @@ static ssize_t at24_eeprom_write_i2c(struct
>> at24_data *at24, const char *buf,  static int at24_read(void *priv,
>> unsigned int off, void *val, size_t count)  {
>>  	struct at24_data *at24 = priv;
>> +	struct i2c_client *client;
>>  	char *buf = val;
>> +	int ret;
>>
>>  	if (unlikely(!count))
>>  		return count;
>>
>> +	client = at24_translate_offset(at24, &off);
>> +
>> +	ret = pm_runtime_get_sync(&client->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(&client->dev);
>> +		return ret;
>> +	}
>> +
>>  	/*
>>  	 * Read data from chip, protecting against concurrent updates
>>  	 * from this host, but not from other I2C masters.
>> @@ -518,6 +529,7 @@ static int at24_read(void *priv, unsigned int off,
>void *val, size_t count)
>>  		status = at24->read_func(at24, buf, off, count);
>>  		if (status < 0) {
>>  			mutex_unlock(&at24->lock);
>> +			pm_runtime_put(&client->dev);
>>  			return status;
>>  		}
>>  		buf += status;
>> @@ -527,17 +539,29 @@ static int at24_read(void *priv, unsigned int
>> off, void *val, size_t count)
>>
>>  	mutex_unlock(&at24->lock);
>>
>> +	pm_runtime_put(&client->dev);
>> +
>>  	return 0;
>>  }
>>
>>  static int at24_write(void *priv, unsigned int off, void *val, size_t
>> count)  {
>>  	struct at24_data *at24 = priv;
>> +	struct i2c_client *client;
>>  	char *buf = val;
>> +	int ret;
>>
>>  	if (unlikely(!count))
>>  		return -EINVAL;
>>
>> +	client = at24_translate_offset(at24, &off);
>> +
>> +	ret = pm_runtime_get_sync(&client->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(&client->dev);
>> +		return ret;
>> +	}
>> +
>>  	/*
>>  	 * Write data to chip, protecting against concurrent updates
>>  	 * from this host, but not from other I2C masters.
>> @@ -550,6 +574,7 @@ static int at24_write(void *priv, unsigned int off,
>void *val, size_t count)
>>  		status = at24->write_func(at24, buf, off, count);
>>  		if (status < 0) {
>>  			mutex_unlock(&at24->lock);
>> +			pm_runtime_put(&client->dev);
>>  			return status;
>>  		}
>>  		buf += status;
>> @@ -559,6 +584,8 @@ static int at24_write(void *priv, unsigned int
>> off, void *val, size_t count)
>>
>>  	mutex_unlock(&at24->lock);
>>
>> +	pm_runtime_put(&client->dev);
>> +
>>  	return 0;
>>  }
>>
>> @@ -743,6 +770,14 @@ static int at24_probe(struct i2c_client *client,
>> const struct i2c_device_id *id)
>>
>>  	i2c_set_clientdata(client, at24);
>>
>> +	/* enable runtime pm */
>> +	pm_runtime_get_noresume(&client->dev);
>> +	err = pm_runtime_set_active(&client->dev);
>> +	if (err < 0)
>> +		goto err_clients;
>
>Btw. I don't think pm_runtime_set_active() can fail here. In other words it'd be
>fine to ignore the return value.
>

Ack


>> +
>> +	pm_runtime_enable(&client->dev);
>> +
>>  	/*
>>  	 * Perform a one-byte test read to verify that the
>>  	 * chip is functional.
>> @@ -753,6 +788,8 @@ static int at24_probe(struct i2c_client *client, const
>struct i2c_device_id *id)
>>  		goto err_clients;
>
>I suppose the runtime PM state is re-initialised for a device when a driver is
>probed, but it'd still be nice to decrement the use count if this fails.

Ack

>You should also disable PM runtime if probe fails and set the device
>suspended again.
>
>Same for other error cases. I think you'll need a new label.
>

Can I disable PM runtime and set suspend in the 'err_clients' label itself ?

>>  	}
>>
>> +	pm_runtime_put(&client->dev);
>> +
>>  	at24->nvmem_config.name = dev_name(&client->dev);
>>  	at24->nvmem_config.dev = &client->dev;
>>  	at24->nvmem_config.read_only = !writable; @@ -810,6 +847,9 @@
>static
>> int at24_remove(struct i2c_client *client)
>>  	for (i = 1; i < at24->num_addresses; i++)
>>  		i2c_unregister_device(at24->client[i]);
>>
>> +	pm_runtime_disable(&client->dev);
>> +	pm_runtime_set_suspended(&client->dev);
>> +
>>  	return 0;
>>  }
>>
>
>--
>Regards,
>
>Sakari Ailus
>e-mail: sakari.ailus-X3B1VOXEql0@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

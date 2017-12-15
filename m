From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 1/3] i2c: core: improve return value handling of
 i2c_new_device and i2c_new_dummy
Date: Fri, 15 Dec 2017 23:28:19 +0100
Message-ID: <0762ad3d-75d8-8dbd-fc7f-50eacab279e4@gmail.com>
References: <083569b1-489a-d84f-1a87-bca52fad53e1@gmail.com>
 <8d2c0c10-e308-d038-4b68-e030404abe26@gmail.com>
 <CAMRc=MckcJxNOGyRnhfwKktxn_k6ANXw2OS2os6XxuCxbf5OrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MckcJxNOGyRnhfwKktxn_k6ANXw2OS2os6XxuCxbf5OrQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Am 15.12.2017 um 23:02 schrieb Bartosz Golaszewski:
> 2017-12-15 18:43 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
>> Currently i2c_new_device and i2c_new_dummy return just NULL in error
>> case although they have more error details internally. Therefore move
>> the functionality into new functions returning detailed errors and
>> add wrappers for compatibilty with the current API.
>>
>> This allows to use these functions with detailed error codes within
>> the i2c core or for API extensions.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
> 
> Hi Heiner,
> 
> I only Reviewed-by this patch, not the whole series. I always
> explicitly state it if I do. Patch 3/3 looks good but since it's at24,
> it's probably going to go through my tree anyway (possibly with the
> rest of this series), so no need for the tag.
> 
Sorry, I misunderstood you here.

>> ---
>> v3:
>> - prefix i2c_new_device and i2c_new_dummy with two underscores
>>   instead one
>> v4:
>> - add missing kernel doc
>> - add reviewed-by
>> ---
>>  drivers/i2c/i2c-core-base.c | 70 ++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 57 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
>> index bb34a5d41..3b962456c 100644
>> --- a/drivers/i2c/i2c-core-base.c
>> +++ b/drivers/i2c/i2c-core-base.c
>> @@ -656,7 +656,7 @@ static int i2c_dev_irq_from_resources(const struct resource *resources,
>>  }
>>
>>  /**
>> - * i2c_new_device - instantiate an i2c device
>> + * __i2c_new_device - instantiate an i2c device
>>   * @adap: the adapter managing the device
>>   * @info: describes one I2C device; bus_num is ignored
>>   * Context: can sleep
>> @@ -669,17 +669,17 @@ static int i2c_dev_irq_from_resources(const struct resource *resources,
>>   * before any i2c_adapter could exist.
>>   *
>>   * This returns the new i2c client, which may be saved for later use with
>> - * i2c_unregister_device(); or NULL to indicate an error.
>> + * i2c_unregister_device(); or an ERR_PTR to indicate an error.
>>   */
>> -struct i2c_client *
>> -i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>> +static struct i2c_client *
>> +__i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>>  {
>>         struct i2c_client       *client;
>>         int                     status;
>>
>>         client = kzalloc(sizeof *client, GFP_KERNEL);
>>         if (!client)
>> -               return NULL;
>> +               return ERR_PTR(-ENOMEM);
>>
>>         client->adapter = adap;
>>
>> @@ -746,7 +746,29 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>>                 client->name, client->addr, status);
>>  out_err_silent:
>>         kfree(client);
>> -       return NULL;
>> +       return ERR_PTR(status);
>> +}
>> +
>> +/**
>> + * i2c_new_device - instantiate an i2c device
>> + * @adap: the adapter managing the device
>> + * @info: describes one I2C device; bus_num is ignored
>> + * Context: can sleep
>> + *
>> + * This function has the same functionality like __i2_new_device, it just
>> + * returns NULL instead of an ERR_PTR in case of an error for compatibility
>> + * with current I2C API.
>> + *
>> + * This returns the new i2c client, which may be saved for later use with
>> + * i2c_unregister_device(); or NULL to indicate an error.
>> + */
>> +struct i2c_client *
>> +i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>> +{
>> +       struct i2c_client *ret;
>> +
>> +       ret = __i2c_new_device(adap, info);
>> +       return IS_ERR(ret) ? NULL : ret;
>>  }
>>  EXPORT_SYMBOL_GPL(i2c_new_device);
>>
>> @@ -793,7 +815,7 @@ static struct i2c_driver dummy_driver = {
>>  };
>>
>>  /**
>> - * i2c_new_dummy - return a new i2c device bound to a dummy driver
>> + * __i2c_new_dummy - return a new i2c device bound to a dummy driver
>>   * @adapter: the adapter managing the device
>>   * @address: seven bit address to be used
>>   * Context: can sleep
>> @@ -808,15 +830,37 @@ static struct i2c_driver dummy_driver = {
>>   * different driver.
>>   *
>>   * This returns the new i2c client, which should be saved for later use with
>> - * i2c_unregister_device(); or NULL to indicate an error.
>> + * i2c_unregister_device(); or an ERR_PTR to indicate an error.
>>   */
>> -struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
>> +static struct i2c_client *
>> +__i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
>>  {
>>         struct i2c_board_info info = {
>>                 I2C_BOARD_INFO("dummy", address),
>>         };
>>
>> -       return i2c_new_device(adapter, &info);
>> +       return __i2c_new_device(adapter, &info);
>> +}
>> +
>> +/**
>> + * i2c_new_dummy - return a new i2c device bound to a dummy driver
>> + * @adapter: the adapter managing the device
>> + * @address: seven bit address to be used
>> + * Context: can sleep
>> + *
>> + * This function has the same functionality like __i2_new_dummy, it just
>> + * returns NULL instead of an ERR_PTR in case of an error for compatibility
>> + * with current I2C API.
>> + *
>> + * This returns the new i2c client, which should be saved for later use with
>> + * i2c_unregister_device(); or an ERR_PTR to indicate an error.
> 
> You're contradicting the previous paragraph here.
> 
Right, copy & paste error ..

> Thanks,
> Bartosz
> 
>> + */
>> +struct i2c_client *i2c_new_dummy(struct i2c_adapter *adapter, u16 address)
>> +{
>> +       struct i2c_client *ret;
>> +
>> +       ret = __i2c_new_dummy(adapter, address);
>> +       return IS_ERR(ret) ? NULL : ret;
>>  }
>>  EXPORT_SYMBOL_GPL(i2c_new_dummy);
>>
>> @@ -939,9 +983,9 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
>>                 info.flags |= I2C_CLIENT_SLAVE;
>>         }
>>
>> -       client = i2c_new_device(adap, &info);
>> -       if (!client)
>> -               return -EINVAL;
>> +       client = __i2c_new_device(adap, &info);
>> +       if (IS_ERR(client))
>> +               return PTR_ERR(client);
>>
>>         /* Keep track of the added device */
>>         mutex_lock(&adap->userspace_clients_lock);
>> --
>> 2.15.1
>>
>>
> 

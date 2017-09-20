From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
Date: Wed, 20 Sep 2017 12:56:09 +0900
Message-ID: <CAAFQd5DUNHJ7fqWy5iD_fb=TBUqGy3AQ3uGXr-TdQ5v39f_hsw@mail.gmail.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
 <1504520928-5191-4-git-send-email-divagar.mohandass@intel.com> <6F87890CF0F5204F892DEA1EF0D77A5972FC1278@FMSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6F87890CF0F5204F892DEA1EF0D77A5972FC1278-XfjTATA9Em864kNsxIetb7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Mani, Rajmohan" <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Mohandass, Divagar" <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "sakari.ailus-X3B1VOXEql0@public.gmane.org" <sakari.ailus-X3B1VOXEql0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks Raj.

Let me post my comments inline.

On Wed, Sep 20, 2017 at 12:52 PM, Mani, Rajmohan
<rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Adding Tomasz...
>
>> -----Original Message-----
>> From: Mohandass, Divagar
>> Sent: Monday, September 04, 2017 3:29 AM
>> To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org;
>> sakari.ailus-X3B1VOXEql0@public.gmane.org
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mani, Rajmohan <rajmohan.mani-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>;
>> Mohandass, Divagar <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Subject: [PATCH v6 3/3] eeprom: at24: enable runtime pm support
>>
>> Currently the device is kept in D0, there is an opportunity to save power by
>> enabling runtime pm.
>>
>> Device can be daisy chained from PMIC and we can't rely on I2C core for auto
>> resume/suspend. Driver will decide when to resume/suspend.
>>
>> Signed-off-by: Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/misc/eeprom/at24.c | 38
>> ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c index
>> 2199c42..d718a7a 100644
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
>> interchangeable.
>> @@ -501,11 +502,21 @@ static ssize_t at24_eeprom_write_i2c(struct
>> at24_data *at24, const char *buf,  static int at24_read(void *priv, unsigned int
>> off, void *val, size_t count)  {
>>       struct at24_data *at24 = priv;
>> +     struct i2c_client *client;
>>       char *buf = val;
>> +     int ret;
>>
>>       if (unlikely(!count))
>>               return count;
>>
>> +     client = at24_translate_offset(at24, &off);
>> +
>> +     ret = pm_runtime_get_sync(&client->dev);
>> +     if (ret < 0) {
>> +             pm_runtime_put_noidle(&client->dev);
>> +             return ret;
>> +     }
>> +
>>       /*
>>        * Read data from chip, protecting against concurrent updates
>>        * from this host, but not from other I2C masters.
>> @@ -518,6 +529,7 @@ static int at24_read(void *priv, unsigned int off, void
>> *val, size_t count)
>>               status = at24->read_func(at24, buf, off, count);
>>               if (status < 0) {
>>                       mutex_unlock(&at24->lock);
>> +                     pm_runtime_put(&client->dev);
>>                       return status;
>>               }
>>               buf += status;
>> @@ -527,17 +539,29 @@ static int at24_read(void *priv, unsigned int off, void
>> *val, size_t count)
>>
>>       mutex_unlock(&at24->lock);
>>
>> +     pm_runtime_put(&client->dev);
>> +
>>       return 0;
>>  }
>>
>>  static int at24_write(void *priv, unsigned int off, void *val, size_t count)  {
>>       struct at24_data *at24 = priv;
>> +     struct i2c_client *client;
>>       char *buf = val;
>> +     int ret;
>>
>>       if (unlikely(!count))
>>               return -EINVAL;
>>
>> +     client = at24_translate_offset(at24, &off);
>> +
>> +     ret = pm_runtime_get_sync(&client->dev);
>> +     if (ret < 0) {
>> +             pm_runtime_put_noidle(&client->dev);
>> +             return ret;
>> +     }
>> +
>>       /*
>>        * Write data to chip, protecting against concurrent updates
>>        * from this host, but not from other I2C masters.
>> @@ -550,6 +574,7 @@ static int at24_write(void *priv, unsigned int off, void
>> *val, size_t count)
>>               status = at24->write_func(at24, buf, off, count);
>>               if (status < 0) {
>>                       mutex_unlock(&at24->lock);
>> +                     pm_runtime_put(&client->dev);
>>                       return status;
>>               }
>>               buf += status;
>> @@ -559,6 +584,8 @@ static int at24_write(void *priv, unsigned int off, void
>> *val, size_t count)
>>
>>       mutex_unlock(&at24->lock);
>>
>> +     pm_runtime_put(&client->dev);
>> +
>>       return 0;
>>  }
>>
>> @@ -743,11 +770,17 @@ static int at24_probe(struct i2c_client *client, const
>> struct i2c_device_id *id)
>>
>>       i2c_set_clientdata(client, at24);
>>
>> +     /* enable runtime pm */
>> +     pm_runtime_get_noresume(&client->dev);
>> +     pm_runtime_set_active(&client->dev);
>> +     pm_runtime_enable(&client->dev);

Do we need this get_noresume/set_active dance? I remember it was for
some reason needed for PCI devices, but I don't see why for I2C
anything else than just pm_runtime_enable() would be necessary.

Also, we enable runtime PM, but we don't provide any callbacks. If
there is no callback in any level of the hierarchy, NULL would be
returned in [3], making [2] return -ENOSYS and [1] fail. The behavior
depends on subsystem and whether the device is attached to a
pm_domain. In our particular case I'd guess the device would be in an
ACPI pm_domain and that would work, but the driver is generic and must
work in any cases.

[1] http://elixir.free-electrons.com/linux/v4.4.88/source/drivers/base/power/runtime.c#L738
[2] http://elixir.free-electrons.com/linux/v4.4.88/source/drivers/base/power/runtime.c#L364
[3] http://elixir.free-electrons.com/linux/v4.4.88/source/drivers/base/power/runtime.c#L19

Best regards,
Tomasz
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2] eeprom: at24: fix I2C device selection for runtime PM
Date: Sun, 3 Dec 2017 20:59:57 +0100
Message-ID: <CAMRc=MftF4Kf2NSHcWWDSUmv=P-zhaCqcdeLLNFAxTLj17A8UQ@mail.gmail.com>
References: <1512153432-491-1-git-send-email-svendev@arcx.com> <20171202144837.mmnv5i2dyzg72xwf@kekkonen.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171202144837.mmnv5i2dyzg72xwf@kekkonen.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Sven Van Asbroeck <svendev@arcx.com>, linux-kernel@vger.kernel.org, linux-i2c <linux-i2c@vger.kernel.org>, divagar.mohandass@intel.com
List-Id: linux-i2c@vger.kernel.org

2017-12-02 15:48 GMT+01:00 Sakari Ailus <sakari.ailus@linux.intel.com>:
> Hi,
>
> On Fri, Dec 01, 2017 at 01:37:12PM -0500, Sven Van Asbroeck wrote:
>> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>>
>> The at24 driver creates dummy I2C devices to access offsets in the chip
>> that are outside the area supported using a single I2C address. It is not
>> meaningful to use runtime PM to such devices; the system firmware (ACPI)
>> does not know about these devices nor runtime PM was enabled for them.
>> Always use the real device instead of the dummy ones.
>>
>> Fixes: 98e8201039af ("eeprom: at24: enable runtime pm support")
>> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Tested-by: Sven Van Asbroeck on a 24AA16/24LC16B <svendev@arcx.com>
>> [Bartosz: rebased on top of previous fixes for 4.15, tweaked the
>>           commit message]
>> [Sven: fixed Bartosz's rebase]
>> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> I presume this is the final one. Yeah, the client variable was effectively
> unused in the earlier version. Seems good to me.
>
>> ---
>>  drivers/misc/eeprom/at24.c | 24 ++++++++++--------------
>>  1 file changed, 10 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 305a7a4..20b4f26 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -562,7 +562,7 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
>>  static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>>  {
>>       struct at24_data *at24 = priv;
>> -     struct i2c_client *client;
>> +     struct device *dev = &at24->client[0]->dev;
>>       char *buf = val;
>>       int ret;
>>
>> @@ -572,11 +572,9 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>>       if (off + count > at24->chip.byte_len)
>>               return -EINVAL;
>>
>> -     client = at24_translate_offset(at24, &off);
>> -
>> -     ret = pm_runtime_get_sync(&client->dev);
>> +     ret = pm_runtime_get_sync(dev);
>>       if (ret < 0) {
>> -             pm_runtime_put_noidle(&client->dev);
>> +             pm_runtime_put_noidle(dev);
>>               return ret;
>>       }
>>
>> @@ -592,7 +590,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>>               status = at24->read_func(at24, buf, off, count);
>>               if (status < 0) {
>>                       mutex_unlock(&at24->lock);
>> -                     pm_runtime_put(&client->dev);
>> +                     pm_runtime_put(dev);
>>                       return status;
>>               }
>>               buf += status;
>> @@ -602,7 +600,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>>
>>       mutex_unlock(&at24->lock);
>>
>> -     pm_runtime_put(&client->dev);
>> +     pm_runtime_put(dev);
>>
>>       return 0;
>>  }
>> @@ -610,7 +608,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>>  static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>>  {
>>       struct at24_data *at24 = priv;
>> -     struct i2c_client *client;
>> +     struct device *dev = &at24->client[0]->dev;
>>       char *buf = val;
>>       int ret;
>>
>> @@ -620,11 +618,9 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>>       if (off + count > at24->chip.byte_len)
>>               return -EINVAL;
>>
>> -     client = at24_translate_offset(at24, &off);
>> -
>> -     ret = pm_runtime_get_sync(&client->dev);
>> +     ret = pm_runtime_get_sync(dev);
>>       if (ret < 0) {
>> -             pm_runtime_put_noidle(&client->dev);
>> +             pm_runtime_put_noidle(dev);
>>               return ret;
>>       }
>>
>> @@ -640,7 +636,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>>               status = at24->write_func(at24, buf, off, count);
>>               if (status < 0) {
>>                       mutex_unlock(&at24->lock);
>> -                     pm_runtime_put(&client->dev);
>> +                     pm_runtime_put(dev);
>>                       return status;
>>               }
>>               buf += status;
>> @@ -650,7 +646,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>>
>>       mutex_unlock(&at24->lock);
>>
>> -     pm_runtime_put(&client->dev);
>> +     pm_runtime_put(dev);
>>
>>       return 0;
>>  }
>> --
>> 1.9.1
>>
>
> --
> Sakari Ailus
> sakari.ailus@linux.intel.com

Sven informed me in private that the bug was actually triggered by a
HW issue on the board he was using and not the code itself, but I
believe this fix makes sense nevertheless, so I queued it for
4.15-rc3. Thanks!

Bartosz

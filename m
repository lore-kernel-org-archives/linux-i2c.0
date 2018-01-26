From: =?UTF-8?Q?Johannes_P=c3=b6hlmann?= <johannes.poehlmann@izt-labs.de>
Subject: Model is M24M01-D* ( was [PATCH alpha] eeprom: at24: new DT property
 "address-width")
Date: Fri, 26 Jan 2018 11:13:07 +0100
Message-ID: <7c3a9b70-a04b-464e-2632-b0d757f780e1@izt-labs.de>
References: <20180125134016.GA21654@ppcx2.izt.loc>
 <CAMRc=MdvhkZaMnR_G8UERdRgDa_8GchrrVUgwEE04aMMHtBOAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.izt-labs.de ([82.135.25.162]:59750 "EHLO mail.izt-labs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751738AbeAZKNS (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Jan 2018 05:13:18 -0500
In-Reply-To: <CAMRc=MdvhkZaMnR_G8UERdRgDa_8GchrrVUgwEE04aMMHtBOAw@mail.gmail.com>
Content-Language: de-DE
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-i2c <linux-i2c@vger.kernel.org>

Am 25.01.2018 um 17:07 schrieb Bartosz Golaszewski:
> 2018-01-25 14:40 GMT+01:00 Johannes Poehlmann <johannes.poehlmann@izt-labs.de>:
>> Hi Bartosz,
>>
>> The patch was build against recent linus master
>>    commit 5b7d27967dabfb17c21b0d98b29153b9e3ee71e5
>>    Merge: f165495 624ca9c
>>    Author: Linus Torvalds <torvalds@linux-foundation.org>
>>    Date:   Wed Jan 24 17:24:30 2018 -0800
>>
>> checkpatch.pl run to 0 Errors
>> tested on powerpc 32bit
>>
>> Any recommendations/comments ?
>>
>>
>> -------------------------------------------------------------------
>>
>> Signed-off-by: Johannes Poehlmann <johannes.poehlmann@izt-labs.de>
>>
>> needed with some eeprom chips
>> modelled after at25
>> ---
>>  .../devicetree/bindings/eeprom/eeprom.txt          |  3 +++
>>  drivers/misc/eeprom/at24.c                         | 24 ++++++++++++++++++++--
>>  2 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> index 27f2bc1..8f3293c 100644
>> --- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
>> @@ -38,10 +38,13 @@ Optional properties:
>>
>>    - size: total eeprom size in bytes
>>
>> +  - address-width : number of address bits (8 or 16)
>> +
>>  Example:
>>
>>  eeprom@52 {
>>         compatible = "atmel,24c32";
>>         reg = <0x52>;
>>         pagesize = <32>;
>> +       address-width = <16>;
>>  };
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 4d63ac8..2a6d476 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -651,11 +651,27 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>>         return 0;
>>  }
>>
>> -static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
>> +static int at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
>>  {
>>         int err;
>>         u32 val;
>>
>> +       if (device_property_read_u32(dev, "address-width", &val) == 0) {
>> +               switch (val) {
>> +               case 8:
>> +                       chip->flags &= ~AT24_FLAG_ADDR16;
>> +                       break;
>> +               case 16:
>> +                       chip->flags |= AT24_FLAG_ADDR16;
>> +                       break;
>> +               default:
>> +                       dev_err(dev,
>> +                               "Error: bad \"address-width\" property: %u\n",
>> +                               val);
>> +                       return -ENODEV;
>> +               }
>> +       }
>> +
>>         if (device_property_present(dev, "read-only"))
>>                 chip->flags |= AT24_FLAG_READONLY;
>>
>> @@ -674,6 +690,7 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
>>                  */
>>                 chip->page_size = 1;
>>         }
>> +       return 0;
>>  }
>>
>>  static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>> @@ -716,7 +733,10 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>                 magic >>= AT24_SIZE_BYTELEN;
>>                 chip.flags = magic & AT24_BITMASK(AT24_SIZE_FLAGS);
>>
>> -               at24_get_pdata(&client->dev, &chip);
>> +               err = at24_get_pdata(&client->dev, &chip);
>> +               if (err)
>> +                       return err;
>> +
>>
>>                 chip.setup = NULL;
>>                 chip.context = NULL;
>> --
>> 2.1.4
>>
> 
> What EEPROM model do you need that for? Is it not covered by all the
> standard types we already support in the driver?
> 
> Thanks,
> Bartosz
> 
Hi Bartosz,

I need this for a M24M01-D* eeprom.
(http://www.st.com/content/ccc/resource/technical/document/datasheet/group0/cb/91/ba/7d/0b/c1/4d/f6/CD00147128/files/CD00147128.pdf/jcr:content/translations/en.CD00147128.pdf)

It is 1 Mbit sized and has 2 byte addresses.

Under another I2C address it offers a additional write lockable page 
of 256 Byte, but with _2 byte addresses_. I could not correctly read 
this "second eeprom" with one of the standard eeprom at24* models. 

With the patch and using a device tree entry of 
			compatible = "at,24c02";
			address-width = <16>;
 			reg = <0x5C>; 
 			pagesize = <256>; 
gave me a 256 Byte "eeprom" file in sysfs with no errors.
 
Regards

Johannes

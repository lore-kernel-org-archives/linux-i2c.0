From: m18063 <Claudiu.Beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] drivers: misc: eeprom: at24: support reading mac
 eeprom from different addresses
Date: Wed, 5 Jul 2017 12:33:18 +0300
Message-ID: <7fa4b55d-12dd-3687-5ffc-eef96a002533@microchip.com>
References: <1498736351-9021-1-git-send-email-claudiu.beznea@microchip.com>
 <1498736351-9021-3-git-send-email-claudiu.beznea@microchip.com>
 <b67a323b-5562-1259-08f1-fa7ee3509e8b@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b67a323b-5562-1259-08f1-fa7ee3509e8b-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 29.06.2017 18:32, David Lechner wrote:
> On 06/29/2017 06:39 AM, Claudiu Beznea wrote:
>> Add support for reading from different offsets of EEPROM.
>> The offset is initialized via device tree. If nothing is
>> given as input the old value, 0x90, is used. In this way
>> the driver could be used as generic driver for different
>> vendor memories by only changing the reading offset via
>> device tree.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
>> ---
>>   drivers/misc/eeprom/at24.c         | 5 ++++-
>>   include/linux/platform_data/at24.h | 1 +
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 764ff5df..53c5fb8 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -365,7 +365,7 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
>>       memset(msg, 0, sizeof(msg));
>>       msg[0].addr = client->addr;
>>       msg[0].buf = addrbuf;
>> -    addrbuf[0] = 0x90 + offset;
>> +    addrbuf[0] = at24->chip.offset + offset;
>>       msg[0].len = 1;
>>       msg[1].addr = client->addr;
>>       msg[1].flags = I2C_M_RD;
>> @@ -581,6 +581,9 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
>>            */
>>           chip->page_size = 1;
>>       }
>> +    err = device_property_read_u8(dev, "start-offset", &chip->offset);
> 
> Why use u8 here? I have an at24 EEPROM that uses 16-bit addressing where the MAC address is stored at 0x3F06. Seems like it would be better to just use u32, then you don't have to mess with /bits/ in the device tree binding.
Agree! I will use u32 instead. It is better that way.

Thanks,
Claudiu
> 
>> +    if (err)
>> +        chip->offset = 0x90;
>>   }
>>     static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>> diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
>> index 271a4e2..d55c454 100644
>> --- a/include/linux/platform_data/at24.h
>> +++ b/include/linux/platform_data/at24.h
>> @@ -50,6 +50,7 @@ struct at24_platform_data {
>>   #define AT24_FLAG_TAKE8ADDR    BIT(4)    /* take always 8 addresses (24c00) */
>>   #define AT24_FLAG_SERIAL    BIT(3)    /* factory-programmed serial number */
>>   #define AT24_FLAG_MAC        BIT(2)    /* factory-programmed mac address */
>> +    u8        offset;
>>         void        (*setup)(struct nvmem_device *nvmem, void *context);
>>       void        *context;
>>
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

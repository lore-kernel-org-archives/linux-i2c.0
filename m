From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v4 5/7] eeprom: at24: add regmap-based read function
Date: Fri, 24 Nov 2017 19:35:31 +0200
Message-ID: <3b01676a-bc35-28ee-b406-bea45e606fa5@microchip.com>
References: <0448eec2-7dfb-ca79-d03a-d5b7fcb5d76c@gmail.com>
 <011081f7-f2af-0e78-f21b-c40493d63a70@gmail.com>
 <CAMRc=McNp=NWeGxZZfz1Xq+sxx+-X1OAFsyoEPrFTn3vaH77mQ@mail.gmail.com>
 <245157a7-bd46-9788-86e9-7058cc4c667b@gmail.com>
 <CAMRc=MetCoJBUnbTxnjjrxewoDZuKuLzosq5EVnjys2S=0J5Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62086 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751018AbdKXRfo (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 24 Nov 2017 12:35:44 -0500
In-Reply-To: <CAMRc=MetCoJBUnbTxnjjrxewoDZuKuLzosq5EVnjys2S=0J5Wg@mail.gmail.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>



On 24.11.2017 13:00, Bartosz Golaszewski wrote:
> 2017-11-23 22:31 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
>> Am 23.11.2017 um 17:40 schrieb Bartosz Golaszewski:
>>> 2017-11-22 22:12 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
>>>> Add regmap-based read function and instead of using three different
>>>> read functions (standard, mac, serial) use just one and factor out the
>>>> read offset adjustment for mac and serial to at24_adjust_read_offset.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>> v2:
>>>> - rebased
>>>> v3:
>>>> - improve readability
>>>> - re-introduce debug message
>>>> - introduce at24_adjust_read_offset
>>>> v4:
>>>> - move offset adjustment calculation to probe function
>>>> ---
>>>>  drivers/misc/eeprom/at24.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 55 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>>>> index 493e2b646..c16a9a495 100644
>>>> --- a/drivers/misc/eeprom/at24.c
>>>> +++ b/drivers/misc/eeprom/at24.c
>>>> @@ -75,6 +75,7 @@ struct at24_data {
>>>>
>>>>         unsigned write_max;
>>>>         unsigned num_addresses;
>>>> +       unsigned int offset_adj;
>>>>
>>>>         struct nvmem_config nvmem_config;
>>>>         struct nvmem_device *nvmem;
>>>> @@ -312,6 +313,36 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
>>>>         return -ETIMEDOUT;
>>>>  }
>>>>
>>>
>>> OK this looks better. The series is almost ready - just a couple more
>>> nits I'd like to see fixed and we're done.
>>>
>>>> +static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
>>>> +                               unsigned int offset, size_t count)
>>>> +{
>>>> +       unsigned long timeout, read_time;
>>>> +       struct at24_client *at24_client;
>>>> +       struct i2c_client *client;
>>>> +       struct regmap *regmap;
>>>> +       int ret;
>>>> +
>>>> +       at24_client = at24_translate_offset(at24, &offset);
>>>> +       regmap = at24_client->regmap;
>>>> +       client = at24_client->client;
>>>> +
>>>> +       if (count > io_limit)
>>>> +               count = io_limit;
>>>> +
>>>> +       /* adjust offset for mac and serial read ops */
>>>> +       offset += at24->offset_adj;
>>>
>>> Let's use '|=' here as it's safer (doesn't shift the bit if it's set
>>> in both sides).
>>>
>> To build an opinion on |= vs. += I checked the code in more detail plus
>> some datasheets, what lead to quite some question marks ..
>>
>> Major issue is that offset and size in at24_read/write are not checked
>> currently. So we completely rely on the calling subsystem (nvmem).
>> The nvmem sysfs interface does such checking. However nvmem_device_read
>> does not. So maybe the nvmem core should be changed to do checking in
>> all cases. I add Srinivas as nvmem maintainer to the conversation
>> to hear his opinion.
>>
>> If we have such checks then in general |= and += deliver the same result,
>> it's just a question of taste.
>>
>> According to the at24mac602/at24mac402 datasheet the MAC is provided at:
>> 24mac402 / EUI-48 -> position 0x9a - 0x9f
>> 24mac602 / EUI-64 -> position 0x98 - 0x9f
>>
>> Size of the 24mac402 is defined as 48 bit = 6 byte and the effective
>> offset in at24_eeprom_read_mac is 0x90 + offset provided by caller.
Moreover, if I remember good, in the initialization of the 24mac402 the
size is truncated at something which is power of 2. I don't if this is
for some historical reasons or not so that you can only read 4 bytes
instead of 6 for the EUI-48.

>> So the caller has to provide offset 0x08 to read the mac what is
>> greater than the chip size of 6 bytes.
>> So reading the mac via nvmem sysfs interface shouldn't be possible.
>>
>> I saw that you submitted the 24macx02 code, did you test the driver
>> with one of these chips and I miss something?
>>
> 
> At the time when I submitted the support for at24cs (which I had
> tested both for 8- and 16-bit addresses), Wolfram suggested that I
> include support for at24mac too, but since I don't have such a chip, I
> could not really test it. Looking at the note on page 21 of the
> relevant datasheet, it's obvious it can't work. I must have missed
> that at the time of writing the code.
> 
> Also: there's this patch[1] which looks like a workaround for this
> problem. I'm Cc'ing the author.
I tried to make this driver work for chip at [3] which EUI-48 is located at 0xfa
and providing this offset via device tree was my first option in order
to not broke the initial functionality. Anyway, the device tree approach
as not accepted at that time, the usage of another DT binding was proposed
to me at that time but I didn't found that feasible, said about it on
mailing list but I didn't received any other inputs.

> 
> @Claudiu: is that the case or do you actually have an EEPROM chip with
> the MAC at a different offset? Could you by any chance test the
> patch[2] from Heiner?
I have chip at [3] with MAC at 0xfa.

Regarding the testing of patch [2], at this moment I haven't a board
with at24mac602 EEPROM. I will come back later to this thread as soon as
I will have one. Regarding the changes, if I remember good, the
at24->chip.byte_len is truncated at something which is power of 2,
in case of 24mac402 will be 4 not 6 as expected, so it should return
only 4 LSB bytes of MAC. Other than this it looks OK from my point
of view.

Thanks,
Claudiu

[3] http://ww1.microchip.com/downloads/en/DeviceDoc/20002124G.pdf
> 
>> Most likely we would have to change the driver so that the caller can
>> read the mac from offset 0.
>>
>> Rgds, Heiner
>>
> 
> Best regards,
> Bartosz Golaszewski
> 
> [1] http://patchwork.ozlabs.org/patch/785106/
> [2] http://patchwork.ozlabs.org/patch/840958/
> 

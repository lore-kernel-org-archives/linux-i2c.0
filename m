From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2] eeprom: at24: fix reading from 24MAC402/24MAC602
Date: Mon, 27 Nov 2017 22:10:02 +0100
Message-ID: <CAMRc=Me-25icE9qvnzpOSPAOrXZta9oV2gxJhi8hVO15uAfH0g@mail.gmail.com>
References: <32cfbfe3-fdff-5165-2753-186cbe2055a4@gmail.com>
 <9f1ca504-9382-1fce-7750-433b6d5078bb@gmail.com> <15033810-5e41-57dc-43a4-3b98ec54fe6a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:43710 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdK0VKD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 16:10:03 -0500
Received: by mail-oi0-f45.google.com with SMTP id z143so7975704oia.10
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 13:10:03 -0800 (PST)
In-Reply-To: <15033810-5e41-57dc-43a4-3b98ec54fe6a@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-27 21:07 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Am 27.11.2017 um 20:59 schrieb Heiner Kallweit:
>> Am 27.11.2017 um 20:46 schrieb Heiner Kallweit:
>>> Chip datasheet mentions that word addresses other than the actual
>>> start position of the MAC delivers undefined results. So fix this.
>>> Current implementation doesn't work due to this wrong offset.
>>>
>>> Fixes: 0b813658c115 "eeprom: at24: add support for at24mac series"
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>> v2:
>>> - extended commit message
>>> ---
>>>  drivers/misc/eeprom/at24.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>>> index e0b4b36ef..00d602be7 100644
>>> --- a/drivers/misc/eeprom/at24.c
>>> +++ b/drivers/misc/eeprom/at24.c
>>> @@ -425,7 +425,8 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
>>>      memset(msg, 0, sizeof(msg));
>>>      msg[0].addr = client->addr;
>>>      msg[0].buf = addrbuf;
>>> -    addrbuf[0] = 0x90 + offset;
>>> +    /* EUI-48 starts from 0x9a, EUI-64 from 0x98 */
>>> +    addrbuf[0] = 0xa0 - at24->chip.byte_len + offset;
>>>      msg[0].len = 1;
>>>      msg[1].addr = client->addr;
>>>      msg[1].flags = I2C_M_RD;
>>>
>> Are you going to apply this patch also before my other patch series?
>> Then I will consider this too when re-basing.
>>
> To answer my own question: As long as we don't have a good enough patch
> to fix byte_len for 24mac402 this patch doesn't make sense.
>
> Then, what we could do: For stable, create a patch based on the current
> code. For next, we could replace the magic values with a proper struct
> already.
>
>
>

I'd like to merge this patch, then a fix for at24mac402 size (please
take a look at my new attempt, this time I manually adjust the value
in probe()), then your sanitization patch and then the regmap series.
The fixes will go to the fixes branch and I'll ask Wolfram to pull
them soon. The rest together with said fixes will go to the devel
branch and we'll go from there with updates for 4.16.

Does that sound ok?

Thanks,
Bartosz

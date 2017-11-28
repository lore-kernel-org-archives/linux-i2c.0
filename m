From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] eeprom: at24: correctly set the size for at24mac402
Date: Tue, 28 Nov 2017 20:39:31 +0100
Message-ID: <d1246ed7-49d2-54a5-ba50-9451d475940b@gmail.com>
References: <20171127210613.9140-1-brgl@bgdev.pl>
 <CAHp75VdAXbSK07xYfuAqgO=TW+2rv25hD7hTLOhW+D5E-J4N2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39824 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752618AbdK1Tjk (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 28 Nov 2017 14:39:40 -0500
In-Reply-To: <CAHp75VdAXbSK07xYfuAqgO=TW+2rv25hD7hTLOhW+D5E-J4N2Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Claudiu Beznea <Claudiu.Beznea@microchip.com>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org

Am 28.11.2017 um 13:09 schrieb Andy Shevchenko:
> On Mon, Nov 27, 2017 at 11:06 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> There's an ilog2() expansion in AT24_DEVICE_MAGIC() which rounds down
>> the actual size of EUI-48 byte array in at24mac402 eeproms to 4 from 6,
>> making it impossible to read it all.
>>
>> Fix it by manually adjusting the value in probe().
>>
>> This patch contains a temporary fix that is suitable for stable
>> branches. Eventually we'll probably remove the call to ilog2() while
>> converting the magic values to actual structs.
>>
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
Looks good also to me.

>> Cc: stable@vger.kernel.org
>> Fixes: 0b813658c115 ("eeprom: at24: add support for at24mac series")
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>> ---
>>  drivers/misc/eeprom/at24.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index e0b4b36ef010..783244b485cc 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -730,6 +730,16 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>                 dev_warn(&client->dev,
>>                         "page_size looks suspicious (no power of 2)!\n");
>>
>> +       /*
>> +        * REVISIT: the size of the EUI-48 byte array is 6 in at24mac402, while
>> +        * the call to ilog2() in AT24_DEVICE_MAGIC() rounds it down to 4.
>> +        *
>> +        * Eventually we'll get rid of the magic values altoghether in favor of
>> +        * real structs, but for now just manually set the right size.
>> +        */
>> +       if (chip.flags & AT24_FLAG_MAC && chip.byte_len == 4)
>> +               chip.byte_len = 6;
>> +
>>         /* Use I2C operations unless we're stuck with SMBus extensions. */
>>         if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>>                 if (chip.flags & AT24_FLAG_ADDR16)
>> --
>> 2.15.0
>>
> 
> 
> 

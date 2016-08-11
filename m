From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] eeprom: at24: check if the chip is functional in probe()
Date: Thu, 11 Aug 2016 17:09:39 +0200
Message-ID: <CAMpxmJVgvxXfdp97y-ud=35H+X13wFR22kzeLS4FnDZQ7NT2sA@mail.gmail.com>
References: <1470837257-15521-1-git-send-email-bgolaszewski@baylibre.com> <20160810140715.GB1607@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160810140715.GB1607@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

2016-08-10 16:07 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> On Wed, Aug 10, 2016 at 03:54:17PM +0200, Bartosz Golaszewski wrote:
>> The at24 driver doesn't check if the chip is functional in its probe
>> function. This leads to instantiating devices that are not physically
>> present. For example the cape EEPROMs for BeagleBone Black are defined
>> in the device tree at four addresses on i2c2, but normally only one of
>> them is present.
>>
>> If the userspace doesn't know the location in advance, it will need to
>> check if reading the nvmem attributes fails to determine which EEPROM
>> is actually there.
>>
>> Try to read a single byte in probe() and bail-out with -ENODEV if the
>> read fails.
>
> That's basically OK...
>
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  drivers/misc/eeprom/at24.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
>> index 3cdf8e1..ed1e4eb 100644
>> --- a/drivers/misc/eeprom/at24.c
>> +++ b/drivers/misc/eeprom/at24.c
>> @@ -593,6 +593,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>       struct at24_data *at24;
>>       int err;
>>       unsigned i, num_addresses;
>> +     char c;
>
> u8?
>
>>
>>       if (client->dev.platform_data) {
>>               chip = *(struct at24_platform_data *)client->dev.platform_data;
>> @@ -780,6 +781,15 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>>       if (chip.setup)
>>               chip.setup(at24->nvmem, chip.context);
>>
>> +     err = at24_read(at24, 0, &c, 1);
>
> Can't we do this before registering dummy clients and nvmem registration?
>

It should be ok for nvmem, but I'm not sure about the clients:
at24_translate_offset() will return one of the registered client
structures and though it should generally work for the first byte (it
would always be at24->client[0]), it won't be "rock solid" anymore.

Best regards,
Bartosz Golaszewski

>> +     if (err) {
>> +             dev_err(&client->dev,
>> +                     "error reading the test byte from EEPROM: %d\n", err);
>
> I don't think we should print an error in case of ENODEV.
>
>> +             nvmem_unregister(at24->nvmem);
>> +             err = -ENODEV;
>> +             goto err_clients;
>> +     }
>> +
>>       return 0;
>>
>>  err_clients:
>> --
>> 2.7.4
>>

From: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: core: add support for read commands longer than byte
Date: Mon, 10 Aug 2015 09:55:18 +0200
Message-ID: <CAKv63uuXSVJ5wa=YvhGgxnc+YsdN47jgo6EYe9Tv_KaPJ_UXnQ@mail.gmail.com>
References: <1437744042-24471-1-git-send-email-cmo@melexis.com>
 <20150809074006.GC1526@katana> <CAKv63usiWb4QgV=pnwuqFJtTogRca7UjtmiSKV69OTM2h7LtHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKv63usiWb4QgV=pnwuqFJtTogRca7UjtmiSKV69OTM2h7LtHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "Simon G. Vogl" <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10 August 2015 at 09:26, Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org> wrote:
> On 9 August 2015 at 09:40, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
>> On Fri, Jul 24, 2015 at 03:20:42PM +0200, Crt Mori wrote:
>>> If you want to send more than 1 byte as command to slave you need to go away
>>> from the smbus (which has a 8 bit command defined in specification). i2c has
>>> no such limitation in specification and since we want to have a longer than
>>> 1 byte command, we need additional function to handle it. With outside
>>> buffers we have also avoided endianness problems (if we would just define a
>>> u16 command instead of u8). Also there are now no limitations (as per i2c
>>> specification) of command length.
>>> Addressed read function is when we have a slave device which accepts commands
>>> longer than byte or some subcommands in same write string before issuing a
>>> repeat start before read cycle to read more than byte (or byte) from slave
>>> device.
>>>
>>> Signed-off-by: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
>>
>> I don't see much gain over using i2c_transfer directly to be honest. Do
>> you see much use of that in the kernel? Any other gain I missed? And if
>> at all, the function should be probably named i2c_write_then_read or
>> something.
>>
> This debate is what I wanted to have. The new Melexis sensor will be
> using it and
> since I think some others might also be using it in future I would
> rather put it to
> i2c. It is more i2c command than sensor specific so I think it fits into i2c.
>
> Another gain is that when number of functions each device does increase, as
> well as ram/rom addressing read commands with longer than 8-bit register read
> commands will be needed. Especially since most sensors have digital design of
> i2c interface (not software) which means native access to registers is required,
> therefor 8bit read addressing (smbus) might not be suitable.
>
> I can fix the function name, but in core this is a master read command.
>
For example IIO list just got the driver for ms_sensors [1] which uses the same
function. I am sure we can find more.

[1] http://www.spinics.net/lists/linux-iio/msg19925.html
>>> ---
>>>  drivers/i2c/i2c-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/i2c.h    |  4 ++++
>>>  2 files changed, 44 insertions(+)
>>>
>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>> index 069a41f..bccf83f 100644
>>> --- a/drivers/i2c/i2c-core.c
>>> +++ b/drivers/i2c/i2c-core.c
>>> @@ -2980,6 +2980,46 @@ int i2c_slave_unregister(struct i2c_client *client)
>>>  EXPORT_SYMBOL_GPL(i2c_slave_unregister);
>>>  #endif
>>>
>>> +/**
>>> + * i2c_addressed_read - writes read commands with desired length and read
>>> + * desired length of data.
>>> + * @client: Handle to slave device
>>> + * @command: Pointer to command location
>>> + * @cmd_len: Number of command bytes on command location
>>> + * @data: Pointer to read data location
>>> + * @data_len: Expected number of read bytes
>>> + *
>>> + * Addressed read on slave device when command is longer than byte. Returns
>>> + * negative errno on error and 0 on success.
>>> + */
>>> +s32 i2c_addressed_read(const struct i2c_client *client, u8 *command,
>>> +                    u16 cmd_len, u8 *data, u16 data_len)
>>> +{
>>> +     s32 status;
>>> +     struct i2c_msg msg[2] = {
>>> +             {
>>> +                     .addr = client->addr,
>>> +                     .flags = client->flags,
>>> +                     .len = cmd_len,
>>> +                     .buf = command,
>>> +             },
>>> +             {
>>> +                     .addr = client->addr,
>>> +                     .flags = client->flags | I2C_M_RD,
>>> +                     .len = data_len,
>>> +                     .buf = data,
>>> +             },
>>> +     };
>>> +
>>> +     status = i2c_transfer(client->adapter, msg, 2);
>>> +
>>> +     if (status < 0)
>>> +             return status;
>>> +
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL(i2c_addressed_read);
>>> +
>>>  MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
>>>  MODULE_DESCRIPTION("I2C-Bus main module");
>>>  MODULE_LICENSE("GPL");
>>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>>> index e83a738..d3cc1af 100644
>>> --- a/include/linux/i2c.h
>>> +++ b/include/linux/i2c.h
>>> @@ -121,6 +121,10 @@ extern s32 i2c_smbus_read_i2c_block_data(const struct i2c_client *client,
>>>  extern s32 i2c_smbus_write_i2c_block_data(const struct i2c_client *client,
>>>                                         u8 command, u8 length,
>>>                                         const u8 *values);
>>> +
>>> +s32 i2c_addressed_read(const struct i2c_client *client, u8 *command,
>>> +                    u16 cmd_len, u8 *data, u16 data_len);
>>> +
>>>  #endif /* I2C */
>>>
>>>  /**
>>> --
>>> 2.1.4
>>>

From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] i2c-stub: Avoid an array overrun on I2C block transfers
Date: Sun, 13 Jul 2014 09:42:30 -0700
Message-ID: <53C2B6F6.8030808@roeck-us.net>
References: <20140713171717.25497712@endymion.delvare>	<53C2A958.8050702@roeck-us.net> <20140713182444.4b95224d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140713182444.4b95224d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 07/13/2014 09:24 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Sun, 13 Jul 2014 08:44:24 -0700, Guenter Roeck wrote:
>> On 07/13/2014 08:17 AM, Jean Delvare wrote:
>>> I2C block transfers can have a size up to 32 bytes. If starting close
>>> to the end of the address space, there may not be enough room to write
>>> that many bytes (on I2C block writes) or not enough bytes to be read
>>> (on I2C block reads.) In that case, we must shorten the transfer so
>>> that it does not exceed the address space.
>>>
>>> Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
>>> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>>> ---
>>>    drivers/i2c/i2c-stub.c |    2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> --- linux-3.16-rc4.orig/drivers/i2c/i2c-stub.c	2014-07-12 11:56:30.933096483 +0200
>>> +++ linux-3.16-rc4/drivers/i2c/i2c-stub.c	2014-07-13 17:01:02.891235856 +0200
>>> @@ -220,6 +220,8 @@ static s32 stub_xfer(struct i2c_adapter
>>>    		 * We ignore banks here, because banked chips don't use I2C
>>>    		 * block transfers
>>>    		 */
>>> +		if (data->block[0] > 256 - command)	/* Avoid overrun */
>>> +			data->block[0] = 256 - command;
>>
>> is it safe to overwrite data->block[0], or should it be something
>> like the following ?
>>
>> 		if (data->block[0] > 256 - command)	/* Avoid overrun */
>> 			len = 256 - command;
>> 		else
>> 			len = data->block[0];
>
> It's not only safe, it is desired. Otherwise the caller doesn't know
> this is a short read, and it may take the end of the block buffer for
> actual data. Check the code in
> i2c-core.c:i2c_smbus_read_i2c_block_data(), you'll see it uses and even
> returns block[0]. Same for writes, that's the only way to notify the
> caller of short writes.
>
>> Also, wonder what happens in the real world if anyone does that.
>> Would the write stop at offset 255, or would it wrap and write from 0 ?
>
> Depends on the chip, I've seen both implementations.
>
> It doesn't really matter what i2c-stub does, as device drivers should
> never do that. I just did not want to risk data leak or corruption in
> case it ever happens.
>

Ok, makes sense.

Reviewed-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

Thanks,
Guenter

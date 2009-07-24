From: Stefano Tebaldi <steteb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c driver doubts
Date: Fri, 24 Jul 2009 17:49:32 +0200
Message-ID: <fdaba91e0907240849h6b3f1116je71acd059145a142@mail.gmail.com>
References: <fdaba91e0907180554x69f0023dk5359f26b2ebf758d@mail.gmail.com>
	 <fdaba91e0907180557n32663ecdy7ce5c6818f4694ab@mail.gmail.com>
	 <20090724103738.1eac9a3b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090724103738.1eac9a3b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

thank you very much for your answers

some other questions below


2009/7/24 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>:
>> At this point I have again the doubt at the 1) point: How can I
>> indicate in my driver that it is for i2c_stub virtual chip ?
>
> If your device can be detected somehow, you can implement the .detect()
> callback in your driver. This will let i2c-core instantiate the device
> for you.
>
> If not, you need kernel >= 2.6.31-rc1, which has a sysfs interface to
> instantiate (and delete) i2c devices from user-space. With older
> kernels you can make use of the I2C_CLIENT_INSMOD* macros, which will
> let you create devices at driver load time, but beware this is
> deprecated and will be removed in the future.
>
> If you haven't yet, I strongly suggest reading
> Documentation/i2c/instantiating-devices

reading this document and asking for that issue, I have understood
that I have to add i2c device configuration in i2c_board_info struct
and
call the i2c_register_board_info() in a specific architecture file
describing platform I am using (for example, for arm architecture,
this file can be
linux/arch/arm/mach-pxa/mioa701.c or pcm990-baseboard.c)
Currently I am using a standard PC and so for x86 architecture I was
not able to find the right place where insert this registration. Then
I tried to insert it directly in my driver, but
I had an i2c_register_board_info() implementation missing error during
linkage of my module and then finally I used i2c_new_device() instead
of i2c_register_board_info() (as described in method 2 of
instantiating-devices) and now things work using i2c-stub.
I am using a 2.6.30 kernel. I can also try I2C_CLIENT_INSMOD* macros
or better update to kernel >= 2.6.31-rc1 and try sysfs interface to
instantiate i2c devices as you have suggested


>> In some cases, for reading the value of 6 contiguous registers, I have
>> seen to use the i2c_transfer() sending first a i2c message of this
>> type:
>>
>> struct i2c_msg msg1[] = {
>> { client->addr, 0, 1, &type },
>> };
>>
>> and then this one
>>
>> struct i2c_msg msg2[] = {
>> { client->addr, I2C_M_RD, 6, d },
>> };
>>
>> the last message is clear for me (d is u8 d[6]), but the first
>> absolutely not. Can anyone explain to me ?
>> How can I indicate the
>> register address ? Is msg1 needed for this purpose ?
>
> "type" in the first message is equivalent to the register address you
> pass as the second parameter to i2c_smbus_read_byte_data(). In most
> cases this is the address of the first register to read, and then the
> chip auto-increments the address for each byte you read (second
> message).
>
>> Can I obtain the same result using i2c_smbus_read_block_data() ?
>
> No, use i2c_smbus_read_i2c_block_data(). i2c_smbus_read_block_data() is
> the SMBus variant, where you receive a block size first and only then
> the data. SMBus devices do this but I2C devices don't.

another question related to SMBus API: if I have two contigous
registers each one containing 1 byte data and I use
i2c_smbus_read_word_data() passing the address of the first register,
can I obtain back the value of the two registers ?

moreover, I read in Documentation/i2c/writing-clients the following:

"If you can choose between plain I2C communication and SMBus level
communication, please use the latter. All adapters understand SMBus level
commands, but only some of them understand plain I2C!"

Does it mean that if possibile is better to use SMBus API ? But I
anderstood that some SMBus functionalities could not be
supported by some devices and i2c_check_functionality() is used for
this purpose. Is it correct ?

From: Douglas Gilbert <dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] i2c-dev: relax ban on I2C_M_RECV_LEN
Date: Mon, 20 Feb 2012 22:45:03 -0500
Message-ID: <4F43133F.5040906@interlog.com>
References: <4F2DA645.3080604@interlog.com> <20120220162939.5ce96d52@endymion.delvare>
Reply-To: dgilbert-qazKcTl6WRFWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120220162939.5ce96d52-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 12-02-20 10:29 AM, Jean Delvare wrote:
> Hi Doug,
>
> Sorry for the late reply, I wanted to make sure I remembered all the
> I2C_M_RECV_LEN logic before replying.
>
> On Sat, 04 Feb 2012 16:42:29 -0500, Douglas Gilbert wrote:
>> The I2C_M_RECV_LEN flag indicates that the length of
>> an I2C response is in the first byte read. So the maximum
>> size of the read buffer using this option is 256 bytes.
>>
>> Currently the i2c-dev driver returns EINVAL when an
>> attempt is made to use ioctl(I2C_RDWR) with the
>> I2C_M_RECV_LEN flag set. That is overly paranoid:
>
> No, this is playing it safe, in the absence of use case and complete
> review of all involved code paths.
>
>> ChangeLog:
>>     - allow I2C_M_RECV_LEN flag in the i2c-dev driver as
>>       long as the associated buffer length can cope with
>>       the worst case size (which is 256 bytes).
>
> This means that you expect user-space to provide a 256 byte message
> buffer when passing the I2C_M_RECV_LEN flag. Underlying bus drivers
> OTOH expect len to be set to 1 when I2C_M_RECV_LEN is used (and they
> add the received block length to that to come up with the actual used
> length.) I don't think this is documented formally anywhere, but reading
> the code of function i2c_smbus_xfer_emulated() in i2c-core will show you
> the calling conventions and expectations. Function readbytes() in
> i2c-algo-bit is also worth reading. So your patch is not correct.
>
> To be honest, I think I recall being the one designing things that way
> but I can't remember why I did so. Some git and mailing list digging
> might be needed. Might be related to the support of SMBus PEC but I'm
> not sure.
>
> Unfortunately there is only i2c_msg.len available to pass length
> information, so it isn't possible to dissociate the buffer size from
> the used size. It happens to be the same in most cases so it has never
> been a problem in practice. Only for the I2C_M_RECV_LEN case it would
> be useful to distinguish between both, and presumably SMBus PEC too.
>
> It has never been a problem so far because only the SMBus layer is
> using I2C_M_RECV_LEN and PEC, and there we know that the block size
> cannot exceed I2C_SMBUS_BLOCK_MAX == 32. Every bus driver can (and
> should) enforce that, and buffers are always large enough to contain 32
> bytes, by design.
>
> Passing I2C_M_RECV_LEN at the I2C (not SMBus) level wouldn't work
> safely, not even in the kernel. The only non-SMBus implementation is in
> i2c-algo-bit as far as I know, and it enforces the I2C_SMBUS_BLOCK_MAX
> limit. So it should be pretty clear that flag I2C_M_RECV_LEN was
> introduced for and designed with SMBus in mind. Using it for I2C
> messaging just doesn't work, thus the ban in i2c-dev.
>
> This makes me wonder how you did test your patch, as I can't see how it
> would work with the upstream driver code. But more importantly, can you
> please explain what you are trying to achieve in the first place?
> Receiving block length as the first data byte is an SMBus thing,
> traditionally non-SMBus devices don't do that. And for SMBus devices
> through i2c-dev, you'd be using ioctl I2C_SMBUS not I2C_RDWR.
>
> If you have a legitimate use case for I2C_M_RECV_LEN, then we can
> discuss it, but it will take a lot more than your 2-line patch to get
> it right.

In the embedded space I only see I2C (TWI) so I don't understand
the fixation with SMBus (some subset I believe).

My illegitimate use case is:
Sonmicro 13.56 MHz RFID Mifare Module:
http://www.sonmicro.com/en/downloads/Mifare/ds_SM130.pdf
http://www.sonmicro.com/en/downloads/Mifare/AN601.pdf

I can make it work by requesting the maximum number of bytes it
will ever respond with on all reads.


Some suggestions for when and if the I2C pass-through is rewritten:
   - make it clean to the user space, don't use it for internal
     plumbing within the kernel (to avoid horrors like those you
     allude to above)
   - put some version number in it so when you want to put some
     extra fields through it (e.g. extra i2c_msg.len field) you
     can bump version number ***
   - the multiple I2C transfers in one structure is great, but
     would be more useful if a delay could be placed between
     each one.


*** Getting new ioctls into the kernel is really difficult since
     the management seems to think pass-throughs subvert the OS
     (they do indeed) and where absolutely necessary sysfs can be
     used for the purpose.

Doug Gilbert

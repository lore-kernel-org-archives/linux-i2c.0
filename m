From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] MFD: Add U300 AB3100 core support v1
Date: Mon, 18 May 2009 16:22:36 +0200
Message-ID: <63386a3d0905180722u282f0dd3ua62b119a1a6a97e8@mail.gmail.com>
References: <63386a3d0905140129s5fd0f32cxde1114489678f012@mail.gmail.com>
	 <4A0BF776.9030301@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A0BF776.9030301-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2009/5/14 Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>:

> A few comments.

First a BIG THANKS. I worked the last few days according to your and
Samuel's comments, great input!

I'll send a v2 soonish with all issues fixed as far as possible. Below
I just discuss things I haven't yet figured out how to fix properly.
(Most stuff is simply just fixed.)

>> +     /*
>> +      * A two-byte write message with the first byte containing the register
>> +      * number and the second byte containing the value to be written
>> +      * effectively sets a register in the AB3100.
>> +      */
>> +     if ((i2c_transfer(ab3100_i2c_client->adapter,
>> +                                     &msgs[0], 1)) != 1) {
>
> Is it necessary to use i2c_transfer here? Maybe i2c_master_send or even
> i2c_smbus_write_word_data would do the job?

Yep it works nicely here but...

>> +/*
>> + * The test registers exist at an I2C bus address up one
>> + * from the ordinary base. They are not supposed to be used
>> + * in production code, but sometimes you have to do that
>> + * anyway. It's currently only used from this file so declare
>> + * it static and do not export.
>> + */
>> +static int ab3100_set_test_register(u8 reg, u8 regval)
>> +{
>> +     u8 regandval[2] = {reg, regval};
>> +     struct i2c_msg msgs[1];
>> +     int err = 0;
>> +
>> +     if (!ab3100_initialized)
>> +             return -ENODEV;
>> +
>> +     msgs[0].addr = ab3100_i2c_client->addr + 1;
>> +     msgs[0].flags = 0;
>> +     msgs[0].len = 2;
>> +     msgs[0].buf = regandval;
>> +     err = mutex_lock_interruptible(&ab3100_access_mutex);
>> +     if (err)
>> +             return err;
>> +
>> +     /*
>> +      * A two-byte write message with the first byte containing the register
>> +      * number and the second byte containing the value to be written
>> +      * effectively sets a register in the AB3100.
>> +      */
>> +     if ((i2c_transfer(ab3100_i2c_client->adapter,
>> +                       &msgs[0], 1)) != 1) {
>
> i2c_master_send?

Here we have a problem. See above:
msgs[0].addr = ab3100_i2c_client->addr + 1;

So this chip actually has two addresses. A "special" address
to deal with test registers, one address up. The I2C framework
assume all devices have one and one address only (which is
of course mostly true).

Here is a special case. When the first device has registered,
you know that the other address is available as well.

You could think of several ugly solutions:

* Keep using i2c_transfer() directly as we do now.

* Make a raw copy of the i2c_device with something like
  memcpy(mock_client, i2c_client, sizeof(i2c_client);
  mock_client->addr++;
  then use i2c_master_send()

* Register a new i2c_device in board_info for the other
  address while strictly speaking it is the same device, and
  this will yield a lot of probing and synchronization code,
  because writing the test registers is used when probing the
  first device, so we have to wait for that device to be probed
  before we can probe the other one etc.

Right now I lean toward the first alternative.

Yours,
Linus Walleij

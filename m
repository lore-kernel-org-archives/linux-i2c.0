From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PCH lost arbitration
Date: Sun, 17 Jul 2011 14:33:16 +0200
Message-ID: <20110717143316.2fe5da1c@endymion.delvare>
References: <CA+VPmgdsdVmv12oaSHerQ6DUN0nJ8FnpRpFGS8w4W__OO192Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+VPmgdsdVmv12oaSHerQ6DUN0nJ8FnpRpFGS8w4W__OO192Yg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Felix,

On Sun, 17 Jul 2011 11:03:42 +0300, Felix Rubinstein wrote:
> Consider a hardware with ~20-30 i2c devices which must be configured
> as quick as possible on boot.
> Each device gets its own configuration which contains 40 register writes.
> In order to minimize the configuration time, I've replaced simple
> script with i2cset to C code i2c_smbus_write_byte_data.

If time is a matter to you, then I doubt that turning i2cset scripting
into a custom binary will help a lot. Most time is certainly spent in
the I2C bus driver, either performing the actual operations or waiting
for the reply.

You may be able to save cycles on the bus by writing more than one byte
at once if some of your I2C devices support this (this is often
referred to as "pointer register auto-increment".) This can be done
using i2c_smbus_write_word_data (2 bytes at once) or even
i2c_smbus_write_i2c_block_data (up to 32 bytes at once.)

But the real time saver would be to finally convert i2c-i801 to use
interruptions rather than polling. It was attempted before, but never
reached the reliability level needed to make it into mainline.

> Now, once in a long while, i2c_smbus_write_byte_data returns -EAGAIN
> PCH driver code issues the following:
> 
>        /* Retry up to 3 times on lost arbitration */
>         priv->adapter.retries = 3;
> 
> I've used I2C_RETRIES ioctl to increase it to 100 and it has solved an error.
> After running 52 hours test I'm confident that in my case it solved an error.
> 
> Why is it set to 3? The data sheet doesn't say anything about the
> value, is it an empirical value?

It is an arbitrary default. Which I can't remember anyone complaining
about so far. The larger the value, the longer the timeout in case of a
permanent error (thankfully capped by the adapter timeout value.) I
didn't expect anyone to need more than 3 retries. Did you instrument
the driver to figure out how many retries max were needed?

Anyway, the whole point of the I2C_RETRIES ioctl is to let users tweak
the value if the default doesn't suit their needs. So you did the right
thing, and it works, so what exactly do you expect from me/us now?

> Have you ever considered lots of i2c back to back transactions?

How is it related? According to the datasheet, BUS_ERR (which ends up
in the driver returning -EAGAIN) is only set on arbitration loss. This
can only happen on multi-master topologies, and depends on what the
other master is doing. There is nothing that can be done on our end to
avoid it. All we can do is retry when it happens.

There is no fundamental reason that I can see why switching from i2cset
scripting to a custom binary would result in more arbitration losses.
The latter should only be marginally faster, so the I2C bus contention
only slightly higher.

So, if you get a lot of arbitration losses (aka bus collisions) this
suggests that another master is also doing heavy use of the I2C bus at
the same time you are. You should investigate and figure out what is
happening there, because this is no good: each side is slowing down the
other side. It would be better to schedule such heavy bus accesses
properly.

More generally, if you need additional help, it's about time for you to
give us more details. Which kernel are you running, what is the
hardware, what is the exact I2C bus topology, what are the slaves?

> To make things even worse, consider the case when 4 hardware CPUs
> (each with different affinity) configure may i2c devices.
> No doubt retries set to 3 will not be enough in this case too.

Affinity to what?

I fail to see how the number of CPUs matters. Access to the SMBus from
the host is serialized, so there is no performance benefit in
distributing the work over several CPUs. And there should be no impact
on bus collisions either. Again, collisions are caused by another
master on the bus, which we do not control.

-- 
Jean Delvare

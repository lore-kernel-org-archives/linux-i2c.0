From: Felix Rubinstein <felixru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: PCH lost arbitration
Date: Sun, 17 Jul 2011 11:03:42 +0300
Message-ID: <CA+VPmgdsdVmv12oaSHerQ6DUN0nJ8FnpRpFGS8w4W__OO192Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

Consider a hardware with ~20-30 i2c devices which must be configured
as quick as possible on boot.
Each device gets its own configuration which contains 40 register writes.
In order to minimize the configuration time, I've replaced simple
script with i2cset to C code i2c_smbus_write_byte_data.

Now, once in a long while, i2c_smbus_write_byte_data returns -EAGAIN
PCH driver code issues the following:

       /* Retry up to 3 times on lost arbitration */
        priv->adapter.retries = 3;

I've used I2C_RETRIES ioctl to increase it to 100 and it has solved an error.
After running 52 hours test I'm confident that in my case it solved an error.

Why is it set to 3? The data sheet doesn't say anything about the
value, is it an empirical value?
Have you ever considered lots of i2c back to back transactions?
To make things even worse, consider the case when 4 hardware CPUs
(each with different affinity) configure may i2c devices.
No doubt retries set to 3 will not be enough in this case too.


Thanks,
Felix R.

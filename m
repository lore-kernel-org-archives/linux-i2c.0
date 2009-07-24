From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c driver doubts
Date: Fri, 24 Jul 2009 10:37:38 +0200
Message-ID: <20090724103738.1eac9a3b@hyperion.delvare>
References: <fdaba91e0907180554x69f0023dk5359f26b2ebf758d@mail.gmail.com>
	<fdaba91e0907180557n32663ecdy7ce5c6818f4694ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fdaba91e0907180557n32663ecdy7ce5c6818f4694ab-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefano Tebaldi <steteb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Stefano,

On Sat, 18 Jul 2009 14:57:17 +0200, Stefano Tebaldi wrote:
> I am quite newbie about Linux Kernel development and in particular i2c driver.
> I am trying to write a i2c driver for a chip and I have the following
> doubts (I am using a Kernel 2.6
> with the new style model instead of deprecated old legacy model):
> 
> 1) I find quite confusing how the Linux system knows about i2c device
> and how I can indicate in my i2c driver the device I want to control
> and to communicate.
> I have seen that in the probe function, the i2c_client struct is
> passed as argument and I have understood that this struct is filled
> automatically by the Kernel. This struct contains some important

There is nothing automatic about it. All these values have to be
provided explicitly, the kernel usually can't guess them. In most cases
they come from platform data (on embedded systems) or from bridge
drivers (for TV adapters.)

> information on my device such as address, irq, etc and it has to be
> used in the driver to communicate with the device. But my question is:
> where the Kernel know this device's details and where in my driver I
> have to indicate the device
> I want to control ? Is it the name in the i2c_driver struct driver
> field or id_table field ? If so, how can I know the right string to
> use for identifing my device ?

Assuming your kernel is recent enough (>= 2.6.25), the strings used to
match an i2c driver with an i2c device are the ones listed in the type
field in the struct i2c_device_id array attached to your driver. For
example, the lm83 driver looks like this:

static const struct i2c_device_id lm83_id[] = {
	{ "lm83", lm83 },
	{ "lm82", lm82 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, lm83_id);

static struct i2c_driver lm83_driver = {
	(...)
	.id_table	= lm83_id,
	(...)
};

This means that I2C devices named either "lm82" or "lm83" will be bound
to the lm83 driver.

These name strings are arbitrary. It is strongly recommended to use the
name of the I2C chip with lowercase letters. The key point is that the
strings must be unique, and using the chip name is a good way to
achieve this.

> 2) since at the moment I have no the board with the chip for what I am
> writing this driver, I would like to perform anyway some test on it
> using i2c_stub module. Do you think it makes sense ?

Yes it does, the i2c-sub driver was written exactly for this.

> At this point I have again the doubt at the 1) point: How can I
> indicate in my driver that it is for i2c_stub virtual chip ?

If your device can be detected somehow, you can implement the .detect()
callback in your driver. This will let i2c-core instantiate the device
for you.

If not, you need kernel >= 2.6.31-rc1, which has a sysfs interface to
instantiate (and delete) i2c devices from user-space. With older
kernels you can make use of the I2C_CLIENT_INSMOD* macros, which will
let you create devices at driver load time, but beware this is
deprecated and will be removed in the future.

If you haven't yet, I strongly suggest reading
Documentation/i2c/instantiating-devices

> 3) Is it possible to address two chip in a single driver (module) ?

Not sure if you mean two different chip instances, or two different
chip types, but the answer to both questions is yes.

> Because i2c_client struct has only one addr field. Have I to write two
> different drivers or for example can I obtain that calling in the
> module init
> two time i2c_add_driver() using two different i2c_driver struct, etc ?

You're quite confused I'm afraid. A driver is a driver, a device is a
device. Don't mix the concepts. Just because you have two devices
thankfully doesn't mean you need two drivers. The same driver can
handle as many devices as you want. So you'll only have one struct
i2c_driver, and only call i2c_add_driver() once.

> I read something about udev that probably can help to do that issue.
> What do you think about ? in addition, I am using sysfs for exporting
> device information to userspace like many drivers of this type do

udev has nothing to do with this, it's a user-space thing.

> 4) For reading register values I have seen to use generally for
> example the i2c_smbus_read_byte_data() passing to it the i2c_client
> struct (for the device address) as first argument and the register
> address as second.

i2c_client isn't passed only for the address, otherwise we'd just pass
the address. It also has a pointer to the underlying I2C segment (for
physical access) as well as a number of (rarely used) flags defining
the transaction details.

> In some cases, for reading the value of 6 contiguous registers, I have
> seen to use the i2c_transfer() sending first a i2c message of this
> type:
> 
> struct i2c_msg msg1[] = {
> { client->addr, 0, 1, &type },
> };
> 
> and then this one
> 
> struct i2c_msg msg2[] = {
> { client->addr, I2C_M_RD, 6, d },
> };
> 
> the last message is clear for me (d is u8 d[6]), but the first
> absolutely not. Can anyone explain to me ?
> How can I indicate the
> register address ? Is msg1 needed for this purpose ?

"type" in the first message is equivalent to the register address you
pass as the second parameter to i2c_smbus_read_byte_data(). In most
cases this is the address of the first register to read, and then the
chip auto-increments the address for each byte you read (second
message).

> Can I obtain the same result using i2c_smbus_read_block_data() ?

No, use i2c_smbus_read_i2c_block_data(). i2c_smbus_read_block_data() is
the SMBus variant, where you receive a block size first and only then
the data. SMBus devices do this but I2C devices don't.

Hope that helps,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

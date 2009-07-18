From: Stefano Tebaldi <steteb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: i2c driver doubts
Date: Sat, 18 Jul 2009 14:57:17 +0200
Message-ID: <fdaba91e0907180557n32663ecdy7ce5c6818f4694ab@mail.gmail.com>
References: <fdaba91e0907180554x69f0023dk5359f26b2ebf758d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fdaba91e0907180554x69f0023dk5359f26b2ebf758d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi all,

I am quite newbie about Linux Kernel development and in particular i2c driver.
I am trying to write a i2c driver for a chip and I have the following
doubts (I am using a Kernel 2.6
with the new style model instead of deprecated old legacy model):

1) I find quite confusing how the Linux system knows about i2c device
and how I can indicate in my i2c driver the device I want to control
and to communicate.
I have seen that in the probe function, the i2c_client struct is
passed as argument and I have understood that this struct is filled
automatically by the Kernel. This struct contains some important
information on my device such as address, irq, etc and it has to be
used in the driver to communicate with the device. But my question is:
where the Kernel know this device's details and where in my driver I
have to indicate the device
I want to control ? Is it the name in the i2c_driver struct driver
field or id_table field ? If so, how can I know the right string to
use for identifing my device ?

2) since at the moment I have no the board with the chip for what I am
writing this driver, I would like to perform anyway some test on it
using i2c_stub module. Do you think it makes sense ?
At this point I have again the doubt at the 1) point: How can I
indicate in my driver that it is for i2c_stub virtual chip ?

3) Is it possible to address two chip in a single driver (module) ?
Because i2c_client struct has only one addr field. Have I to write two
different drivers or for example can I obtain that calling in the
module init
two time i2c_add_driver() using two different i2c_driver struct, etc ?
I read something about udev that probably can help to do that issue.
What do you think about ? in addition, I am using sysfs for exporting
device information to userspace like many drivers of this type do

4) For reading register values I have seen to use generally for
example the i2c_smbus_read_byte_data() passing to it the i2c_client
struct (for the device address) as first argument and the register
address as second.
In some cases, for reading the value of 6 contiguous registers, I have
seen to use the i2c_transfer() sending first a i2c message of this
type:

struct i2c_msg msg1[] = {
{ client->addr, 0, 1, &type },
};

and then this one

struct i2c_msg msg2[] = {
{ client->addr, I2C_M_RD, 6, d },
};

the last message is clear for me (d is u8 d[6]), but the first
absolutely not. Can anyone explain to me ? How can I indicate the
register address ? Is msg1 needed for this purpose ?
Can I obtain the same result using i2c_smbus_read_block_data() ?


sorry for the mail length and my poor english

thank you very much. Any advice is welcome

Stefano

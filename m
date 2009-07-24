From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c driver doubts
Date: Fri, 24 Jul 2009 19:05:39 +0200
Message-ID: <20090724190539.149b9bd5@hyperion.delvare>
References: <fdaba91e0907180554x69f0023dk5359f26b2ebf758d@mail.gmail.com>
	<fdaba91e0907180557n32663ecdy7ce5c6818f4694ab@mail.gmail.com>
	<20090724103738.1eac9a3b@hyperion.delvare>
	<fdaba91e0907240849h6b3f1116je71acd059145a142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fdaba91e0907240849h6b3f1116je71acd059145a142-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefano Tebaldi <steteb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Stefano,

On Fri, 24 Jul 2009 17:49:32 +0200, Stefano Tebaldi wrote:
> 2009/7/24 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>:
> > If your device can be detected somehow, you can implement the .detect()
> > callback in your driver. This will let i2c-core instantiate the device
> > for you.
> >
> > If not, you need kernel >= 2.6.31-rc1, which has a sysfs interface to
> > instantiate (and delete) i2c devices from user-space. With older
> > kernels you can make use of the I2C_CLIENT_INSMOD* macros, which will
> > let you create devices at driver load time, but beware this is
> > deprecated and will be removed in the future.
> >
> > If you haven't yet, I strongly suggest reading
> > Documentation/i2c/instantiating-devices
> 
> reading this document and asking for that issue, I have understood
> that I have to add i2c device configuration in i2c_board_info struct
> and
> call the i2c_register_board_info() in a specific architecture file
> describing platform I am using (for example, for arm architecture,
> this file can be
> linux/arch/arm/mach-pxa/mioa701.c or pcm990-baseboard.c)
> Currently I am using a standard PC and so for x86 architecture I was
> not able to find the right place where insert this registration. Then
> I tried to insert it directly in my driver, but
> I had an i2c_register_board_info() implementation missing error during

i2c_register_board_info() requires fixed i2c adapter numbers, which x86
doesn't implement. So you indeed can't use i2c_register_board_info().

> linkage of my module and then finally I used i2c_new_device() instead
> of i2c_register_board_info() (as described in method 2 of
> instantiating-devices) and now things work using i2c-stub.
> I am using a 2.6.30 kernel. I can also try I2C_CLIENT_INSMOD* macros
> or better update to kernel >= 2.6.31-rc1 and try sysfs interface to
> instantiate i2c devices as you have suggested

i2c_new_device() indeed works if you don't mind patching i2c-stub
locally. If this is only for temporary testing I guess this is
acceptable.

> > (...)
> > No, use i2c_smbus_read_i2c_block_data(). i2c_smbus_read_block_data() is
> > the SMBus variant, where you receive a block size first and only then
> > the data. SMBus devices do this but I2C devices don't.
> 
> another question related to SMBus API: if I have two contigous
> registers each one containing 1 byte data and I use
> i2c_smbus_read_word_data() passing the address of the first register,
> can I obtain back the value of the two registers ?

Depends on the hardware implementation on the I2C chip side. Some chips
do support it, some do not. Just try... or look at the datasheet of
your chip.

> moreover, I read in Documentation/i2c/writing-clients the following:
> 
> "If you can choose between plain I2C communication and SMBus level
> communication, please use the latter. All adapters understand SMBus level
> commands, but only some of them understand plain I2C!"
> 
> Does it mean that if possibile is better to use SMBus API ?

Yes.

> But I anderstood that some SMBus functionalities could not be
> supported by some devices and i2c_check_functionality() is used for
> this purpose. Is it correct ?

This is correct. But controllers that can do I2C, can do all of SMBus by
definition. OTOH SMBus controllers can't do I2C, so if you use
i2c_transfer() (I2C) your code will not work on SMBus controllers.
Almost all x86 systems implement SMBus rather than full I2C, so you
really want to use i2c_smbus_*() functions and not i2c_transfer().

Now you're right that SMBus controllers don't have to implement all of
SMBus. Usually you have to find the correct balance between portability
and speed. If you only use byte transactions, your code will run on all
SMBus controllers, but may be slow if your chip has a large number of
(used) registers. If you start using word or block transactions, some
controllers might not support them and your driver will not work there.
As a rule of thumb, word transactions are widely supported, while block
transactions are not.

The right balance really depends on the speed improvement you get from
using block transactions for your specific chip, and on how many
different systems your driver must work. There are some cases where
portability doesn't matter at all.

And if you really need both speed and portability, you're free to
implement two (or more) register access functions in your driver, and
select the best one at run-time using i2c_check_functionality().

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

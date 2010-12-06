From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help to fix some issues with the linux driver    
 "i2c-gpio"
Date: Mon, 6 Dec 2010 11:25:57 +0100
Message-ID: <20101206112557.3dc8ffe3@endymion.delvare>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
	<20101130182150.3bbc8f01@endymion.delvare>
	<4CF62AFD020000AA000080E3@center.bmk-electronics.de>
	<20101202172322.43ea4698@endymion.delvare>
	<4CFCB095020000AA00008187@center.bmk-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CFCB095020000AA00008187-PZWwcLLCDcw8dQ1qNLwSjGRXbTvXh2ZWs0AfqQuZ5sE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Zacharias <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Matthias,

On Mon, 06 Dec 2010 09:44:53 +0100, Matthias Zacharias wrote:
> > On Wed, 01 Dec 2010 11:01:17 +0100, Matthias Zacharias wrote:
> >> I can provide the sources for the MLX90614 driver, but I think it
> >> is not a good ideea to attach it to this E-Mail.
> > 
> > If the source code is publicly visible somewhere, you can point us
> > to that location. If not, maybe this is the right time to publish
> > it ;) Or you can send it to me privately.
> 
> Where is a good place to publish the MLX90614 driver?

The lm-sensors list would be a good place, as indicated in section
"HARDWARE MONITORING" of file MAINTAINERS in the kernel source tree. If
you intend to get this driver in the upstream kernel tree, you'll have
to post it there sooner or later anyway (even though the device is more
of a temperature sensor than an actual hardware monitoring chip.)

> > BTW, it would be very interesting to see if you can get a MLX90614
> > chip to work with this driver on another system with a different
> > I2C or SMBus master.
> 
> Any suggestion how to do that? I don't know how to get other hardware
> which has an accessible SMBus to connect the MLX90614 directly.

Some boards have SMBus pins accessible to connect external devices.
Otherwise you need a soldering iron and basic electronics skills and
equipment.

> >> (...)
> >> I access the eeprom as generic i2c device (file pointer to i2c-0)
> >> without usage of any specific driver.
> > 
> > Which system calls and transaction types are you using?
> 
> The MLX90614 uses now only the i2c_smbus_xfer(..) transaction to read
> from the SMBus. But I think the MLX90614 driver must be extended to be
> able to write configuration data (Word) on SMBus device as well.

My question was related to your access to the EEPROM access, not the
MLX90614. Besides, i2c_smbus_xfer() is a generic function for all SMBus
transaction types, so you didn't completely answer my question. Which
SMBus transaction types are you asking i2c_smbus_xfer() for?

> > Did you try accessing the MLX90614 the same way?
> 
> The MLX90614 is accessed as a hwmon device using the new device model

I know that. My question was, did you try an alternative way? For
example you could use the i2cget command line tool (part of i2c-tools)
for user-space access. It would be interesting to see if it makes a
difference.

> > (...)
> > Err. I thought there was a kernel function for that, but apparently
> > I was wrong. Well this could be done in asm but I don't think you want
> > to try that.
> > 
> > Maybe you can do something with spin_lock_irqsave() and
> > spin_unlock_irqrestore() around the critical sections, I'm not sure.
> 
> I have no experience with spin_lock's, don't know how to use them. If
> you have a good example please point me to it.

I don't have any experience with spin locks either (at least none of
the driver I wrote ever used one) but with over 4000 calls to this
function throughout the kernel source tree, it shouldn't be difficult
to find an example you can follow.

> > (...)
> > When CONFIG_I2C_DEBUG_ALGO isn't set, bit_dbg() is a no-op so it
> > certainly can't affect you in any way.
> > 
> I don't know how the compiler do handle the bit_dbg() makro, but I can
> see the difference if the bit_dbg() call where included in the code or
> not,  also if  CONFIG_I2C_DEBUG_ALGO was not set.

This is highly unlikely, unless you modified the driver source code.
bit_dbg is defined with:

#ifdef DEBUG
#define bit_dbg(level, dev, format, args...) \
	do { \
		if (i2c_debug >= level) \
			dev_dbg(dev, format, ##args); \
	} while (0)
#else
#define bit_dbg(level, dev, format, args...) \
	do {} while (0)
#endif /* DEBUG */

And DEBUG is only set if CONFIG_I2C_DEBUG_ALGO=y. So bit_dbg() is a
no-op when CONFIG_I2C_DEBUG_ALGO isn't set.

As a matter of fact, I just tried removing all calls to bit_dbg() and
i2c-algo-bit.o is unchanged, as I expected. So either you messed up
your testing, or your compiler is seriously broken.

> > Question is whether the SCL line is stretched by the master or by
> > the slave. Both are allowed to do it to a certain point.
>
> in the board settings I configure the SCL signal as output only to
> avoid that SCL streching can be done by the SMBus slaves.

Oh my! You shot yourself in the foot!

How do you expect _slaves_ to change their behavior just because you
said your I2C master to not pay attention to clock stretching? If
slaves want to stretch the clock line, they will. The MLX90614
datasheet isn't mentioning clock stretching, but that doesn't mean the
device is not doing exactly that.

You really want a bidirectional SCL on the master side, otherwise
reliability cannot be guaranteed. In fact, i2c-algo-bit with no SCL read
callback is not I2C-compliant. It's just a hack because sometimes we
have no other way, but in real systems you really don't want to do
that. Maybe I should make i2c-algo-bit complain when SCL read callback
is missing, to make it more obvious.

So please fix this, set a proper callback for SCL read. This alone
might fix your problem.

> > Does stretching happen on SCL high, or SCL low, or both?
>
> The streching occures on both levels at un predictable times.

This would be on the master side then. Slaves can stretch the clock
line by holding it down, but they can't prevent it from going down if
the master pulls it low, so they can't stretch the high part of the
clock cycle.

> > If the stretching is done by the master, then you may search for
> > interrupt sources on your system. Maybe you have a misbehaving
> > driver or device on your system which causes repeated and long
> > interruptions. Making these interruptions shorter (e.g. by moving
> > the real work to a workqueue) would then help.
>
> I have no ideea how to find a missbehaving driver, if any?

This isn't trivial. You can try unloading each driver sequentially and
see if things get better when one driver is missing. You can also check
in /proc/interrupts if any value is increasing particularly fast, or if
you can find a correlation between SCL problems and a particular
interrupt.

Some kernel debug options might be helpful here, such as
CONFIG_DETECT_SOFTLOCKUP and CONFIG_LATENCYTOP, and maybe others. I'm
not too familiar with this.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

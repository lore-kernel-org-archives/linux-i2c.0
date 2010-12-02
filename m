From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help to fix some issues with the linux driver   "i2c-gpio"
Date: Thu, 2 Dec 2010 17:23:22 +0100
Message-ID: <20101202172322.43ea4698@endymion.delvare>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
	<20101130182150.3bbc8f01@endymion.delvare>
	<4CF62AFD020000AA000080E3@center.bmk-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CF62AFD020000AA000080E3-PZWwcLLCDcw8dQ1qNLwSjGRXbTvXh2ZWs0AfqQuZ5sE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Zacharias <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Matthias,

On Wed, 01 Dec 2010 11:01:17 +0100, Matthias Zacharias wrote:
> >>> Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> 30.11.2010 18:21 >>>
> > It's difficult to answer here without seeing the source code of the
> > MLX90614 driver. What I can say is that values "near 0xFFFF" look
> > like uncaught (negative) error codes carelessly cast to u16. So you
> > should ensure that your driver properly deals with errors returned
> > by the i2c layer (i2c_transfer and i2c_smbus_*). And if such errors
> > happen, you should print them so that you see what exactly is going
> > on and when.
> 
> I can provide the sources for the MLX90614 driver, but I think it is
> not a good ideea to attach it to this E-Mail.

If the source code is publicly visible somewhere, you can point us to
that location. If not, maybe this is the right time to publish it ;) Or
you can send it to me privately.

BTW, it would be very interesting to see if you can get a MLX90614 chip
to work with this driver on another system with a different I2C or
SMBus master.

> > If the EEPROM works fine, it may depend on the transaction types. I
> > can't comment further because you didn't tell us which driver you
> > were using (eeprom or at24). But it would be interesting to see
> > which transactions fail, and if there is a pattern.
> 
> I access the eeprom as generic i2c device (file pointer to i2c-0)
> without usage of any specific driver.

Which system calls and transaction types are you using?

Did you try accessing the MLX90614 the same way?

> > Note that i2c-algo-bit is CPU-driven. It doesn't sleep, so it
> > shouldn't be preempted by regular code, but nothing can be done
> > against interrupts. I see that the MLX90614 has a very short
> > timeout when SCL is high (45 to 55 us), so receiving an interrupt
> > in this state could indeed be an issue. You may want to try
> > disabling interrupts before raising SCL (except at the end of the
> > transaction, of course) in i2c-algo-bit.
> 
> Please give me an example how the disable interrupts as you suggest.

Err. I thought there was a kernel function for that, but apparently I
was wrong. Well this could be done in asm but I don't think you want to
try that.

Maybe you can do something with spin_lock_irqsave() and
spin_unlock_irqrestore() around the critical sections, I'm not sure.

> In the i2c-algo-bits there is used the "bit_dbg" makro to print some
> debug messages to ksys. Removing the makros wich where placed on the
> main execution line (not on for error messages) helps to get a better
> behavoir: SCL stretching occure on better reproducable communication
> times.

Err, are you by any chance running a kernel built with
CONFIG_I2C_DEBUG_ALGO=y, and have set i2c_debug to 2 or more? This
could explain your problems, at least in part. i2c-algo-bit is quite
verbose in the kernel logs when debugging level is set to 2 or more,
and writing the log to the disk is adding a lot of latency to the
system.

Unfortunately this is one case where enabling debugging to better
understand what is going on also affects what is going on. As you have
an external bus analyzer, it's better to not enable debugging in
i2c-algo-bit, or at least not beyond level 1.

When CONFIG_I2C_DEBUG_ALGO isn't set, bit_dbg() is a no-op so it
certainly can't affect you in any way.

> > And, as Bill already underlined, you have to ensure that you're
> > running the bus at the right frequency. The MLX90614 is an SMBus
> > compliant device so it wants a clock between 10 and 100 kHz. This
> > means a udelay value between 5 and 50.
> 
> I checked the clock speed, It can be changed in the specified limits
> for MLX90614 with similar results in the data output. 
> Using an I2C analyzer I was able to see that SCL stretching occures on
> unpredictable times. If these SCL stretching is on specific point in the
> communication process or match the one of the SMbus timeout conditions
> (2 different timeout values) unpredictable data is output, with out any
> error from the I2C subsystem. Only the "i2c-adapter i2c-0: sendbytes:
> NAK bailout." message is correctly thrown.

Question is whether the SCL line is stretched by the master or by the
slave. Both are allowed to do it to a certain point.

Does stretching happen on SCL high, or SCL low, or both?

If the stretching is done by the master, then you may search for
interrupt sources on your system. Maybe you have a misbehaving driver
or device on your system which causes repeated and long interruptions.
Making these interruptions shorter (e.g. by moving the real work to a
workqueue) would then help.

> I can provide screeshots which ilustrate the behavoir. How can I make
> these sceenshots available for you?

Either put it on some publicly available web server if you have one
at hand; or send them to me by mail privately.

> > I presume Haavard left Atmel meanwhile. Not much we can do about
> > that, except removing his address from the source tree (I will
> > do.)
> the last entry @vger.kernel.org was in 2007

Not true. He posted until September 2010:
http://marc.info/?l=linux-kernel&m=128498842805216&w=2

Said post confirms that he left Atmel, BTW. Too bad he did not remove
or update his address in the tree at that time.

-- 
Jean Delvare

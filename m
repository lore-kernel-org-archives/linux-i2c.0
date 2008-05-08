From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80
Date: Thu, 8 May 2008 09:34:56 +0200
Message-ID: <20080508093456.340a42b0@hyperion.delvare>
References: <200805070120.03821.david-b@pacbell.net>
	<Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.55.0805072226180.25644-j8+e0ZhYU2SU0huXySazC6sMm+1xrEX8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Maciej,

On Wed, 7 May 2008 23:28:25 +0100 (BST), Maciej W. Rozycki wrote:
> On Wed, 7 May 2008, David Brownell wrote:
> 
> > This patch is way too big for what it does.  Lots of whitespace
> > and similar noise (did those headers *need* rearranging?).
> 
>  I can submit the formatting fix for the register offsets separately, no 
> problem.  Similarly about the headers -- it is just that kind of the 
> changes that hardly deserve a separate patch, but if changes are made in 
> the area, it may well be a good time to tidy up.

If you think a change doesn't deserve a separate patch, I say it
doesn't deserve to be done at all. The golden rule is to have separate
patches for separate changes.

>  Personally I prefer to keep header inclusions sorted as it makes it
> easier to immediately see what is included and what is not, but if you 
> prefer them in a random order, then my preference is not strong enough for 
> me to resist.

The problem is that there is no such rule in Documentation/CodingStyle,
and in general developers don't care about sorting the header inclusions
alphabetically or otherwise, so it is unlikely that your sort will
survive the next changes that will happen in this area. So I join David
in saying that this change is just not needed.

> > But most importantly, that driver already uses SMBus calls.
> > So you shouldn't *stop* it from using them by adding wrapper
> > code like this:
> 
>  Well, I have to admit what I know in detail about I2C and how it is 
> handled by Linux is what I gathered over the last weekend.  The idea of 
> the change, given a change had to be done, was to make the driver a bit 
> more flexible.  Of all the I2C RTC drivers this seems to be one of the two 
> only that require *both* I2C *and* SMBus functionality in the driving 
> controller at the same time.  With this change in place only either of the 
> two is needed.  Please correct me if I am wrong.

You are correct, but it is important to understand that, for a Linux
chip driver, "requiring I2C and SMBus" and "requiring I2C" are almost
equivalent statements. So what you wrote above is almost equivalent to
writing:

"Of all the I2C RTC drivers this seems to be one of the two only that
require I2C functionality in the driving controller."

Hopefully, with this equivalence in mind you'll have an easier time
understanding what changes should be made to the driver to make it more
portable as you intended.

>  Do you mean our generic I2C code emulates SMBus calls if the hardware
> does not support them directly?  Well, it looks to me it indeed does and
> you are right, but I have assumed, perhaps mistakenly, (but I generally
> trust if a piece of code is there, it is for a reason), that this driver
> checks for I2C_FUNC_SMBUS_BYTE_DATA for a purpose.

The driver rightly checks I2C_FUNC_SMBUS_BYTE_DATA because it calls
i2c_smbus_read_byte_data() and i2c_smbus_write_byte_data(). A driver
calling specific SMBus transaction functions should always check that
they are supported by the underlying bus driver first.

You are correct that, with what we said above, checking for
I2C_FUNC_I2C and checking for I2C_FUNC_I2C | I2C_FUNC_SMBUS_FOO
should be the same. However, this is only strictly equivalent if the
underlying bus driver supports I2C without any restriction. In practice
this is rarely the case, most I2C controllers have limitations. Many
don't support zero-byte messages, for example. Some don't support more
than 2 messages in a transaction, and some additionally have limits to
the maximum length of messages. We've even seen a controller lately
that would only support messages of 1, 8, 16 and 32 bytes.

For this reason, it is up to the bus driver to declare exactly what
part of SMBus they can emulate. Most of the time it's
I2C_FUNC_SMBUS_EMUL (which is a _subset_ of the SMBus transaction set
plus the I2C block transactions) but some drivers remove a few
functionality bits and some add a few ones. That's the reason why the
I2C chip drivers must still check for individual functionality bits if
they do direct calls to specific SMBus transaction functions.

> > The chip docs basically tell us that if the underlying SMBus
> > controller can issue i2c_smbus_read_i2c_block_data() and its
> > write-side sibling, it can *easily* talk to this chip.
> 
>  Well, I have obviously missed the existence of the SMBus block transfer

Important note: the chip supports _I2C_ block transactions, as David
properly wrote. These are different from _SMBus_ block transactions.

>  Given the driver uses a mixture of SMBus calls and raw I2C calls, I would
> assume the other controller currently used with the driver (that's the
> D-Link DNS-323 platform -- I cannot immediately figure out which I2C
> controller this one would use) does not support these SMBus block calls
> either.

Wrong assumption. All it means is that the original driver author took
the most direct path to get the driver working on _his_ hardware, which
apparently supported I2C. He left it to other developers (i.e. you) to
update the code if the driver was needed to work on top of less gifted
controllers.

>  I feel a bit uneasy about unconditional emulation of SMBus block calls
> with a series of corresponding byte read/write calls.  The reason is it
> changes the semantics -- given how the I2C bus is specified, a device is
> free to interpret a series of byte calls differently to seemingly
> equivalent block calls.

You are absolutely correct, and this is the reason why no such
emulation is done in i2c-core. However a number of chip drivers do that
emulation when they know that this is correct for their chip (e.g.
drivers/i2c/chips/eeprom.c). So you are free to do a similar emulation
in the rtc-m41t80 driver.

>                         It may not support one or the other altogether as
> well.  Even this simple RTC device differs slightly in this respect, by
> latching or not the clock registers.  Admittedly in this case the effect
> of the difference can be eliminated by rereading the least significant 
> part of the timestamp considered, but it cannot be universally guaranteed.  
> Which is why I would prefer not to hide these details behind an interface.
> 
>  I think a pair of functions called i2c_smbus_read_i2c_byte_data() and
> i2c_smbus_write_i2c_byte_data() could be added to the core though.  Their
> implementations might choose either byte or block transfers as available
> within a given SMBus controller and they could be used by drivers known
> for sure not to care about which kind of the transfers is uses (either
> because the relevant piece of hardware does not care or because the driver
> caters for either scenario).  What do you think?

This has been discussed recently on the lm-sensors list:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022908.html
(Search for "the smbus layer doesn't emulate it".)

The conclusion was that we may implement the emulation in i2c-core if
enough drivers needed it, and they agreed on the implementation. But
you shouldn't wait for it to happen, just do the emulation in your
driver for now. I'm really not sure if an i2c-core implementation will
ever happen, just look at the code in the eeprom driver, it's really
simple and I'm not sure we would save much by moving the emulation to
i2c-core. Plus, with the emulation done by each driver, the driver is
free to implement the emulation exactly the way it wants depending on
what the chip itself supports.

>  BTW, as mentioned elsewhere the SMBus controller of the BCM1250A SOC can
> be switched into a bit-banged raw I2C mode, where you can send whatever
> you want over the bus and block tranfers would not be a problem at all,
> but hopefully you agree this is not necessarily the best idea ever.

That's a trade-off... Bit-banged I2C is more CPU-intensive, but if you
can do block transactions that way, you might save some time. I'd say
it depends on which chip you're accessing and the size of the blocks.
If you're reading 10 bytes from an RTC chip once in a while, it's
probably not worth the effort. If you're reading a firmware from a large
EEPROM at boot time, you may consider it. But also keep in mind that
i2c-algo-bit can't run too fast, it is not necessarily stable over 100
kHz and simply cannot go above 250 kHz due to a design limitation. So
if your hardware controller does 400 kHz I2C, there's probably not much
to win by doing bit-banged I2C.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

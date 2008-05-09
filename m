From: "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80
Date: Fri, 9 May 2008 20:18:22 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805091917370.10552@cliff.in.clinika.pl>
References: <200805070120.03821.david-b@pacbell.net>
	<Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
	<20080508093456.340a42b0@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080508093456.340a42b0-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

 I am not dead anymore, so here it goes...

> If you think a change doesn't deserve a separate patch, I say it
> doesn't deserve to be done at all. The golden rule is to have separate
> patches for separate changes.

 I agree with the rule in general, although you always have to apply
common sense, as with everything in life -- complete inflexibility gets
you nowhere.  Originally patches comprising style correction only were not
allowed for Linux at all.  Based on my observation of the janitorial and
trivial monkey work over the last few years I think this is no longer the
case, but from various discussions at the relevant mailing lists I gather
small corrections of this kind are best to be included with substantive
changes within the area of interest.

 And last but not least I think the matter is not that a change that does
not deserve a separate patch, does not deserve to be done at all, but that
there are some changes that do not deserve extra people's effort to handle
them, but if they come for free with other changes, then this is not a big
deal.  I apply this rule to whatever changes I happen to be in charge to
ack and nobody has complained so far. :-)

> The problem is that there is no such rule in Documentation/CodingStyle,
> and in general developers don't care about sorting the header inclusions
> alphabetically or otherwise, so it is unlikely that your sort will
> survive the next changes that will happen in this area. So I join David
> in saying that this change is just not needed.

 Well, given no general rule any is valid.  I think anybody clever enough
to notice an obvious rule having been applied will follow it.  Personally
seeing no immediate rule within header inclusions I always have to invest
some brainpower in answering the question: "Is there any reason these
headers are in this particular order or not?  If so, where should I add a
new one -- would the beginning or the end be OK or should it come just
after <linux/fs.h>?"  This is because historically we used to have
ordering dependencies.  I think most of them have gone now, but few may
still remain.  If the alphabetical and functional (i.e. linux/ vs asm/,
etc.) order is kept, there is no need for such a question.  Besides, it
solves the problem of unnecessary multiple inclusions of the same file
popping out from time to time -- last seen yesterday with some report. ;-)

> The driver rightly checks I2C_FUNC_SMBUS_BYTE_DATA because it calls
> i2c_smbus_read_byte_data() and i2c_smbus_write_byte_data(). A driver
> calling specific SMBus transaction functions should always check that
> they are supported by the underlying bus driver first.
> 
> You are correct that, with what we said above, checking for
> I2C_FUNC_I2C and checking for I2C_FUNC_I2C | I2C_FUNC_SMBUS_FOO
> should be the same. However, this is only strictly equivalent if the
> underlying bus driver supports I2C without any restriction. In practice
> this is rarely the case, most I2C controllers have limitations. Many
> don't support zero-byte messages, for example. Some don't support more
> than 2 messages in a transaction, and some additionally have limits to
> the maximum length of messages. We've even seen a controller lately
> that would only support messages of 1, 8, 16 and 32 bytes.
> 
> For this reason, it is up to the bus driver to declare exactly what
> part of SMBus they can emulate. Most of the time it's
> I2C_FUNC_SMBUS_EMUL (which is a _subset_ of the SMBus transaction set
> plus the I2C block transactions) but some drivers remove a few
> functionality bits and some add a few ones. That's the reason why the
> I2C chip drivers must still check for individual functionality bits if
> they do direct calls to specific SMBus transaction functions.

 Ah, I see -- I must have missed it from documentation or perhaps it is
somewhat unclear.  You mean our I2C API implies a driver for a
full-featured raw I2C controller -- say a bit-banger -- will set
I2C_FUNC_I2C | I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE |
[...] to let the core know these subsets of functionality can be achieved
somehow with this piece of silicon, even though there may be no dedicated
hardware support and all the layers of emulation may have to be involved 
-- am I correct?

 OK, I will adjust my changes accordingly.

> Important note: the chip supports _I2C_ block transactions, as David
> properly wrote. These are different from _SMBus_ block transactions.

 I have noticed that already, indeed, thanks.

> Wrong assumption. All it means is that the original driver author took
> the most direct path to get the driver working on _his_ hardware, which
> apparently supported I2C. He left it to other developers (i.e. you) to
> update the code if the driver was needed to work on top of less gifted
> controllers.

 Well, such an approach deserves a note somewhere around the piece of code
in question.

> You are absolutely correct, and this is the reason why no such
> emulation is done in i2c-core. However a number of chip drivers do that
> emulation when they know that this is correct for their chip (e.g.
> drivers/i2c/chips/eeprom.c). So you are free to do a similar emulation
> in the rtc-m41t80 driver.

 Code duplication is wrong and happens too often and it cannot be stressed
too much, so I will repeat again -- if there is anything to share, every
effort should be taken for it to be shared.  I agree it should be outside
the core, i.e. either in headers if trivial enough to be an inline
function or otherwise in a reasonable place like drivers/i2c/lib/.

> This has been discussed recently on the lm-sensors list:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022908.html
> (Search for "the smbus layer doesn't emulate it".)

 Thanks for the reference.

> The conclusion was that we may implement the emulation in i2c-core if
> enough drivers needed it, and they agreed on the implementation. But
> you shouldn't wait for it to happen, just do the emulation in your
> driver for now. I'm really not sure if an i2c-core implementation will
> ever happen, just look at the code in the eeprom driver, it's really
> simple and I'm not sure we would save much by moving the emulation to
> i2c-core. Plus, with the emulation done by each driver, the driver is
> free to implement the emulation exactly the way it wants depending on
> what the chip itself supports.

 See my note above.  Small differences may be parametrised.  Large ones
may need a private copy, indeed, and this is the trade-off.

> That's a trade-off... Bit-banged I2C is more CPU-intensive, but if you
> can do block transactions that way, you might save some time. I'd say
> it depends on which chip you're accessing and the size of the blocks.
> If you're reading 10 bytes from an RTC chip once in a while, it's
> probably not worth the effort. If you're reading a firmware from a large
> EEPROM at boot time, you may consider it. But also keep in mind that
> i2c-algo-bit can't run too fast, it is not necessarily stable over 100
> kHz and simply cannot go above 250 kHz due to a design limitation. So
> if your hardware controller does 400 kHz I2C, there's probably not much
> to win by doing bit-banged I2C.

 The BCM1250A can go up to 12.5MHz on its I2C buses in hardware; I do not
know how many client devices if any at all can go beyond 400kHz by the
spec.  Besides, the SOC can drive I2C in the interrupt mode and now that
matters, doesn't it?  Our driver sets the bus #1 to 400kHz and the bus #0
to 100kHz -- I gather this is because SDRAM sockets are wired to the
latter.

  Maciej

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

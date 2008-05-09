From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80
Date: Fri, 9 May 2008 22:27:54 +0200
Message-ID: <20080509222754.03de1c54@hyperion.delvare>
References: <200805070120.03821.david-b@pacbell.net>
	<Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
	<20080508093456.340a42b0@hyperion.delvare>
	<Pine.LNX.4.55.0805091917370.10552@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.55.0805091917370.10552-j8+e0ZhYU2SU0huXySazC6sMm+1xrEX8@public.gmane.org>
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

On Fri, 9 May 2008 20:18:22 +0100 (BST), Maciej W. Rozycki wrote:
>  I am not dead anymore, so here it goes...

Welcome back to the world of the living creatures then. How was the
other world? :)

> > If you think a change doesn't deserve a separate patch, I say it
> > doesn't deserve to be done at all. The golden rule is to have separate
> > patches for separate changes.
> 
>  I agree with the rule in general, although you always have to apply
> common sense, as with everything in life -- complete inflexibility gets
> you nowhere.  Originally patches comprising style correction only were not
> allowed for Linux at all.

Really? I don't remember any such rule, so this must have been before
2003.

>                            Based on my observation of the janitorial and
> trivial monkey work over the last few years I think this is no longer the
> case, but from various discussions at the relevant mailing lists I gather
> small corrections of this kind are best to be included with substantive
> changes within the area of interest.

We probably don't read the same mailing lists, all the ones I am reading
clearly carry the message that cleanups go to separate patches.

>  And last but not least I think the matter is not that a change that does
> not deserve a separate patch, does not deserve to be done at all, but that
> there are some changes that do not deserve extra people's effort to handle
> them, but if they come for free with other changes, then this is not a big
> deal.  I apply this rule to whatever changes I happen to be in charge to
> ack and nobody has complained so far. :-)

You're wrong in your assumption that adding coding style cleanups to a
patch is "for free". It makes reviewing the patch more difficult, and it
makes backporting the patch more difficult, too (cleanups increase the
risks that the patch won't apply to an older kernel, and you have to
filter out all cleanups for -stable.) Compared to this, the time spent
to handle a separate, cleanup-only patch is very small by my maintainer
experience.

> > The problem is that there is no such rule in Documentation/CodingStyle,
> > and in general developers don't care about sorting the header inclusions
> > alphabetically or otherwise, so it is unlikely that your sort will
> > survive the next changes that will happen in this area. So I join David
> > in saying that this change is just not needed.
> 
>  Well, given no general rule any is valid.

Definitely not :p

>                                             I think anybody clever enough
> to notice an obvious rule having been applied will follow it.

You're wrong again, sorry. Developers are always in a hurry, they often
fail to follow the written rules, they just won't care about unwritten
ones.

Want an example? Look at MAINTAINERS. It is supposed to be sorted
alphabetically, the header says so and pretty much everyone should be
aware of it by now, still you can check by yourself that of the 600
entries in that file, about 100 are not at the correct place.

That was for data for which being sorted has some value, and that is
clearly documented as being sorted. So I let you guess what will happen
to your header include list, which is not documented to be sorted and
for which being sorted has little interest.

>                                                                Personally
> seeing no immediate rule within header inclusions I always have to invest
> some brainpower in answering the question: "Is there any reason these
> headers are in this particular order or not?  If so, where should I add a
> new one -- would the beginning or the end be OK or should it come just
> after <linux/fs.h>?"  This is because historically we used to have
> ordering dependencies.  I think most of them have gone now, but few may

I sure hope that they are all gone by now. Headers which need to
included in a specific order are a bug.

> still remain.  If the alphabetical and functional (i.e. linux/ vs asm/,
> etc.) order is kept, there is no need for such a question.  Besides, it
> solves the problem of unnecessary multiple inclusions of the same file
> popping out from time to time -- last seen yesterday with some report. ;-)

I think we have a script to find duplicates. I admit that sorting the
headers in alphabetical order solve the problem. But OTOH, if
developers can't be bothered to make sure they don't add a duplicate
header, I doubt that they can be bothered to keep the includes sorted
alphabetically.

>  Ah, I see -- I must have missed it from documentation or perhaps it is
> somewhat unclear.  You mean our I2C API implies a driver for a

It's documented in Documentation/i2c/functionality. If something is
unclear, please let me know and/or send a patch.

> full-featured raw I2C controller -- say a bit-banger -- will set
> I2C_FUNC_I2C | I2C_FUNC_SMBUS_READ_BYTE | I2C_FUNC_SMBUS_WRITE_BYTE |
> [...] to let the core know these subsets of functionality can be achieved
> somehow with this piece of silicon, even though there may be no dedicated
> hardware support and all the layers of emulation may have to be involved 
> -- am I correct?

Yes, you are correct. In general, full-featured I2C bus drivers simply
declare I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL. I2C_FUNC_SMBUS_EMUL
includes all the SMBus transactions which can be emulated by i2c-core
without the cooperation of the bus driver, with the addition of the
I2C block transactions (because many SMBus controllers can handle them,
too.)

> > (...)
> > You are absolutely correct, and this is the reason why no such
> > emulation is done in i2c-core. However a number of chip drivers do that
> > emulation when they know that this is correct for their chip (e.g.
> > drivers/i2c/chips/eeprom.c). So you are free to do a similar emulation
> > in the rtc-m41t80 driver.
> 
>  Code duplication is wrong and happens too often and it cannot be stressed
> too much, so I will repeat again -- if there is anything to share, every
> effort should be taken for it to be shared.

More exactly: if there is anything to share _and the added cost of
sharing is less than the benefit_ then it should be done. Additional
kernel modules have a cost. Even just exporting additional functions,
has a cost. Going through an interface often has a cost. The benefit on
the maintenance front must overcome these, otherwise it's not worth
doing it.

>                                             I agree it should be outside
> the core, i.e. either in headers if trivial enough to be an inline
> function or otherwise in a reasonable place like drivers/i2c/lib/.

It definitely won't be trivial enough to go in headers.

> > This has been discussed recently on the lm-sensors list:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022908.html
> > (Search for "the smbus layer doesn't emulate it".)
> 
>  Thanks for the reference.
> 
> > The conclusion was that we may implement the emulation in i2c-core if
> > enough drivers needed it, and they agreed on the implementation. But
> > you shouldn't wait for it to happen, just do the emulation in your
> > driver for now. I'm really not sure if an i2c-core implementation will
> > ever happen, just look at the code in the eeprom driver, it's really
> > simple and I'm not sure we would save much by moving the emulation to
> > i2c-core. Plus, with the emulation done by each driver, the driver is
> > free to implement the emulation exactly the way it wants depending on
> > what the chip itself supports.
> 
>  See my note above.  Small differences may be parametrised.  Large ones
> may need a private copy, indeed, and this is the trade-off.

You assume that there is roughly only one way to emulate reading or
writing a block from/to an I2C or SMBus device, with only slight
variations. I would love it the I2C world was that simple, but
unfortunately it is not. Each device has its own constraints on how a
block read/write can be emulated. For example on some devices you can
use word reads as an alternative to block reads, but other devices will
only accept byte reads as an alternative. Some devices will accept byte
reads but not at the same address as the block read (see for example
drivers/hwmon/lm93.c - actually this is mandatory for SMBus block
reads), etc. So I am still skeptical that we can come up with one or
more emulation functions that can be used by more than 2 drivers and
still get the best of each device.

But well, if you want to give it a try, just go on, prepare a patch,
and send it for review.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

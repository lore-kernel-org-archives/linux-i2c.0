From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
Date: Wed, 7 May 2008 16:25:20 -0700
Message-ID: <200805071625.20430.david-b@pacbell.net>
References: <200805070120.03821.david-b@pacbell.net>
	<Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.55.0805072226180.25644-j8+e0ZhYU2SU0huXySazC6sMm+1xrEX8@public.gmane.org>
Content-Disposition: inline
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
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 07 May 2008, Maciej W. Rozycki wrote:
> On Wed, 7 May 2008, David Brownell wrote:
> 
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

It checks for "I2C_FUNC_I2C | I2C_FUNC_SMBUS_BYTE_DATA" which is
admittedly odd.  Because if it can do I2C, it can assuredly do
that minor subset of SMBus.  (Modulo bugs in how drivers end up
reporting their capabilities.)


> > > +static int m41t80_write_byte_data(struct i2c_client *client, u8 reg, u8 val)
> > > +{ 
> > > +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> > > +		return m41t80_i2c_transfer(client, 1, reg, 1, &val);
> > > +	else
> > > +		return i2c_smbus_write_byte_data(client, reg, val);
> > > +}
> > 
> > That's because if an I2C controller can execute that protocol,
> > it can do so through the SMBus calls too.  And the current code
> > already verifies that will work ... those wrappers are pointless,
> > as well as untested.
> 
>  Do you mean our generic I2C code emulates SMBus calls if the hardware
> does not support them directly?  Well, it looks to me it indeed does and
> you are right, but I have assumed, perhaps mistakenly, (but I generally
> trust if a piece of code is there, it is for a reason), that this driver
> checks for I2C_FUNC_SMBUS_BYTE_DATA for a purpose.

That purpose being:  it makes those SMBus calls explicitly.
(And it makes i2c_transfer calls explicitly too...)


> > The chip docs basically tell us that if the underlying SMBus
> > controller can issue i2c_smbus_read_i2c_block_data() and its
> > write-side sibling, it can *easily* talk to this chip.
> 
>  Well, I have obviously missed the existence of the SMBus block transfer
> and you have correctly inferred this means the controller used here does
> not support them.  The SOC implements a "subset of a standard SMBus
> controller with some extensions" -- the subset being send/receive byte,
> write/read byte and write/read word.

That's what I noticed in the current driver, yes.


> The extensions are 16-bit commands 
> (required by another RTC chip used on some of these boards) and an obscure
> subset of the process call and block read/write commands (called an EEPROM
> read and an extended write/read, respectively).

Subset of process call??  That's send-three-bytes, receive-two-bytes.
Not possible to subset it ... anything else isn't a process call!!

Presumably those block read/write commands aren't quite enough
for you to implement i2c_smbus_read_i2c_block_data() and friend?


> > So wouldn't it be a better idea to just replace the existing
> > calls to i2c_transfer() with those pseudo-SMBus block calls?
> 
>  I can do that, no problem.  It looks like a good way to eliminate code 
> duplication here.

And work on systems that don't support full I2C messaging, but
can support that minor SMBus extension.  (Which includes all
systems capable of full I2C, and a few others that this driver
currently won't support.)


> > And then *separately* add workarounds for i2c-sibyte, and
> > similar controllers that don't offer block transfers?  Maybe
> > using your existing structure ... just not replacing those
> > existing perfectly-fine SMBus calls.
> 
>  Given the driver uses a mixture of SMBus calls and raw I2C calls, I would
> assume the other controller currently used with the driver (that's the
> D-Link DNS-323 platform -- I cannot immediately figure out which I2C
> controller this one would use) does not support these SMBus block calls
> either.

If it can support the I2C version of those calls, it can support
the I2C version of those calls as made by the SMBus "emulation"
code.  Don't worry about that.


>  I feel a bit uneasy about unconditional emulation of SMBus block calls
> with a series of corresponding byte read/write calls.  The reason is it
> changes the semantics

No it doesn't.  The I2C signal transitions (SCL/SDA) will be
exactly the same.  It's IMO very misleading to call it "emulation"
since it's nothing more than a different software interface to
the same functionality.


>     -- given how the I2C bus is specified, a device is 
> free to interpret a series of byte calls differently to seemingly
> equivalent block calls.  It may not support one or the other altogether as
> well.  Even this simple RTC device differs slightly in this respect, by
> latching or not the clock registers.

That's a different issue.  In that case you're switching to
different protocol operations, to cope with limitations of
the underlying controller.

Different protocol == different semantics.

So that's not the same as just using a different programming
interface to execute a given sequence of protocol messages.


> Admittedly in this case the effect 
> of the difference can be eliminated by rereading the least significant 
> part of the timestamp considered, but it cannot be universally guaranteed.  
> Which is why I would prefer not to hide these details behind an interface.

That would be internal to the m41t80 driver, not part of the
i2c core.  (As your patch already does ...)

 
>  I think a pair of functions called i2c_smbus_read_i2c_byte_data() and
> i2c_smbus_write_i2c_byte_data() could be added to the core though.

Too late.  Those calls have been in the I2C core for a long
time now.  ;)


> Their 
> implementations might choose either byte or block transfers as available
> within a given SMBus controller and they could be used by drivers known
> for sure not to care about which kind of the transfers is uses (either
> because the relevant piece of hardware does not care or because the driver
> caters for either scenario).  What do you think?

You shouldn't think about changing the i2c core for that.


>  BTW, as mentioned elsewhere the SMBus controller of the BCM1250A SOC can
> be switched into a bit-banged raw I2C mode, where you can send whatever
> you want over the bus and block tranfers would not be a problem at all,
> but hopefully you agree this is not necessarily the best idea ever.

Between two drivers that both busy-wait and burn CPU cycles, I'd
much rather have the one that provides the full functionality
needed for the bus.  So I'd choose that bitbanger, no question.

If the SMBus driver were more functional, AND didn't busy-wait,
then I'd consider using the native hardware.

- Dave




>  Thanks a lot for your review!
> 
>   Maciej
> 



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

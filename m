From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Thu, 5 Feb 2015 09:53:26 -0800
Message-ID: <20150205175326.GA26691@roeck-us.net>
References: <1423067017-27607-1-git-send-email-linux@roeck-us.net>
 <20150204174723.GB30930@katana>
 <20150204190819.GA15467@roeck-us.net>
 <20150204233516.GA1677@katana>
 <20150205002630.GA396@roeck-us.net>
 <20150205144028.GA4865@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150205144028.GA4865@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 05, 2015 at 03:40:28PM +0100, Wolfram Sang wrote:
> > > > At the same time multi-master access is quite rare.
> > > 
> > > It should still work in those rare cases. A setup of an SoC, an EC
> > > (those like to be masters, as well), and an EEPROM is not very far off.
> 
> To clarify: What I meant here is, at24 should also work in those rare
> cases reliably (like the described case of SoC, EC and EEPROM). Your
> patch sacrificies this reliability.
> 
But it won't, and it can't. 24c32 should simply not be used in such cases.
Besides, at least on PCs, ACPI should reserve and thus block SMBus access
if it is used by an EC (or IPMI or similar).

I don't think it should (or even can) be the Linux kernel's responsibility
to ensure that the hardware does not prevent such problems.

> > It won't work if the 24c32 is connected to a controller which only supports
> > SMBus transactions. Also, there is no problem if it is connected to a
> > controller supporting direct i2c accesses.
> 
> I know and agree.
> 
> > The only real solution is to not use an SMBus-only controller together
> > with 24c32 or any similar chip in such situations.
> 
> Exactly.
> 
> > > Huh, using i2c_transfer to ensure 'repeated start' between messages
> > > should do the trick, no? Drivers doing this via SMBus calls are broken
> > > and should be fixed.
> > > 
> > 
> > That would require all those drivers to have two separate implementations,
> > or to declare that any such chips must only be connected to controllers
> > supporting direct i2c accesses.
> 
> Yes, TBH I though this was the case. Which drivers did you find using
> unsafe SMBus transactions?
> 

An easy example would be multi-bank i2c hardware monitoring chips.
Those will typically be connected to the ICH and thus depend on SMBus
transactions (besides for the most part being specified as SMBus chips),
and obviously require multiple transactions in a sequence (though
normally the bank register is simply cached and not rewritten).

But there are many other examples.

As a starting point, all i2c muxes and by implication drivers for chips
behind them are not multi-master safe. There is nothing preventing
master #2 from changing the mux port after master #1 selected it.

That is just a start. It is hard to imagine that any I2C based TPM chip
is multi-master safe, much less its driver. At least some I2C GPIO expanders
require multiple SMBus transactions (look for pca957X). Others cache output
bytes and only update bits when updating pin values (pcf857x). It is also
difficult to imagine that any i2c clock chips can be programmed or
even polled with a single SMBus transaction.

Another interesting example is regmap-i2c, specifically regmap_update_bits.
This function performs an i2c read followed by some bit masking and a write.
Obviously that is not multi-master safe, no matter what you do.
Any other i2c chip driver which has to do a read-modify-write sequence
is by definition not multi-master safe (including most if not all i2c
gpio expanders).

Browsing through code, I also see accelerometer drivers using multi-command
SMBus transactions. At least some adc drivers do the same. Humidity sensors do
it, both in hwmon and iio. Various light sensors do it. Magnetometer sensors
do it. Keyboard drivers do it. And so on; at this point I stopped looking.

> > Both isn't really practical and defies the real world, where any kind
> > of chip will be connected to SMBus-only controllers.
> 
> Is it that bad? The vast majority of controllers I come across in the
> embedded world are more like I2C than SMBus controllers. They have their
> quirks but most support repeated starts somehow. This is why I came up

I encounter a lot of chips connected to ICH. Obviously all of them are
affected.

> with the quirk infrastructure BTW, to describe what the controller is
> capable of and what not. So, users can check if the controller is up to
> what the user needs and then they can decide what to do if they
> encounter a too limited controller.
> 
> Back to topic: I2C and SMBus are multi-master busses. Drivers have to
> cope with that. If we say "let's assume single master busses, because
> most of them out there are exactly that", then we open a window for
> very subtle and hard to find bugs for the multi-master case. And people
> would get rightfully angry IMO, because they should expect specified
> things to work.
> 
I don't think that is correct; there would have to be a lot of angry
people out there if that would be the case.

> However, if people are connecting I2C devices to an SMBus controller,
> well, they ask for prob^H^H^H^H special cases and they need to deal with
> that. And using a module parameter is not much to deal with if you ask
> me. BTW another idea I got was that a user could mark an SMBus
> controller as "single-master", so a driver can check for that and use
> some fallback.
> 
You would have to add that module parameter to a lot of drivers. And you would
have to rewrite a lot of drivers to use i2c transactions instead of SMBus
transactions. As mentioned above, in read-modify-write cases that isn't even
possible, or at least I would have no idea how to implement it.

> I am really all for the "better-safe-than-sorry" approach here. I am not
> objecting if somebody wants to move out of that area. It needs some form
> of "yes, I really want to do that" however.
> 
How about adding a warning to the driver, such as the following,
if chips such as the 24c32 are connected to an SMBus controller ?

	"reading data from the chip in multi-master systems is not reliable"

> 
> > A worse situation would occur if the chip specifically
> > (only) supports SMBus transactions and thus doesn't explicitly support
> > repeated start after completion of one transaction.
> 
> You lost me here. Is "the chip" the master or the slave?
> 
Slave.

> > This may or may not
> > work depending on the chip or even chip revision, and it usually would
> > not be specified as a valid transaction in the chip datasheet.
> 
> Can you elaborate, please?
> 
As an example, a normal write byte sequence is
	<s><addr><w><A><command><A><data><A><p>
and read sequence is
	<s><addr><w><A><command><A><sr><addr><r><A><data><N><p>

In your case you would want to combine that to something like
	<s><addr><w><A><command><A><data><A>
	<sr><addr><w><A><command><A><sr><addr><r><A><data><N><p>

I am not aware of a SMBus (client) chip which explicitly specifies
that it would support such combined SMBUs transactions in a single
sequence without stop condition in between. Maybe there are some,
but I never encountered any. I also don't see such a sequence
specified in the SMBus standard, though maybe I am missing it.
Given that, I would be very hesitant to implement and rely on
support for such a sequence in any of my drivers.

Thanks,
Guenter

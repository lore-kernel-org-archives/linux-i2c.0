From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Fri, 23 May 2008 09:17:03 +0200
Message-ID: <20080523091703.2ba86bb1@hyperion.delvare>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<20080522222022.68d65cd7@hyperion.delvare>
	<200805221435.36829.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805221435.36829.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 22 May 2008 14:35:36 -0700, David Brownell wrote:
> On Thursday 22 May 2008, Jean Delvare wrote:
> > Hi Wolfram, hi David,
> > 
> > On Thu, 15 May 2008 22:36:39 +0200, Wolfram Sang wrote:
> > > Add a new-style driver for most I2C EEPROMs, giving sysfs read/write
> > > access to their data. Tested with various chips and clock rates.
> > 
> > Preliminary note: I'm curious if sysfs is the right interface for
> > writable EEPROMs. Isn't /dev/mtd supposed to be used for this purpose?
> 
> It's never been used for that before.  Consider also all the
> various /sys/class/rtc/rtc0/device/nvram files,

Isn't there /dev/nvram too?

> as well as what the current "eeprom" driver does.

Whatever the "eeprom" driver does is not necessarily meaningful. It
uses sysfs because it was considered a "sensor" driver for a long time
and hardware monitoring drivers use sysfs.

>                                         Being writable isn't
> a good reason to adopt a new naming convention.  And having
> char device nodes is both needless and confusing ... there'd
> still need to be a way to map the device back to the hardware,
> which comes for free with sysfs.
> 
> Plus, it doesn't support the MTD model ... which, as someone
> pointed out, is more attuned to filesystems (lots of data,
> vs a relative handful of bytes).

I'm not insisting... I just seemed to remember that binary files
in /sysfs were only tolerated and should be avoided when possible. I
don't remember where I read that though.

> > Another difference is that the eeprom driver caches the data for 5
> > minutes, while the at24 driver doesn't.
> 
> Which IMO is kind of a waste of energy ... and I think you didn't
> say it right.  It caches the data forever, but refreshes it if it's
> older than 5 minutes.

What difference does that make?

>                       If you're going to talk about performance,
> it's probably worth just saying that "at24" will usually be faster
> since it uses block I/O primitives.

The slowness of the eeprom driver is exactly the reason why we made it
cache the data. Your at24 driver is faster, but it will fail to work on
most SMBus adapters (I2C block transaction support is a rare feature.)
If we ever want to get rid of the eeprom driver, SMBus-compatible
access will have to be added to the at24 driver, and with it I suspect
that we will want to get the caching feature, unless the situation has
improved a lot meanwhile.

> > > +	client = to_i2c_client();
> 
> Needs a parameter ... ;)

I accidentally broke the quote while replying to it, my bad.

> > > +	at24 = i2c_get_clientdata(client);
> > 
> > If that's the only thing you need client for, you'd rather do:
> > 
> > 	at24 = dev_get_drvdata(container_of(kobj, struct device, kobj));
> 
> Better:  at24 = i2c_get_clientdata(to_i2c_client(kobj));
> 
> GCC shouldn't care, and it's a lot more clear when that line
> can be tied to other (i2c-specific) code elsewhere.

Err, please, no. That would be a fragile hack.

> > > +static ssize_t at24_ee_write(struct at24_data *at24, char *buf, loff_t off,
> > > +		size_t count)
> > > +{
> > > +	struct i2c_client *client;
> > > +	struct i2c_msg  msg;
> > 
> > Doubled space.
> > 
> > > +	unsigned offset = (unsigned) off;
> > 
> > Why don't you simply make the offset parameter an unsigned int, if
> > that's what you want?
> 
> The sysfs API says it's "loff_t"; can't change that.

at24_ee_write() is a helper function, not a sysfs callback function, so
we are free to use whatever parameter types we want. As a matter of
fact, at24_ee_read() has its offset passed as an unsigned.

> > > +	dev_err(&client->dev, "write %zd@%d, timeout %ld ticks\n",
> > > +			count, offset, jiffies
> > > +			- (timeout - msecs_to_jiffies(write_timeout)));
> > 
> > I'm not sure what value there is to print the number of ticks. We
> > already know that it'll be the next possible value after write_timeout.
> 
> For debugging it was nice to know just how long it waited.

So it can go away now? Or be moved to a dev_dbg().

> > > +	dev_info(&client->dev, "%Zd byte %s EEPROM%s\n",
> > > +		at24->bin.size, client->name,
> > > +		writable ? " (writable)" : "");
> > 
> > What about explicitly saying " (read-only)" for read-only EEPROMs?
> 
> Instead of "(writable)"?  Probably makes sense; the bias here
> is to provide full access, and messages should call out what's
> uncommon, not what's common.

I was thinking: in addition to "(writable)". You have writable EEPROMs
in mind but users may not, so I think it's better to just write what we
have explicitly. It's not that expensive.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

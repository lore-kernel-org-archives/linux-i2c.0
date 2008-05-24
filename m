From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Sat, 24 May 2008 14:11:25 -0700
Message-ID: <200805241411.25615.david-b@pacbell.net>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<200805221435.36829.david-b@pacbell.net>
	<20080523091703.2ba86bb1@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080523091703.2ba86bb1-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Friday 23 May 2008, Jean Delvare wrote:
> > > Preliminary note: I'm curious if sysfs is the right interface for
> > > writable EEPROMs. Isn't /dev/mtd supposed to be used for this purpose?
> > 
> > It's never been used for that before.  Consider also all the
> > various /sys/class/rtc/rtc0/device/nvram files,
> 
> Isn't there /dev/nvram too?

There is such a legacy driver; I don't believe it's much
used.  The ATARI bits, for example.  Seems to me the main
point of that driver is the /proc/driver/nvram file, which
parses some of the better understood fields.

Note that the "nvram" contents are extremely specific to
the platform ... and that on non-PC hardware there might
be more than one device with NVRAM.  The /dev/nvram stuff
does not allow multiple NVRAM files.


> > as well as what the current "eeprom" driver does.
> 
> Whatever the "eeprom" driver does is not necessarily meaningful. It
> uses sysfs because it was considered a "sensor" driver for a long time
> and hardware monitoring drivers use sysfs.

The existing model for EEPROMs *should* be meaningful!
If for no other reason than not needlessly exposing a
different interface to the same SPD EEPROM.

It wouldn't necessarily be determinative, of course.
What might be determinative would be a compelling reason
that a binary sysfs file is the wrong model.  And there
don't seem to be any such reasons.


> > Plus, it doesn't support the MTD model ... which, as someone
> > pointed out, is more attuned to filesystems (lots of data,
> > vs a relative handful of bytes).
>
> I'm not insisting... I just seemed to remember that binary files
> in /sysfs were only tolerated and should be avoided when possible. I
> don't remember where I read that though.

It would be the wrong model for e.g. exposing a register bank;
that's where I recall specific pushback.


> > > Another difference is that the eeprom driver caches the data for 5
> > > minutes, while the at24 driver doesn't.
> > 
> > Which IMO is kind of a waste of energy ... and I think you didn't
> > say it right.  It caches the data forever, but refreshes it if it's
> > older than 5 minutes.
> 
> What difference does that make?

Memory consumption.  When it's only the 256 bytes of the old
EEPROM driver, that may not matter.  But when you're talking
about needlessly tying down several pages (e.g. 64 KB for the
24c512 EEPROMs found on some of my ARM boards) virtually
forever ... the fact that there's no cache purging (or any
intelligence about how much to cache) can be a big deal.


> >                       If you're going to talk about performance,
> > it's probably worth just saying that "at24" will usually be faster
> > since it uses block I/O primitives.
> 
> The slowness of the eeprom driver is exactly the reason why we made it
> cache the data.

How much does that matter though, for SMBus systems where the
only reason to read the SPD data is to see what kind of memory
is available?  (In more detail than the DMI tables expose.)

It'd be rare to need that data more than a few times, ever.
(Ergo "waste of energy".)

Plus, caching presumes the system isn't multi-master, where
another master could change the data (without any way to
invalidate such a local cache).  SMBus restricts itself to
a single master, but I2C doesn't.


> Your at24 driver is faster, but it will fail to work on 
> most SMBus adapters (I2C block transaction support is a rare feature.)

Well, a quick check shows that the i801 SMBus support on most
recent motherboards with Intel chipsets can do it.  So it's
hardly "rare"; more accurate would be "common".  (I suspect
some of the other SMBus drivers could do those transactions,
but their drivers don't yet know how.)

But it's true that it's not universal.  Also true that it's
very fixable ... and that using "word" (16 bits not 32/64/...)
would be an easy 100+% performance boost over byte-at-a-time
reads/writes!


> > > > +	unsigned offset = (unsigned) off;
> > > 
> > > Why don't you simply make the offset parameter an unsigned int, if
> > > that's what you want?
> > 
> > The sysfs API says it's "loff_t"; can't change that.
> 
> at24_ee_write() is a helper function, not a sysfs callback function, so
> we are free to use whatever parameter types we want. As a matter of
> fact, at24_ee_read() has its offset passed as an unsigned.

Forgot about that.  OK, changing that to "unsigned" would be fine.


> > > > +	dev_err(&client->dev, "write %zd@%d, timeout %ld ticks\n",
> > > > +			count, offset, jiffies
> > > > +			- (timeout - msecs_to_jiffies(write_timeout)));
> > > 
> > > I'm not sure what value there is to print the number of ticks. We
> > > already know that it'll be the next possible value after write_timeout.
> > 
> > For debugging it was nice to know just how long it waited.
> 
> So it can go away now? Or be moved to a dev_dbg().

Sure.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

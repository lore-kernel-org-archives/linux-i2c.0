From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Add a new-style driver for most I2C EEPROMs
Date: Thu, 22 May 2008 14:35:36 -0700
Message-ID: <200805221435.36829.david-b@pacbell.net>
References: <1210883799-25188-1-git-send-email-w.sang@pengutronix.de>
	<20080522222022.68d65cd7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080522222022.68d65cd7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Thursday 22 May 2008, Jean Delvare wrote:
> Hi Wolfram, hi David,
> 
> On Thu, 15 May 2008 22:36:39 +0200, Wolfram Sang wrote:
> > Add a new-style driver for most I2C EEPROMs, giving sysfs read/write
> > access to their data. Tested with various chips and clock rates.
> 
> Preliminary note: I'm curious if sysfs is the right interface for
> writable EEPROMs. Isn't /dev/mtd supposed to be used for this purpose?

It's never been used for that before.  Consider also all the
various /sys/class/rtc/rtc0/device/nvram files, as well as
what the current "eeprom" driver does.  Being writable isn't
a good reason to adopt a new naming convention.  And having
char device nodes is both needless and confusing ... there'd
still need to be a way to map the device back to the hardware,
which comes for free with sysfs.

Plus, it doesn't support the MTD model ... which, as someone
pointed out, is more attuned to filesystems (lots of data,
vs a relative handful of bytes).


> > ---
> > 
> > As we now support device_ids, probably most of the chip data will come back
> > into the driver. This is yet to be done. Tested on two platforms by me and
> > another one by David. Builds also on x86.
> 
> We have to make a decision about the strategy now, and stick to it.
> Changing it after the driver is upstream will cause a lot of confusion.
> I think that having predefined names for the most common EEPROM sizes
> would be a good idea. You can also keep a generic "at24" type where all
> the parameters have to be provided by platform code.

That's what I was leaning towards.  It should include a chip name,
so the "hai i found ur chip" message can be properly informative.


> > +	  				 Also, if your chip
> > +	  has any software write-protect mechanism you may want to make
> > +	  sure this driver won't turn it on by accident.
> 
> How?

Code review.  "... you may want to review this code to make sure ..."


> > + * Other than binding model, current differences from "eeprom" driver are
> > + * that this one handles write access and isn't restricted to 24c02 devices.
> > + * It also handles larger devices (32 kbit and up) with two-byte addresess,
> 
> Typo: addresses.
> 
> > + * which won't work on pure SMBus systems.
> > + */
> 
> Another difference is that the eeprom driver caches the data for 5
> minutes, while the at24 driver doesn't.

Which IMO is kind of a waste of energy ... and I think you didn't
say it right.  It caches the data forever, but refreshes it if it's
older than 5 minutes.  If you're going to talk about performance,
it's probably worth just saying that "at24" will usually be faster
since it uses block I/O primitives.


> > +	struct i2c_client *client[];
> 
> Isn't this supposed to be
> 
> 	struct i2c_client *client[0];
> 
> ?

ISTR client[0] is the GNU-ism, while ANSI C allows the last
element of a struct to be an unsized array.


> > +	if (unlikely(i > chip->i2c_addr_mask)) {
> > +		dev_err(&at24->client[0]->dev,
> > +			"requested client %u not available!\n", i);
> > +		return NULL;
> > +	}
> 
> That's not just unlikely... that would be a bug in the driver, right?
> This could be protected by #ifdef DEBUG, to not slow down the driver
> uselessly.

Right ...


> > +
> > +	*addr = at24->client[i]->addr;
> 
> Strange idea to return addr in a per-address parameter when the caller
> can get it from the returned client easily. This would also allow for
> some code reordering on the caller side.

That's probably a bit of a historical artifact.


> > +	client = to_i2c_client();

Needs a parameter ... ;)


> > +	at24 = i2c_get_clientdata(client);
> 
> If that's the only thing you need client for, you'd rather do:
> 
> 	at24 = dev_get_drvdata(container_of(kobj, struct device, kobj));

Better:  at24 = i2c_get_clientdata(to_i2c_client(kobj));

GCC shouldn't care, and it's a lot more clear when that line
can be tied to other (i2c-specific) code elsewhere.

 
> > +static ssize_t at24_ee_write(struct at24_data *at24, char *buf, loff_t off,
> > +		size_t count)
> > +{
> > +	struct i2c_client *client;
> > +	struct i2c_msg  msg;
> 
> Doubled space.
> 
> > +	unsigned offset = (unsigned) off;
> 
> Why don't you simply make the offset parameter an unsigned int, if
> that's what you want?

The sysfs API says it's "loff_t"; can't change that.

> > +	dev_err(&client->dev, "write %zd@%d, timeout %ld ticks\n",
> > +			count, offset, jiffies
> > +			- (timeout - msecs_to_jiffies(write_timeout)));
> 
> I'm not sure what value there is to print the number of ticks. We
> already know that it'll be the next possible value after write_timeout.

For debugging it was nice to know just how long it waited.


> > +	/*
> > +	 * Export the EEPROM bytes through sysfs, since that's convenient.
> > +	 * By default, only root should see the data (maybe passwords etc)
> > +	 */
> > +	at24->bin.attr.name = "eeprom";
> > +	at24->bin.attr.mode = S_IRUSR;
> 
> This makes the data only readable by root, as the comment says. The
> eeprom driver makes (most of) the data world-readable. I think it would
> be good to at least have the option to make the data world-readable,
> for example for SPD or EDID data. Otherwise we will never be able to
> drop the eeprom driver.

There are a few flag bits available for that purpose.  ;)

And for the SPD case, it's easy to set that (along with "no write").


> > +				err = -ENOCSI;
> 
> Again a funky error value, completely unrelated with the error that
> occurred. -EBUSY?

For the record, not only are all those error code assignments
ancient (predating recent discussion), but the goal was to have
a unique code for each fault path (as I recall).


> > +	dev_info(&client->dev, "%Zd byte %s EEPROM%s\n",
> > +		at24->bin.size, client->name,
> > +		writable ? " (writable)" : "");
> 
> What about explicitly saying " (read-only)" for read-only EEPROMs?

Instead of "(writable)"?  Probably makes sense; the bias here
is to provide full access, and messages should call out what's
uncommon, not what's common.


> > +#define	AT24_EE_ADDR2		0x0080		/* 16 bit addrs; <= 64 KB */
> 
> What does the "<= 64 KB" means?

Just makes the consequence of 16 bit addressing be obvious:
no more than 64 KibiBytes of data.



_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

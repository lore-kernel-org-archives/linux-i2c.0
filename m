From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
	device_ids)
Date: Thu, 12 Jun 2008 14:17:51 -0700
Message-ID: <200806121417.51446.david-b@pacbell.net>
References: <20080605193103.GA13062@pengutronix.de>
	<200806111025.08951.david-b@pacbell.net>
	<20080611214135.090ea690@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080611214135.090ea690-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Wednesday 11 June 2008, Jean Delvare wrote:
> > The idea you refer to was a simplification:  the driver wouldn't
> > need to maintain lots of chip tables *plus* provide a per-chip
> > override mechanism.  There'd be only platform_data, in all cases.
> 
> Such devices can never be created from user-space then (or maybe using
> configfs? I really need to look into that). The nice thing about i2c
> device names is that it makes devices easy to instantiate.

But they do *NOT* provide enough information to let any given
device connect in non-trivial ways to the rest of the kernel.

Examples include "which IRQ does it use", callbacks that may
be needed to configure things that implicitly rely on that
I2C device, calibration data, and more.

I'm just not a fan of creating devices from userspace, it seems.
The main reason to support such mechanisms is historical.  But
all the I2C systems I work with haven't needed such stuff ...
plus, those legacy configuration schemes required drivers to have
lots of board-specific hacks.  Those hacks went away when we
could finally rely on platform_data.


> > The easy way would be to reference a predefined struct, which
> > could easily be cloned and modified to address pagesize and
> > write protection issues.  (Also the various EEPROMs that were
> > not listed in the current tables.)
> 
> That's what I would like to avoid. I think that providing predefined
> structures is dangerous. You have to look at two places to know what
> you have exactly. If platform data is provided then I would like all of
> it to be spelled out explicitly by the caller. Otherwise I expect some
> confusion.

Thing is, we know developers *WILL* cut'n'paste such stuff.
Many of them won't dig up the data sheets.  Some confusion
is unavoidable ... the issue is how to minimize it.

As I said, my thought there is to make it safe for most
developers to just say "24c32" (or whatever) and have a
sane default ... while making sure that they *always* have
a way to set chips up to be readonly, or provide a better
page size (if they need better bulk write speeds).


> > > I think 
> > > that our decision whether to have default definitions in the driver,
> > > depends on the answer to this question (and you'll know better than me.)
> > 
> > I don't quite follow your decision tree there.  Elaborate please?
> 
> My point is: if EEPROM parts can be swapped easily and manufacturers
> do that, then platform code has to play it safe and always use the
> smallest possible page size. That is, do exactly what plan on doing with
> i2c_device_id entries. So it makes sense to have these entries
> (platform code will use them.)

Smallest size among the parts qualified for that design.  That's
a manufacturing and design question; we don't know whether the
qualified parts will ever include one of the small-page chips.


> OTOH, if EEPROM parts are usually not swappable and the platform code
> authors really knows what is there, then they will want to optimize the
> platform data to use the best possible page size, meaning that the
> i2c_device_id entries will, in general, not be used, and thus might not
> be worth even defining.

Some designs will use one hand, one will use the other.  I can't
see this as an either/or situation myself.  Both examples will fit
some real-world produts.


> An alternative approach would be to make all i2c_device_id entries
> read-only EEPROMs (so the page size no longer matters) and anyone who
> wants write access has to provide custom platform data.

Ugh.  That'd be a PROM driver, not an EEPROM driver.  ;)

 
> As I wrote above, I never had to deal with writable EEPROMs myself, so
> I'm really not the right person to make the decision. Leaving it up to
> you and Wolfram.

I don't know what Wolframe thinks about this ...

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

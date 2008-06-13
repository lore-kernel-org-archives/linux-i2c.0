From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3] New-style I2C and SMBus EEPROM driver (with
 device_ids)
Date: Fri, 13 Jun 2008 10:16:44 +0200
Message-ID: <20080613101644.6333fcff@hyperion.delvare>
References: <20080605193103.GA13062@pengutronix.de>
	<200806111025.08951.david-b@pacbell.net>
	<20080611214135.090ea690@hyperion.delvare>
	<200806121417.51446.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200806121417.51446.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, 12 Jun 2008 14:17:51 -0700, David Brownell wrote:
> On Wednesday 11 June 2008, Jean Delvare wrote:
> > > The idea you refer to was a simplification:  the driver wouldn't
> > > need to maintain lots of chip tables *plus* provide a per-chip
> > > override mechanism.  There'd be only platform_data, in all cases.
> > 
> > Such devices can never be created from user-space then (or maybe using
> > configfs? I really need to look into that). The nice thing about i2c
> > device names is that it makes devices easy to instantiate.
> 
> But they do *NOT* provide enough information to let any given
> device connect in non-trivial ways to the rest of the kernel.
> 
> Examples include "which IRQ does it use", callbacks that may
> be needed to configure things that implicitly rely on that
> I2C device, calibration data, and more.

The IRQ could be easily provided from user-space, as it's a field in
struct i2c_client. What cannot be easily provided are driver-specific
settings, I agree. But I still have to check if configfs could help
there.

My point was that having a way to instantiate read-only 128 or 256-byte
EEPROMs (as used for EDID and SPD, respectively) from user-space would
be valuable. And having an i2c_device_id entry for that, should help.
But I agree that, as long as the mechanism to actually instantiate I2C
devices from user-space isn't implemented, any discussion about how
drivers must be designed to support it, is moot. Let's postpone it to
later.

> I'm just not a fan of creating devices from userspace, it seems.
> The main reason to support such mechanisms is historical.  But

Such mechanisms existed because they were useful, and they still are.
You can't at the same time dislike automatic probing of I2C devices in
the kernel, and say that a way to instantiate I2C devices from
user-space is not needed. We need at least one of these mechanisms
(and, for the time being, the two of them.)

> all the I2C systems I work with haven't needed such stuff ...
> plus, those legacy configuration schemes required drivers to have
> lots of board-specific hacks.  Those hacks went away when we
> could finally rely on platform_data.

For the cases I have at hand (hardware monitoring devices, eeproms...)
there is no board-specific hacks involved at all.

> > > The easy way would be to reference a predefined struct, which
> > > could easily be cloned and modified to address pagesize and
> > > write protection issues.  (Also the various EEPROMs that were
> > > not listed in the current tables.)
> > 
> > That's what I would like to avoid. I think that providing predefined
> > structures is dangerous. You have to look at two places to know what
> > you have exactly. If platform data is provided then I would like all of
> > it to be spelled out explicitly by the caller. Otherwise I expect some
> > confusion.
> 
> Thing is, we know developers *WILL* cut'n'paste such stuff.
> Many of them won't dig up the data sheets.  Some confusion
> is unavoidable ... the issue is how to minimize it.
> 
> As I said, my thought there is to make it safe for most
> developers to just say "24c32" (or whatever) and have a
> sane default ... while making sure that they *always* have
> a way to set chips up to be readonly, or provide a better
> page size (if they need better bulk write speeds).

I agree on the principle. But the question remains: what is a sane
default in this context? Using the smallest page size amongst commonly
used EEPROM models? Using the smallest page size amongst known models?
Using the smallest possible page size (that would be 1 byte for all
EEPROM sizes as I understand it)? This 3rd possibility would probably
be no better than defaulting to read-only, as the write performance
would be so bad that every developer would specify custom platform data.

> > (...)
> > An alternative approach would be to make all i2c_device_id entries
> > read-only EEPROMs (so the page size no longer matters) and anyone who
> > wants write access has to provide custom platform data.
> 
> Ugh.  That'd be a PROM driver, not an EEPROM driver.  ;)

With what I wrote above, this still sounds like a sane thing to do,
though. Plus, if the default is read-only, developers who need write
access will have to pay some attention to the page size they set.
Hopefully this should minimize the risk of them accidentally using the
wrong page size.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c

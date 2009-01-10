From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: Regulator consumer and i2c device interaction.
Date: Sat, 10 Jan 2009 18:43:17 +0000
Message-ID: <20090110184316.GB31525@sirena.org.uk>
References: <4968C652.2050300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4968C652.2050300-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Jan 10, 2009 at 04:01:22PM +0000, Jonathan Cameron wrote:

[Regulators use a struct device and a supply name for lookup...]

> Now in the case of i2c devices, the struct device  pointer is created
> somewhat later and isn't readily available.

> I think the struct device pointer is only used as device instance specific
> token in the regulator framework.  If so is there any reason it can't be

That's the primary reason - this idiom is also used by at least the
clock API and possibly other things.  It also allows us to do things
like show which devices are supplied by which regulators in sysfs.

> relaxed to a void * thus allowing something else to be used in i2c drivers?

That's doable at the cost of the diagnostic info but...

> If so what could actually be used?  Unfortunately all the data elements
> of i2c_board_info are coppied out (rather than a pointer to the original
> structure being used) so that's not currently available.  I guess it could
> be made so at the cost of a single pointer in each i2c_client structure.

...as you say it's a bit tricky to use right now.  I haven't checked but
I expect that the platform data that you can supply in the i2c board info
would work as a token, though it's far from ideal and there may be no
other need for platform data.

As a temporary workaround note that the regulator API allows the device
to be NULL at the minute, though there is a desire to remove that
option.  Providing your regulators have unique names you will be able to
pass the supply name in as platform data and use that only.  This usage
is not encouraged and will hopefully become invalid over time, it's
there at the minute mainly because we don't have a good idea what to use
for the struct device for cpufreq drivers.

> So the question is how would people prefer to do this?

It'd be nice to be able to access the struct device for i2c devices more
readily at registration time.  Like I say, it's not a regulator specific
issue so it'd be good to come up with a general solution.

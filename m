From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Fri, 17 Dec 2010 14:24:03 +0000
Message-ID: <20101217142402.GA19391@rakim.wolfsonmicro.main>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
 <201012171425.07775.rjw@sisk.pl>
 <20101217133434.GH31453@rakim.wolfsonmicro.main>
 <201012171449.26082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201012171449.26082.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 17, 2010 at 02:49:25PM +0100, Rafael J. Wysocki wrote:
> On Friday, December 17, 2010, Mark Brown wrote:

> > By, for example, providing default implementations which the buses can
> > use if they choose to.

> OK, so we have generic_subsys_pm_ops.  Do we need anything beyond that?

Hrm.  Possibly just some fiddling with those or alternative versions.
For example, looking at the I2C bus suspend it's this:

static int i2c_device_pm_suspend(struct device *dev)
{
	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;

	if (pm) {
		if (pm_runtime_suspended(dev))
			return 0;
		else
			return pm->suspend ? pm->suspend(dev) : 0;
	}

	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
}

Ideally the if (pm) block could just be factored out into the pm core as
there's nothing I2C-specific about that at all.  Possibly even the whole
logic surrounding fall back to legacy, though that smells a bit.  The
generic suspend operation doesn't fit here:

int pm_generic_suspend(struct device *dev)
{
	return __pm_generic_call(dev, PM_EVENT_SUSPEND);
}
EXPORT_SYMBOL_GPL(pm_generic_suspend);

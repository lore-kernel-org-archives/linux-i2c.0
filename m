From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Sat, 18 Dec 2010 00:01:25 +0100
Message-ID: <201012180001.25263.rjw@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com> <201012171449.26082.rjw@sisk.pl> <20101217142402.GA19391@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101217142402.GA19391-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, December 17, 2010, Mark Brown wrote:
> On Fri, Dec 17, 2010 at 02:49:25PM +0100, Rafael J. Wysocki wrote:
> > On Friday, December 17, 2010, Mark Brown wrote:
> 
> > > By, for example, providing default implementations which the buses can
> > > use if they choose to.
> 
> > OK, so we have generic_subsys_pm_ops.  Do we need anything beyond that?
> 
> Hrm.  Possibly just some fiddling with those or alternative versions.
> For example, looking at the I2C bus suspend it's this:
> 
> static int i2c_device_pm_suspend(struct device *dev)
> {
> 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> 
> 	if (pm) {
> 		if (pm_runtime_suspended(dev))
> 			return 0;
> 		else
> 			return pm->suspend ? pm->suspend(dev) : 0;
> 	}
> 
> 	return i2c_legacy_suspend(dev, PMSG_SUSPEND);
> }
> 
> Ideally the if (pm) block could just be factored out into the pm core as
> there's nothing I2C-specific about that at all.  Possibly even the whole
> logic surrounding fall back to legacy, though that smells a bit.

No, the legacy is i2c-specific.

> The generic suspend operation doesn't fit here:
> 
> int pm_generic_suspend(struct device *dev)
> {
> 	return __pm_generic_call(dev, PM_EVENT_SUSPEND);
> }
> EXPORT_SYMBOL_GPL(pm_generic_suspend);

Well, looking at __pm_generic_call(), I think it does.

It appears to do exactly what the pm block above does, so it should be possible
to have something like this:

static int i2c_device_pm_suspend(struct device *dev)
{
	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
	return pm ? pm_generic_suspend(dev) : i2c_legacy_suspend(dev, PMSG_SUSPEND);
}

if I'm not missing anything.

Thanks,
Rafael

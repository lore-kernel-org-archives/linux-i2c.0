From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using (i2c) drivers
Date: Wed, 15 Dec 2010 23:01:18 +0100
Message-ID: <201012152301.18700.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1012151530590.2171-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1012151530590.2171-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday, December 15, 2010, Alan Stern wrote:
> On Wed, 15 Dec 2010, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> > Subject: PM / Runtime: Fix pm_runtime_suspended()
> > 
> > pm_runtime_suspended() shouldn't return true if the runtime PM of the
> > given device is disabled.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw-KKrjLPT3xs0@public.gmane.org>
> > ---
> >  include/linux/pm_runtime.h |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Index: linux-2.6/include/linux/pm_runtime.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/pm_runtime.h
> > +++ linux-2.6/include/linux/pm_runtime.h
> > @@ -78,7 +78,8 @@ static inline void device_set_run_wake(s
> >  
> >  static inline bool pm_runtime_suspended(struct device *dev)
> >  {
> > -	return dev->power.runtime_status == RPM_SUSPENDED;
> > +	return dev->power.runtime_status == RPM_SUSPENDED
> > +		&& !dev->power.disable_depth;
> >  }
> 
> You need to update the documentation entry for pm_runtime_suspended as 
> well.

Yes, I also need to rework the changelog to explain what exactly the problem is.

> I think this is okay.  If a driver or subsystem uses
> pm_runtime_suspended() then it must be runtime-PM-aware, so it wouldn't
> leave a device disabled for runtime PM.
> 
> So in theory the only place this would matter is if the function is
> called in a generic setting, and AFAICT the only place that happens is
> in generic_ops.c, where the change is correct.

Indeed.

Thanks,
Rafael

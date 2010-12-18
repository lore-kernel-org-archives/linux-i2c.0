From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Sat, 18 Dec 2010 15:59:50 +0100
Message-ID: <201012181559.50347.rjw@sisk.pl>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com> <201012181354.58077.rjw@sisk.pl> <20101218132029.GA22273@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101218132029.GA22273-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Saturday, December 18, 2010, Mark Brown wrote:
> On Sat, Dec 18, 2010 at 01:54:57PM +0100, Rafael J. Wysocki wrote:
> > On Saturday, December 18, 2010, Mark Brown wrote:
> 
> > > SPI and platform (the first two buses I looked at) both seem to have
> > > legacy suspend operations too?  Clearly the bus would need to provide an
> > > op to invoke the legacy call but the logic which prioritises the pm_ops
> > > over the legacy operation is generic.
> 
> > Well, the problem with that is the driver would need to tell the generic call
> > what the legacy routine is and there's no, er, generic way to do that.
> 
> > In the i2c case, for example, there is struct i2c_driver that contains the
> > ->suspend() and ->resume() pointers, so the bus type driver _knows_ how to
> > get there, but the PM core doesn't have this information.
> 
> Sure, but this could be readily accomplished by providing bus
> legacy_suspend() and legacy_resume() operations that the generic code
> could use to do the actual call.

First, there already are ->suspend() and ->resume() callbacks in
struct bus_type which are regarded as "legacy".  The PM core uses those as
appropriate in drivers/base/power/main.c .

Second, the situation at hand is that the bus type implements dev_pm_ops,
but the driver doesn't.  Now, pm_generic_suspend() is called with a struct
device pointer, so it would have to go back to dev->bus, find the
->legacy_suspend() callback (as opposed to ->suspend(), which also is legacy,
but is called by the PM core instead).  May I call that confusing?

> This would save them all implmeneting
> essentially the same decision making code for all the various different 
> PM operations - the only bit that differs between buses is going to be
> the actual process for calling the legacy API.
> 
> Like I say, I'm not sure if it's actually worth it.

Well, I don't really think so.

Thanks,
Rafael

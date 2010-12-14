From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using (i2c) drivers
Date: Wed, 15 Dec 2010 00:57:31 +0100
Message-ID: <201012150057.31237.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1012141114150.2087-100000@iolanthe.rowland.org> <201012150028.07938.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201012150028.07938.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday, December 15, 2010, Rafael J. Wysocki wrote:
> On Tuesday, December 14, 2010, Alan Stern wrote:
> > On Tue, 14 Dec 2010, Rabin Vincent wrote:
> > 
> > > Hello,
> > > 
> > > If an i2c driver uses dev_pm_ops and pm_runtime_suspended() returns true
> > > for the device,  the i2c core will not call the driver's pm->suspend()
> > > routine.  Similar behaviour (except for the if dev_pm_ops check) is
> > > present in the generic PM ops provided in
> > > drivers/base/power/generic_ops.c.
> > > 
> > > Since pm_runtime_suspended() returns true if the relevant driver did not
> > > call any pm_runtime functions, this means that any driver which does not
> > > use pm_runtime APIs will not get its pm->suspend() callback called
> > > during system sleep, if CONFIG_PM_RUNTIME is enabled.
> > > 
> > > For the i2c case, there are several such drivers (in drivers/input/*,
> > > etc) lacking these calls.  How is this to be handled?  Do all of these
> > > drivers need to be patched to use the pm_runtime API if they are to be
> > > used on a kernel with PM_RUNTIME enabled?
> > 
> > I'm not familiar with the details of how the i2c subsystem works.  But
> > in general, the subsystem code should call pm_runtime_set_active()  
> > for every device before registering it.  Then if a driver doesn't use
> > any runtime-PM functions, pm_runtime_suspended() will return false.
> 
> I rather think that our current definition of pm_runtime_suspended() is
> not really adequate.
> 
> Namely, it shouldn't really return true if runtime PM is not enabled
> (ie. power.disable_depth > 1).

That should have been power.disable_depth > 0, of course.  Sorry.

> That change would fix the issue at hand,  wouldn't it?

Rafael

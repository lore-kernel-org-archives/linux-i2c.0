From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] pm_runtime_suspended() and non-pm_runtime-using (i2c)
 drivers
Date: Tue, 14 Dec 2010 11:16:45 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012141114150.2087-100000@iolanthe.rowland.org>
References: <AANLkTik7D2mDJN=BaasvLa4xx0fQBgjHREqQB06aD9JU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTik7D2mDJN=BaasvLa4xx0fQBgjHREqQB06aD9JU-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rabin Vincent <rabin-66gdRtMMWGc@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 14 Dec 2010, Rabin Vincent wrote:

> Hello,
> 
> If an i2c driver uses dev_pm_ops and pm_runtime_suspended() returns true
> for the device,  the i2c core will not call the driver's pm->suspend()
> routine.  Similar behaviour (except for the if dev_pm_ops check) is
> present in the generic PM ops provided in
> drivers/base/power/generic_ops.c.
> 
> Since pm_runtime_suspended() returns true if the relevant driver did not
> call any pm_runtime functions, this means that any driver which does not
> use pm_runtime APIs will not get its pm->suspend() callback called
> during system sleep, if CONFIG_PM_RUNTIME is enabled.
> 
> For the i2c case, there are several such drivers (in drivers/input/*,
> etc) lacking these calls.  How is this to be handled?  Do all of these
> drivers need to be patched to use the pm_runtime API if they are to be
> used on a kernel with PM_RUNTIME enabled?

I'm not familiar with the details of how the i2c subsystem works.  But
in general, the subsystem code should call pm_runtime_set_active()  
for every device before registering it.  Then if a driver doesn't use
any runtime-PM functions, pm_runtime_suspended() will return false.

Alan Stern

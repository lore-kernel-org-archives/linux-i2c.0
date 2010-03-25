From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] i2c: Fix bus-level power management callbacks
Date: Thu, 25 Mar 2010 21:16:23 +0100
Message-ID: <201003252116.23171.rjw@sisk.pl>
References: <201003132204.30905.rjw@sisk.pl> <20100325095720.0b115056@hyperion.delvare> <20100325092802.GA27729@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100325092802.GA27729-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thursday 25 March 2010, Mark Brown wrote:
> On Thu, Mar 25, 2010 at 09:57:20AM +0100, Jean Delvare wrote:
> 
> > Mark, you contributed the initial runtime PM support for the i2c
> > subsystem, I thought you would have comments on Rafael's
> > reimplementation?
> 
> Yeah, see below...
> 
> > >  drivers/i2c/i2c-core.c     |  168 ++++++++++++++++++++++++++-------------------
> > >  include/linux/pm_runtime.h |    7 +
> 
> > I am a little surprised to see changes to a generic header file here,
> > how is the i2c subsystem so special that we have needs other subsystems
> > did not?
> 
> Very few subsystems actually support runtime PM thus far - I think it's
> more the case that I2C is an early user than anything else.

That's the case indeed.

> > Apart from the above, the code looks sane to me, but then again I don't
> > know a thing about power management. I'll keep this patch in my i2c
> > tree, scheduled for merge in 2.6.35. If there are any updates, please
> > send them over, either as a new patch or as incremental changes which I
> > will merge myself.
> 
> I'm in a similar position - the code looks fine except I'm not 100% sure
> I follow all the possible ifdefs and I've never actually used hibernate
> (s2disk isn't supported on ARM) but for what it's worth:
> 
> Acked-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

Thanks!

Rafael

From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [linux-pm] [PATCH] i2c: Hook up runtime PM support
Date: Fri, 5 Feb 2010 23:17:26 +0000
Message-ID: <20100205231726.GB5466@sirena.org.uk>
References: <1265203367-21344-1-git-send-email-broonie@opensource.wolfsonmicro.com> <201002042257.27145.rjw@sisk.pl> <20100205103915.GA2600@sirena.org.uk> <201002052309.13966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201002052309.13966.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, pm list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 05, 2010 at 11:09:13PM +0100, Rafael J. Wysocki wrote:
> On Friday 05 February 2010, you wrote:

> > Hrm, I guess.  It seems an odd thing to want to use - for a bus like I2C
> > there's nothing other than the driver involved so the request that is
> > being vetoed will have been initiated by the driver which seems wrong.

> Not really.  _idle is also called automatically by the runtime PM core after
> _resume in case the device may be suspended again.  Your _idle has to handle
> this case as well and that's when the driver may want to veto the suspend.

I was viewing that as being part of the same case, going on the basis
that the driver would have marked the device as active already if
something had changed over the suspend.  The use cases that jumped out
at me for the veto were for buses or classes rather than for individual
devices.

> > Out of interest do you have any pointers to drivers using this (my greps
> > aren't turning anything up in -next)?

> There aren't any in -next, because I'm waiting for the base PCI runtime PM
> code to settle down.  I have two in my private queue at the moment , for r8169
> and e1000e (I posted some older versions of them some time ago, but they
> wouldn't fit the current framework too well, which is the basic reason I'm
> sitting on them, so that I don't have to post too many updates :-)).

> I can send them to you privately, if needed.

No, that's OK - like I say, it was just out of interest.

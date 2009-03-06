From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Fri, 6 Mar 2009 19:54:29 +0100
Message-ID: <20090306185429.GB20135@buzzloop.caiaq.de>
References: <20090225212119.67402391@hyperion.delvare> <1235606248-13004-1-git-send-email-daniel@caiaq.de> <20090226094857.50d0710d@hyperion.delvare> <20090306160042.GA17800@buzzloop.caiaq.de> <20090306182432.338b0244@hyperion.delvare> <49B166E2.5060909@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49B166E2.5060909-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 06, 2009 at 06:09:38PM +0000, Jonathan Cameron wrote:
> > Sorry for the long silence, I have been pretty busy these last days,
> > and was also hopping for a comment from Jonathan. The industrial I/O
> > subsystem isn't orphaned, I am fairly certain it will be merged some
> > day, but it could take some time.
> Sorry, I missed this thread entirely until just now.
> 
> Jean is indeed correct that things have gotten a little delayed.  The
> principal problem has been lack of interested users / testers / driver
> developers.
> Basically not enough people had relevant hardware.  Things are improving
> so hopefully we can make some progress on this soon.  In the meantime
> I've mostly just been fixing bugs my local users have been submitting
> rather than doing any major new development.
> 
> I have a similar light sensor driver which I'll admit I've not widely
> distributed at yet (it's in one of my git trees, imote2-linux, but under
> the soon to disappear i2c-chips oops) This one has been out of mainline
> for a while. It's for the tsl2561.

And there is more in drivers/i2c/chips/ which should also be moved then
(my last patch did so and put it into the proposed drivers/sensors).

> > I agree that it doesn't make sense to wait for the industrial I/O
> > subsystem to be merged. But I also do not want to put in drivers/hwmon
> > drivers which do not really belong there. So I'd either go the way you
> > proposed already (drivers/sensors for non-hwmon sensor drivers) or
> > simply put your driver in drivers/misc if this is only meant as a
> > temporary home until the industrial I/O subsystem is merged.
> Jean's suggestion of drivers/misc may make sense in the short term or
> I'm happy to do the minor bit of porting needed to merge this (and my tsl
> driver) into the industrial i/o tree (held on kernel.org) to ensure it
> doesn't disappear into the ether!

Ok, perfect, do it so. And Cc: me when things get merged :)

Thanks,
Daniel

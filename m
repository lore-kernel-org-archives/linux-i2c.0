From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Fri, 6 Mar 2009 19:14:09 +0100
Message-ID: <20090306181409.GA20135@buzzloop.caiaq.de>
References: <20090225212119.67402391@hyperion.delvare> <1235606248-13004-1-git-send-email-daniel@caiaq.de> <20090226094857.50d0710d@hyperion.delvare> <20090306160042.GA17800@buzzloop.caiaq.de> <20090306182432.338b0244@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090306182432.338b0244-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 06, 2009 at 06:24:32PM +0100, Jean Delvare wrote:
> > Sorry to annoy you again with that topic, but I'm a little stuck here.
> > The 'industrial I/O' thread I was pointed to seems to be orphaned and I
> > didn't get much response on the LKML about alternatives either.
> 
> Sorry for the long silence, I have been pretty busy these last days,
> and was also hopping for a comment from Jonathan. The industrial I/O
> subsystem isn't orphaned, I am fairly certain it will be merged some
> day, but it could take some time.

Haven't seen any follow-up on it, hence the doubt.


> > As hwmon still appears the best existing place for such a driver to live
> > in, could we just take it and move it somewhere else as soon somebody
> > comes along with some better idea? I'd just like to avoid it being lost,
> > and every other approach does not feel very productive currently.
> 
> I agree that it doesn't make sense to wait for the industrial I/O
> subsystem to be merged. But I also do not want to put in drivers/hwmon
> drivers which do not really belong there. So I'd either go the way you
> proposed already (drivers/sensors for non-hwmon sensor drivers) or
> simply put your driver in drivers/misc if this is only meant as a
> temporary home until the industrial I/O subsystem is merged.

Okay, drviers/misc sounds like a good intermediate solution. Do you want
me to post another patch for that or will you move it yourself?

Thanks,
Daniel

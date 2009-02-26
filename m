From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH] Added driver for ISL29003 ambient light sensor
Date: Thu, 26 Feb 2009 10:57:18 +0100
Message-ID: <20090226095718.GA24575@buzzloop.caiaq.de>
References: <20090225212119.67402391@hyperion.delvare> <1235606248-13004-1-git-send-email-daniel@caiaq.de> <20090226094857.50d0710d@hyperion.delvare> <20090226090651.GA20531@buzzloop.caiaq.de> <20090226104204.21dd9616@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090226104204.21dd9616-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 26, 2009 at 10:42:04AM +0100, Jean Delvare wrote:
> > > >  create mode 100644 Documentation/hwmon/isl29003
> > > >  create mode 100644 drivers/hwmon/isl29003.c
> > > 
> > > Still no luck, sorry. Light sensors have nothing to do with hardware
> > > monitoring.
> > 
> > I decided to put it there because of 
> > 
> > config SENSORS_APPLESMC
> >         tristate "Apple SMC (Motion sensor, light sensor, keyboard
> > 	backlight)"
> 
> That driver is in hwmon for the motion sensor, and the temperature
> sensors, not the light sensor. 

Agreed. I was just looking for an appropriate place for it and the one
above is what came closest.

What about adding drivers/sensors and start moving things there? I'd
post a patch to move the tsl2550, the thing my driver derived from.

Does that sound suitable?

Daniel

From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: therm_adt746x: attach_adapter method is deprecated (fwd)
Date: Tue, 05 Jul 2011 17:20:40 +1000
Message-ID: <1309850440.14501.275.camel@pasglop>
References: <alpine.DEB.2.01.1104211758220.18728@trent.utfs.org>
	 <20110422103147.24c79768@endymion.delvare>
	 <alpine.DEB.2.01.1104221057160.18728@trent.utfs.org>
	 <20110422201803.6886669d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110422201803.6886669d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Christian Kujau <lists-AanptEQQ3TL9uQeqpI+JUg@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2011-04-22 at 20:18 +0200, Jean Delvare wrote:
> On Fri, 22 Apr 2011 10:59:16 -0700 (PDT), Christian Kujau wrote:
> > On Fri, 22 Apr 2011 at 10:31, Jean Delvare wrote:
> > > Redirecting to the right mailing list, as 1* this is an i2c issue and
> > > 2* the therm_adt746x driver doesn't integrate into the standard
> > > hwmon/libsensors interface anyway.
> > 
> > Ah, thanks for redirecting. Yeah, lm-sensors never worked for me and I'm 
> > still reading fan speeds/temperatures off of /sys/devices/temperatures/*
> 
> Note that I think it would make a lot of sense to expose all the
> monitored values at least read-only through a hwmon-style interface in
> all these powermac specific drivers. This would let these values be
> reported to users by all standard monitoring tools.
> 
> Independent from the warnings you were reported, though.

Ok, I've finally decided to dedicate a couple of days in fixing them,
it's non-trivial, but I'm getting there slowly. In some cases (windfarm)
it's easy and actually removes significant amounts of code from the
drivers. In other cases, it's harder because the drivers are pretty
awful in the first place (therm_adt746x).

I might completely replace therm_pm72 with a windfarm implementation for
those older G5's which would be more consistent (all G5's would thus use
windfarm) since it's cleaner (therm_pm72 hard code i2c addresses etc...
while windfarm is meant for more dynamic probing of the sensors).

Regarding the hwmon interface, well, that's a whole different issue...

Windfarm generically creates sysfs files for all sensors so I suppose it
-could- start exposing them in a more standard interface.

therm_adt746x creates its own special /sys/devices/temperatures with all
the files in it. I don't want to remove it for now but it might be
worthwhile adding an hwmon interface to it, at least I can still test
on it.

therm_windtunnel is similar but I don't have the HW to test so that's
going to be a bit nastier.

I hope to have something before the end of the week for you to review.

Cheers,
Ben. 

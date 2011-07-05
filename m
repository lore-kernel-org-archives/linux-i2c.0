From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: therm_adt746x: attach_adapter method is deprecated (fwd)
Date: Tue, 5 Jul 2011 10:27:52 +0200
Message-ID: <20110705102752.1251361c@endymion.delvare>
References: <alpine.DEB.2.01.1104211758220.18728@trent.utfs.org>
	<20110422103147.24c79768@endymion.delvare>
	<alpine.DEB.2.01.1104221057160.18728@trent.utfs.org>
	<20110422201803.6886669d@endymion.delvare>
	<1309850440.14501.275.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1309850440.14501.275.camel@pasglop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Christian Kujau <lists-AanptEQQ3TL9uQeqpI+JUg@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Benjamin,

On Tue, 05 Jul 2011 17:20:40 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2011-04-22 at 20:18 +0200, Jean Delvare wrote:
> > Note that I think it would make a lot of sense to expose all the
> > monitored values at least read-only through a hwmon-style interface in
> > all these powermac specific drivers. This would let these values be
> > reported to users by all standard monitoring tools.
> > 
> > Independent from the warnings you were reported, though.
> 
> Ok, I've finally decided to dedicate a couple of days in fixing them,
> it's non-trivial, but I'm getting there slowly. In some cases (windfarm)
> it's easy and actually removes significant amounts of code from the
> drivers. In other cases, it's harder because the drivers are pretty
> awful in the first place (therm_adt746x).

I am glad to hear that the change will simplify the code in at least
some cases.

> I might completely replace therm_pm72 with a windfarm implementation for
> those older G5's which would be more consistent (all G5's would thus use
> windfarm) since it's cleaner (therm_pm72 hard code i2c addresses etc...
> while windfarm is meant for more dynamic probing of the sensors).
> 
> Regarding the hwmon interface, well, that's a whole different issue...
> 
> Windfarm generically creates sysfs files for all sensors so I suppose it
> -could- start exposing them in a more standard interface.
> 
> therm_adt746x creates its own special /sys/devices/temperatures with all
> the files in it. I don't want to remove it for now but it might be
> worthwhile adding an hwmon interface to it, at least I can still test
> on it.

Sounds good.

> therm_windtunnel is similar but I don't have the HW to test so that's
> going to be a bit nastier.
> 
> I hope to have something before the end of the week for you to review.

Sure, as soon as you have anything ready, I'll be happy to review it.

-- 
Jean Delvare

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH/RFC v2 4/4] hwmon: sysfs API updates
Date: Tue, 6 Jul 2010 09:21:09 +0200
Message-ID: <20100706092109.776c4779@hyperion.delvare>
References: <1278303018-22069-1-git-send-email-guenter.roeck@ericsson.com>
	<1278303018-22069-5-git-send-email-guenter.roeck@ericsson.com>
	<20100705091857.77ce0077@hyperion.delvare>
	<20100705213953.GA27095@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100705213953.GA27095-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Jonathan Cameron <kernel-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Ira W. Snyder" <iws-lulEs6mt1IksTUYHLfqkUA@public.gmane.org>, "Darrick J. Wong" <djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 5 Jul 2010 14:39:53 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> I noticed I did not copy the list with my reply, so here are are again,
> with a couple of additional comments.
> 
> On Mon, Jul 05, 2010 at 03:18:57AM -0400, Jean Delvare wrote:
> > On Sun, 4 Jul 2010 21:10:18 -0700, Guenter Roeck wrote:
> > > @@ -482,10 +501,17 @@ OR
> > >  
> > >  in[0-*]_min_alarm
> > >  in[0-*]_max_alarm
> > > +in[0-*]_lcrit_alarm
> > > +in[0-*]_crit_alarm
> > > +curr[1-*]_lcrit_alarm
> > > +curr[1-*]_crit_alarm
> > 
> > No _min and _max alarm for curr?
> > 
> Oversight. pmbus devices don't support currX_min and currX_min_alarm, only
> currX_lcrit and currX_lcrit_alarm. The ltc4245 driver already supports
> currX_max_alarm, though, so I'll add both for consistency.
> 
> The ltc4245 driver only supports currX_max_alarm, not currX_min_alarm, though.
> Wonder if that should be changed to currX_alarm, to more closely follow the API.
> Let me know and I'll submit a patch if needed.

Both should be defined and supported, and the driver author chooses
what fits his/her chip best.

-- 
Jean Delvare

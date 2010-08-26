From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [lm-sensors] [PATCH] hwmon: Add tempX_emergency to sysfs ABI
Date: Thu, 26 Aug 2010 10:08:02 -0700
Message-ID: <20100826170802.GC19423@ericsson.com>
References: <1282838085-7210-1-git-send-email-guenter.roeck@ericsson.com>
 <20100826161022.GA1383@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100826161022.GA1383-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 26, 2010 at 12:10:23PM -0400, Henrique de Moraes Holschuh wrote:
> On Thu, 26 Aug 2010, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> > ---
> > tempX_emergency will be used by max6696. It can also be used for other chips
> > supporting three upper temperature limits.
> > 
> >  Documentation/hwmon/sysfs-interface |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> > index ff45d1f..1ceb2b9 100644
> > --- a/Documentation/hwmon/sysfs-interface
> > +++ b/Documentation/hwmon/sysfs-interface
> > @@ -310,6 +310,12 @@ temp[1-*]_crit_hyst
> >  		from the critical value.
> >  		RW
> >  
> > +temp[1-*]_emergency
> > +		Temperature emergency value, typically greater than
> > +		corresponding temp_crit values.
> > +		Unit: millidegree Celsius
> > +		RW
> > +
> 
> If we have two-level alarms: critical, then emergency, it is best to have
> that written down than to imply it by "typically greater than corresponding
> temp_crit"...
> 
Do you have a better wording in mind ?

Guenter

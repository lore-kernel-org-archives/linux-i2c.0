From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] scripts/checkpatch.pl: Add strict test of logical test
 continuations at beginning of line
Date: Sun, 11 Jul 2010 14:15:47 -0700
Message-ID: <20100711211547.GA24666@ericsson.com>
References: <1278859984-22593-1-git-send-email-guenter.roeck@ericsson.com>
 <1278862266.1501.59.camel@Joe-Laptop.home>
 <20100711161658.GA23927@ericsson.com>
 <20100711182138.132815e4@hyperion.delvare>
 <1278874632.1501.68.camel@Joe-Laptop.home>
 <20100711213444.4243014c@hyperion.delvare>
 <1278877979.1501.76.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1278877979.1501.76.camel-AkRN8/LKpobuYGix6ZUp1Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andy Whitcroft <apw-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Paul Goyette <paul-3orOWTcw9wBWk0Htik3J/w@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jul 11, 2010 at 03:52:59PM -0400, Joe Perches wrote:
> On Sun, 2010-07-11 at 21:34 +0200, Jean Delvare wrote:
> > On Sun, 11 Jul 2010 11:57:12 -0700, Joe Perches wrote:
> > > I don't remember that discussion.  Link?
> > http://lkml.org/lkml/2009/12/5/65
> > You started the thread, so I would think you'd remember it.
> 
> Though there are differences in opinion about what's important,
> I try to forget the trivial.  Just ask my sweet wife...
> 
Same issue hit me twice now, so it isn't as if nobody cares. 

For my part, I don't care where to put the &&. But I would like to have a means 
to get beyond the basic stuff before submitting my patches, to give reviewers 
an opportunity to find the _real_ problems in my code.

Guenter

From: Mika Kuoppala <mika.kuoppala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: Prevent priority inversion on top of bus lock
Date: Wed, 16 Sep 2009 15:35:24 +0300
Message-ID: <1253104524.22491.2.camel@adserver2>
References: <1253099829-17655-1-git-send-email-mika.kuoppala@nokia.com>
	 <1253099829-17655-2-git-send-email-mika.kuoppala@nokia.com>
	 <20090916135159.0d74f178@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090916135159.0d74f178-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

On Wed, 2009-09-16 at 13:51 +0200, ext Jean Delvare wrote:

> >  		if (in_atomic() || irqs_disabled()) {
> > -			ret = mutex_trylock(&adap->bus_lock);
> > +			ret = rt_mutex_trylock(&adap->bus_lock);
> >  			if (!ret)
> >  				/* I2C activity is ongoing. */
> >  				return -EAGAIN;
> >  		} else {
> > -			mutex_lock_nested(&adap->bus_lock, adap->level);
> > +			rt_mutex_lock(&adap->bus_lock);
> 
> Hmm, rt_mutex doesn't handle locking model validation as regular
> mutexes have? Looks like a regression to me.
> 

There seems to be no rtmutex_lock_nested in include/linux/rtmutex.h.

CONFIG_DEBUG_RT_MUTEXES help says this:
  This allows rt mutex semantics violations and rt mutex related
  deadlocks (lockups) to be detected and reported automatically.

I don't know if this includes the same stuff as lockdep does.

But as the context is stripped away (adap-level) it's safe to assume
that atleast some functionality is also stripped. Thus it is a
regression.

-- Mika

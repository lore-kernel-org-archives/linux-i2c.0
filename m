From: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: add "reset" sysfs entry for adapters.
Date: Wed, 11 Feb 2009 14:00:29 +0100
Message-ID: <20090211130028.GM8639@enneenne.com>
References: <1233933798-17673-1-git-send-email-giometti@linux.it> <20090209171720.76efd2c8@hyperion.delvare> <20090209204108.GH7975@enneenne.com> <20090210114438.67bfb5fb@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090210114438.67bfb5fb-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 10, 2009 at 11:44:38AM +0100, Jean Delvare wrote:
> On Mon, 9 Feb 2009 21:41:08 +0100, Rodolfo Giometti wrote:
> > On Mon, Feb 09, 2009 at 05:17:20PM +0100, Jean Delvare wrote:
> > > On Fri,  6 Feb 2009 16:23:17 +0100, Rodolfo Giometti wrote:
> > > > It could happen that an i2c adapter may lock the bus due due
> > > 
> > > Typo: "due due" -> "due to".
> > 
> > Ok.
> > 
> > > > electrical problems, so the user may recover this stale state by using:
> > > > 
> > > > 	$ echo 1 > /sys/class/i2c-adapter/i2c-0/reset
> > > 
> > > What is the intended purpose, debugging? I would certainly hope that
> > > drivers know by themselves when they need a reset. Requiring users to
> > > reset themselves doesn't sound terribly friendly :(
> > 
> > Unluckely not all adapter does it by themselfes! At least not PXA
> > one. I'm currently work on adding this new feature.
> 
> Well, if you are going to fix the i2c-pxa driver, and it's the only
> driver using the manual reset feature, then do we really need to add
> this feature?

I don't know about other controllers, I know about PXA one because I'm
currently working on it. :)

> 
> Don't get me wrong, if this feature is still useful then I am fine
> adding it. But OTOH we still have to think twice when doing such core
> changes, because they increase the memory footprint for all systems.

I agree. Maybe I can add such entry with a conditional #ifdef DEBUG
and setting it off by default?

> 
> I am curious what other developers think. Me, I never felt the need for
> a manual reset feature. Usually when I have managed to break an I2C
> controller, cycling the driver would fix it, or if not, it was so
> broken that I had to power-cycle the box anyway.
> 
> Are there other developers out there who consider the proposed manual
> reset feature a good thing to have? Please speak up.

However, regarding PXA controller I found a way to automagically reset
it when it locks. I'll send a patchset ASAP.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
Linux Device Driver                          giometti-k2GhghHVRtY@public.gmane.org
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti

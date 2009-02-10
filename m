From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: add "reset" sysfs entry for adapters.
Date: Tue, 10 Feb 2009 11:44:38 +0100
Message-ID: <20090210114438.67bfb5fb@hyperion.delvare>
References: <1233933798-17673-1-git-send-email-giometti@linux.it>
	<20090209171720.76efd2c8@hyperion.delvare>
	<20090209204108.GH7975@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090209204108.GH7975-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 9 Feb 2009 21:41:08 +0100, Rodolfo Giometti wrote:
> On Mon, Feb 09, 2009 at 05:17:20PM +0100, Jean Delvare wrote:
> > On Fri,  6 Feb 2009 16:23:17 +0100, Rodolfo Giometti wrote:
> > > It could happen that an i2c adapter may lock the bus due due
> > 
> > Typo: "due due" -> "due to".
> 
> Ok.
> 
> > > electrical problems, so the user may recover this stale state by using:
> > > 
> > > 	$ echo 1 > /sys/class/i2c-adapter/i2c-0/reset
> > 
> > What is the intended purpose, debugging? I would certainly hope that
> > drivers know by themselves when they need a reset. Requiring users to
> > reset themselves doesn't sound terribly friendly :(
> 
> Unluckely not all adapter does it by themselfes! At least not PXA
> one. I'm currently work on adding this new feature.

Well, if you are going to fix the i2c-pxa driver, and it's the only
driver using the manual reset feature, then do we really need to add
this feature?

Don't get me wrong, if this feature is still useful then I am fine
adding it. But OTOH we still have to think twice when doing such core
changes, because they increase the memory footprint for all systems.

I am curious what other developers think. Me, I never felt the need for
a manual reset feature. Usually when I have managed to break an I2C
controller, cycling the driver would fix it, or if not, it was so
broken that I had to power-cycle the box anyway.

Are there other developers out there who consider the proposed manual
reset feature a good thing to have? Please speak up.

-- 
Jean Delvare

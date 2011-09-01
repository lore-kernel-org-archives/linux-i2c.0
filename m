From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c: remove deprecated callbacks
Date: Fri, 02 Sep 2011 09:32:07 +1000
Message-ID: <1314919927.4145.24.camel@pasglop>
References: <1314852027-9523-1-git-send-email-xiyou.wangcong@gmail.com>
	 <20110901105226.0d8dd8b2@endymion.delvare>
	 <1314919458.4145.23.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1314919458.4145.23.camel@pasglop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: WANG Cong <xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2011-09-02 at 09:24 +1000, Benjamin Herrenschmidt wrote:


 .../...

> I'm just bogged down by too many things, including quite a bit of travel
> lately. I have some mostly untested patches converting part of windfarm
> (not all of it yet), and therm_adt746x and a patch to add the generic
> code to register i2c devices from device-tree properly on powermacs.
> 
> I'm missing a couple more drivers & bits of windfarm and therm_pm72
> which I'd like to use the opportunity to convert into a windfarm module.

I'll push out my WIP to a branch on powerpc.git on k.org when hera is
back online so those who want can help.

Cheers,
Ben.

> Then there's some sound drivers etc...
> 
> I am travelling again tomorrow for 2 weeks, and after that a month in
> europe, tho I'll have 10 days in the middle where I _might_ be able to
> make progress on that. Else it will have to wait for november.
>  
> > Cong, do you have a specific interest in these callbacks being removed?
> > 
> > If you want to help, then instead of sending a patch which I already
> > have and virtually everybody could have written, please get the
> > remaining 3 drivers converted to the current i2c binding model:
> >   sound/ppc/keywest.c
> >   sound/aoa/codecs/onyx.c
> >   sound/aoa/codecs/tas.c
> > THAT would be helpful. At the moment, it only looks like you are trying
> > to get your name on a trivial patch, i.e. getting credit for work you
> > didn't really do.
> 
> Cheers,
> Ben.
> 
> > > 
> > > ---
> > > diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> > > index c4a6e14..89a9695 100644
> > > --- a/Documentation/feature-removal-schedule.txt
> > > +++ b/Documentation/feature-removal-schedule.txt
> > > @@ -486,15 +486,6 @@ Files:	include/linux/netfilter_ipv4/ipt_addrtype.h
> > >  
> > >  ----------------------------
> > >  
> > > -What:	i2c_driver.attach_adapter
> > > -	i2c_driver.detach_adapter
> > > -When:	September 2011
> > > -Why:	These legacy callbacks should no longer be used as i2c-core offers
> > > -	a variety of preferable alternative ways to instantiate I2C devices.
> > > -Who:	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > -
> > > -----------------------------
> > > -
> > > (...)
> > 
> 

From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] i2c/pnx: Really fix start/stop issue
Date: Mon, 19 Apr 2010 18:59:29 +0200
Message-ID: <083DF309106F364B939360100EC290F80979C8121C@eu1rdcrdc1wx030.exi.nxp.com>
References: <1271586070-12266-1-git-send-email-w.sang@pengutronix.de>
 <20100418130457.0341efce@hyperion.delvare>
 <20100418114021.GA21364@pengutronix.de>
 <20100418165306.GB2234@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100418165306.GB2234-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


Hi Ben,

I'm not sure if you got the other set of 3 i2c-pnx patches
yet, one of those patches also fixed this issue. If you
haven't installed those patches yet, I'll resubmit them
without this fix.

thanks,
Kevin

> -----Original Message-----
> From: Ben Dooks [mailto:ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org]
> Sent: Sunday, April 18, 2010 9:53 AM
> To: Wolfram Sang
> Cc: Jean Delvare; Ben Dooks; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Luotao Fu; Kevin
> Wells
> Subject: Re: [PATCH] i2c/pnx: Really fix start/stop issue
> 
> On Sun, Apr 18, 2010 at 01:40:21PM +0200, Wolfram Sang wrote:
> > On Sun, Apr 18, 2010 at 01:04:57PM +0200, Jean Delvare wrote:
> > > Hi Wolfram,
> > >
> > > On Sun, 18 Apr 2010 12:21:10 +0200, Wolfram Sang wrote:
> > > > The issue was truly solved by the second patch in this thread:
> > > >
> > > > http://thread.gmane.org/gmane.linux.drivers.i2c/5436
> > > >
> > > > Accidently, the first one was picked up. So, this patch adds the
> > > > remaining diff (and an additional newline).
> > > >
> > > > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > Cc: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > Cc: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
> > > > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > > > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > > ---
> > > >
> > > > Jean, can you pick this up, so it will be correct in 2.6.34?
> > >
> > > i2c-pnx is for an embedded platform -> this is for Ben.
> >
> > Would you mind picking it up if he has not done till, let's say, rc6? He
> did
> > not comment to my pointers so far. Other stuff is pending, too (though not
> > urgent). Maybe he is away/busy?
> 
> Forgot to send last set of fixes after putting them into my git.
> 
> Will merge and send later today.
> 
> --
> Ben
> 

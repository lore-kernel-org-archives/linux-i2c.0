From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: i2c-i801 driver quit working in 3.8.11
Date: Thu, 7 Aug 2014 13:42:29 -0700
Message-ID: <20140807204229.GA7418@roeck-us.net>
References: <20130806192228.GB8246@roeck-us.net>
 <CANQojO74882h+oFJDrq2dsSC71NZHuyf2sjTzCr4a+VmPMLyVA@mail.gmail.com>
 <52026530.2080301@roeck-us.net>
 <CANQojO5B+7c+J=fxV-_mT=Y19Uy=4cW-83vnrphPkN5pmgc2YQ@mail.gmail.com>
 <20130807174801.GB1862@roeck-us.net>
 <CANQojO5QuoGSmmNYxxZ=0MhbZt0mEW-8n6kTxVSWuZ4p6NFw5Q@mail.gmail.com>
 <20130807192556.GA31395@roeck-us.net>
 <20140807101147.34087264@endymion.delvare>
 <CANQojO70ys+UERD5fw0pZDWpneN7aN6z+d-RfCNqiH5-gjDyNQ@mail.gmail.com>
 <20140807185557.512e08e5@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140807185557.512e08e5-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Soren Harward <stharward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 07, 2014 at 06:55:57PM +0200, Jean Delvare wrote:
> Hi Soren,
> 
> Please keep the list and everyone else involved in Cc.
> 
> On Thu, 7 Aug 2014 07:33:16 -0400, Soren Harward wrote:
> > On Aug 7, 2014 4:11 AM, "Jean Delvare" <jdelvare-l3A5Bk7waGM@public.gmane.org> wrote:
> > > Soren, what's the status on your side? Are you still running a kernel
> > > with commit 6676a847 reverted?
> > 
> > Yes, I'm running 3.14 (Gentoo is always a few versions behind) with
> > 6676a847 reverted.  Thanks for telling me about the command-line option;
> > that'll be way more convenient than reverting the patch every time I
> > upgrade.
> 
> OK. Did you ever try 3.14 without the revert? Or do you always revert
> before even testing because you assume the problem is still present?
> 
> > > Also I had one report of a problem with the same chipset you are using,
> > > and the reporter claims that kernel v3.16 no longer has the problem. We
> > > don't know why yet, but it might be worth a try.
> > 
> > I'm out of town for a few days, so I'll try v3.16 when I get home. I'll get
> > back to you mid next week.
> 
> Great, thanks.
> 
> Meanwhile I have prepared a debug flavor of the i2c-i801 driver, which
> can be built separately from the kernel:
> 
> http://jdelvare.nerim.net/devel/lm-sensors/drivers/i2c-i801_debug/
> 
> Feel free to give it a try and report the results, this may help us
> understand where the problem lies.
> 
I tried to enable MSI on a Xeon L5238, but it failed.
So I guess MSI does not work after all.

Guenetr

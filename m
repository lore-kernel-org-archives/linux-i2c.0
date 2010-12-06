From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Date: Mon, 6 Dec 2010 10:02:03 -0800
Message-ID: <20101206180203.GA18478@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
 <20101206173040.GA18372@ericsson.com>
 <AANLkTikGgfBuj086eRvy4VzzyE2suJCL9z=SfmOiFiPx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikGgfBuj086eRvy4VzzyE2suJCL9z=SfmOiFiPx-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org" <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, "Maciej W. Rozycki" <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 06, 2010 at 12:40:15PM -0500, Matt Turner wrote:
> On Mon, Dec 6, 2010 at 5:30 PM, Guenter Roeck
> <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org> wrote:
> > On Mon, Dec 06, 2010 at 01:38:14AM -0500, Matt Turner wrote:
> >> From: Maciej W. Rozycki <macro-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
> >>
> >> This is a rewrite of large parts of the driver mainly so that it uses
> >> SMBus interrupts to offload the CPU from busy-waiting on status inputs.
> >> As a part of the overhaul of the init and exit calls, all accesses to the
> >> hardware got converted to use accessory functions via an ioremap() cookie.
> >>
> >> Minimally rebased by Matt Turner.
> >>
> >> Tested-by: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Signed-off-by: Matt Turner <mattst88-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> >
> > I applied the patch to my 1480 tree. Unfortunately, it doesn't work with my system.
> > As far as I can see, the driver does not get any interrupts.
> >
> > My tree is 2.6.32, though. Do you know if I might be missing some other relevant patch ?
> >
> > Thanks,
> > Guenter
> 
> I think this patch depends on
> http://www.linux-mips.org/archives/linux-mips/2010-12/msg00030.html
> 
I did apply the second patch as well, since you had mentioned it in your patch.
That did not help, though. Frankly, I don't see the dependency in the first place - the other 
patch only affects drivers/rtc/rtc-m41t80.c, and I would hope that SMBus support does not depend
on an rtc driver. Am I missing something ?

Thanks,
Guenter

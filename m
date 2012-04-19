From: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-sh_mobile device tree support
Date: Thu, 19 Apr 2012 10:41:13 +0900
Message-ID: <20120419014113.GB22189@linux-sh.org>
References: <20120330084402.19597.63655.sendpatchset@w520>
 <20120330084744.GF26543@linux-sh.org>
 <CANqRtoTERUznk7xYr5qHMP4X5cVbvUw9vLZ5X-6YFkmVf69m4Q@mail.gmail.com>
 <20120330090341.GG26543@linux-sh.org>
 <20120418140839.GD19220@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120418140839.GD19220-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 18, 2012 at 04:08:39PM +0200, Wolfram Sang wrote:
> Hi Paul,
> 
> > > Of course, if you think it is cramping your SH device tree style then
> > > we can easily add a "renesas-shmobile-iic" entry as well.
> > > 
> > I obviously don't mind if you wish to use the rmobile naming convention
> > going forward, as the new parts have obviously dropped with the shmobile
> > naming convention, and it's likely you'll even be able to infer different
> > capabilities between rmobile vs shmobile. That's not sufficient cause to
> > prefer one over the other though, so you're still going to have to keep
> > things balanced. Simply having two aliases seems to me to be the easiest
> > solution.
> 
> "alias" is a second compatible entry here? Is it okay if this is added
> with a seperate patch when needed?
> 
Yes, that's fine.

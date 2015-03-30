From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH/RFC] i2c: rcar: Fix order of restart and clear status
Date: Mon, 30 Mar 2015 09:15:30 +0900
Message-ID: <20150330001530.GA1549@verge.net.au>
References: <1424011396-3492-1-git-send-email-ykaneko0929@gmail.com>
 <b0a6dd2b593f2f891946ef910c876b48@the-dreams.de>
 <20150304040819.GB12776@verge.net.au>
 <20150306220531.GA6572@katana>
 <20150307103349.GA1194@katana>
 <20150327131044.GB19151@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150327131044.GB19151@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 27, 2015 at 02:10:45PM +0100, Wolfram Sang wrote:
> On Sat, Mar 07, 2015 at 11:33:49AM +0100, Wolfram Sang wrote:
> > On Fri, Mar 06, 2015 at 11:05:31PM +0100, Wolfram Sang wrote:
> > > 
> > > > I asked Kataoka-san about this and his response was as follows:
> > > 
> > > Thanks, Simon!
> > > 
> > > > If system(CPU) is busy, the driver can't clear the status register soon
> > > > after kicking start.
> > > > 
> > > > If sequence of first start is as follows, there is a problem.
> > > > Because H/W starts by 1.
> > > > But sequence of re-start is as follows, there is no problem.
> > > > Because H/W starts by 2.
> > > > 
> > > >   1. Issue START condition by ESG bit of ICMCR register.
> > > >                   <--- If there is too much time, H/W finish transmitting
> > > >                        and set status in status register.
> > > >   2. Clear interrupt status (ICMSR).
> > > >   3. Open interrupt mask.
> > > >   4. Wait interrupt.
> > > >                   <--- If status is cleared, interrupt does not occur.
> > > 
> > > I understand. I'll add this explanation to the patch and apply it soon.
> > 
> > Sorry, another question came up while applying:
> > 
> > How can this interruption happen? The function is called in a
> > spin_lock_irqsave protected area. Is this an RT_PREEMPT related issue?
> > Am I missing something?
> 
> Hi,
> 
> any news on this one?

Sorry, I seem to have dropped the ball here. I've (finally) forwarded
your question on to the BSP team.

From: Radu Rendec <rrendec@arista.com>
Subject: Re: Calling i2c_transfer() from NMI context
Date: Fri, 02 Feb 2018 18:12:45 +0000
Message-ID: <1517595165.20910.18.camel@arista.com>
References: <1516995828.8854.12.camel@arista.com>
         <7c718179-2075-0a68-d8d0-acbfc8bdcf6b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:44962 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754064AbeBBSMv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Feb 2018 13:12:51 -0500
Received: by mail-pg0-f54.google.com with SMTP id m20so14410967pgc.11
        for <linux-i2c@vger.kernel.org>; Fri, 02 Feb 2018 10:12:50 -0800 (PST)
In-Reply-To: <7c718179-2075-0a68-d8d0-acbfc8bdcf6b@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org

On Fri, 2018-02-02 at 17:29 +0100, Peter Rosin wrote:
> On 2018-01-26 20:43, Radu Rendec wrote:
> > I have a weird use case where I need to call i2c_transfer() from NMI
> > context. The idea is to save some useful information in an i2c flash
> > memory before crashing the system (the NMI is triggered by a hardware
> > watchdog).
> > 
> > The problem is that i2c_transfer() ends up calling i2c_trylock_bus()
> > when in NMI context and the latter is basically just a wrapper around
> > rt_mutex_trylock(&adapter->bus_lock), which is not supposed to be
> > called from NMI context as per commit 6ce47fd961fa.
> > 
> > Since I'm not familiar with the overall i2c subsystem design, I'd like
> > to ask if what I'm trying to do is fundamentally wrong or is simply an
> > atypical use case that hasn't been considered in the design (and could
> > be worked around).
> 
> I don't know the answers to all you specific questions, but first off,
> all serial transactions from interrupt context seem ... suspect.

Thanks for getting back to me on this. Yes, serial transactions from
interrupt context do seem suspect, this is why I was questioning my own
reasoning in the first place.

> In this case, i2c is using an rt_mutex in order to prevent priority
> inversion. At least according to the commit changing the ordinary
> mutex to an rt_mutex. Changing back at this point will trigger all
> sorts of false positives from lockdep, so that might take some
> work. And you still have that priority inversion thing, which might
> cause regressions, but probably only on obscure HW three years
> down the road. Not fun to sign off on such changes.

No, I wouldn't go the path of changing the rt_mutex into an ordinary
mutex. As you already pointed out, the rt_mutex is there for a good
reason. Besides, I think an ordinary mutex would have a similar
problem.

> So, I think you will have to live with the rt_mutex. It might be
> an option to simply ignore the WARN from that commit? I mean, what
> difference does it make that you get a WARN, when you are crashing
> anyway? It might of course be bad if the deadlock mentioned in
> that 6ce47fd961fa commit triggers and causes the watchdog to fail
> to get you up and running again. But if that's the case, it feels
> like a rather useless watchdog...

It's the potential deadlock that worries me more than the WARN itself.
However, I took a different approach. I noticed that rt_mutex_trylock
has a fast path (which is just a cmpxchg) and a slow path. If the fast
path is available (i.e. cmpxchg is supported by the architecture and
the kernel is not compiled with rt_mutex debugging), it is enough to
acquire the lock and the slow path is not needed. The cmpxchg cannot
deadlock; it's only the slow path that can deadlock.

So what I did was "invent" a new rt_mutex_trylock_irq, which is
basically just the fast path of rt_mutex_trylock. If the fast path is
not available (or unsuccessful), this new function just fails -- which
is fine, since i2c_transfer already expects that the trylock operation
may fail.

This is good enough for me (it solves both the WARN and the potential
deadlock), but I'm not sure if it's relevant to the community. In other
words, I'm not sure if it's worth sending out a patch (or at least an
RFC) based on these changes.

Thanks,
Radu

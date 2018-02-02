From: Peter Rosin <peda@axentia.se>
Subject: Re: Calling i2c_transfer() from NMI context
Date: Fri, 2 Feb 2018 17:29:42 +0100
Message-ID: <7c718179-2075-0a68-d8d0-acbfc8bdcf6b@axentia.se>
References: <1516995828.8854.12.camel@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0113.outbound.protection.outlook.com ([104.47.2.113]:8754
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751963AbeBBQ3u (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Feb 2018 11:29:50 -0500
In-Reply-To: <1516995828.8854.12.camel@arista.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Radu Rendec <rrendec@arista.com>, linux-i2c@vger.kernel.org

On 2018-01-26 20:43, Radu Rendec wrote:
> Hi i2c developers,
> 
> I have a weird use case where I need to call i2c_transfer() from NMI
> context. The idea is to save some useful information in an i2c flash
> memory before crashing the system (the NMI is triggered by a hardware
> watchdog).
> 
> The problem is that i2c_transfer() ends up calling i2c_trylock_bus()
> when in NMI context and the latter is basically just a wrapper around
> rt_mutex_trylock(&adapter->bus_lock), which is not supposed to be
> called from NMI context as per commit 6ce47fd961fa.
> 
> Since I'm not familiar with the overall i2c subsystem design, I'd like
> to ask if what I'm trying to do is fundamentally wrong or is simply an
> atypical use case that hasn't been considered in the design (and could
> be worked around).

I don't know the answers to all you specific questions, but first off,
all serial transactions from interrupt context seem ... suspect.

In this case, i2c is using an rt_mutex in order to prevent priority
inversion. At least according to the commit changing the ordinary
mutex to an rt_mutex. Changing back at this point will trigger all
sorts of false positives from lockdep, so that might take some
work. And you still have that priority inversion thing, which might
cause regressions, but probably only on obscure HW three years
down the road. Not fun to sign off on such changes.

So, I think you will have to live with the rt_mutex. It might be
an option to simply ignore the WARN from that commit? I mean, what
difference does it make that you get a WARN, when you are crashing
anyway? It might of course be bad if the deadlock mentioned in
that 6ce47fd961fa commit triggers and causes the watchdog to fail
to get you up and running again. But if that's the case, it feels
like a rather useless watchdog...

Cheers,
Peter

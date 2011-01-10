From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [i2c-tools][PATCH] honor CROSS_COMPILE
Date: Mon, 10 Jan 2011 15:26:08 +0100
Message-ID: <20110110152608.536de8e7@endymion.delvare>
References: <1294426874-24973-1-git-send-email-nm@ti.com>
	<20110108192345.GB4045@pengutronix.de>
	<4D28C9D5.8050401@ti.com>
	<20110108210130.GC4045@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110108210130.GC4045-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 8 Jan 2011 22:01:30 +0100, Wolfram Sang wrote:
> On Sat, Jan 08, 2011 at 02:32:21PM -0600, Nishanth Menon wrote:
> > Wolfram Sang wrote, on 01/08/2011 01:23 PM:
> > >Then again, the vast majority of userspace-projects do not use CROSS_COMPILE.
> > >Build systems like ptxdist and buildroot have done fine with overriding CC so
> > >far. I don't see much gain in that addition.
> > >
> > The same is true for CROSS_COMPILE as well.. since the patch does
> > still allow CC to be over-ridden (as was the previous behavior), why
> > not add CROSS_COMPILE as well considering folks who could be cross
> > compiling just i2ctools without using buildroot and the likes?
> 
> You can override CC even without a build-system :) I would sum it up like this:
> On the positive side you could call it "more flexible", on the negative side
> you could call it "redundant". I wouldn't pick it up, but I surely have no
> strong feelings about it. It is up to Jean, after all.

I don't have a strong opinion on this either. But I don't get the point
of setting values for AS, LD, AR etc. when they don't seem to be used
anywhere. And STRIP is set too, but "strip" hard-coded in
tools/Module.mk, so I fail to see how that would work. What am I
missing?

-- 
Jean Delvare

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Build core and algo drivers with -Wshadow
Date: Tue, 16 Feb 2010 22:53:52 +0100
Message-ID: <20100216225352.1c4c3893@hyperion.delvare>
References: <20100216122152.29dbbeb5@hyperion.delvare>
	<20100216202715.GC17428@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100216202715.GC17428-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 16 Feb 2010 21:27:15 +0100, Wolfram Sang wrote:
> On Tue, Feb 16, 2010 at 12:21:52PM +0100, Jean Delvare wrote:
> > I like building with -Wshadow, it helps catch bugs or at least bad
> > choices in variable names.
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> > Any objection?
> 
> [After some searching]
> 
> Do you know if -Wshadow has improved since this thread?
> 
> http://kerneltrap.org/node/7434

Probably not. This is the reason why I enabled -Wshadow only in 2
selected subdirectories where I think it makes sense (low driver count)
rather than the whole kernel (or even the whole i2c subsystem.)

The fact that it spotted one (admittedly harmless) bug, and would have
caught my confusing code in i2c-smbus too, make me confident that this
is not too bad an idea.

-- 
Jean Delvare

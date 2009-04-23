From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa.c: timeouts off by 1
Date: Thu, 23 Apr 2009 16:35:07 -0700
Message-ID: <20090423163507.9588a73d.akpm@linux-foundation.org>
References: <49A524E4.5050108@gmail.com>
	<20090423143654.7fc2327e@hyperion.delvare>
	<49F07ADB.1030300@gmail.com>
	<20090423170218.66dda625@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090423170218.66dda625-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 23 Apr 2009 17:02:18 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> On Thu, 23 Apr 2009 16:27:39 +0200, Roel Kluin wrote:
> > Ok, here's for drivers/i2c/busses/i2c-pxa.c. Note that I found another,
> > the last hunk.
> > --------------------------->8-------------8<------------------------------
> > With `while (timeout--)' timeout reaches -1 after the loop, so the tests
> > below are off by one.
> > 
> > Signed-off-by: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> 
> Ben, Wolfram, I'll let you handle this one as it's an arm driver.
> 

The patch looks OK, but the original code is weird.

: static int i2c_pxa_wait_bus_not_busy(struct pxa_i2c *i2c)
: {
: 	int timeout = DEF_TIMEOUT;
: 
: 	while (timeout-- && readl(_ISR(i2c)) & (ISR_IBB | ISR_UB)) {
: 		if ((readl(_ISR(i2c)) & ISR_SAD) != 0)
: 			timeout += 4;
: 
: 		msleep(2);
: 		show_state(i2c);
: 	}
: 
: 	if (timeout < 0)
: 		show_state(i2c);
: 
: 	return timeout < 0 ? I2C_RETRY : 0;
: }

The timeout+=4 inside the loop makes my brain hurt.  It makes the loop
potentially almost-infinite.  By effectively doing timeout+=3 each time
we'll break out of the loop after we've wrapped through 0x100000000
three times.  Or something.  Help!



Also, i2c_pxa_pio_set_master() does

	long timeout = 2 * DEF_TIMEOUT;

whereas i2c_pxa_wait_bus_not_bus() does

	int timeout = DEF_TIMEOUT;


`int' seems an appropriate choice.

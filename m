From: Jamie Lokier <jamie-yetKDKU6eevNLxjTenLetw@public.gmane.org>
Subject: Re: [PATCH] mach-pxa/viper: Fix timeout usage for I2C
Date: Mon, 12 Apr 2010 22:53:26 +0100
Message-ID: <20100412215326.GD6148@shareable.org>
References: <20100412193943.GP3048@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100412193943.GP3048-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Paul Shen <paul.shen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Marc Zyngier <maz-20xNzvSXLT6hUMvJH42dtQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Russell King - ARM Linux wrote:
> On Mon, Apr 12, 2010 at 09:32:35PM +0200, Jean Delvare wrote:
> > On Mon, 12 Apr 2010 20:20:10 +0100, Russell King - ARM Linux wrote:
> > > On Mon, Apr 12, 2010 at 09:13:19PM +0200, Jean Delvare wrote:
> > > > On Tue, 13 Apr 2010 01:57:51 +0800, Eric Miao wrote:
> > > > > One other better and cleaner approach to such inconsistency issue is
> > > > > to have a timeout_ms field, and having i2c-gpio.c driver to convert this
> > > > > to jiffies using msec_to_jiffies() at run-time.
> > > > 
> > > > With what benefit? Expressing time values in units of HZ is very
> > > > frequent in the kernel code and shouldn't actually surprise anyone.
> > > 
> > > Actually, this patch shows there is confusion.
> > > 
> > > "Assume '100' means 100ms here and adapt accordingly."
> > > 
> > > Since this patch is for ARM, where HZ=100, the above patch is not a
> > > simple "convert how we derive this constant" patch - it's a functional
> > > change, reducing the timeouts by a factor of 10.
> > > 
> > > Could that be because the patch author misinterpreted the HZ-based
> > > values?
> > 
> > I admit I would have assumed 100 -> HZ, as hard-coded HZ-dependent
> > value typically assume HZ=100.
> > 
> > > I suspect I'm not the only one who thinks that the latter of "HZ / 10"
> > > "100ms" is easier to read and comprehend without mistake.
> > 
> > OTOH, converting from ms to jiffies each time you need the value has a
> > cost.
> 
> True; what I did for MMC stuff is converted it from ms to jiffies at
> initialization time when copying it in from platform data in the
> driver's probe function.
> 
> I'm not saying that I care either way, I'm merely showing that dealing
> with HZ-based values can be (maybe unexpectedly) more error prone.

HZ is used a lot in kernel timeouts, so even though it's confusing, it
is something everyone ought to get used to.

But I agree it is too confusing.  An obvious remedy is:

#define milliseconds(ms) (((ms) * HZ + 999) / 1000)
#define seconds(s)       ((s) * HZ)

-- Jamie

From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC] i2c-algo-bit: Disable interrupts while SCL is high
Date: Thu, 3 Nov 2011 13:59:28 +0100
Message-ID: <20111103135928.3fb04cef@endymion.delvare>
References: <20101216150638.7d3850b5@endymion.delvare>
	<20101216160046.GE20097@trinity.fluff.org>
	<20101216175337.2b1ae6ee@endymion.delvare>
	<4D0B5312.5080107@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D0B5312.5080107-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthias Zacharias <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Michael, Ben,

On Fri, 17 Dec 2010 13:09:54 +0100, Michael Lawnick wrote:
> Jean Delvare said the following:
> > Hi Ben,
> > 
> > On Thu, 16 Dec 2010 16:00:46 +0000, Ben Dooks wrote:
> >> On Thu, Dec 16, 2010 at 03:06:38PM +0100, Jean Delvare wrote:
> >> > Add a spinlock to every user of i2c-algo-bit, which is taken before
> >> > raising SCL and released after lowering SCL. We don't really need
> >> > the exclusion functionality, but we have to disable local interrupts.
> >> > This is needed to comply with SMBus requirements that SCL shouldn't
> >> > be high for longer than 50 us.
> >> > 
> >> > SMBus slaves can consider SCL being high for 50 us as a timeout
> >> > condition. This has been observed to happen reproducibly with the
> >> > Melexis MLX90614.
> >> > 
> >> > The drawback of this approach is that spin_lock_irqsave() and
> >> > spin_unlock_irqrestore() will be called once for each bit going on the
> >> > I2C bus in either direction. This can mean up to 100 kHz for standard
> >> > I2C and SMBus and up to 250 kHz for fast I2C. The good thing is that
> >> > this limits the latency to reasonable values (2us at 250 kHz, 5 us at
> >> > 100 kHz and 50 us at 10 kHz).
> >> 
> >> Hmm, this is going to be a drain on interrupt latency... disabling
> >> interrupts in a system for that long could cause other things to
> >> jitter.
> > 
> > So you consider that even disabling interrupts for 5 us is too long? Or
> > are you only worried by the 50 us case?
> 
> Sorry to disturb, but
> <MANTRA>
> 	Disabling interrupts may be done only for a few instructions.</MANTRA>
> 
> Even 1 us is an eternity on modern systems.

Well well, no matter how little you and Ben seem to like it, it appears
that w1 is going more or less the route I had proposed for i2c-algo-bit:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=3fd306c85adcde7209281cb663dd8ea247e97cc3

So I am again considering something similar for i2c (at least as an
option.) Presumably their local_irq_save() is cheaper than my
spin_lock_irqsave(), so I'd use that, not sure why I didn't do it
originally.

-- 
Jean Delvare

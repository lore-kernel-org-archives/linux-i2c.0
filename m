From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] staging iio: Replace kmalloc with local variable
Date: Tue, 7 Jun 2011 16:02:06 +0200
Message-ID: <20110607160206.6cb3168d@endymion.delvare>
References: <1307450354.1516.23.camel@anish-desktop>
	<4DEE20E7.4020008@cam.ac.uk>
	<20110607134135.GD15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110607134135.GD15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, anish <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-l3A5Bk7waGM@public.gmane.org, manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org, lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 7 Jun 2011 14:41:35 +0100, Ben Dooks wrote:
> On Tue, Jun 07, 2011 at 02:00:23PM +0100, Jonathan Cameron wrote:
> > On 06/07/11 13:39, anish wrote:
> > > From: anish kumar <anish198519851985-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > 
> > > replaced kmalloc with local variable as I2C(in this case) doesn't require
> > > kmalloc memory it can do with stack memory.
> > I've cc'd linux-i2c just to check I'm right about the whole i2c doesn't need
> > dma safe buffers bit...
> 
> No, it is down to the i2c driver, and from recollection dma from stack is
> not recommended, due to things like cache line alignment. Please do not
> do this.

To be clearer, it is down to the i2c BUS (adapter) driver, NOT the i2c
device driver. So the patch is correct.

Keep in mind that not all I2C/SMBus controllers care about DMA. In fact,
most don't (at least in the set I am maintaining - might be different
an embedded.) So calling kmalloc for every transfer in every I2C device
driver "just in case" is very much counterproductive.

And, if a controller does DMA and needs well-aligned, dynamically
allocated buffer, its driver would hopefully allocate the buffer ONCE
and keep it around, rather than reallocating it for every transfer.

-- 
Jean Delvare

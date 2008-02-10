From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [PATCH] Define a NO_GPIO macro to compare against and to use as
 an invalid GPIO
Date: Sun, 10 Feb 2008 01:13:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802100053450.7517@axis700.grange>
References: <Pine.LNX.4.64.0801311624370.8478@axis700.grange>
 <200802081543.42467.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756860AbYBJANU@vger.kernel.org>
In-Reply-To: <200802081543.42467.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 8 Feb 2008, David Brownell wrote:

> On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> > As discussed on i2c mailing list with David Brownell, and number
> > outside of the 0...MAX_INT range is invalid as a GPIO number.
> > Define a macro, similar to NO_IRQ, to be used as a deliberate
> > invalid GPIO, rather than defining a is_valid_gpio() macro.
> 
> Actually I thought that what you needed was an is_valid_gpio();
> your motivation was that you needed a predicate.
> 
> The problem I have with a #define for a single such invalid GPIO
> number is that people will inevitably start to assume it's the
> only such number.  In particular "if (gpio == NO_GPIO) ..."
> is by definition incorrect.
> 
> So I'd really rather see a predicate like is_valid_gpio().
> 
> If you want to designate one value for use as an initializer,
> then I'd rather see a simple
> 
> 	#define NO_GPIO	(-EINVAL)
> 
> without any option for arch-specific overrides ... along with a
> comment that this is only *one* of the numerous values which
> will fail is_valid_gpio().

I was thinking about irq numbers and trying to avoid as early as possible 
their problem: namely that each and every platform has its own idea of 
which irq numbers are valid and which are not, some use 0 as invalid irq, 
some -1, some 256, etc. And when those platforms share drivers, problems 
arise. And the simple and efficient NO_IRQ notion, that would fis those 
problems nicely, cannot seem to establish itself.

The disadvantages I see in your suggestions are:

1. two accessors (is_valid_gpio() and NO_GPIO) instead of one
2. have to include errno.h
3. it doesn't seem very logical to me to define a gpio number in terms of 
   an error code
4. "confusing freedom" - NO_GPIO is the invalid gpio number, but, in fact, 
   you can use just any negative number

Advantages of my proposal:

1. simplicity - only one macro, and "well-definedness" - use this and only 
   this as invalid gpio number. The rest are either valid, or undefined.
2. overridable by platforms - though I don't have any examples at hand, I 
   can imagine, that some platforms would prefer some specific "natural" 
   for them numbers.

But, this is not something I would spend too much energy arguing about, 
and this is your code in the end:-) So, if you still disagree, I'll do it 
the way you suggest. I might well be wrong too:-)

Thanks
Guennadi
---
Guennadi Liakhovetski

From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Define a NO_GPIO macro to compare against and to use as an invalid GPIO
Date: Fri, 8 Feb 2008 15:43:42 -0800
Message-ID: <200802081543.42467.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801311624370.8478@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759931AbYBHXn4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0801311624370.8478@axis700.grange>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> As discussed on i2c mailing list with David Brownell, and number
> outside of the 0...MAX_INT range is invalid as a GPIO number.
> Define a macro, similar to NO_IRQ, to be used as a deliberate
> invalid GPIO, rather than defining a is_valid_gpio() macro.

Actually I thought that what you needed was an is_valid_gpio();
your motivation was that you needed a predicate.

The problem I have with a #define for a single such invalid GPIO
number is that people will inevitably start to assume it's the
only such number.  In particular "if (gpio == NO_GPIO) ..."
is by definition incorrect.

So I'd really rather see a predicate like is_valid_gpio().

If you want to designate one value for use as an initializer,
then I'd rather see a simple

	#define NO_GPIO	(-EINVAL)

without any option for arch-specific overrides ... along with a
comment that this is only *one* of the numerous values which
will fail is_valid_gpio().

- Dave



> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
> 
> ---
> 
> As gpiolib doesn't seem to have an own mailing list, sending it directly 
> to LKML.
> 
>  include/asm-generic/gpio.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index f29a502..806b86c 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -16,6 +16,10 @@
>  #define ARCH_NR_GPIOS		256
>  #endif
>  
> +#ifndef NO_GPIO
> +#define NO_GPIO			((unsigned int)-1)
> +#endif
> +
>  struct seq_file;
>  
>  /**
> -- 
> 1.5.3.4
> 

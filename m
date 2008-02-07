From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [PATCH] Define a NO_GPIO macro to compare against and to use as
 an invalid GPIO
Date: Thu, 7 Feb 2008 16:24:48 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802071622020.5383@axis700.grange>
References: <Pine.LNX.4.64.0801311624370.8478@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932105AbYBGPYq@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0801311624370.8478@axis700.grange>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 31 Jan 2008, Guennadi Liakhovetski wrote:

> As discussed on i2c mailing list with David Brownell, and number
> outside of the 0...MAX_INT range is invalid as a GPIO number.
> Define a macro, similar to NO_IRQ, to be used as a deliberate
> invalid GPIO, rather than defining a is_valid_gpio() macro.

David, I think, your ack is required on this one. Can we get it in, 
please? My soc-camera patches are accepted by the v4l maintainer, and 
without this one the series would be incomplete.

Thanks
Guennadi

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

---
Guennadi Liakhovetski

From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/3] of: of_gpiochip_add is needed only for gpiolib
Date: Mon, 31 Jan 2011 15:16:35 -0700
Message-ID: <20110131221635.GB27856@angua.secretlab.ca>
References: <AANLkTimS70uHqmv3jhr+7mPz4QFKXRXuFnWj8s3EpKsO@mail.gmail.com>
 <1296487551-30938-2-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1296487551-30938-2-git-send-email-thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Cc: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 31, 2011 at 11:25:50PM +0800, Thomas Chou wrote:
> Some gpio drivers may not use gpiolib. In this case, struct gpio_chip
> is not defined and of_gpiochip_add/remove are not needed.
> 
> Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>

I'm not thrilled with the idea of supporting a gpio subsystem that
doesn't use gpiolib.  These functions don't even make sense if gpiolib
isn't being used (gpio_chip is a gpiolib construct).

Have you posted a patch that depends on this change?  Patch 3 in this
series doesn't seem to need it.

g.

> ---
>  include/linux/of_gpio.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
> index 6598c04..fc96af0 100644
> --- a/include/linux/of_gpio.h
> +++ b/include/linux/of_gpio.h
> @@ -71,9 +71,13 @@ static inline unsigned int of_gpio_count(struct device_node *np)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_GPIOLIB
> +
>  static inline void of_gpiochip_add(struct gpio_chip *gc) { }
>  static inline void of_gpiochip_remove(struct gpio_chip *gc) { }
>  
> +#endif /* CONFIG_GPIOLIB */
> +
>  #endif /* CONFIG_OF_GPIO */
>  
>  /**
> -- 
> 1.7.3.5
> 

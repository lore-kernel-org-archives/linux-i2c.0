From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2] i2c-bfin-twi: handle faulty slave devices better
Date: Wed, 12 May 2010 00:09:01 +0100
Message-ID: <20100511230901.GA31325@fluff.org.uk>
References: <1273403087-3326-1-git-send-email-vapier@gentoo.org>
 <1273505624-30920-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1273505624-30920-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 10, 2010 at 11:33:44AM -0400, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> Faulty slave devices might drive SDA low after a transfer finishes.  So,
> when this scenario is detected, have the master generate up to 9 extra
> clocks until the SDA is properly released.

This doesn't apply to my for-2635/i2c-bfin tree, can't find the BUFWERR
patch. will check to see if theres's something i've missed..
 
> Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> ---
> v2
> 	- fix typo in comment pointed out by Ben
> 	- use 9 clocks rather than 8 to cover a possible NACK pointed out by Michael
> 
>  drivers/i2c/busses/i2c-bfin-twi.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
> index fb26e5c..1ee9d5a 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -20,6 +20,7 @@
>  #include <linux/completion.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/delay.h>
>  
>  #include <asm/blackfin.h>
>  #include <asm/portmux.h>
> @@ -159,6 +160,27 @@ static void bfin_twi_handle_interrupt(struct bfin_twi_iface *iface,
>  		if (mast_stat & BUFWRERR)
>  			dev_dbg(&iface->adap.dev, "Buffer Write Error\n");
>  
> +		/* Faulty slave devices, may drive SDA low after a transfer
> +		 * finishes. To release the bus this code generates up to 9
> +		 * extra clocks until SDA is released.
> +		 */
> +
> +		if (read_MASTER_STAT(iface) & SDASEN) {
> +			int cnt = 9;
> +			do {
> +				write_MASTER_CTL(iface, SCLOVR);
> +				udelay(6);
> +				write_MASTER_CTL(iface, 0);
> +				udelay(6);
> +			} while ((read_MASTER_STAT(iface) & SDASEN) && cnt--);
> +
> +			write_MASTER_CTL(iface, SDAOVR | SCLOVR);
> +			udelay(6);
> +			write_MASTER_CTL(iface, SDAOVR);
> +			udelay(6);
> +			write_MASTER_CTL(iface, 0);
> +		}
> +
>  		/* If it is a quick transfer, only address without data,
>  		 * not an err, return 1.
>  		 */
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

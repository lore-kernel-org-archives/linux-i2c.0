From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Fri, 20 Feb 2009 11:05:42 -0800
Message-ID: <20090220190541.GX7414@atomide.com>
References: <20090220185329.GV7414@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090220185329.GV7414-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [090220 10:53]:
> Hi Ben,
> 
> Here's a fix for i2c-omap fix from Eero Nurkkala that would be nice
> to get queued up for mainline.

Resent, I still had the old i2c list in my aliases..

> Regards,
> 
> Tony

> From b3849f3074fe50f176e2e4d89be56854f7b02d3b Mon Sep 17 00:00:00 2001
> From: Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Date: Fri, 20 Feb 2009 10:46:17 -0800
> Subject: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
> 
> The number of bytes to be received is read from wrong
> place with all OMAPs with highspeed I2C support,
> which involves a FIFO and BUFSTAT_REG. It is the 6
> bits starting from the bit 8 in the BUFSTAT_REG
> that indicate this amount of bytes to be read.
> Moreover, only the 6 LSB:s are relevant for the
> TXSTAT field.
> 
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index be8ee2c..0c3ed41 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -675,8 +675,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				if (stat & OMAP_I2C_STAT_RRDY)
>  					num_bytes = dev->fifo_size;
>  				else
> -					num_bytes = omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG);
> +					num_bytes = (omap_i2c_read_reg(dev,
> +							OMAP_I2C_BUFSTAT_REG)
> +							>> 8) & 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;
> @@ -714,8 +715,9 @@ omap_i2c_isr(int this_irq, void *dev_id)
>  				if (stat & OMAP_I2C_STAT_XRDY)
>  					num_bytes = dev->fifo_size;
>  				else
> -					num_bytes = omap_i2c_read_reg(dev,
> -							OMAP_I2C_BUFSTAT_REG);
> +					num_bytes = (omap_i2c_read_reg(dev,
> +							OMAP_I2C_BUFSTAT_REG))
> +							& 0x3F;
>  			}
>  			while (num_bytes) {
>  				num_bytes--;

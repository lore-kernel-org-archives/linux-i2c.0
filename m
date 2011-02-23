From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-ocores: register devices on child nodes
Date: Wed, 23 Feb 2011 00:12:52 +0000
Message-ID: <20110223001252.GT15795@trinity.fluff.org>
References: <1297306314-11483-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1297306314-11483-1-git-send-email-thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Feb 10, 2011 at 10:51:54AM +0800, Thomas Chou wrote:
> This patch registers devices on the devicetree child nodes to the bus.
> Also removes one trailing whitespace.

Is this required as an urgent fix, or can it queue for next merge window?
 
> Signed-off-by: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-ocores.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index ef3bcb1..c63838f 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -18,7 +18,7 @@
>   * - interrupts      : interrupt number
>   * - regstep         : size of device registers in bytes
>   * - clock-frequency : frequency of bus clock in Hz
> - * 
> + *
>   * Example:
>   *
>   *  i2c0: ocores@a0000000 {
> @@ -55,6 +55,7 @@
>  #include <linux/i2c-ocores.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> +#include <linux/of_i2c.h>
>  
>  struct ocores_i2c {
>  	void __iomem *base;
> @@ -347,6 +348,9 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
>  			i2c_new_device(&i2c->adap, pdata->devices + i);
>  	}
>  
> +	/* Now register all the child nodes */
> +	of_i2c_register_devices(&i2c->adap);
> +
>  	return 0;
>  }
>  
> -- 
> 1.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

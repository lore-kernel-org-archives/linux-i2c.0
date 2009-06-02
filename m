From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Tue, 2 Jun 2009 23:48:22 +0100
Message-ID: <20090602224822.GE18453@fluff.org.uk>
References: <4A2566E8.7080404@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4A2566E8.7080404-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard R????jfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 02, 2009 at 07:52:40PM +0200, Richard R????jfors wrote:
> There is sometimes a need for the ocores driver to add devices to the bus when installed.

please wrap to 72 characters per line. 
 
> i2c_register_board_info can not always be used, because the I2C devices are not known at an early state,
> they could for instance be connected on a I2C bus on a PCI device which has the Open Cores IP.

Maybe i2c_register_board_info() needs to check if the bus is extant
or not. Anyone else have any feedback on this suggestion?
 
> i2c_new_device can not be used in all cases either since the resulting bus nummer might be unknown.
> 
> The solution is the pass a list of I2C devices in the platform data to the Open Cores driver. Is
> useful for MFD drivers for instance.

Possibly, but most systems I see know what devices they have before
instantiation so can hard-fix the bus numbering when supplying the MFD
drivers with their data.
 
> Signed-off-by: Richard R??jfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
> ---
> Index: linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c
> ===================================================================
> --- linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c	(revision 861)
> +++ linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c	(revision 862)
> @@ -216,6 +216,7 @@
>  	struct ocores_i2c_platform_data *pdata;
>  	struct resource *res, *res2;
>  	int ret;
> +	u8 i;

really, an int will do here, you might find compilers on !x86 archs
will spend time contracting this variable to an u8.
 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res)
> @@ -271,6 +272,10 @@
>  		goto add_adapter_failed;
>  	}
> 
> +	/* add in known devices to the bus */
> +	for (i = 0; i < pdata->num_devices; i++)
> +		i2c_new_device(&i2c->adap, pdata->devices + i);
> +
>  	return 0;
> 
>  add_adapter_failed:
> Index: linux-2.6.30-rc7/include/linux/i2c-ocores.h
> ===================================================================
> --- linux-2.6.30-rc7/include/linux/i2c-ocores.h	(revision 861)
> +++ linux-2.6.30-rc7/include/linux/i2c-ocores.h	(revision 862)
> @@ -14,6 +14,8 @@
>  struct ocores_i2c_platform_data {
>  	u32 regstep;   /* distance between registers */
>  	u32 clock_khz; /* input clock in kHz */
> +	u8 num_devices; /* number of devices in the devices list */
> +	struct i2c_board_info const *devices; /* devices connected to the bus */
>  };

anyone want to kerneldoc this?
 
>  #endif /* _LINUX_I2C_OCORES_H */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

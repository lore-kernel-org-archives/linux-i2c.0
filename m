From: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/6] i2c: Xilinx IIC: make reset after TX error
 configurable
Date: Mon, 3 Aug 2015 07:34:27 +0200
Message-ID: <55BEFD63.6090108@xilinx.com>
References: <1438344034-20211-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
 <1438344034-20211-7-git-send-email-rabel@cit-ec.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438344034-20211-7-git-send-email-rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 07/31/2015 02:00 PM, Robert ABEL wrote:
> CONFIG_I2C_XILINX_ERRATA makes resetting XIIC after every
> Master Transmit error configurable.
> Also mention proper module name for XIIC kernel module.

Datasheet? version.

> 
> Signed-off-by: Robert ABEL <rabel-Ejy783gw450hGw5VS8l+XCM2BslAju9D@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig    | 9 ++++++++-
>  drivers/i2c/busses/i2c-xiic.c | 9 +++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 46d5488..3255e89 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -886,7 +886,14 @@ config I2C_XILINX
>  	  Xilinx I2C controller.
>  
>  	  This driver can also be built as a module.  If so, the module
> -	  will be called xilinx_i2c.
> +	  will be called i2c-xiic.
> +
> +config I2C_XILINX_ERRATA
> +	bool "Reset on "
> +	depends on I2C_XILINX
> +	help
> +	  By enabling this option, the Xilinx I2C Controller will be reset
> +	  after Master Transmit Errors.
>  
>  config I2C_XLR
>  	tristate "XLR I2C support"
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 5c9897e..6a834bc 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -509,6 +509,15 @@ static irqreturn_t xiic_process(int irq, void *dev_id)
>  			break;
>  		}
>  
> +#if defined(CONFIG_I2C_XILINX_ERRATA)
> +		if (!(msg->flags & I2C_M_RD)) {
> +			/* dynamic mode seem to suffer from problems if we just flush
> +			 * fifos and the next message is a TX with len 0 (only addr)
> +			 * reset the IP instead of just flushing fifos
> +			 */
> +			xiic_reinit(i2c);
> +		}
> +#endif
>  	}
>  	
>  	/* Receive FIFO is full */
> 

Make it DT configurable.

Thanks,
Michal

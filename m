From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware-pci: Add Haswell ULT device IDs
Date: Mon, 21 Oct 2013 09:53:42 +0300
Message-ID: <20131021065342.GW3521@intel.com>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
 <1382326010-4554-2-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1382326010-4554-2-git-send-email-bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 20, 2013 at 08:26:49PM -0700, Benson Leung wrote:
> From: Duncan Laurie <dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> 
> Add the necessary PCI Device IDs to use the Haswell ULT
> I2C controller in PCI mode.
> 
> Set the bus numbers to -1 so it will use dynamic assignment
> rather than hardcoded.
> 
> Signed-off-by: Duncan Laurie <dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Looks good to me, except one thing...

> ---
>  drivers/i2c/busses/i2c-designware-pcidrv.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index f6ed06c..e4cbbdf 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -54,6 +54,9 @@ enum dw_pci_ctl_id_t {
>  	medfield_3,
>  	medfield_4,
>  	medfield_5,
> +
> +	haswell_0,
> +	haswell_1,
>  };
>  
>  struct dw_pci_controller {
> @@ -132,6 +135,20 @@ static struct  dw_pci_controller  dw_pci_controllers[] = {
>  		.rx_fifo_depth = 32,
>  		.clk_khz      = 25000,
>  	},
> +	[haswell_0] = {
> +		.bus_num     = -1,
> +		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
> +		.tx_fifo_depth = 32,
> +		.rx_fifo_depth = 32,
> +		.clk_khz      = 25000,

The input clock for I2C in Haswell is 100MHz, not 25MHz.

> +	},
> +	[haswell_1] = {
> +		.bus_num     = -1,
> +		.bus_cfg   = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
> +		.tx_fifo_depth = 32,
> +		.rx_fifo_depth = 32,
> +		.clk_khz      = 25000,

Ditto.

> +	},
>  };

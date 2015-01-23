From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 3/3] i2c: designware-pci: no need to provide clk_khz
Date: Fri, 23 Jan 2015 11:12:13 +0200
Message-ID: <54C2106D.5050206@linux.intel.com>
References: <1421937869-28376-1-git-send-email-andriy.shevchenko@linux.intel.com> <1421937869-28376-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421937869-28376-3-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 01/22/2015 04:44 PM, Andy Shevchenko wrote:
> The clk_khz field makes sense only if SS counters are not provided. Since we
> provide them for Haswell and Baytrail explicitly we can omit the clk_khz
> parameter.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>   drivers/i2c/busses/i2c-designware-pcidrv.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
> index 2bbd2a7..506cbe8 100644
> --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> @@ -112,7 +112,6 @@ static struct dw_pci_controller dw_pci_controllers[] = {
>   		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
>   		.tx_fifo_depth = 32,
>   		.rx_fifo_depth = 32,
> -		.clk_khz = 100000,
>   		.functionality = I2C_FUNC_10BIT_ADDR,
>   		.scl_sda_cfg = &byt_config,
>   	},
> @@ -121,7 +120,6 @@ static struct dw_pci_controller dw_pci_controllers[] = {
>   		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
>   		.tx_fifo_depth = 32,
>   		.rx_fifo_depth = 32,
> -		.clk_khz = 100000,
>   		.functionality = I2C_FUNC_10BIT_ADDR,
>   		.scl_sda_cfg = &hsw_config,
>   	},
>
Yes, there are no other use for the clock rate than calculate these SS 
counters in drivers/i2c/busses/i2c-designware-core.c, and which will get 
overwritten by provided values.

Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

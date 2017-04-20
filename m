From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v8 4/6] i2c: designware: introducing I2C_SLAVE definitions
Date: Thu, 20 Apr 2017 15:49:12 +0300
Message-ID: <fe61a6b8-fd6e-0f90-be31-852b252ddf33@linux.intel.com>
References: <cover.1492014220.git.lolivei@synopsys.com>
 <d04556720066de26b6c7f979d0a1ab9bdf36e8fe.1492014220.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d04556720066de26b6c7f979d0a1ab9bdf36e8fe.1492014220.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/12/2017 07:47 PM, Luis Oliveira wrote:
> - Definitions were added to core library
> - A example was added to designware-core.txt Documentation that shows
>   how the slave can be setup using DTS
>
> SLAVE related definitions were added to the core of the controller.
>
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
> v7-v8
> - no changes
...
> +#define DW_IC_RX_ABRT_SLAVE_RD_INTX	(1UL << ABRT_SLAVE_RD_INTX)
> +#define DW_IC_RX_ABRT_SLAVE_ARBLOST	(1UL << ABRT_SLAVE_ARBLOST)
> +#define DW_IC_RX_ABRT_SLAVE_FLUSH_TXFIFO	(1UL << ABRT_SLAVE_FLUSH_TXFIFO)
>
>  #define DW_IC_TX_ABRT_NOACK		(DW_IC_TX_ABRT_7B_ADDR_NOACK | \
>  					 DW_IC_TX_ABRT_10ADDR1_NOACK | \
> @@ -212,6 +237,7 @@ struct dw_i2c_dev {
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
>  	struct reset_control	*rst;
> +	struct i2c_client		*slave;
>  	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
>  	struct dw_pci_controller *controller;
>  	int			cmd_err;
> @@ -231,6 +257,7 @@ struct dw_i2c_dev {
>  	struct i2c_adapter	adapter;
>  	u32			functionality;
>  	u32			master_cfg;
> +	u32			slave_cfg;
>  	unsigned int		tx_fifo_depth;
>  	unsigned int		rx_fifo_depth;
>  	int			rx_outstanding;

You forgot to add comments here.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

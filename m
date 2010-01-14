From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 2/3] Check component type register
Date: Thu, 14 Jan 2010 01:11:01 +0000
Message-ID: <20100114011101.GK3738@trinity.fluff.org>
References: <20100113193224.753273000@octasic.com> <20100113193421.139644000@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100113193421.139644000-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 13, 2010 at 02:32:26PM -0500, Jean-Hugues Deschenes wrote:
> Designware component type register is checked before attaching to the device.
> 
> ---
>  drivers/i2c/busses/i2c-designware.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Index: linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
> ===================================================================
> --- linux-2.6_i2c.orig/drivers/i2c/busses/i2c-designware.c
> +++ linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
> @@ -68,6 +68,7 @@
>  #define DW_IC_TXFLR		0x74
>  #define DW_IC_RXFLR		0x78
>  #define DW_IC_COMP_PARAM_1	0xf4
> +#define DW_IC_COMP_TYPE		0xfc
>  #define DW_IC_TX_ABRT_SOURCE	0x80
>  
>  #define DW_IC_CON_MASTER		0x1
> @@ -756,6 +757,16 @@ static int __devinit dw_i2c_probe(struct
>  		goto err_unuse_clocks;
>  	}
>  	{
> +		u32 comp_type = i2c_dw_readl(dev, DW_IC_COMP_TYPE);
> +
> +		if (0x44570140 != comp_type) {
> +			dev_err(&pdev->dev, "Unknown Synopsys component type: "
> +					"0x%08x\n",	comp_type);
> +			r = -ENODEV;
> +			goto err_iounmap;
> +		}
> +	}
> +	{

The general convention in linux is to do (if x = constant).

>  		u32 param1 = i2c_dw_readl(dev, DW_IC_COMP_PARAM_1);
>  
>  		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
> 
> -- 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2 2/3] i2c-designware: Check component type register
Date: Sun, 24 Jan 2010 15:40:26 +0000
Message-ID: <20100124154026.GC28675@fluff.org.uk>
References: <20100119140234.689304000@octasic.com>
 <20100119140234.870830000@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100119140234.870830000-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 19, 2010 at 09:02:36AM -0500, Jean-Hugues Deschenes wrote:
> Designware component type register is checked before attaching to the device.
> 
> Signed-off-by: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
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
> +		u32 comp_type = dw_readl(dev, DW_IC_COMP_TYPE);
> +
> +		if (comp_type != 0x44570140) {
> +			dev_err(&pdev->dev, "Unknown Synopsys component type: "
> +					"0x%08x\n",	comp_type);
> +			r = -ENODEV;
> +			goto err_iounmap;
> +		}
> +	}

having looked at the code around here, let's just use a single
u32 reg or u32 val field at the top of dw_i2c_probe and avoid the
need for the {} blocks in the probe.

Would like to see a patch fixing this added to the series.

> +	{
>  		u32 param1 = dw_readl(dev, DW_IC_COMP_PARAM_1);
>  
>  		dev->tx_fifo_depth = ((param1 >> 16) & 0xff) + 1;
> 
> -- 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

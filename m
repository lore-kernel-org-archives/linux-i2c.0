From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] Use local version of readl & writel
Date: Fri, 15 Jan 2010 08:40:51 +0900
Message-ID: <4B4FAB83.1060408@necel.com>
References: <20100113193224.753273000@octasic.com> <20100113193421.068608000@octasic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100113193421.068608000-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean-Hugues Deschenes wrote:
> Use local versions of readl & writel, so per-access manipulations may be performed

Let's put Signed-off-by: here.

> ---
>  drivers/i2c/busses/i2c-designware.c |   88 ++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> Index: linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
> ===================================================================
> --- linux-2.6_i2c.orig/drivers/i2c/busses/i2c-designware.c
> +++ linux-2.6_i2c/drivers/i2c/busses/i2c-designware.c
> @@ -219,6 +219,16 @@ struct dw_i2c_dev {
>  	unsigned int		rx_fifo_depth;
>  };
>  
> +static u32 i2c_dw_readl(struct dw_i2c_dev *dev, int addr)
> +{
> +	return readl(dev->base + addr);
> +}

nit: As being used with dev->base, "offset", "reg" or something
like that would be nice, rather than "addr".

> +static void i2c_dw_writel(struct dw_i2c_dev *dev, u32 b, int addr)
> +{
> +	writel(b, dev->base + addr);
> +}
> +
>  static u32
>  i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
>  {

Since these are I/O accessros / wrappers, and don't provide any
meaningful functions, how about simply dw_readl() / dw_writel(),
similarly as other {read,write}[bwl] wrappers do.  I'd prefer a
reasonably shorter name for this kind of accessors!

-- 
Shinya Kuribayashi
NEC Electronics

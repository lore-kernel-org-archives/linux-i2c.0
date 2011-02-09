From: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/10] i2c-designware: Allow mixed endianness accesses
Date: Thu, 10 Feb 2011 00:42:31 +0900
Message-ID: <4D52B5E7.4060106@pobox.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
 <1296699608-13227-2-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1296699608-13227-2-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 02/03/2011 11:19 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> @@ -356,24 +393,24 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
>  	u32 ic_con;
>  
>  	/* Disable the adapter */
> -	writel(0, dev->base + DW_IC_ENABLE);
> +	dw_writel(dev, 0, DW_IC_ENABLE);
>  
>  	/* set the slave (target) address */
> -	writel(msgs[dev->msg_write_idx].addr, dev->base + DW_IC_TAR);
> +	dw_writel(dev, msgs[dev->msg_write_idx].addr, DW_IC_TAR);
>  
>  	/* if the slave address is ten bit address, enable 10BITADDR */
> -	ic_con = readl(dev->base + DW_IC_CON);
> +	ic_con = dw_readl(dev, DW_IC_CON);
>  	if (msgs[dev->msg_write_idx].flags & I2C_M_TEN)
>  		ic_con |= DW_IC_CON_10BITADDR_MASTER;
>  	else
>  		ic_con &= ~DW_IC_CON_10BITADDR_MASTER;
> -	writel(ic_con, dev->base + DW_IC_CON);
> +	dw_writel(dev->base, ic_con, DW_IC_CON);

Found a type:
	dw_writel(dev, ic_con, DW_IC_CON);

>  	/* Enable the adapter */
> -	writel(1, dev->base + DW_IC_ENABLE);
> +	dw_writel(dev, 1, DW_IC_ENABLE);
>  
>  	/* Enable interrupts */
> -	writel(DW_IC_INTR_DEFAULT_MASK, dev->base + DW_IC_INTR_MASK);
> +	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
>  }

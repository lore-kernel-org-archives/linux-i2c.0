From: Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 03/10] i2c-designware: retrieve clock frequency based
 CONFIG_HAVE_CLK
Date: Fri, 04 Feb 2011 13:28:20 +0900
Message-ID: <4D4B8064.2040008@renesas.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
 <1296699608-13227-4-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1296699608-13227-4-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2/3/2011 11:20 AM, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> +u32 i2c_dw_clk_get_rate(struct dw_i2c_dev *dev)
> +{
> +#ifndef CONFIG_HAVE_CLK
> +	return dev->clk_khz;
> +#else
> +	return clk_get_rate(dev->clk)/1000;
> +#endif
> +}
> +

As pointed out before, I prefer not use #ifndef like this:

#ifdef CONFIG_HAVE_CLK
	return clk_get_rate(dev->clk)/1000;
#else
	return dev->clk_khz;
#endif


> @@ -76,7 +85,6 @@ void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
>  	writel(b, dev->base + offset);
>  }
>  
> -
>  static u32
>  i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
>  {

Unnecessary empty line.

As for the rest, this is ok.
-- 
Shinya Kuribayashi
Renesas Electronics

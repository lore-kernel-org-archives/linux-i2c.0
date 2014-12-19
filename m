From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: use {readl|writel}_relaxed instead of
 readl/writel
Date: Fri, 19 Dec 2014 10:43:15 +0800
Message-ID: <20141219104315.0ccbba9c@xhacker>
References: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418279201-3886-1-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear all,

Is there any issue I need to resolve so that the patch can be merged?

Thanks in advance,
Jisheng

On Wed, 10 Dec 2014 22:26:41 -0800
Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org> wrote:

> readl/writel is too expensive especially on Cortex A9 w/ outer L2 cache.
> This introduces i2c read/write errors on Marvell BG2/BG2Q SoCs when there
> are heavy L2 cache maintenance operations at the same time.
> 
> The driver does not perform DMA, so it's safe to use the relaxed version.
> From another side, the relaxed io accessor macros are available on all
> architectures now, so we can use the relaxed versions instead.
> 
> Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c
> b/drivers/i2c/busses/i2c-designware-core.c index 23628b7..e279948 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -170,10 +170,10 @@ u32 dw_readl(struct dw_i2c_dev *dev, int offset)
>  	u32 value;
>  
>  	if (dev->accessor_flags & ACCESS_16BIT)
> -		value = readw(dev->base + offset) |
> -			(readw(dev->base + offset + 2) << 16);
> +		value = readw_relaxed(dev->base + offset) |
> +			(readw_relaxed(dev->base + offset + 2) << 16);
>  	else
> -		value = readl(dev->base + offset);
> +		value = readl_relaxed(dev->base + offset);
>  
>  	if (dev->accessor_flags & ACCESS_SWAP)
>  		return swab32(value);
> @@ -187,10 +187,10 @@ void dw_writel(struct dw_i2c_dev *dev, u32 b, int
> offset) b = swab32(b);
>  
>  	if (dev->accessor_flags & ACCESS_16BIT) {
> -		writew((u16)b, dev->base + offset);
> -		writew((u16)(b >> 16), dev->base + offset + 2);
> +		writew_relaxed((u16)b, dev->base + offset);
> +		writew_relaxed((u16)(b >> 16), dev->base + offset + 2);
>  	} else {
> -		writel(b, dev->base + offset);
> +		writel_relaxed(b, dev->base + offset);
>  	}
>  }
>  

From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 5/5] ARM: shmobile: r8a7791: add DMA nodes for IIC
Date: Thu, 13 Nov 2014 09:26:50 +0900
Message-ID: <20141113002650.GB14971@verge.net.au>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <1415355104-2031-6-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415355104-2031-6-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 07, 2014 at 11:11:44AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 9a57215f54f7..213b6bda6201 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -371,6 +371,8 @@
>  		reg = <0 0xe60b0000 0 0x425>;
>  		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
> +		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
>  
> @@ -381,6 +383,8 @@
>  		reg = <0 0xe6500000 0 0x425>;
>  		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
> +		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
>  
> @@ -391,6 +395,8 @@
>  		reg = <0 0xe6510000 0 0x425>;
>  		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
> +		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
>  
> -- 
> 2.1.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

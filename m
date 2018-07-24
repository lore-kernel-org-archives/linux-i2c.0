From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/4] arm: dts: ls1021a: Enable I2C DMA support
Date: Tue, 24 Jul 2018 10:02:48 +0200
Message-ID: <20180724080248.gncihyhiibzkvkzg@pengutronix.de>
References: <20180709094304.8814-1-esben.haabendal@gmail.com>
 <20180709094304.8814-5-esben.haabendal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180709094304.8814-5-esben.haabendal@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben.haabendal@gmail.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Yuan Yao <yao.yuan@freescale.com>, Esben Haabendal <eha@deif.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, NXP Linux Team <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

expanding Cc a bit to include Shawn and the kernel teams of Pengutronix
and NXP.

On Mon, Jul 09, 2018 at 11:43:04AM +0200, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Gives substantial performance improvement for transfers larger than 16
> bytes (DMA_THRESHOLD).  Smaller transfers are unaffected.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c55d479971cc..1e5640701c65 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -363,6 +363,8 @@
>  			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "i2c";
>  			clocks = <&clockgen 4 1>;
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 39>, <&edma0 1 38>;
>  			status = "disabled";
>  		};
>  
> @@ -374,6 +376,8 @@
>  			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "i2c";
>  			clocks = <&clockgen 4 1>;
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 37>, <&edma0 1 36>;
>  			status = "disabled";
>  		};
>  
> @@ -385,6 +389,8 @@
>  			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "i2c";
>  			clocks = <&clockgen 4 1>;
> +			dma-names = "tx", "rx";
> +			dmas = <&edma0 1 35>, <&edma0 1 34>;
>  			status = "disabled";
>  		};

This is a bit orthogonal to the other changes in this series and needs
at least an ack from Shawn. Looks ok in my eyes.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

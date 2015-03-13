From: Andy Gross <agross@codeaurora.org>
Subject: Re: [PATCH 6/6] dts: msm8974: Add dma channels for blsp2_i2c1 node
Date: Fri, 13 Mar 2015 14:54:25 -0500
Message-ID: <20150313195425.GA16977@qualcomm.com>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
 <1426268992-19298-7-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426268992-19298-7-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, galak@codeaurora.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 13, 2015 at 11:19:52PM +0530, Sricharan R wrote:
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---

Reviewed-by: Andy Gross <agross@codeaurora.org>

>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 3f648ae..1ec7ec5 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -246,6 +246,8 @@
>  			clock-names = "core", "iface";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> +			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
> +			dma-names = "bam-tx", "bam-rx";

more of a nit, but the bam- is unnecessary.  it's just rx/tx.
>  		};
>  
>  		blsp2_dma: dma@f9944000 {
> -- 
> 1.8.2.1
> 

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: i3c: Document Qualcomm GENI I3C
 master bindings
Date: Mon, 13 Aug 2018 15:47:55 -0600
Message-ID: <20180813214755.GA18952@rob-hp-laptop>
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
 <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533101942-29442-3-git-send-email-mshettel@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Shettel <mshettel@codeaurora.org>
Cc: gregkh@linuxfoundation.org, boris.brezillon@bootlin.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, bjorn.andersson@linaro.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 31, 2018 at 11:39:01PM -0600, Mike Shettel wrote:
> Signed-off-by: Mike Shettel <mshettel@codeaurora.org>
> ---
>  .../devicetree/bindings/i3c/qcom,geni-i3c.txt      | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt b/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> new file mode 100644
> index 0000000..8b76fda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
> @@ -0,0 +1,44 @@
> +Bindings for Qualcomm Geni I3C master block
> +===========================================
> +
> +Required properties:
> +--------------------
> +- compatible: shall be "qcom,geni-i3c"
> +- clocks: shall reference the se clock
> +- clock-names: shall contain clock name corresponding to the serial engine

What's the name?

> +- interrupts: the interrupt line connected to this I3C master
> +- reg: I3C master registers
> +
> +Optional properties:
> +--------------------
> +- se-clock-frequency: Source serial clock frequency to use

You should be able to figure out this frequency based on available 
dividers and the specified bus frequencies.

Or use assigned-clocks.

> +- dfs-index: Dynamic frequency scaling table index to use

Needs a vendor prefix.

> +
> +Mandatory properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- #address-cells: shall be set to 3
> +- #size-cells: shall be set to 0
> +
> +Optional properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- i2c-scl-hz
> +- i3c-scl-hz
 +
> +I3C device connected on the bus follow the generic description (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> +
> +Example:
> +
> +	i3c-master@0d040000 {
> +		compatible = "qcom,geni-i3c";
> +		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
> +		clock-names = "se";
> +		interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
> +		reg = <0x0d040000 0x4000>;
> +		#address-cells = <3>;
> +		#size-cells = <0>;
> +		i2c-scl-hz = <100000>;
> +	};
> +
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

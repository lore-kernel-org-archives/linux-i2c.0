From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: media: Binding document for Qualcomm
 Camera Control Interface driver
Date: Tue, 17 Oct 2017 17:21:28 -0500
Message-ID: <20171017222128.eg256eba4ufqjsus@rob-hp-laptop>
References: <1507892203-17033-1-git-send-email-todor.tomov@linaro.org>
 <1507892203-17033-2-git-send-email-todor.tomov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507892203-17033-2-git-send-email-todor.tomov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Todor Tomov <todor.tomov@linaro.org>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

gOn Fri, Oct 13, 2017 at 01:56:40PM +0300, Todor Tomov wrote:
> Add DT binding document for Qualcomm Camera Control Interface driver
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>  .../devicetree/bindings/i2c/i2c-qcom-cci.txt       | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt b/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> new file mode 100644
> index 0000000..cb1fe15
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> @@ -0,0 +1,46 @@
> +Qualcomm Camera Control Interface controller
> +
> +Required properties:
> + - compatible: Should be one of:
> +   - "qcom,cci-v1.0.8" for 8916;
> +   - "qcom,cci-v1.4.0" for 8996.

Does using version numbers really buy anything over using SoC names?

> + - #address-cells: Should be <1>.
> + - #size-cells: Should be <0>.
> + - reg: Base address of the controller and length of memory mapped region.
> + - interrupts: Specifier for CCI interrupt.
> + - clocks: List of clock specifiers, one for each entry in clock-names.
> + - clock-names: Should contain:
> +   - "mmss_mmagic_ahb" - on 8996 only;
> +   - "camss_top_ahb";
> +   - "cci_ahb";
> +   - "cci";
> +   - "camss_ahb".
> +
> +Required properties on 8996:
> + - power-domains: Power domain specifier.
> +
> +Optional:
> + - clock-frequency: Desired I2C bus clock frequency in Hz, defaults to 100 kHz
> +   if omitted.

I2C freq? The block has an I2C controller? If so, you should explicitly 
state that somewhere in here and show a sensor as a child node.


> +
> +Example:
> +
> +                cci@a0c000 {
> +                        compatible = "qcom,cci-v1.4.0";
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <0xa0c000 0x1000>;
> +                        interrupts = <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>;
> +                        power-domains = <&mmcc CAMSS_GDSC>;
> +                        clocks = <&mmcc MMSS_MMAGIC_AHB_CLK>,
> +                                        <&mmcc CAMSS_TOP_AHB_CLK>,
> +                                        <&mmcc CAMSS_CCI_AHB_CLK>,
> +                                        <&mmcc CAMSS_CCI_CLK>,
> +                                        <&mmcc CAMSS_AHB_CLK>;
> +                        clock-names = "mmss_mmagic_ahb",
> +                                        "camss_top_ahb",
> +                                        "cci_ahb",
> +                                        "cci",
> +                                        "camss_ahb";
> +                        clock-frequency = <400000>;
> +                };
> -- 
> 2.7.4
> 

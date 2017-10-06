From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/4] dt-bindings: media: Binding document for Qualcomm
 Camera Control Interface driver
Date: Thu, 5 Oct 2017 22:29:54 -0700
Message-ID: <20171006052954.GC1575@tuxbook>
References: <1506953613-23875-1-git-send-email-todor.tomov@linaro.org>
 <1506953613-23875-2-git-send-email-todor.tomov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506953613-23875-2-git-send-email-todor.tomov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Todor Tomov <todor.tomov@linaro.org>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon 02 Oct 07:13 PDT 2017, Todor Tomov wrote:
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt b/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> new file mode 100644
> index 0000000..f4c5338
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> @@ -0,0 +1,55 @@
> +Qualcomm Camera Control Interface I2C controller

Well, it's not a I2C controller, it is a MIPI CCI controller.

> +
> +Required properties:
> + - compatible: Should be one of:
> +   - "qcom,cci-v1.0.8" for 8916;
> +   - "qcom,cci-v1.4.0" for 8996.
> + - #address-cells: Should be <1>.
> + - #size-cells: Should be <0>.
> + - reg: Base address of the controller and length of memory mapped region.
> + - reg-names: Should be "cci".

No need for reg-names, as we only have one.

> + - interrupts: Specifier for CCI interrupt.
> + - interrupt-names: Should be "cci".

No need for interrupt-names, as we only have one.

> + - clocks: List of clock specifiers, one for each entry in clock-names.
> + - clock-names: Should contain:
> +   - "mmss_mmagic_ahb" - on 8996 only;
> +   - "camss_top_ahb";
> +   - "cci_ahb";
> +   - "cci";
> +   - "camss_ahb".
> + - pinctrl-names: Should contain only one value - "default".
> + - pinctrl-0: Pin control group to be used for this controller.

No need to document that the node can have the default pinctrl
properties.

> +
> +
> +Required properties on 8996:
> + - power-domains: Power domain specifier.
> +
> +Optional:
> + - clock-frequency: Desired I2C bus clock frequency in Hz, defaults to 100 kHz
> +   if omitted.
> +
> +Example:
> +
> +                cci: qcom,cci@a0c000 {

Don't do qcom, in the node name, and there's probably no reason to have
a label for this node either. So just make it

		   cci@a0c000 {

> +                        compatible = "qcom,cci-v1.4.0";
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +                        reg = <0xa0c000 0x1000>;
> +                        reg-names = "cci";
> +                        interrupts = <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>;
> +                        interrupt-names = "cci";
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
> +                        pinctrl-names = "default";
> +                        pinctrl-0 = <&cci0_default>;
> +                        clock-frequency = <400000>;
> +                };

In the case of this single cci block having two masters we need a way to
describe the two sets of clients. I think the two options we have are:

cci {
	client {
		reg = <0 0x2c>;
	};
};

The reg here being <master address>

or:

cci {
	master0 {
		client {
			reg = <0x2c>;
		};
	};
};

The name "master0" could be made significant and picked up by name, and
in the case of single-master this level could be omitted.


I like the first one, but it looks really hard to get implemented in
Linux, based on the i2c core's expectation that #address-cells is 1. So
I think the latter is the favourable option.

Regards,
Bjorn

From: Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH v3 3/3] arm64: dts: msm8916: Add CCI node
Date: Wed, 4 Mar 2020 20:08:11 +0100
Message-ID: <CAG3jFys_2zwsZw_khUP2Vp4rPF42=Ammd+0UPpAo8T7FCqm0tw@mail.gmail.com>
References: <1583340776-27865-1-git-send-email-loic.poulain@linaro.org> <1583340776-27865-3-git-send-email-loic.poulain@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1583340776-27865-3-git-send-email-loic.poulain@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Loic Poulain <loic.poulain@linaro.org>
Cc: wsa@the-dreams.de, vkoul@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Due to lack of suitable hardware, I currently can't test the msm8916,
but I have written similar DT nodes for the sdm845, which indeed work properly.

Signed-off-by: Robert Foss <robert.foss@linaro.org>

On Wed, 4 Mar 2020 at 17:49, Loic Poulain <loic.poulain@linaro.org> wrote:
>
> The msm8916 CCI controller provides one CCI/I2C bus.
>
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: add this patch in the series
>  v3: add only cci node for now
>
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 8686e10..985cb5f 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -1451,6 +1451,33 @@
>                         };
>                 };
>
> +               cci@1b0c000 {
> +                       compatible = "qcom,msm8916-cci";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1b0c000 0x1000>;
> +                       interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
> +                       clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
> +                               <&gcc GCC_CAMSS_CCI_AHB_CLK>,
> +                               <&gcc GCC_CAMSS_CCI_CLK>,
> +                               <&gcc GCC_CAMSS_AHB_CLK>;
> +                       clock-names = "camss_top_ahb", "cci_ahb",
> +                                     "cci", "camss_ahb";
> +                       assigned-clocks = <&gcc GCC_CAMSS_CCI_AHB_CLK>,
> +                                         <&gcc GCC_CAMSS_CCI_CLK>;
> +                       assigned-clock-rates = <80000000>, <19200000>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&cci0_default>;
> +                       status = "disabled";
> +
> +                       cci0: i2c-bus@0 {
> +                               reg = <0>;
> +                               clock-frequency = <400000>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +               };
> +
>                 camss: camss@1b00000 {
>                         compatible = "qcom,msm8916-camss";
>                         reg = <0x1b0ac00 0x200>,
> --
> 2.7.4
>

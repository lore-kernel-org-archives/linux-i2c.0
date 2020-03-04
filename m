From: Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: i2c: Add binding for Qualcomm CCI I2C controller
Date: Wed, 4 Mar 2020 20:44:35 +0100
Message-ID: <CAG3jFyvrL_To_cm3jzYzLRVOZWjBeRDiXJkV5AjmBZB_28UipA@mail.gmail.com>
References: <1583340776-27865-1-git-send-email-loic.poulain@linaro.org>
 <1583340776-27865-2-git-send-email-loic.poulain@linaro.org> <CAG3jFyvjQ_rAe_UkBc5Ha-sSK5ERTCaO+r2FS5n9RiLFRTikig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36747 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgCDTos (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Mar 2020 14:44:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id t24so3368997oij.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Mar 2020 11:44:46 -0800 (PST)
In-Reply-To: <CAG3jFyvjQ_rAe_UkBc5Ha-sSK5ERTCaO+r2FS5n9RiLFRTikig@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Loic Poulain <loic.poulain@linaro.org>
Cc: wsa@the-dreams.de, vkoul@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>

Let me revise that, feel free to add by r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Wed, 4 Mar 2020 at 20:05, Robert Foss <robert.foss@linaro.org> wrote:
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
>
> On Wed, 4 Mar 2020 at 17:49, Loic Poulain <loic.poulain@linaro.org> wrote:
> >
> > From: Todor Tomov <todor.tomov@linaro.org>
> >
> > Add DT binding document for Qualcomm Camera Control Interface (CCI)
> > I2C controller.
> >
> > Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  v2: Fix subnode properties, remove mandatory clock names
> >  v3: Add sdm845 compatible string
> >
> >  .../devicetree/bindings/i2c/i2c-qcom-cci.txt       | 92 ++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt b/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> > new file mode 100644
> > index 0000000..c6668b7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
> > @@ -0,0 +1,92 @@
> > +Qualcomm Camera Control Interface (CCI) I2C controller
> > +
> > +PROPERTIES:
> > +
> > +- compatible:
> > +       Usage: required
> > +       Value type: <string>
> > +       Definition: must be one of:
> > +               "qcom,msm8916-cci"
> > +               "qcom,msm8996-cci"
> > +               "qcom,sdm845-cci"
> > +
> > +- reg
> > +       Usage: required
> > +       Value type: <prop-encoded-array>
> > +       Definition: base address CCI I2C controller and length of memory
> > +                   mapped region.
> > +
> > +- interrupts:
> > +       Usage: required
> > +       Value type: <prop-encoded-array>
> > +       Definition: specifies the CCI I2C interrupt. The format of the
> > +                   specifier is defined by the binding document describing
> > +                   the node's interrupt parent.
> > +
> > +- clocks:
> > +       Usage: required
> > +       Value type: <prop-encoded-array>
> > +       Definition: a list of phandle, should contain an entry for each
> > +                   entries in clock-names.
> > +
> > +- clock-names
> > +       Usage: required
> > +       Value type: <string>
> > +       Definition: a list of clock names, must include "cci" clock.
> > +
> > +- power-domains
> > +       Usage: required for "qcom,msm8996-cci"
> > +       Value type: <prop-encoded-array>
> > +       Definition:
> > +
> > +SUBNODES:
> > +
> > +The CCI provides I2C masters for one (msm8916) or two i2c busses (msm8996 and
> > +sdm845), described as subdevices named "i2c-bus@0" and "i2c-bus@1".
> > +
> > +PROPERTIES:
> > +
> > +- reg:
> > +       Usage: required
> > +       Value type: <u32>
> > +       Definition: Index of the CCI bus/master
> > +
> > +- clock-frequency:
> > +       Usage: optional
> > +       Value type: <u32>
> > +       Definition: Desired I2C bus clock frequency in Hz, defaults to 100
> > +                   kHz if omitted.
> > +
> > +Example:
> > +
> > +       cci@a0c000 {
> > +               compatible = "qcom,msm8996-cci";
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +               reg = <0xa0c000 0x1000>;
> > +               interrupts = <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>;
> > +               clocks = <&mmcc MMSS_MMAGIC_AHB_CLK>,
> > +                        <&mmcc CAMSS_TOP_AHB_CLK>,
> > +                        <&mmcc CAMSS_CCI_AHB_CLK>,
> > +                        <&mmcc CAMSS_CCI_CLK>,
> > +                        <&mmcc CAMSS_AHB_CLK>;
> > +               clock-names = "mmss_mmagic_ahb",
> > +                             "camss_top_ahb",
> > +                             "cci_ahb",
> > +                             "cci",
> > +                             "camss_ahb";
> > +
> > +               i2c-bus@0 {
> > +                       reg = <0>;
> > +                       clock-frequency = <400000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +               };
> > +
> > +               i2c-bus@1 {
> > +                       reg = <1>;
> > +                       clock-frequency = <400000>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +               };
> > +       };
> > --
> > 2.7.4
> >

From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [Patch V4 2/2] i2c: imx: add devicetree binding for lpi2c
Date: Thu, 17 Nov 2016 02:31:33 +0200
Message-ID: <19931d8c-08eb-5dd8-795f-20e900e4be4f@mleia.com>
References: <1479115411-1537-1-git-send-email-pandy.gao@nxp.com>
 <1479115411-1537-2-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:45736 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751652AbcKQAbg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 16 Nov 2016 19:31:36 -0500
In-Reply-To: <1479115411-1537-2-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>, wsa@the-dreams.de, u.kleine-koenig@pengutronix.de, cmo@melexis.com, robh@kernel.org
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com

On 11/14/2016 11:23 AM, Gao Pan wrote:
> Add a binding document for lpi2c driver
>
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> ---
>  .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt        | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
> new file mode 100644
> index 0000000..edaf04f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
> @@ -0,0 +1,20 @@
> +* Freescale Low Power Inter IC (LPI2C) for i.MX
> +
> +Required properties:
> +- compatible :
> +  - "fsl,imx8dv-lpi2c" for LPI2C compatible with the one integrated on i.MX8DV soc
> +  - "fsl,imx7ulp-lpi2c" for LPI2C compatible with the one integrated on i.MX7ULP soc
> +- reg : address and length of the lpi2c master registers
> +- interrupt-parent : core interrupt controller
> +- interrupts : lpi2c interrupt
> +- clocks : lpi2c clock specifier

I don't know if description of standard properties is really needed,
probably Rob can advise.

My point is that pretty "interrupts-extended" is never mentioned, and
all three interrupt* properties are well described in interrupts.txt,
and in general there is no point to mention all those interrupts,
clocks, clock-names and friends properties again and again.

But here better to get a clarification from Rob.

> +
> +Examples:
> +
> +lpi2c7: lpi2c7@40A50000 {
> +	compatible = "fsl,imx8dv-lpi2c";
> +	reg = <0x40A50000 0x10000>;
> +	interrupt-parent = <&intc>;
> +	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&clks IMX7ULP_CLK_LPI2C7>;
> +};
>

Please rearrange the changes, devicetree binding change should be 1/2,
the driver change should be 2/2.

--
With best wishes,
Vladimir

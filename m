From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: i2c: add optional mul-value property to
 binding
Date: Thu, 2 May 2019 15:59:01 -0500
Message-ID: <20190502205901.GA24224@bogus>
References: <20190430043242.29687-1-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190430043242.29687-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuanhua Han <chuanhua.han@nxp.com>
Cc: mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com, festevam@gmail.com, wsa+renesas@sang-engineering.com, u.kleine-koenig@pengutronix.de, eha@deif.com, linux@rempel-privat.de, sumit.batra@nxp.com, l.stach@pengutronix.de, peda@axentia.se
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 30, 2019 at 12:32:40PM +0800, Chuanhua Han wrote:
> NXP Layerscape SoC have up to three MUL options available for all
> divider values, we choice of MUL determines the internal monitor rate
> of the I2C bus (SCL and SDA signals):
> A lower MUL value results in a higher sampling rate of the I2C signals.
> A higher MUL value results in a lower sampling rate of the I2C signals.
> 
> So in Optional properties we added our custom mul-value property in the
> binding to select which mul option for the device tree i2c controller
> node.
> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-imx.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> index b967544590e8..ba8e7b7b3fa8 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> @@ -18,6 +18,9 @@ Optional properties:
>  - sda-gpios: specify the gpio related to SDA pin
>  - pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
>    bus recovery, call it "gpio" state
> +- mul-value: NXP Layerscape SoC have up to three MUL options available for
> +all I2C divider values, it describes which MUL we choose to use for the driver,
> +the values should be 1,2,4.

Needs a vendor prefix. I don't find 'value' to add anything nor do I 
understand what MUL is.

If it is determined by SoC rather than board, then it should perhaps be 
implied by compatible.

Rob

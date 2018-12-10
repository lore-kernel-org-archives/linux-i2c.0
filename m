From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: i2c: Add S700 support for Actions
 Semi Soc's
Date: Mon, 10 Dec 2018 19:13:48 +0530
Message-ID: <20181210134348.GA25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-2-pn@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-2-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Parthiban Nallathambi <pn@denx.de>
Cc: afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com
List-Id: linux-i2c@vger.kernel.org

On Mon, Nov 26, 2018 at 07:58:18PM +0100, Parthiban Nallathambi wrote:
> Add s700 compatible string to Actions Semi SoC dt-bindings.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-owl.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-owl.txt b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> index b743fe444e9f..dfa1197e0dbf 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-owl.txt
> @@ -2,7 +2,7 @@ Actions Semiconductor Owl I2C controller
>  
>  Required properties:
>  
> -- compatible        : Should be "actions,s900-i2c".
> +- compatible        : Should be "actions,s700-i2c" or "actions,s900-i2c".

Since this driver will also support S500 in future, the above could be
phrased as:

compatible:	Should be one of the following:

		- "actions,s700-i2c" for S700 SoC
		- "actions,s900-i2c" for S900 SoC

Regards,
Mani

>  - reg               : Offset and length of the register set for the device.
>  - #address-cells    : Should be 1.
>  - #size-cells       : Should be 0.
> -- 
> 2.17.2
> 

From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/5] dt: bindings: i2c-mux-pca954x: Add documentation for
 interrupt controller
Date: Wed, 4 Jan 2017 15:11:42 +0100
Message-ID: <64587c91-19e2-f4f7-d959-929a6b3acd1b@axentia.se>
References: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
 <1483522197-38819-3-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0138.outbound.protection.outlook.com ([104.47.1.138]:21408
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934105AbdADO1x (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 4 Jan 2017 09:27:53 -0500
In-Reply-To: <1483522197-38819-3-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

On 2017-01-04 10:29, Phil Reid wrote:
> Various muxes can aggregate multiple irq lines and provide a control
> register to determine the active line. Add bindings for interrupt
> controller support.
> 

I'm no irq expert, but looks good (superficially).

With the below nitpick,
Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
peda

> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index cf53d5f..9f7c275 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -19,7 +19,14 @@ Optional Properties:
>    - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
>      children in idle state. This is necessary for example, if there are several
>      multiplexers on the bus and the devices behind them use same I2C addresses.
> -
> +  - interrupt-parent: Phandle for the interrupt controller that services
> +    interrupts for this device.
> +  - interrupts: Interrupt mapping for IRQ.
> +  - interrupt-controller: Marks the device node as a interrupt controller.

as an interrupt

> +  - #interrupt-cells : Should be two.
> +    - first cell is the pin number
> +    - second cell is used to specify flags.
> +    See also Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
>  Example:
>  
> @@ -29,6 +36,11 @@ Example:
>  		#size-cells = <0>;
>  		reg = <0x74>;
>  
> +		interrupt-parent = <&ipic>;
> +		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-controller;
> +		#interrupt-cells=<2>;
> +
>  		i2c@2 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> 

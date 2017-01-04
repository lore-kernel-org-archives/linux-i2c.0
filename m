From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/5] dt: bindings: i2c-mux-pca954x: Add documentation for
 interrupt controller
Date: Wed, 4 Jan 2017 08:45:44 -0600
Message-ID: <20170104144544.e7isnrg5pynipwng@rob-hp-laptop>
References: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
 <1483522197-38819-3-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33739 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031202AbdADOpw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Jan 2017 09:45:52 -0500
Content-Disposition: inline
In-Reply-To: <1483522197-38819-3-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: peda@axentia.se, wsa@the-dreams.de, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

On Wed, Jan 04, 2017 at 05:29:54PM +0800, Phil Reid wrote:
> Various muxes can aggregate multiple irq lines and provide a control
> register to determine the active line. Add bindings for interrupt
> controller support.
> 
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

Needs spaces around the '='. With that,

Acked-by: Rob Herring <robh@kernel.org>

> +
>  		i2c@2 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -- 
> 1.8.3.1
> 

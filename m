From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH 4/5] dt: bindings: i2c-mux-pca954x: Add documentation for
 i2c-mux-irq-mask-en
Date: Wed, 4 Jan 2017 15:14:19 +0100
Message-ID: <61bada0c-d239-1cd1-0cf0-d32e67696c7e@axentia.se>
References: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
 <1483522197-38819-5-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483522197-38819-5-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-01-04 10:29, Phil Reid wrote:
> Unfortunately some hardware device will assert their irq line immediately
> on power on and provide no mechanism to mask the irq. As the i2c muxes
> provide no method to mask irq line this provides a work around by keeping
> the parent irq masked until enough device drivers have loaded to service
> all pending interrupts.
> 
> For example the the ltc1760 assert its SMBALERT irq immediately on power
> on. With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
> device is registered irq are enabled and fire continuously as the second
> device driver has not yet loaded. Setting this parameter to 0x3 while
> delay the irq being enabled until both devices are ready.
> 
> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index 9f7c275..d3e63dc 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -19,6 +19,8 @@ Optional Properties:
>    - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
>      children in idle state. This is necessary for example, if there are several
>      multiplexers on the bus and the devices behind them use same I2C addresses.
> +  - i2c-mux-irq-mask-en: BitMask; Defines a mask for which irq lines need to be
> +    unmasked before the parent irq line in enabled.

The prefix should be "nxp," instead of "i2c-mux-", and I don't think you should
abbreviate enable. So, nxp,irq-mask-enable.

With that fixed,
Acked-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

Cheers,
peda

>    - interrupt-parent: Phandle for the interrupt controller that services
>      interrupts for this device.
>    - interrupts: Interrupt mapping for IRQ.
> @@ -36,6 +38,7 @@ Example:
>  		#size-cells = <0>;
>  		reg = <0x74>;
>  
> +		i2c-mux-irq-mask-en = <0x3>;
>  		interrupt-parent = <&ipic>;
>  		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
>  		interrupt-controller;
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

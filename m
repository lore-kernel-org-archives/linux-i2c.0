From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v4 4/5] dt: bindings: i2c-mux-pca954x: Add documentation
 for i2c-mux-irq-mask-en
Date: Mon, 16 Jan 2017 12:40:27 +0100
Message-ID: <e61b6df8-e5a1-fb2f-f8c0-725bd784badb@axentia.se>
References: <1484536275-75995-1-git-send-email-preid@electromag.com.au>
 <1484536275-75995-5-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1484536275-75995-5-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-01-16 04:11, Phil Reid wrote:
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
> Acked-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Hmm, I see that this is already acked by some people :-) ...

... but. I just thought a bit more about it and going forward it might
make sense to make this not a bitmask that only support 0 or 1 irq clients
for each mux segment, and instead make it one u32 for each segment. Then
the binding would extend to also cover cases where several i2c clients
register for interrupts and the shared interrupt needs to be masked until
the last client is registered.

Or is that idea over-engineered?

I'd be satisfied if the implementation simply mapped the u32 array to
a bitmask, as long as it failed noisily when finding anything bigger
than 1 in the array.

Cheers,
peda

> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index aa09704..6de1e8e 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -19,6 +19,8 @@ Optional Properties:
>    - i2c-mux-idle-disconnect: Boolean; if defined, forces mux to disconnect all
>      children in idle state. This is necessary for example, if there are several
>      multiplexers on the bus and the devices behind them use same I2C addresses.
> +  - nxp,irq-mask-enable: BitMask; Defines a mask for which irq lines need to be
> +    unmasked before the parent irq line in enabled.
>    - interrupt-parent: Phandle for the interrupt controller that services
>      interrupts for this device.
>    - interrupts: Interrupt mapping for IRQ.
> @@ -36,6 +38,7 @@ Example:
>  		#size-cells = <0>;
>  		reg = <0x74>;
>  
> +		nxp,irq-mask-enable = <0x3>;
>  		interrupt-parent = <&ipic>;
>  		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
>  		interrupt-controller;
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

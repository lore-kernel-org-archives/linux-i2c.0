From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] Documentation: dt: i2c: Add Altera I2C Controller
Date: Thu, 13 Apr 2017 16:22:40 -0500
Message-ID: <20170413212240.uxwh5525baqmgny4@rob-hp-laptop>
References: <1491926547-29510-1-git-send-email-thor.thayer@linux.intel.com>
 <1491926547-29510-3-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1491926547-29510-3-git-send-email-thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 11, 2017 at 11:02:26AM -0500, thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org wrote:
> From: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Add the documentation to support the Altera I2C Controller.

"dt-bindings: i2c: ..." for the subject.

> 
> Signed-off-by: Thor Thayer <thor.thayer-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-altera.txt         | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-altera.txt b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
> new file mode 100644
> index 0000000..a67241c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-altera.txt
> @@ -0,0 +1,37 @@
> +* Altera I2C Controller

This is the only one? For synthesizable logic or a hard block in 
socfpga?

> +
> +Required properties :
> + - compatible : should be "altr,sip-i2c"

Seems kind of generic.

> + - reg        : Offset and length of the register set for the device
> + - interrupts : <IRQ> where IRQ is the interrupt number.
> + - clocks     : phandles to input clocks.

Need to specify how many clocks.

> + - #address-cells = <1>;
> + - #size-cells = <0>;
> +
> +Recommended properties :
> + - clock-frequency : desired I2C bus clock frequency in Hz.
> +
> +Optional properties :
> + - altr,fifo-size : Size of the RX and TX FIFOs.

in bytes?

Just "fifo-size" is already fairly common, so drop the vendor prefix.

> + - Child nodes conforming to i2c bus binding
> +
> +Example :
> +
> +	i2c@100080000 {
> +		compatible = "altr,sip-i2c";
> +		reg = <0x00000001 0x00080000 0x00000040>;
> +		interrupt-parent = <&intc>;
> +		interrupts = <0 43 4>;
> +		clocks = <&clk_0>;
> +		clock-frequency = <100000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		altr,fifo-size = <4>;
> +
> +		eeprom@51 {
> +			compatible = "atmel,24c32";
> +			reg = <0x51>;
> +			pagesize = <32>;
> +		};
> +	};
> +
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

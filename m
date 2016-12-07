From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 2/2] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Wed, 7 Dec 2016 02:19:26 +0200
Message-ID: <5ca0db30-76e1-5ffa-fb48-6e0ace945f82@mleia.com>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
 <1480467618-7497-3-git-send-email-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480467618-7497-3-git-send-email-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Brendan,

please find review comments below.

On 11/30/2016 03:00 AM, Brendan Higgins wrote:
> Added device tree binding documentation for Aspeed I2C controller and
> busses.

This is not the exact description of the added bindings, here you add two
device tree bindings of interrupt controller device and I2C bus controller
device.

Please separate the description into two separate files, place one into
../interrupt-controller/aspeed,ast2400-i2c-ic.txt and another one into
../i2c/aspeed,ast2400-i2c.txt file

The description of device tree bindings must precede the actual drivers,
assuming that the file with two drivers is also split into two files
there should be 4 patches for v6:
1) device tree description of the interrupt controller,
2) interrupt controller driver,
3) device tree description of the I2C bus controller,
4) I2C bus controller driver.

> Signed-off-by: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
> Changes for v2:
>   - None
> Changes for v3:
>   - Removed reference to "bus" device tree param
> Changes for v4:
>   - None
> Changes for v5:
>   - None
> ---
>  .../devicetree/bindings/i2c/i2c-aspeed.txt         | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> new file mode 100644
> index 0000000..dd11a97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -0,0 +1,61 @@
> +Device tree configuration for the I2C controller and busses on the AST24XX
> +and AST25XX SoCs.
> +
> +Controller:

Interrupt controller.

> +
> +	Required Properties:
> +	- #address-cells	: should be 1
> +	- #size-cells 		: should be 1
> +	- #interrupt-cells 	: should be 1
> +	- compatible 		: should be "aspeed,ast2400-i2c-controller"
> +				  or "aspeed,ast2500-i2c-controller"
> +	- reg			: address start and range of controller
> +	- ranges		: defines address offset and range for busses
> +	- interrupts		: interrupt number
> +	- clocks		: root clock of bus, should reference the APB
> +				  clock
> +	- clock-ranges		: specifies that child busses can inherit clocks
> +	- interrupt-controller	: denotes that the controller receives and fires
> +				  new interrupts for child busses
> +
> +Bus:

I2C bus controller.

> +
> +	Required Properties:
> +	- #address-cells	: should be 1
> +	- #size-cells		: should be 0
> +	- reg			: address offset and range of bus
> +	- compatible		: should be "aspeed,ast2400-i2c-bus"
> +				  or "aspeed,ast2500-i2c-bus"
> +	- interrupts		: interrupt number
> +
> +	Optional Properties:
> +	- clock-frequency	: frequency of the bus clock in Hz
> +				  defaults to 100 kHz when not specified
> +
> +Example:
> +
> +i2c: i2c@1e78a000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	#interrupt-cells = <1>;
> +
> +	compatible = "aspeed,ast2400-i2c-controller";
> +	reg = <0x1e78a000 0x40>;
> +	ranges = <0 0x1e78a000 0x1000>;
> +	interrupts = <12>;
> +	clocks = <&clk_apb>;
> +	clock-ranges;
> +	interrupt-controller;
> +
> +	i2c0: i2c-bus@40 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x40 0x40>;
> +		compatible = "aspeed,ast2400-i2c-bus";
> +		clock-frequency = <100000>;
> +		status = "disabled";
> +		interrupts = <0>;
> +		interrupt-parent = <&i2c>;
> +	};
> +};

The selected layout of device tree nodes does not reflect the actual
hardware, I2C bus controller (sub-)devices can not be children of the
interrupt controller device, they are only consumers of interrupts from
the interrupt controller device.

In this case the proper and expected device tree description should
look like the one below:

i2c {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0x1e78a000 0x1000>;

	i2c-ic: interrupt-controller@0 {
		compatible = "aspeed,ast2400-i2c-ic";
		reg = <0x0 0x40>;
		clocks = <&clk_apb>;
		interrupt-controller;
		interrupts = <12>;
		#interrupt-cells = <1>;
	};

	i2c0: i2c@40 {
		compatible = "aspeed,ast2400-i2c";
		reg = <0x40 0x40>;
		#address-cells = <1>;
		#size-cells = <0>;
		clock-frequency = <100000>;
		interrupt-parent = <&i2c-ic>;
		interrupts = <0>;
		status = "disabled";
	};

	i2c1: i2c-bus@80 {
		.....
	};
};

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

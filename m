From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 3/5] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Mon, 3 Apr 2017 09:24:10 -0500
Message-ID: <20170403142410.57qqtuvawu3qon2m@rob-hp-laptop>
References: <20170328051226.21677-1-brendanhiggins@google.com>
 <20170328051226.21677-4-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34048 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbdDCOYN (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 3 Apr 2017 10:24:13 -0400
Content-Disposition: inline
In-Reply-To: <20170328051226.21677-4-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, benh@kernel.crashing.org

On Mon, Mar 27, 2017 at 10:12:24PM -0700, Brendan Higgins wrote:
> Added device tree binding documentation for Aspeed I2C busses.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Changes for v2:
>   - None
> Changes for v3:
>   - Removed reference to "bus" device tree param
> Changes for v4:
>   - None
> Changes for v5:
>   - None
> Changes for v6:
>   - Replaced the controller property with and interrupt controller, leaving only
>     the busses in the I2C documentation.
> ---
>  .../devicetree/bindings/i2c/i2c-aspeed.txt         | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> new file mode 100644
> index 000000000000..fbcc501706b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -0,0 +1,49 @@
> +Device tree configuration for the I2C busses on the AST24XX and AST25XX SoCs.
> +
> +Required Properties:
> +- #address-cells	: should be 1
> +- #size-cells		: should be 0
> +- reg			: address offset and range of bus
> +- compatible		: should be "aspeed,ast2400-i2c-bus"
> +			  or "aspeed,ast2500-i2c-bus"
> +- clocks		: root clock of bus, should reference the APB
> +			  clock
> +- interrupts		: interrupt number
> +- interrupt-parent	: interrupt controller for bus, should reference a
> +			  aspeed,ast2400-i2c-ic or aspeed,ast2500-i2c-ic
> +			  interrupt controller
> +
> +Optional Properties:
> +- clock-frequency	: frequency of the bus clock in Hz
> +			  defaults to 100 kHz when not specified
> +
> +Example:
> +
> +i2c {
> +	compatible = "simple-bus";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges = <0 0x1e78a000 0x1000>;
> +
> +	i2c_ic: interrupt-controller@0 {
> +		#interrupt-cells = <1>;
> +		compatible = "aspeed,ast2400-i2c-ic";
> +		reg = <0x0 0x40>;
> +		interrupts = <12>;
> +		interrupt-controller;
> +	};
> +
> +	i2c0: i2c-bus@40 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#interrupt-cells = <1>;
> +		reg = <0x40 0x40>;
> +		compatible = "aspeed,ast2400-i2c-bus";
> +		bus = <0>;

Not documented and what's it for?

> +		clocks = <&clk_apb>;
> +		clock-frequency = <100000>;
> +		status = "disabled";

Drop status from examples.

> +		interrupts = <0>;
> +		interrupt-parent = <&i2c_ic>;
> +	};
> +};
> -- 
> 2.12.2.564.g063fe858b8-goog
> 

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v6 1/5] irqchip/aspeed-i2c-ic: binding docs for Aspeed
 I2C Interrupt Controller
Date: Tue, 28 Mar 2017 19:49:40 +1100
Message-ID: <1490690980.3177.108.camel@kernel.crashing.org>
References: <20170328051226.21677-1-brendanhiggins@google.com>
         <20170328051226.21677-2-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:58048 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754563AbdC1Iuh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 28 Mar 2017 04:50:37 -0400
In-Reply-To: <20170328051226.21677-2-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Mon, 2017-03-27 at 22:12 -0700, Brendan Higgins wrote:
> Added device tree binding documentation for Aspeed I2C Interrupt
> Controller.

It's a little bit overkill ... It's not so much an interrupt controller
than a single "summary" register that reflects the state of the
interrupts of all the i2c controllers ;-) It can't do anything with
them, no individual masking or acking or similar.

In fact to be honest I wouldn't even have bothered making it an
irq_domain in the first place though it *is* nice I admit to see the
interrupt counts per bus in /proc/interrupts as a result.

Cheers,
Ben.

> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
> Added in v6:
>   - Pulled "aspeed_i2c_controller" out into a interrupt controller
> since that is
>     what it actually does.
> ---
>  .../interrupt-controller/aspeed,ast2400-i2c-ic.txt | 25
> ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-
> controller/aspeed,ast2400-i2c-ic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-
> controller/aspeed,ast2400-i2c-ic.txt
> b/Documentation/devicetree/bindings/interrupt-
> controller/aspeed,ast2400-i2c-ic.txt
> new file mode 100644
> index 000000000000..033cc82e5684
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-
> controller/aspeed,ast2400-i2c-ic.txt
> @@ -0,0 +1,25 @@
> +Device tree configuration for the I2C Interrupt Controller on the
> AST24XX and
> +AST25XX SoCs.
> +
> +Required Properties:
> +- #address-cells	: should be 1
> +- #size-cells 		: should be 1
> +- #interrupt-cells 	: should be 1
> +- compatible 		: should be "aspeed,ast2400-i2c-ic"
> +			  or "aspeed,ast2500-i2c-ic"
> +- reg			: address start and range of controller
> +- interrupts		: interrupt number
> +- interrupt-controller	: denotes that the controller receives
> and fires
> +			  new interrupts for child busses
> +
> +Example:
> +
> +i2c_ic: interrupt-controller@0 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	#interrupt-cells = <1>;
> +	compatible = "aspeed,ast2400-i2c-ic";
> +	reg = <0x0 0x40>;
> +	interrupts = <12>;
> +	interrupt-controller;
> +};

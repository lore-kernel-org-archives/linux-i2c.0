From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: aspeed: added documentation for Aspeed I2C
 driver
Date: Mon, 19 Sep 2016 16:35:36 -0500
Message-ID: <20160919213536.GA19274@rob-hp-laptop>
References: <201609100847.j1qUadzy%fengguang.wu@intel.com>
 <1473472551-11149-1-git-send-email-brendanhiggins@google.com>
 <1473472551-11149-2-git-send-email-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473472551-11149-2-git-send-email-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Sep 09, 2016 at 06:55:51PM -0700, Brendan Higgins wrote:
> Added device tree binding documentation for Aspeed I2C controller and
> busses.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
> Changes for v2:
>   - None
> ---
>  .../devicetree/bindings/i2c/i2c-aspeed.txt         | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> new file mode 100644
> index 0000000..df68f2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
> @@ -0,0 +1,63 @@
> +Device tree configuration for the I2C controller and busses on the AST24XX
> +and AST25XX SoCs.
> +
> +Controller:
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
> +
> +	Required Properties:
> +	- #address-cells	: should be 1
> +	- #size-cells		: should be 0
> +	- reg			: address offset and range of bus
> +	- compatible		: should be "aspeed,ast2400-i2c-bus"
> +				  or "aspeed,ast2500-i2c-bus"
> +	- bus			: the bus's number

Don't use indexes. The reg property is enough to id which bus is which.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

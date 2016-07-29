From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/7] dt-bindings: i2c: add support for 'i2c-gate' subnode
Date: Fri, 29 Jul 2016 16:25:59 -0500
Message-ID: <20160729212559.GA11341@rob-hp-laptop>
References: <1469609010-23049-1-git-send-email-peda@axentia.se>
 <1469609010-23049-4-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34062 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbcG2V0B (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 29 Jul 2016 17:26:01 -0400
Content-Disposition: inline
In-Reply-To: <1469609010-23049-4-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>

On Wed, Jul 27, 2016 at 10:43:26AM +0200, Peter Rosin wrote:
> Handle i2c gates similarly to how i2c arbitrators are handled.
> This gets rid of a pointless 'reg' property for i2c gates.
> 
> I.e. this new and more compact style
> 
>         some-gate {
>                 i2c-gate {
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         some-i2c-device@50 {
>                                 reg = <0x50>;
>                         };
>                 };
>         };
> 
> instead of the old
> 
>         some-gate {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> 
>                 i2c@0 {
>                         reg = <0>;
> 
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> 
>                         some-i2c-device@50 {
>                                 reg = <0x50>;
>                         };
>                 };
>         };
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-gate.txt | 35 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gate.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-gate.txt b/Documentation/devicetree/bindings/i2c/i2c-gate.txt
> new file mode 100644
> index 000000000000..78f17892dfc6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-gate.txt
> @@ -0,0 +1,35 @@
> +Common i2c gate properties.

Perhaps define what a gate is.

> +
> +- i2c-gate child node
> +
> +Required properties for the i2c-gate child node:
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +
> +Optional properties for i2c-gate child node:
> +- Child nodes conforming to i2c bus binding
> +
> +
> +Example :
> +
> +	/*
> +	   An Invensense mpu9150 at address 0x68 featuring an on-chip Asahi
> +	   Kasei ak8975 compass behind a gate.
> +	 */
> +
> +	mpu9150@68 {
> +		compatible = "invensense,mpu9150";
> +		reg = <0x68>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <18 1>;
> +
> +		i2c-gate {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			ax8975@0c {
> +				compatible = "ak,ak8975";
> +				reg = <0x0c>;
> +			};
> +		};
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 543052305a09..0e6cc071c480 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5525,6 +5525,7 @@ F:	Documentation/i2c/i2c-topology
>  F:	Documentation/i2c/muxes/
>  F:	Documentation/devicetree/bindings/i2c/i2c-mux*
>  F:	Documentation/devicetree/bindings/i2c/i2c-arb*
> +F:	Documentation/devicetree/bindings/i2c/i2c-gate*
>  F:	drivers/i2c/i2c-mux.c
>  F:	drivers/i2c/muxes/
>  F:	include/linux/i2c-mux.h
> -- 
> 2.1.4
> 

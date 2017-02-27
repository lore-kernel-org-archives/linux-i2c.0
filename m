From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 4/6] i2c: designware: introducing I2C_SLAVE definitions
Date: Mon, 27 Feb 2017 11:24:25 -0600
Message-ID: <20170227172425.cwg3wlzdm75lr5gz@rob-hp-laptop>
References: <cover.1487009294.git.lolivei@synopsys.com>
 <36d6f21ead74e6436215f9ca449a42114ebec0d1.1487009294.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36496 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbdB0RdX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Feb 2017 12:33:23 -0500
Content-Disposition: inline
In-Reply-To: <36d6f21ead74e6436215f9ca449a42114ebec0d1.1487009294.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Wed, Feb 15, 2017 at 12:22:13PM +0000, Luis Oliveira wrote:
> - Definitions were added to core library
> - A example was added to designware-core.txt Documentation that shows
>   how the slave can be setup using DTS
> 
> SLAVE related definitions were added to the core of the controller.
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> V5->V6
> - Included an example of use in the device tree binding document
> 
>  .../devicetree/bindings/i2c/i2c-designware.txt     | 16 +++++++++-
>  drivers/i2c/busses/i2c-designware-core.h           | 35 ++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fee26dc3e858..c6f1d9a63d18 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -20,7 +20,7 @@ Optional properties :
>   - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tHIGH period.
>  
> -Example :
> +Examples :
>  
>  	i2c@f0000 {
>  		#address-cells = <1>;
> @@ -43,3 +43,17 @@ Example :
>  		i2c-sda-falling-time-ns = <300>;
>  		i2c-scl-falling-time-ns = <300>;
>  	};
> +
> +	i2c@01120000 {

Drop leading 0. With that, for the binding:

Acked-by: Rob Herring <robh@kernel.org>

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x2000 0x100>;
> +		clock-frequency = <400000>;
> +		clocks = <&i2cclk>;
> +		interrupts = <0>;
> +
> +		eeprom@64 {
> +			compatible = "linux,slave-24c02";
> +			reg = <0x40000064>;
> +		};
> +	};

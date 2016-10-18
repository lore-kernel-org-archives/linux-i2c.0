From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] Device bindings documentation updated
 ACPI-enabled platforms not currently supported
Date: Tue, 18 Oct 2016 09:33:01 -0500
Message-ID: <20161018143301.vkfsjzytvwqxmsvj@rob-hp-laptop>
References: <cover.1476462204.git.lolivei@synopsys.com>
 <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36513 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933466AbcJROdD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 18 Oct 2016 10:33:03 -0400
Content-Disposition: inline
In-Reply-To: <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis.Oliveira@synopsys.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, CARLOS.PALMINHA@synopsys.com, Ramiro.Oliveira@synopsys.com

On Fri, Oct 14, 2016 at 05:52:50PM +0100, Luis.Oliveira@synopsys.com wrote:
> From: Luis Oliveira <lolivei@synopsys.com>
> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 5 ++++-
>  drivers/i2c/busses/i2c-designware-platdrv.c              | 4 +++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fee26dc..d3d163c 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -19,6 +19,8 @@ Optional properties :
>  
>   - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tHIGH period.
> +   
> + - is-slave : indicates if the block is a I2C slave device.

This should be documented as a generic property.

>  
>  Example :
>  
> @@ -30,7 +32,7 @@ Example :
>  		interrupts = <11>;
>  		clock-frequency = <400000>;
>  	};
> -
> +	

Adding trailing whitespace...

>  	i2c@1120000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> @@ -42,4 +44,5 @@ Example :
>  		i2c-sda-hold-time-ns = <300>;
>  		i2c-sda-falling-time-ns = <300>;
>  		i2c-scl-falling-time-ns = <300>;
> +		is-slave;
>  	};

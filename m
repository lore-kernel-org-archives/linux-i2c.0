From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/5] i2c: designware: Add slave definitions
Date: Fri, 18 Nov 2016 14:35:52 +0200
Message-ID: <1479472552.22212.23.camel@linux.intel.com>
References: <cover.1479410047.git.lolivei@synopsys.com>
         <f1bf9ca52e47cdd79b8f0d5e0c159a8727857269.1479410047.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbcKRMh1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 18 Nov 2016 07:37:27 -0500
In-Reply-To: <f1bf9ca52e47cdd79b8f0d5e0c159a8727857269.1479410047.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Fri, 2016-11-18 at 11:19 +0000, Luis Oliveira wrote:
>  - Add slave defintitions to i2c-designware-core
>  - Changes in Kconfig to auto-enable I2C_SLAVE when compiling the
> modules
>  - Add compatible string to designware-core.txt explaining the
> devicetree bindings
> 


> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -2,7 +2,9 @@
>  
>  Required properties :
>  
> - - compatible : should be "snps,designware-i2c"
> + - compatible : should be:
> +   - "snps,designware-i2c" to setup the hardware block as I2C master.
> +   - "snps,designware-i2c-slave" to setup the hardware block as I2C
> slave.

Not sure about this one.

Compatible string is more generic than list of modes. Basically you have
to add a property which selects mode.

DT people's ACK is a must for this change.


--- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -470,6 +470,7 @@ config I2C_DESIGNWARE_CORE
>  config I2C_DESIGNWARE_PLATFORM
>  	tristate "Synopsys DesignWare Platform"
>  	select I2C_DESIGNWARE_CORE
> +	select I2C_SLAVE
> 

Common rule, generic dependencies usually go first

	select I2C_SLAVE
 	select I2C_DESIGNWARE_CORE

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

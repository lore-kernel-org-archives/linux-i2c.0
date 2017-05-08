From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9 6/6] i2c: designware: enable SLAVE in platform module
Date: Mon, 08 May 2017 19:40:18 +0300
Message-ID: <1494261618.30052.67.camel@linux.intel.com>
References: <cover.1493893241.git.lolivei@synopsys.com>
         <dc32ce6a3988a28e6bd08d4ec2797f0a544ae4ad.1493893241.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc32ce6a3988a28e6bd08d4ec2797f0a544ae4ad.1493893241.git.lolivei@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com
List-Id: linux-i2c@vger.kernel.org

On Mon, 2017-05-08 at 11:37 +0100, Luis Oliveira wrote:
> - Slave mode selected in platform module if the support is detected in
>   the DT.

>  config I2C_DESIGNWARE_PLATFORM
>  	tristate "Synopsys DesignWare Platform"
>  	select I2C_DESIGNWARE_CORE
> +	select I2C_DESIGNWARE_SLAVE
>  	depends on (ACPI && COMMON_CLK) || !ACPI
>  	help
>  	  If you say yes to this option, support will be included for
> the

> @@ -483,6 +484,7 @@ config I2C_DESIGNWARE_SLAVE
>  	bool "Synopsys DesignWare Slave"
>  	select I2C_SLAVE
>  	depends on I2C_DESIGNWARE_PLATFORM
> +	default y

Can you elaborate why this line is needed?


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
